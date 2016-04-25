From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Mon, 25 Apr 2016 14:51:22 +0300
Message-ID: <571E04BA.3030301@linux.intel.com>
References: <5707B9B4.6020402@alitech.com>
 <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40217 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbcDYLvb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 07:51:31 -0400
In-Reply-To: <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>

On 04/22/2016 06:08 PM, Lucas De Marchi wrote:
> Disabling the adapter after each transfer is pretty bad for sensors and
> other devices doing small transfers at a high rate. It slows down the
> transfer rate a lot since each of them have to wait the adapter to be
> enabled again.
>
> During the transfer init we check the status register for no activity
> and TX buffer being empty since otherwise we can't change IC_TAR
> dynamically.
>
> When a transfer fails the adapter will still be disabled - this is a
> conservative approach. When transfers succeed, the adapter is left
> enabled and it's configured so to disable interrupts.
>
> With a small program test to read/write registers in a sensor the speed
> doubled. Example below with write sequences of 16 bytes:
>
> Before:
> 	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
> 	num_transfers=20000
> 	transfer_time_avg=1032.728500us
>
> After:
> 	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
> 	num_transfers=20000
> 	transfer_time_avg=470.256050us
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.c | 48 ++++++++++++++++++++------------
>   drivers/i2c/busses/i2c-designware-core.h |  1 +
>   2 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 99b54be..8a08e68 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -90,6 +90,7 @@
>   					 DW_IC_INTR_STOP_DET)
>
>   #define DW_IC_STATUS_ACTIVITY	0x1
> +#define DW_IC_STATUS_TX_EMPTY	0x2

...

> @@ -413,8 +416,16 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>   	struct i2c_msg *msgs = dev->msgs;
>   	u32 ic_con, ic_tar = 0;
>
> -	/* Disable the adapter */
> -	__i2c_dw_enable(dev, false);
> +	if (dev->enabled) {
> +		u32 ic_status;
> +
> +		/* check ic_tar and ic_con can be dynamically updated */
> +		ic_status = dw_readl(dev, DW_IC_STATUS);
> +		if (ic_status & DW_IC_STATUS_ACTIVITY
> +			|| !(ic_status & DW_IC_STATUS_TX_EMPTY)) {
> +			__i2c_dw_enable(dev, false);
> +		}
> +	}
>
Worth to double check this. I see bit 1 means TX FIFO not full and bit 2 
is TX FIFO completely empty.

Otherwise I'm fine with the patch as long as it works for Christian.

-- 
Jarkko
