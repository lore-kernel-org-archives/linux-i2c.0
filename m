From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date: Sun, 21 Oct 2018 16:39:07 +0200
Message-ID: <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-4-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625161303.7991-4-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
>
> This driver assumes that an interrupt line is always available for
> the I2C master. This is not always the case and this patch adds support
> for a polling version based on workqueue.

It probably makes sense to make it the switch between irq/irqless mode
dynamic to support the upcoming master_xfer_irqless logic.

> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 94 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 274d6eb22a2c..0dad1a512ef5 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -26,14 +27,19 @@
>  #include <linux/io.h>
>  #include <linux/log2.h>
>  #include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#define OCORES_FLAG_POLL BIT(0)
>
>  struct ocores_i2c {
>         void __iomem *base;
>         u32 reg_shift;
>         u32 reg_io_width;
> +       unsigned long flags;
>         wait_queue_head_t wait;
>         struct i2c_adapter adap;
>         struct i2c_msg *msg;
> +       struct work_struct xfer_work;
>         int pos;
>         int nmsgs;
>         int state; /* see STATE_ */
> @@ -166,8 +172,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
>                         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
>                         return;
>                 }
> -       } else
> +       } else {
>                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> +       }

This looks unrelated to $SUBJECT.

>
>         /* end of msg? */
>         if (i2c->pos == msg->len) {
> @@ -232,6 +239,50 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +
> +/**
> + * It waits until is possible to process some data

Please don't use "It waits ..", but rather "wait until ..". Same for
the other function comments.


> + * @i2c: ocores I2C device instance
> + *
> + * This is used when the device is in polling mode (interrupts disabled).
> + * It sleeps for the time necessary to send 8bits (one transfer over
> + * the I2C bus), then it permanently ping the ip-core until is possible
> + * to process data. The idea is that we sleep for most of the time at the
> + * beginning because we are sure that the ip-core is not ready yet.
> + */
> +static void ocores_poll_wait(struct ocores_i2c *i2c)
> +{
> +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
> +       u8 loop_on;
> +
> +       usleep_range(sleep_min, sleep_min + 10);

Where does this 10 come from?

> +       if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
> +               loop_on = OCI2C_STAT_BUSY;
> +       else
> +               loop_on = OCI2C_STAT_TIP;
> +       while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
> +               ;

How would an I2C transmission timeout be handled here?

> +}
> +
> +
> +/**
> + * It implements the polling logic
> + * @work: work instance descriptor
> + *
> + * Here we try to re-use as much as possible from the IRQ logic
> + */
> +static void ocores_work(struct work_struct *work)
> +{
> +       struct ocores_i2c *i2c = container_of(work,
> +                                             struct ocores_i2c, xfer_work);
> +       irqreturn_t ret;
> +
> +       do {
> +               ocores_poll_wait(i2c);
> +               ret = ocores_isr(-1, i2c);
> +       } while (ret != IRQ_NONE);

Might as well drop the negation, E.G. while (ret == IRQ_HANDLED);

> +}
> +
>  static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  {
>         struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> @@ -245,6 +296,9 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>         oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
>         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
>
> +       if (i2c->flags & OCORES_FLAG_POLL)
> +               schedule_work(&i2c->xfer_work);
> +
>         if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
>                                (i2c->state == STATE_DONE), HZ)) {
>                 return (i2c->state == STATE_DONE) ? num : -EIO;
> @@ -264,7 +318,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
>         u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
>
>         /* make sure the device is disabled */
> -       oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> +       ctrl &= ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN);
> +       oc_setreg(i2c, OCI2C_CONTROL, ctrl);

This looks unrelated to $SUBJECT

>
>         prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
>         prescale = clamp(prescale, 0, 0xffff);
> @@ -277,12 +332,16 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
>                 return -EINVAL;
>         }
>
> +

Here as well.

> @@ -538,6 +600,8 @@ static int ocores_i2c_remove(struct platform_device *pdev)
>  {
>         struct ocores_i2c *i2c = platform_get_drvdata(pdev);
>
> +       flush_scheduled_work();
> +

Why not cancel_work_sync(&i2c->xfer_work)?

-- 
Bye, Peter Korsgaard
