From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Date: Tue, 31 Jul 2018 22:09:32 +0200
Message-ID: <20180731200932.n7djds2rmqhclit5@ninjato>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
 <20180726154603.5089-6-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4utn4zc36jrfmsgr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180726154603.5089-6-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org, linux-i2c@vger.kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org


--4utn4zc36jrfmsgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Thu, Jul 26, 2018 at 09:16:02PM +0530, Manivannan Sadhasivam wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Peter Rosin <peda@axentia.se>

Looks mostly good already. Thanks Peter for the initial review!

> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{
> +	struct owl_i2c_dev *i2c_dev =3D _dev;
> +	struct i2c_msg *msg =3D i2c_dev->msg;
> +	unsigned long flags;
> +	unsigned int stat, fifostat;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	fifostat =3D readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
> +	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
> +		dev_dbg(&i2c_dev->adap.dev, "received NACK from device\n");
> +		goto stop;
> +	}
> +
> +	stat =3D readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (stat & OWL_I2C_STAT_BEB) {
> +		dev_dbg(&i2c_dev->adap.dev, "bus error\n");
> +		goto stop;
> +	}

I wonder if you can't pass back the different errors to the upper
layers? Like -ENXIO for NACK and -EIO for bus error? We have a
convention for that and it seems your HW can support it. The different
error codes would then maybe also make the debug outputs obsolete.


> +	/*
> +	 * Here, -ENXIO will be returned if interrupt occurred but no
> +	 * read or write happened. Else if msg_ptr equals to message length,
> +	 * message count will be returned.
> +	 */
> +	ret =3D i2c_dev->msg_ptr =3D=3D msg->len ? num : -ENXIO;

I'd think this kinda unusual construct could go then as well by just
returning the error code derived from the interrupt handler above.

> +static const struct i2c_adapter_quirks owl_i2c_quirks =3D {
> +	.flags		=3D I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +	.max_read_len   =3D 240,
> +	.max_write_len  =3D 240,
> +	.max_comb_1st_msg_len =3D 6,
> +	.max_comb_2nd_msg_len =3D 240,
> +};

Yay! Good use of the i2c_adapter_quirks struct :)

Regards,

   Wolfram


--4utn4zc36jrfmsgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltgwfwACgkQFA3kzBSg
KbZ21Q/9GYHmyV1EiblUh0zTmtvPSAJ36HoCteZkNdGlmvUwDXToxDapDNObY+sY
6S1awC/4Z3iNfVDsQ3q5RTzozcY1gq2tGRLHmBkCH/x8WxIJQ0uz+gs2YSOqRuIc
iwZqLQ8PKodo2X9Hj02sl/FyYveiaNgFcx21w9pg/Sgx5mn+yB7KYTubln2MeaHh
H0y06sSnq0hO24WIOEhl6H3hjMDLYXYEG1+VH32kBFjk2ObPueqvpTmD39R/FTHE
a0m9XqPfwh55IrFKfJTxDv6nS8YD5oLti32wH1fvcZ9bk5MbRlCoMFVmLjU+kR5Y
rRW0sWl3Lf2WKcVDZbuUycWHJOaXsx7wbAzoYYTo9ucX17rQiuYu2OX3jj+ZWIQg
hDPcaWA9bNtkdWK8oIiJ+0uPvLvsoDdEuVY5+H+rfvtkwPAwX6xKvDj2EGyOVjyi
KJnaRS/DlSbksqx7mtbNbN695qErb7k6CmA9uJxd6T9z5JxZuXoEcU57ELP91VDn
QG3JLPkdsg+5vQImhW+akuY8a4izTo41frlq2aDkKgwrv6WtYC2c/XdJHFtKeV33
PdC0eQpv4Ne4DlC1CO3Etq61oTTMCkDLRT7DpLXDO1vGw+J9oqS8DGlaJPW7/50A
Z2cjKc7e+6JcyYdDax43FvqQc42618/AWg7hN4Jmy80Eexo3uQY=
=6ZjR
-----END PGP SIGNATURE-----

--4utn4zc36jrfmsgr--
