From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date: Mon, 11 Feb 2019 14:14:59 +0100
Message-ID: <1845501.4feNL5aF6H@pcbe13614>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211083122.32485-4-federico.vaga@cern.ch> <7ef62069-3ce1-2c31-b64e-3a5d045990e5@axentia.se>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ef62069-3ce1-2c31-b64e-3a5d045990e5@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, February 11, 2019 11:43:45 AM CET Peter Rosin wrote:
> On 2019-02-11 09:31, Federico Vaga wrote:
> 
> > This driver assumes that an interrupt line is always available for
> > the I2C master. This is not always the case and this patch adds support
> > for a polling version.
> > 
> > Report from Andrew Lunn:
> > 
> > 
> >   I did some timing tests for this. On my box, we request a udelay of
> >   80uS. The kernel actually delays for about 79uS. We then spin in
> >   ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
> > 
> > 
> > 
> >   There are actually 9 bits on the wire, not 8, since there is an
> >   ACK/NACK bit after the actual data transfer. So i changed the delay to
> >   (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
> >   not looping at all. But for reading an 4K AT24 EEPROM, it increased
> >   the read time by 10ms, from 424ms to 434ms. So we should probably keep
> >   with 8.
> > 
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 180
> >  +++++++++++++++++++++++++++++++++++-----
 1 file changed, 160
> >  insertions(+), 20 deletions(-)
> > 
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c
 index fcc2558..d42a324 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -13,6 +13,7 @@
> > 
> >   */
> >  
> >  
> >  #include <linux/clk.h>
> > 
> > +#include <linux/delay.h>
> > 
> >  #include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > 
> > @@ -26,6 +27,9 @@
> > 
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> >  #include <linux/spinlock.h>
> > 
> > +#include <linux/jiffies.h>
> > +
> > +#define OCORES_FLAG_POLL BIT(0)
> > 
> >  
> >  /**
> >  
> >   * @process_lock: protect I2C transfer process.
> > 
> > @@ -35,6 +39,7 @@ struct ocores_i2c {
> > 
> >  	void __iomem *base;
> >  	u32 reg_shift;
> >  	u32 reg_io_width;
> > 
> > +	unsigned long flags;
> > 
> >  	wait_queue_head_t wait;
> >  	struct i2c_adapter adap;
> >  	struct i2c_msg *msg;
> > 
> > @@ -246,10 +251,117 @@ static void ocores_process_timeout(struct
> > ocores_i2c *i2c)
> 
> >  	spin_unlock_irqrestore(&i2c->process_lock, flags);
> >  
> >  }
> >  
> > 
> > -static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > int num)
 +/**
> > + * Wait until something change in a given register
> > + * @i2c: ocores I2C device instance
> > + * @reg: register to query
> > + * @mask: bitmask to apply on register value
> > + * @val: expected result
> > + * @timeout: timeout in jiffies
> > + *
> > + * Timeout is necessary to avoid to stay here forever when the chip
> > + * does not answer correctly.
> > + *
> > + * Return: 0 on success, -ETIMEDOUT on timeout
> > + */
> > +static int ocores_wait(struct ocores_i2c *i2c,
> > +		       int reg, u8 mask, u8 val,
> > +		       const unsigned long timeout)
> > +{
> > +	unsigned long j;
> > +
> > +	j = jiffies + timeout;
> > +	while (1) {
> > +		u8 status = oc_getreg(i2c, reg);
> > +
> > +		if ((status & mask) == val)
> > +			break;
> > +
> > +		if (time_after(jiffies, j))
> > +			return -ETIMEDOUT;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/**
> > + * Wait until is possible to process some data
> > + * @i2c: ocores I2C device instance
> > + *
> > + * Used when the device is in polling mode (interrupts disabled).
> > + *
> > + * Return: 0 on success, -ETIMEDOUT on timeout
> > + */
> > +static int ocores_poll_wait(struct ocores_i2c *i2c)
> > +{
> > +	u8 mask;
> > +	int err;
> > +
> > +	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR) {
> > +		/* transfer is over */
> > +		mask = OCI2C_STAT_BUSY;
> > +	} else {
> > +		/* on going transfer */
> > +		mask = OCI2C_STAT_TIP;
> > +		/*
> > +		 * We wait for the data to be transfered (8bit),
> > +		 * then we start polling on the ACK/NACK bit
> > +		 */
> > +		udelay((8 * 1000) / i2c->bus_clock_khz);
> > +	}
> > +
> > +	/*
> > +	 * once we are here we expect to get the expected result immediately
> > +	 * so if after 1ms we timeout then something is broken.
> > +	 */
> > +	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
> > +	if (err)
> > +		dev_warn(i2c->adap.dev.parent,
> > +			 "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
> > +			 __func__, mask);
> > +	return err;
> > +}
> > +
> > +
> > +/**
> > + * It handles an IRQ-less transfer
> > + * @i2c: ocores I2C device instance
> > + *
> > + * Even if IRQ are disabled, the I2C OpenCore IP behavior is exactly the
> > same
 + * (only that IRQ are not produced). This means that we can re-use
> > entirely + * ocores_isr(), we just add our polling code around it.
> > + *
> > + * It can run in atomic context
> > + */
> > +static void ocores_process_polling(struct ocores_i2c *i2c)
> > +{
> > +	while (1) {
> > +		irqreturn_t ret;
> > +		int err;
> > +
> > +		err = ocores_poll_wait(i2c);
> > +		if (err) {
> > +			i2c->state = STATE_ERROR;
> > +			break; /* timeout */
> > +		}
> > +
> > +		ret = ocores_isr(-1, i2c);
> > +		if (ret == IRQ_NONE)
> > +			break; /* all messages have been transfered */
> > +	}
> > +}
> > +
> > +static int ocores_xfer_core(struct ocores_i2c *i2c,
> > +			    struct i2c_msg *msgs, int num,
> > +			    bool polling)
> > 
> >  {
> > 
> > -	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> > 
> >  	int ret;
> > 
> > +	u8 ctrl;
> > +
> > +	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> > +	if (polling)
> > +		oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~OCI2C_CTRL_IEN);
> > +	else
> > +		oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN);
> > 
> >  
> >  
> >  	i2c->msg = msgs;
> >  	i2c->pos = 0;
> > 
> > @@ -259,16 +371,37 @@ static int ocores_xfer(struct i2c_adapter *adap,
> > struct i2c_msg *msgs, int num)
> 
> >  	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
> >  	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> >  
> >  
> > 
> > -	ret = wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> > -				 (i2c->state == STATE_DONE), HZ);
> > -	if (ret == 0) {
> > -		ocores_process_timeout(i2c);
> > -		return -ETIMEDOUT;
> > +	if (polling) {
> > +		ocores_process_polling(i2c);
> > +	} else {
> > +		ret = wait_event_timeout(i2c->wait,
> > +					 (i2c->state == STATE_ERROR) ||
> > +					 (i2c->state == STATE_DONE), HZ);
> > +		if (ret == 0) {
> > +			ocores_process_timeout(i2c);
> > +			return -ETIMEDOUT;
> > +		}
> > 
> >  	}
> >  
> >  
> >  
> >  	return (i2c->state == STATE_DONE) ? num : -EIO;
> >  
> >  }
> >  
> > 
> > +static int ocores_xfer_polling(struct i2c_adapter *adap,
> > +			       struct i2c_msg *msgs, int num)
> > +{
> > +	return ocores_xfer_core(i2c_get_adapdata(adap), msgs, num, true);
> > +}
> > +
> > +static int ocores_xfer(struct i2c_adapter *adap,
> > +		       struct i2c_msg *msgs, int num)
> > +{
> > +	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> > +
> > +	if (i2c->flags & OCORES_FLAG_POLL)
> > +		return ocores_xfer_polling(adap, msgs, num);
> > +	return ocores_xfer_core(i2c, msgs, num, false);
> > +}
> > +
> > 
> >  static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
> >  {
> >  
> >  	int prescale;
> > 
> > @@ -294,7 +427,7 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)
> 
> >  
> >  
> >  	/* Init the device */
> >  	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
> > 
> > -	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
> > +	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
> 
> 
> You fix this up in patch 5 (in what is perhaps carelessly marketed as
> fixes for minor checkpatch issues), but for this patch you are actually
> no longer making sure that you clear the OCI2C_CTRL_IEN bit as the code
> used to before this patch. I think you intended to preserve that
> behavior, no?

I think you got confused by the two patches because those lines look very 
similar.

In PATCH 5 what you see is the "style fix" to clear EN and IEN before clock 
configuration

in PATCH 3 (this one) what you see is when later (same function, after clock 
configuration) the device is re-enabled (EN), but without enabling the 
interrupt because on polling configuration we do not want to see interrupt 
flowing.

So, the behavior is preserved for what concern clearing the IEN bit before 
clock configuration.

am I wrong?

> 
> Cheers,
> Peter
> 
> 
> >  
> >  
> >  	return 0;
> >  
> >  }
> > 
> > @@ -451,10 +584,6 @@ static int ocores_i2c_probe(struct platform_device
> > *pdev)
> 
> >  	int ret;
> >  	int i;
> >  
> >  
> > 
> > -	irq = platform_get_irq(pdev, 0);
> > -	if (irq < 0)
> > -		return irq;
> > -
> > 
> >  	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> >  	if (!i2c)
> >  	
> >  		return -ENOMEM;
> > 
> > @@ -509,18 +638,29 @@ static int ocores_i2c_probe(struct platform_device
> > *pdev)
> 
> >  		}
> >  	
> >  	}
> >  
> >  
> > 
> > +	init_waitqueue_head(&i2c->wait);
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq == -ENXIO) {
> > +		i2c->flags |= OCORES_FLAG_POLL;
> > +	} else {
> > +		if (irq < 0)
> > +			return irq;
> > +	}
> > +
> > +	if (!(i2c->flags & OCORES_FLAG_POLL)) {
> > +		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
> > +				       pdev->name, i2c);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Cannot claim IRQ\n");
> > +			goto err_clk;
> > +		}
> > +	}
> > +
> > 
> >  	ret = ocores_init(&pdev->dev, i2c);
> >  	if (ret)
> >  	
> >  		goto err_clk;
> >  
> >  
> > 
> > -	init_waitqueue_head(&i2c->wait);
> > -	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
> > -			       pdev->name, i2c);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "Cannot claim IRQ\n");
> > -		goto err_clk;
> > -	}
> > -
> > 
> >  	/* hook up driver to tree */
> >  	platform_set_drvdata(pdev, i2c);
> >  	i2c->adap = ocores_adapter;
> > 
> > 
> 
> 
