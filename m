From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Clarification on i2c-pca-platform driver timeout
Date: Mon, 23 Feb 2009 16:52:22 +0100
Message-ID: <20090223165222.6e376e11@hyperion.delvare>
References: <20090223152308.1db394a6@hyperion.delvare>
	<20090223145027.GA3052@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090223145027.GA3052-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 23 Feb 2009 15:50:27 +0100, Wolfram Sang wrote:
> Hello Jean,
> 
> On Mon, Feb 23, 2009 at 03:23:08PM +0100, Jean Delvare wrote:
> > Hi Wolfram,
> > 
> > I would like you to clarify the situation when it comes to the value of
> > the timeout field of struct i2c_pca9564_pf_platform_data:
> > 
> > struct i2c_pca9564_pf_platform_data {
> > 	(...)
> > 	int timeout;		/* timeout = this value * 10us */
> > };
> > 
> > The only user, board-sh7785lcr.c, sets this value to 100, resulting in
> > a 1 ms timeout. This seems really short. Is this really intended?
> 
> This is a typo. It should say 10ms as a unit, resulting in 1s total.

OK, makes more sense...

> > Why is the timeout value defined in such a strange unit?
> 
> I didn't change this in i2c-algo-pca.c back then, look at the beginning
> of pca_xfer:
> 
> while ((state = pca_status(adap)) != 0xf8 && timeout--) {
>         msleep(10);
> }

Ah, thanks for pointing me to this piece of code... which I have
forgotten in my previous patch. Poor code, as even if timeout is
expressed in units of 10 ms, msleep(10) can sleep more then 10 ms... up
to 20 ms at HZ=100. This should be converted to time_after().

> So, timeout acts as a loop counter in waiting for a free bus, which is
> why your change in "Adapter timeout is in jiffies" alone won't do for
> pca-based drivers. There seems to be a bigger rework needed for handling
> the timeout :( I wanted to look into it this evening, but it seems to
> be a bit urgent?

No, it's not that urgent. Most of the change set is for 2.6.30 anyway,
as there is no bug that needs immediate fixing, more of a general
cleanup. I'll back out the i2c-pca-isa part for now.

> > static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
> > {
> > 	struct i2c_pca_pf_data *i2c;
> > 	(...)
> > 	struct i2c_pca9564_pf_platform_data *platform_data =
> > 				pdev->dev.platform_data;
> > 	(...)
> > 	i2c->adap.timeout = platform_data->timeout;
> > 
> > The problem is that i2c->adap.timeout is supposed to be expressed in
> > jiffies, not units of 10 us. So there is a conversion missing.
> 
> Yup, see above.
> 
> > Lastly, you define a timeout value but never use it. Shouldn't you use
> > wait_event_interruptible_timeout() instead of
> > wait_event_interruptible() in i2c_pca_pf_waitforcompletion?
> 
> This is probably one part of the complete solution.
> 
> > An upcoming patch will add code which handles a timeout at i2c-core
> > level, so it matters to get all i2c bus drivers right first.
> 
> Sounds reasonable...

If you can come up with a working patch in the next few days, please
do. If not, I'll take care of it. In the meantime I'm reviewing your
patch adding PCA9665 support.

-- 
Jean Delvare
