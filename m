From: Alexander Sverdlin <alexander.sverdlin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: davinci: Refactor =?utf-8?b?aTJjX2RhdmluY2lfd2FpdF9idXNfbm90X2J1c3koKQ==?=
Date: Wed, 11 Mar 2015 19:22:22 +0000 (UTC)
Message-ID: <loom.20150311T201816-754@post.gmane.org>
References: <55003E6B.40008@nokia.com> <55008AD7.4070905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

Grygorii.Strashko@... <grygorii.strashko@...> writes:
> > +/*
> > + * Wait until specific bit in status register has particular value
> > + * Function returns 0 if condition was met,
> > + * -ETIMEDOUT in case of timeout.
> > + */
> > +static int i2c_davinci_wait_status_change(struct davinci_i2c_dev *dev, 
u16 mask,
> > +                                          u16 val)
> 
> do we really need it as separate function? (even if it looks good:)

Initially I had a patch for "recover" function also, but I've dropped it and 
I'm going to test your series. It might be re-used in case if we want to 
wait for something in the recover...
 
> > +{
> > +	unsigned long timeout = jiffies + dev->adapter.timeout;
> > +
> > +	while ((davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG) & mask) != 
val) {
> > +		if (time_after(jiffies, timeout))
> > +			return -ETIMEDOUT;
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		schedule_timeout(1);
> 
> schedule_timeout_uninterruptible()

Will do in v2...

[...]

> > +	if (i2c_davinci_wait_status_change(dev, DAVINCI_I2C_STR_BB, 0)) {
> > +		dev_warn(dev->dev, "timeout waiting for bus ready\n");
> > +		davinci_i2c_recover_bus(dev);
> > +		i2c_davinci_init(dev);
> > +		/*
> > +		 * the bus should not be busy after init, otherwise 
something
> > +		 * is badly broken
> > +		 */
> 
> I think you should recheck BB and return error if it's still detected.

Good idea! Will do in v2...

> >   	}
> >
> >   	return 0;
> >  <at>  <at>  -449,7 +456,7  <at>  <at>  i2c_davinci_xfer(struct 
i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >
> >   	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
> >
> > -	ret = i2c_davinci_wait_bus_not_busy(dev, 1);
> > +	ret = i2c_davinci_wait_bus_not_busy(dev);
> >   	if (ret < 0) {
> >   		dev_warn(dev->dev, "timeout waiting for bus ready\n");
> >   		return ret;


Alex.
