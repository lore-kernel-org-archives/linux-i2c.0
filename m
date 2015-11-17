From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 3/3] i2c: xiic: Replace spinlock with mutex
Date: Tue, 17 Nov 2015 10:48:22 +0530
Message-ID: <CAKfKVtGDe+SYx7wmtNtkvDCA9_Ham0Rt9Q4g=6pk3M57GKvrpA@mail.gmail.com>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
	<1447681325-30914-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33447 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbKQFSX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Nov 2015 00:18:23 -0500
Received: by qgea14 with SMTP id a14so65302762qge.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2015 21:18:22 -0800 (PST)
In-Reply-To: <1447681325-30914-3-git-send-email-lars@metafoo.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org

On Mon, Nov 16, 2015 at 7:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> All protected sections are only called from sleep-able context, so there is
> no need to use a spinlock.

Looks good to me. Feel free to add my reviewed by.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 0b20449..6efd200 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -70,7 +70,7 @@ struct xiic_i2c {
>         wait_queue_head_t       wait;
>         struct i2c_adapter      adap;
>         struct i2c_msg          *tx_msg;
> -       spinlock_t              lock;
> +       struct mutex            lock;
>         unsigned int            tx_pos;
>         unsigned int            nmsgs;
>         enum xilinx_i2c_state   state;
> @@ -369,7 +369,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
>          * To find which interrupts are pending; AND interrupts pending with
>          * interrupts masked.
>          */
> -       spin_lock(&i2c->lock);
> +       mutex_lock(&i2c->lock);
>         isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
>         ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
>         pend = isr & ier;
> @@ -497,7 +497,7 @@ out:
>         dev_dbg(i2c->adap.dev.parent, "%s clr: 0x%x\n", __func__, clr);
>
>         xiic_setreg32(i2c, XIIC_IISR_OFFSET, clr);
> -       spin_unlock(&i2c->lock);
> +       mutex_unlock(&i2c->lock);
>         return IRQ_HANDLED;
>  }
>
> @@ -662,10 +662,10 @@ static void __xiic_start_xfer(struct xiic_i2c *i2c)
>
>  static void xiic_start_xfer(struct xiic_i2c *i2c)
>  {
> -       spin_lock(&i2c->lock);
> +       mutex_lock(&i2c->lock);
>         xiic_reinit(i2c);
>         __xiic_start_xfer(i2c);
> -       spin_unlock(&i2c->lock);
> +       mutex_unlock(&i2c->lock);
>  }
>
>  static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> @@ -745,7 +745,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>         i2c->adap.dev.parent = &pdev->dev;
>         i2c->adap.dev.of_node = pdev->dev.of_node;
>
> -       spin_lock_init(&i2c->lock);
> +       mutex_init(&i2c->lock);
>         init_waitqueue_head(&i2c->wait);
>
>         ret = devm_request_threaded_irq(&pdev->dev, irq, xiic_isr,
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
