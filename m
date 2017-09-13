From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH v3 3/5] i2c: i2c-stm32f7: add driver
Date: Wed, 13 Sep 2017 23:26:39 +0200
Message-ID: <20170913212639.2zyvg24364ovwfxh@ninjato>
References: <1504251255-20469-1-git-send-email-pierre-yves.mordret@st.com>
 <1504251255-20469-4-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3nttgcsxruquswtt"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1504251255-20469-4-git-send-email-pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3nttgcsxruquswtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for this driver!

> +/**
> + * struct stm32f7_i2c_spec - private i2c specification timing
> + * @rate: I2C bus speed (Hz)
> + * @rate_min: 80% of I2C bus speed (Hz)
> + * @rate_max: 120% of I2C bus speed (Hz)

You would generate a clock which is higher than the requested one?
This is highly unusual. Any special reason?

> + * @fall_max: Max fall time of both SDA and SCL signals (ns)
> + * @rise_max: Max rise time of both SDA and SCL signals (ns)
> + * @hddat_min: Min data hold time (ns)
> + * @vddat_max: Max data valid time (ns)
> + * @sudat_min: Min data setup time (ns)
> + * @l_min: Min low period of the SCL clock (ns)
> + * @h_min: Min high period of the SCL clock (ns)
> + */
> +static struct stm32f7_i2c_spec i2c_specs[] = {
> +	[STM32_I2C_SPEED_STANDARD] = {
> +		.rate = 100000,
> +		.rate_min = 8000,

This is not 80%. Typo?

> +		.rate_max = 120000,
> +		.fall_max = 300,
> +		.rise_max = 1000,
> +		.hddat_min = 0,
> +		.vddat_max = 3450,
> +		.sudat_min = 250,
> +		.l_min = 4700,
> +		.h_min = 4000,
> +	},

...

> +	/*
> +	 * Among Prescaler possibilities discovered above figures out SCL Low
> +	 * and High Period. Provided:
> +	 * - SCL Low Period has to be higher than Low Period of tehs SCL Clock

tehs?

> +	 *   defined by I2C Specification. I2C Clock has to be lower than
> +	 *   (SCL Low Period - Analog/Digital filters) / 4.
> +	 * - SCL High Period has to be lower than High Period of the SCL Clock
> +	 *   defined by I2C Specification
> +	 * - I2C Clock has to be lower than SCL High Period
> +	 */

...

> +	/* NACK received */
> +	if (status & STM32F7_I2C_ISR_NACKF) {
> +		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK\n", __func__);
> +		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
> +		f7_msg->result = -EBADE;

-ENXIO (see Documentation/i2c/fault-codes)

...

> +	timeout = wait_for_completion_timeout(&i2c_dev->complete,
> +					      i2c_dev->adap.timeout);
> +	ret = f7_msg->result;
> +
> +	if (!timeout) {
> +		dev_dbg(i2c_dev->dev, "Access to slave 0x%x timed out\n",
> +			i2c_dev->msg->addr);
> +		ret = -ETIMEDOUT;
> +	}

Could you rename the variable to time_left? It looks strange, basically:

	if (!timeout)
		return -ETIMEDOUT

...

> +	adap->retries = 0;

Why no retries when you check for arbitration lost?

> +	adap->algo = &stm32f7_i2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	adap->dev.of_node = pdev->dev.of_node;
> +
> +	init_completion(&i2c_dev->complete);
> +
> +	ret = i2c_add_adapter(adap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add adapter\n");

Please remove, the core will print info when adding fails.


Rest looks good!

Thanks,

   Wolfram


--3nttgcsxruquswtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm5oosACgkQFA3kzBSg
KbZ3qA//TBkSQOVRq4ita4tDo6ZQl8wBSlEbZPYqVmSeVpDPRalLPppM/tUxhCj2
hLHwxaHROnctidhFO4fGtJzVXJiz1gm6+ztbra8w1sJvPc4j10IN5PI4Jy+lSFjB
w5coW4MIR0KmD405ujjtbKgJCuEIBJlJRJvdmlspPLv3E5HQ6l1PhR3YQV1u9JSN
89NN3hiqy1Z5UA0dcG5ZiydHYFvOvAnt/iat7+Ll65rCIb/2SeI4kXCuVwmpybLG
kHd8be6mX0siUf4d9L3Qsc/woIvDlZdk5HGz6UrvkOM2DK9NWkZhDuyC2TPNgAZe
ieT4ubjABQ8Z/fzjnpHu6HgmakACkB5fDzKgzZqMQbyRh4wnFgc5nSrEa4DnVv7T
97RfepJCOz80p9fpz6PHawrUw2VsFRniPmfVAWyIRIFL9YVfhPEIIuxQT7VCUbqo
wI/lPDvSKRLPARtIqx2GrGpWFhsZ6CxAT0tC8BQCr7Z/z0CX5BdZMv1+yWnkSySq
gXzISCoP5qBATmoXA8I0aHMwQkH5dFw40TTTM5lhOJZnNVzXzD3nyYspvMfxjTaU
blGf2rF50EqzhRlFvq7Qu5JhM1NKW+ucg9GNdkq56yqpoqDfeGwMcfh9L6b2GOWz
+8/2Kj21juPuSqAS3GIVZ2vKz/LY+vrNuNZifE0oDos08x2bxXk=
=Ez8X
-----END PGP SIGNATURE-----

--3nttgcsxruquswtt--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
