From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Mon, 2 May 2016 12:11:35 +0200
Message-ID: <572727D7.6080708@alitech.com>
References: <5707B9B4.6020402@alitech.com>
 <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
 <CAKi4VA+WVwXBM5cP8Q1iQ_YqWF5jvE5XbbLYEb9Jjfo4Lgw3=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nopam.alitech.com ([202.3.176.31]:39573 "EHLO nopam.alitech.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbcEBKL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 May 2016 06:11:58 -0400
In-Reply-To: <CAKi4VA+WVwXBM5cP8Q1iQ_YqWF5jvE5XbbLYEb9Jjfo4Lgw3=g@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>

Dear Lucas,

On 22.04.2016 17:19, Lucas De Marchi wrote:
> CC'ing Christian.
> 
> On Fri, Apr 22, 2016 at 12:08 PM, Lucas De Marchi
> <lucas.demarchi@intel.com> wrote:
>> Disabling the adapter after each transfer is pretty bad for sensors and
>> other devices doing small transfers at a high rate. It slows down the
>> transfer rate a lot since each of them have to wait the adapter to be
>> enabled again.
>>
>> During the transfer init we check the status register for no activity
>> and TX buffer being empty since otherwise we can't change IC_TAR
>> dynamically.
>>
>> When a transfer fails the adapter will still be disabled - this is a
>> conservative approach. When transfers succeed, the adapter is left
>> enabled and it's configured so to disable interrupts.
> 
> Christian, this is the updated patch. Now adapter starts disabled and
> is disabled when there's a failed transfer. I hope this can work with
> your hardware.

Good news: The system now boots without deadlocks.

Bad  news: Not all transfers seem to take place as they should.
           I don't have the time for a deep analysis but a few quick
           experiments seem to indicate that the adapter needs to be
           disabled while updating TAR to a value different from the
           previous one. Disabling the adapter does not seem to be
           required if TAR doesn't change from one transfer to the next.
           I don't know if there are any conditions under which we can
           leave the adapter enabled while changing TAR but at least in
           some cases it seems to work.

The adapter seems to work reliably with the following diff on top of
your patch (included a dirty version of Jarkko's comments as well, not
sure if that's required to make everything work):

diff --git a/drivers/i2c/busses/i2c-designware-core.c
b/drivers/i2c/busses/i2c-designware-core.c
index 8a08e68..e927285 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -421,8 +421,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)

                /* check ic_tar and ic_con can be dynamically updated */
                ic_status = dw_readl(dev, DW_IC_STATUS);
-               if (ic_status & DW_IC_STATUS_ACTIVITY
-                       || !(ic_status & DW_IC_STATUS_TX_EMPTY)) {
+               if (ic_status & (0x1<<5)
+                       || !(ic_status & (0x1<<1))) {
                        __i2c_dw_enable(dev, false);
                }
        }
@@ -442,13 +442,18 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
                ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
        }

+       ic_tar |= msgs[dev->msg_write_idx].addr;
+
        dw_writel(dev, ic_con, DW_IC_CON);

        /*
         * Set the slave (target) address and enable 10-bit addressing mode
         * if applicable.
         */
-       dw_writel(dev, msgs[dev->msg_write_idx].addr | ic_tar, DW_IC_TAR);
+       if (ic_tar != dw_readl(dev, DW_IC_TAR))
+               __i2c_dw_enable(dev, false);
+
+       dw_writel(dev, ic_tar, DW_IC_TAR);

        /* enforce disabled interrupts (due to HW issues) */
        i2c_dw_disable_int(dev);
