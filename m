From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Fri, 22 Apr 2016 12:19:57 -0300
Message-ID: <CAKi4VA+WVwXBM5cP8Q1iQ_YqWF5jvE5XbbLYEb9Jjfo4Lgw3=g@mail.gmail.com>
References: <5707B9B4.6020402@alitech.com> <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:32831 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbcDVPUS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Apr 2016 11:20:18 -0400
In-Reply-To: <1461337687-2484-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, christian.ruppert@alitech.com
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>

CC'ing Christian.

On Fri, Apr 22, 2016 at 12:08 PM, Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
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

Christian, this is the updated patch. Now adapter starts disabled and
is disabled when there's a failed transfer. I hope this can work with
your hardware.

Leaving patch below.

Lucas De Marchi


>
> With a small program test to read/write registers in a sensor the speed
> doubled. Example below with write sequences of 16 bytes:
>
> Before:
>         i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
>         num_transfers=20000
>         transfer_time_avg=1032.728500us
>
> After:
>         i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
>         num_transfers=20000
>         transfer_time_avg=470.256050us
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 48 ++++++++++++++++++++------------
>  drivers/i2c/busses/i2c-designware-core.h |  1 +
>  2 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 99b54be..8a08e68 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -90,6 +90,7 @@
>                                          DW_IC_INTR_STOP_DET)
>
>  #define DW_IC_STATUS_ACTIVITY  0x1
> +#define DW_IC_STATUS_TX_EMPTY  0x2
>
>  #define DW_IC_ERR_TX_ABRT      0x1
>
> @@ -256,8 +257,10 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
>
>         do {
>                 dw_writel(dev, enable, DW_IC_ENABLE);
> -               if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
> +               if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable) {
> +                       dev->enabled = enable;
>                         return;
> +               }
>
>                 /*
>                  * Wait 10 times the signaling period of the highest I2C
> @@ -413,8 +416,16 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>         struct i2c_msg *msgs = dev->msgs;
>         u32 ic_con, ic_tar = 0;
>
> -       /* Disable the adapter */
> -       __i2c_dw_enable(dev, false);
> +       if (dev->enabled) {
> +               u32 ic_status;
> +
> +               /* check ic_tar and ic_con can be dynamically updated */
> +               ic_status = dw_readl(dev, DW_IC_STATUS);
> +               if (ic_status & DW_IC_STATUS_ACTIVITY
> +                       || !(ic_status & DW_IC_STATUS_TX_EMPTY)) {
> +                       __i2c_dw_enable(dev, false);
> +               }
> +       }
>
>         /* if the slave address is ten bit address, enable 10BITADDR */
>         ic_con = dw_readl(dev, DW_IC_CON);
> @@ -442,8 +453,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>         /* enforce disabled interrupts (due to HW issues) */
>         i2c_dw_disable_int(dev);
>
> -       /* Enable the adapter */
> -       __i2c_dw_enable(dev, true);
> +       if (!dev->enabled)
> +               __i2c_dw_enable(dev, true);
>
>         /* Clear and enable interrupts */
>         dw_readl(dev, DW_IC_CLR_INTR);
> @@ -624,7 +635,8 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
>  }
>
>  /*
> - * Prepare controller for a transaction and call i2c_dw_xfer_msg
> + * Prepare controller for a transaction and start transfer by calling
> + * i2c_dw_xfer_init()
>   */
>  static int
>  i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> @@ -671,16 +683,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>                 goto done;
>         }
>
> -       /*
> -        * We must disable the adapter before returning and signaling the end
> -        * of the current transfer. Otherwise the hardware might continue
> -        * generating interrupts which in turn causes a race condition with
> -        * the following transfer.  Needs some more investigation if the
> -        * additional interrupts are a hardware bug or this driver doesn't
> -        * handle them correctly yet.
> -        */
> -       __i2c_dw_enable(dev, false);
> -
>         if (dev->msg_err) {
>                 ret = dev->msg_err;
>                 goto done;
> @@ -818,9 +820,19 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
>          */
>
>  tx_aborted:
> -       if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
> +       if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
> +                       || dev->msg_err) {
> +               /*
> +                * We must disable interruts before returning and signaling
> +                * the end of the current transfer. Otherwise the hardware
> +                * might continue generating interrupts for non-existent
> +                * transfers.
> +                */
> +               i2c_dw_disable_int(dev);
> +               dw_readl(dev, DW_IC_CLR_INTR);
> +
>                 complete(&dev->cmd_complete);
> -       else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
> +       } else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
>                 /* workaround to trigger pending interrupt */
>                 stat = dw_readl(dev, DW_IC_INTR_MASK);
>                 i2c_dw_disable_int(dev);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index cd409e7..115c4b0 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -105,6 +105,7 @@ struct dw_i2c_dev {
>         int                     (*acquire_lock)(struct dw_i2c_dev *dev);
>         void                    (*release_lock)(struct dw_i2c_dev *dev);
>         bool                    pm_runtime_disabled;
> +       bool                    enabled;
>  };
>
>  #define ACCESS_SWAP            0x00000001
> --
> 2.5.5
>



-- 
Lucas De Marchi
