From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date: Wed, 24 Oct 2018 11:51:19 +0200
Message-ID: <4222986.LvGMQbjSbS@pcbe13614>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-4-federico.vaga@cern.ch> <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sunday, October 21, 2018 4:39:07 PM CEST Peter Korsgaard wrote:
> On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
> > This driver assumes that an interrupt line is always available for
> > the I2C master. This is not always the case and this patch adds support
> > for a polling version based on workqueue.
> 
> It probably makes sense to make it the switch between irq/irqless mode
> dynamic to support the upcoming master_xfer_irqless logic.
> 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 94
> >  ++++++++++++++++++++++++++++++++++------- 1 file changed, 79
> >  insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c index 274d6eb22a2c..0dad1a512ef5 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -13,6 +13,7 @@
> > 
> >   */
> >  
> >  #include <linux/clk.h>
> > 
> > +#include <linux/delay.h>
> > 
> >  #include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > 
> > @@ -26,14 +27,19 @@
> > 
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> >  #include <linux/spinlock.h>
> > 
> > +#include <linux/workqueue.h>
> > +
> > +#define OCORES_FLAG_POLL BIT(0)
> > 
> >  struct ocores_i2c {
> >  
> >         void __iomem *base;
> >         u32 reg_shift;
> >         u32 reg_io_width;
> > 
> > +       unsigned long flags;
> > 
> >         wait_queue_head_t wait;
> >         struct i2c_adapter adap;
> >         struct i2c_msg *msg;
> > 
> > +       struct work_struct xfer_work;
> > 
> >         int pos;
> >         int nmsgs;
> >         int state; /* see STATE_ */
> > 
> > @@ -166,8 +172,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8
> > stat)> 
> >                         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> >                         return;
> >                 
> >                 }
> > 
> > -       } else
> > +       } else {
> > 
> >                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> > 
> > +       }
> 
> This looks unrelated to $SUBJECT.

Do you prefer a different patch just for styling?

> 
> >         /* end of msg? */
> >         if (i2c->pos == msg->len) {
> > 
> > @@ -232,6 +239,50 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
> > 
> >         return IRQ_HANDLED;
> >  
> >  }
> > 
> > +
> > +/**
> > + * It waits until is possible to process some data
> 
> Please don't use "It waits ..", but rather "wait until ..". Same for
> the other function comments.

ok

> > + * @i2c: ocores I2C device instance
> > + *
> > + * This is used when the device is in polling mode (interrupts disabled).
> > + * It sleeps for the time necessary to send 8bits (one transfer over
> > + * the I2C bus), then it permanently ping the ip-core until is possible
> > + * to process data. The idea is that we sleep for most of the time at the
> > + * beginning because we are sure that the ip-core is not ready yet.
> > + */
> > +static void ocores_poll_wait(struct ocores_i2c *i2c)
> > +{
> > +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
> > +       u8 loop_on;
> > +
> > +       usleep_range(sleep_min, sleep_min + 10);
> 
> Where does this 10 come from?

It's true, it's just a random number. It can be zero as well, and we ask the 
system to just sleep for that amount of time. 

(1) usleep_range(sleep_min, sleep_min);

I noticed that it is a common practice to just put numbers that sounds 
correct, indeed there are many random numbers (not commented at least, so they 
are random numbers for the reader) in drivers/i2c/busses when they use this 
function.

This magic number can be also something like:
 
(2) usleep_range(sleep_min, sleep_min * 1.10);

to give a 10% (again random choice) extra margin before starting to actively 
poll.

But I agree that random numbers are not good. So I'm ok with option (1). I did 
not try it, but I think is fine to give a zero delta (delta=max-min=0).

> 
> > +       if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
> > +               loop_on = OCI2C_STAT_BUSY;
> > +       else
> > +               loop_on = OCI2C_STAT_TIP;
> > +       while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
> > +               ;
> 
> How would an I2C transmission timeout be handled here?

There is the assumption that the hardware is alive and what we read from 
oc_getreg() is correct. With this assumption, when there is a timeout this 
will happen:
1. STOP command (previous patch)
2. both TIP and BUSY will become zero at some point and we get out from the 
loop

I can see now that there are cases when it may loop forever: for example if 
the device is broken and it does answer always with 0xFFFF: we should not 
break the host as well :)

I can fix this.
 
> > +}
> > +
> > +
> > +/**
> > + * It implements the polling logic
> > + * @work: work instance descriptor
> > + *
> > + * Here we try to re-use as much as possible from the IRQ logic
> > + */
> > +static void ocores_work(struct work_struct *work)
> > +{
> > +       struct ocores_i2c *i2c = container_of(work,
> > +                                             struct ocores_i2c,
> > xfer_work); +       irqreturn_t ret;
> > +
> > +       do {
> > +               ocores_poll_wait(i2c);
> > +               ret = ocores_isr(-1, i2c);
> > +       } while (ret != IRQ_NONE);
> 
> Might as well drop the negation, E.G. while (ret == IRQ_HANDLED);

ok

> > +}
> > +
> > 
> >  static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >  int num) {
> >  
> >         struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> > 
> > @@ -245,6 +296,9 @@ static int ocores_xfer(struct i2c_adapter *adap,
> > struct i2c_msg *msgs, int num)> 
> >         oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
> >         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> > 
> > +       if (i2c->flags & OCORES_FLAG_POLL)
> > +               schedule_work(&i2c->xfer_work);
> > +
> > 
> >         if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> >         
> >                                (i2c->state == STATE_DONE), HZ)) {
> >                 
> >                 return (i2c->state == STATE_DONE) ? num : -EIO;
> > 
> > @@ -264,7 +318,8 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)> 
> >         u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> >         
> >         /* make sure the device is disabled */
> > 
> > -       oc_setreg(i2c, OCI2C_CONTROL, ctrl &
> > ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +       ctrl &= ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN);
> > +       oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> 
> This looks unrelated to $SUBJECT
>
> 
> >         prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
> >         prescale = clamp(prescale, 0, 0xffff);
> > 
> > @@ -277,12 +332,16 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)> 
> >                 return -EINVAL;
> >         
> >         }
> > 
> > +
> 
> Here as well.
>
> 
> > @@ -538,6 +600,8 @@ static int ocores_i2c_remove(struct platform_device
> > *pdev)> 
> >  {
> >  
> >         struct ocores_i2c *i2c = platform_get_drvdata(pdev);
> > 
> > +       flush_scheduled_work();
> > +
> 
> Why not cancel_work_sync(&i2c->xfer_work)?

you are right!
