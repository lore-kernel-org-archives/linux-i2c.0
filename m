From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: new bus driver for efm32
Date: Mon, 10 Mar 2014 08:55:58 +0100
Message-ID: <20140310075558.GD2571@katana>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392027598-29015-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Uwe,

> +#include <linux/platform_data/efm32-i2c.h>

Shouldn't a new platform like efm32 be DT only?

> +
> +struct efm32_i2c_ddata {
> +	struct i2c_adapter adapter;
> +	spinlock_t lock;

No need, see later.

> +	struct clk *clk;
> +	void __iomem *base;
> +	unsigned int irq;
> +	struct efm32_i2c_pdata pdata;
> +
> +	/* transfer data */
> +	struct completion done;
> +	struct i2c_msg *msgs;
> +	size_t num_msgs;
> +	size_t current_word, current_msg;
> +};
> +
> +static u32 efm32_i2c_read32(struct efm32_i2c_ddata *ddata, unsigned offset)
> +{
> +	return readl(ddata->base + offset);
> +}
> +
> +static void efm32_i2c_write32(struct efm32_i2c_ddata *ddata,
> +		unsigned offset, u32 value)
> +{
> +	writel(value, ddata->base + offset);
> +}

Do those two really help readability?

> +static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
> +{
> +	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
> +
> +	dev_dbg(&ddata->adapter.dev, "send msg %zu/%zu (addr = %x, flags = %x, if = %08x)\n",
> +			ddata->current_msg, ddata->num_msgs, cur_msg->addr,
> +			cur_msg->flags, efm32_i2c_read32(ddata, REG_IF));

Remove. We have stuff like this in the core and will soon get tracing
functionality.

> +	efm32_i2c_write32(ddata, REG_CMD, REG_CMD_START);
> +	efm32_i2c_write32(ddata, REG_TXDATA, cur_msg->addr << 1 |
> +			(cur_msg->flags & I2C_M_RD ? 1 : 0));
> +}
> +
> +static void efm32_i2c_send_next_byte(struct efm32_i2c_ddata *ddata)
> +{
> +	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
> +	dev_dbg(&ddata->adapter.dev, "%s, %zu %zu\n",
> +			__func__, ddata->current_word, cur_msg->len);

Hmm, quite much debug output in this driver...

...

> +	switch (state & REG_STATE_STATE__MASK) {
> +	case REG_STATE_STATE_IDLE:
> +		/* arbitration lost? */
> +		complete(&ddata->done);

If arbitration is lost, you should return -EAGAIN.

> +		break;
> +	case REG_STATE_STATE_WAIT:
> +		/* huh, this shouldn't happen */
> +		BUG();

Is this really a reason to halt the kernel?

> +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> +		struct i2c_msg *msgs, int num)
> +{
> +	struct efm32_i2c_ddata *ddata = i2c_get_adapdata(adap);
> +	int ret = -EBUSY;
> +
> +	spin_lock_irq(&ddata->lock);
> +
> +	if (ddata->msgs)
> +		/*
> +		 * XXX: can .master_xfer be called when the previous is still
> +		 * running?
> +		 */

Check the core. It has per adapter locks. So the lock can go away.

> +		goto out_unlock;
> +
> +	ddata->msgs = msgs;
> +	ddata->num_msgs = num;
> +	ddata->current_word = 0;
> +	ddata->current_msg = 0;
> +
> +	init_completion(&ddata->done);

reinit_completion() here and init_completion() in probe.

> +
> +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> +			efm32_i2c_read32(ddata, REG_STATE),
> +			efm32_i2c_read32(ddata, REG_STATUS));
> +
> +	efm32_i2c_send_next_msg(ddata);
> +
> +	spin_unlock_irq(&ddata->lock);
> +
> +	wait_for_completion(&ddata->done);
> +
> +	spin_lock_irq(&ddata->lock);
> +
> +	if (ddata->current_msg >= ddata->num_msgs)
> +		ret = ddata->num_msgs;
> +	else
> +		ret = -EIO;

Check Documentation/i2c/fault-codes for more fine grained responses.

> +
> +	ddata->msgs = NULL;
> +
> +out_unlock:
> +	spin_unlock_irq(&ddata->lock);
> +	return ret;
> +}
> +
> +static u32 efm32_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	/* XXX: some more? */
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;

That is usually enough. Make sure you checked SMBUS_QUICK, though
(i2cdetect -q ...).

> +	ret = of_property_read_u32(np, "location", &location);

Huh? Is this an accepted binding? Doesn't look like it because of a
generic name and IMO a specific use-case. BTW the binding documentation
for this driver is missing.

> +	if (!ret) {
> +		dev_dbg(&pdev->dev, "using location %u\n", location);
> +	} else {
> +		/* default to location configured in hardware */
> +		location = efm32_i2c_get_configured_location(ddata);
> +
> +		dev_info(&pdev->dev, "fall back to location %u\n", location);
> +	}
> +
> +	ddata->pdata.location = location;
> +
> +	ret = of_property_read_u32(np, "clock-frequency", &frequency);
> +	if (!ret) {
> +		dev_dbg(&pdev->dev, "using frequency %u\n", frequency);
> +	} else {
> +		frequency = 100000;
> +		dev_info(&pdev->dev, "defaulting to 100 kHz\n");
> +	}
> +	ddata->pdata.frequency = frequency;
> +
> +	/* i2c core takes care about bus numbering using an alias */
> +	ddata->adapter.nr = -1;

In case of DT only, drop this and simply use i2c_add_adapter.

> +
> +	return 0;
> +}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to determine base address\n");

devm_ioremap_resource() checks for a valid resource. Drop this.

> +		return -ENODEV;
> +	}
> +
> +	if (resource_size(res) < 0x42) {
> +		dev_err(&pdev->dev, "memory resource too small\n");
> +		return -EINVAL;
> +	}

I'd drop this check since, but I won't force you to.

> +	ret = efm32_i2c_probe_dt(pdev, ddata);
> +	if (ret > 0) {
> +		/* not created by device tree */

As said above: Wondering about this driver not being DT only.

> +	rate = clk_get_rate(ddata->clk);
> +	if (!rate) {
> +		dev_err(&pdev->dev, "there is no input clock available\n");
> +		ret = -EIO;
> +		goto err_disable_clk;
> +	}
> +	clkdiv = DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1;
> +	if (clkdiv >= 0x200) {
> +		dev_err(&pdev->dev,
> +				"input clock too fast (%lu) to divide down to bus freq (%lu)",
> +				rate, ddata->pdata.frequency);
> +		ret = -EIO;
> +		goto err_disable_clk;
> +	}

-EIO for clocks errors? Is this common?

> +static int efm32_i2c_remove(struct platform_device *pdev)
> +{
> +	struct efm32_i2c_ddata *ddata = platform_get_drvdata(pdev);
> +
> +	free_irq(ddata->irq, ddata);
> +	clk_disable_unprepare(ddata->clk);

No i2c_del_adapter()?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id efm32_i2c_dt_ids[] = {
> +	{
> +		.compatible = "efm32,i2c",
> +	}, {
> +		/* sentinel */
> +	}

One line per entry is better to read IMO.

Regards,

   Wolfram

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHXANAAoJEBQN5MwUoCm2WX0QALDSvkywCZ3K0qDgWvTqhVJ0
dwc0ZDBUXaYmkw5QEsr+SMZympF6XI37NpxnVh8MpKFIrWk7fdXAOB1Onlp1o6S2
EjFaWG8n5B+RBWuHSUz4FuH7D7glRLoua8uoTYr9sXvv/YRh+4XJgDmB/qOq3APw
XvaxU62f/r9IhRBYqq+49pedxbAaFupsYLQkqk8mQxGmtcK2ImD4kHAF3+nTSjtr
8xn5zSsgzGFTfd5YaEKiV4FXpsEItbau0YovKR1juAc6zusQ47/pJWyH+qfN3M8f
iVMKrvoIk39JbqXhcSuPw24Onk3NVzdCJszB/EtUuQHCUefbeTGoQux+9Na648Za
WTigpNcbareiUFiNcrRYpC+Jtba4Pwt6vZSi5glDXHfSmpc6V/ysbvEy5ASP0QUB
yL4NgwVuO974iza1PTr88VGaFKG7dRmhBb1MZSewraXKB+yDiuSsnMotQwBrI63Z
CFRQXDIdOiW6SFyDCaqabgg0SMWrWzh3/tq6zZiTNP8ByQPMZuWyE39KQmX8qmul
AGT8/Zn6BOqotYW0TFue5YvJeNm3W+9gScwwu8QVZxJLD8E/AyAQ2HeiBQjVxqR6
RDpvyXwhamNZ7Tsi9ZLV1TtM/a85uYfSjWvnOkWvc5XW5Bs/UQYJeXtuPxPaeGJ2
sG8MVvZXpj1/YEolAFCm
=9xCM
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
