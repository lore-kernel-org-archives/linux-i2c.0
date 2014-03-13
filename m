From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: new bus driver for efm32
Date: Thu, 13 Mar 2014 22:26:13 +0100
Message-ID: <20140313212613.GB15674@pengutronix.de>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140310075558.GD2571@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140310075558.GD2571@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Mar 10, 2014 at 08:55:58AM +0100, Wolfram Sang wrote:
> > +#include <linux/platform_data/efm32-i2c.h>
>=20
> Shouldn't a new platform like efm32 be DT only?
it is, at least in mainline. My (not very strong) POV is that it's not
much effort/code size to support both. I dropped the non-DT part, it's
easily readded if need should arise.

> > +
> > +struct efm32_i2c_ddata {
> > +	struct i2c_adapter adapter;
> > +	spinlock_t lock;
>=20
> No need, see later.
Ok.
=20
> > ...
> > +static u32 efm32_i2c_read32(struct efm32_i2c_ddata *ddata, unsigne=
d offset)
> > +{
> > +	return readl(ddata->base + offset);
> > +}
> > +
> > +static void efm32_i2c_write32(struct efm32_i2c_ddata *ddata,
> > +		unsigned offset, u32 value)
> > +{
> > +	writel(value, ddata->base + offset);
> > +}
>=20
> Do those two really help readability?
I like them to add debug code, usually trace_printk.

> > +static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
> > +{
> > +	struct i2c_msg *cur_msg =3D &ddata->msgs[ddata->current_msg];
> > +
> > +	dev_dbg(&ddata->adapter.dev, "send msg %zu/%zu (addr =3D %x, flag=
s =3D %x, if =3D %08x)\n",
> > +			ddata->current_msg, ddata->num_msgs, cur_msg->addr,
> > +			cur_msg->flags, efm32_i2c_read32(ddata, REG_IF));
>=20
> Remove. We have stuff like this in the core and will soon get tracing
> functionality.
ok, dropped with several other dev_dbg.

> > +	switch (state & REG_STATE_STATE__MASK) {
> > +	case REG_STATE_STATE_IDLE:
> > +		/* arbitration lost? */
> > +		complete(&ddata->done);
>=20
> If arbitration is lost, you should return -EAGAIN.
ok.

> > +		break;
> > +	case REG_STATE_STATE_WAIT:
> > +		/* huh, this shouldn't happen */
> > +		BUG();
>=20
> Is this really a reason to halt the kernel?
No, probably not. What do you suggest? Reinit the hardware, report and
return an error?

> > +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> > +		struct i2c_msg *msgs, int num)
> > +{
> > +	struct efm32_i2c_ddata *ddata =3D i2c_get_adapdata(adap);
> > +	int ret =3D -EBUSY;
> > +
> > +	spin_lock_irq(&ddata->lock);
> > +
> > +	if (ddata->msgs)
> > +		/*
> > +		 * XXX: can .master_xfer be called when the previous is still
> > +		 * running?
> > +		 */
>=20
> Check the core. It has per adapter locks. So the lock can go away.
ok. So I can also drop the "if (ddata->msgs)" check, right?
=20
> > +		goto out_unlock;
> > +
> > +	ddata->msgs =3D msgs;
> > +	ddata->num_msgs =3D num;
> > +	ddata->current_word =3D 0;
> > +	ddata->current_msg =3D 0;
> > +
> > +	init_completion(&ddata->done);
>=20
> reinit_completion() here and init_completion() in probe.
*nod*

> > +
> > +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> > +			efm32_i2c_read32(ddata, REG_STATE),
> > +			efm32_i2c_read32(ddata, REG_STATUS));
> > +
> > +	efm32_i2c_send_next_msg(ddata);
> > +
> > +	spin_unlock_irq(&ddata->lock);
> > +
> > +	wait_for_completion(&ddata->done);
> > +
> > +	spin_lock_irq(&ddata->lock);
> > +
> > +	if (ddata->current_msg >=3D ddata->num_msgs)
> > +		ret =3D ddata->num_msgs;
> > +	else
> > +		ret =3D -EIO;
>=20
> Check Documentation/i2c/fault-codes for more fine grained responses.
ok, I have EAGAIN for arbitration lost, ENXIO for NAck in address phase
and EIO for NAck in data phase now. Sounds good?
=20
> > +
> > +	ddata->msgs =3D NULL;
> > +
> > +out_unlock:
> > +	spin_unlock_irq(&ddata->lock);
> > +	return ret;
> > +}
> > +
> > +static u32 efm32_i2c_functionality(struct i2c_adapter *adap)
> > +{
> > +	/* XXX: some more? */
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>=20
> That is usually enough. Make sure you checked SMBUS_QUICK, though
> (i2cdetect -q ...).
Both -q and -r seem to do the right thing.

> > +	ret =3D of_property_read_u32(np, "location", &location);
>=20
> Huh? Is this an accepted binding? Doesn't look like it because of a
> generic name and IMO a specific use-case. BTW the binding documentati=
on
> for this driver is missing.
Well, I got it in for the serial and spi driver. It wasn't without
discussion, but for lack of better approaches it was accepted. The
problem is that there are two places to care for to setup the pin muxin=
g
on efm32. The pins that are used in the (here) i2c function are
selected in the ROUTE register in the I2C module's address space.
Still I need to configure the pins in the GPIO module as
input; pushpull; open drain or open collector (and a few more details
like driver strength). You could abstract that with a big list of
phandles and so have pinmuxing only in the pin controler device, but
that's ugly, error prone to use and implement, not understandable with
the hardware reference and (I guess) not how the hardware works
internally.
Regarding the generic name: I don't care much, but I don't have a
problem with it. IMHO it's implicitly name-spaced by the compatible
string which starts with "efm32," and so is fine. I'd like to have the
same property name for all efm32 device drivers and "location" matches
the hardware reference manual (apart from capitalization).

> > ...
> > +	/* i2c core takes care about bus numbering using an alias */
> > +	ddata->adapter.nr =3D -1;
>=20
> In case of DT only, drop this and simply use i2c_add_adapter.
done

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to determine base address\n");
>=20
> devm_ioremap_resource() checks for a valid resource. Drop this.
But resource_size doesn't ...
=20
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (resource_size(res) < 0x42) {
> > +		dev_err(&pdev->dev, "memory resource too small\n");
> > +		return -EINVAL;
> > +	}
>=20
> I'd drop this check since, but I won't force you to.
I'd understand your sentence with s/since//, not sure about it as is.
Anyhow, I like this check.

> > +	rate =3D clk_get_rate(ddata->clk);
> > +	if (!rate) {
> > +		dev_err(&pdev->dev, "there is no input clock available\n");
> > +		ret =3D -EIO;
> > +		goto err_disable_clk;
> > +	}
> > +	clkdiv =3D DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1;
> > +	if (clkdiv >=3D 0x200) {
> > +		dev_err(&pdev->dev,
> > +				"input clock too fast (%lu) to divide down to bus freq (%lu)",
> > +				rate, ddata->pdata.frequency);
> > +		ret =3D -EIO;
> > +		goto err_disable_clk;
> > +	}
>=20
> -EIO for clocks errors? Is this common?
Changed to ENODEV. Ok?

> > +static int efm32_i2c_remove(struct platform_device *pdev)
> > +{
> > +	struct efm32_i2c_ddata *ddata =3D platform_get_drvdata(pdev);
> > +
> > +	free_irq(ddata->irq, ddata);
> > +	clk_disable_unprepare(ddata->clk);
>=20
> No i2c_del_adapter()?
added.

I fixed the driver in my tree for now, will resend when we settled on
the things still open.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
