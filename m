From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2] i2c: add sc18is600 driver
Date: Sat, 29 Jul 2017 14:03:38 +0200
Message-ID: <20170729120338.5suksarziutwa4o3@ninjato>
References: <20170701150831.20197-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="urhqvcyybnnm2zna"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170701150831.20197-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--urhqvcyybnnm2zna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for V2.

On Sat, Jul 01, 2017 at 05:08:31PM +0200, Sebastian Reichel wrote:
> This adds an I=C2=B2C master driver for SPI -> I=C2=B2C bus bridge chips.
> It currently supports NXP's SC18IS600 and SC18IS601, as well as
> Silicon Labs' CP2120. The driver was only tested on SC18IS600.

I prefer 'I2C' to "I=C2=B2C' to keep things simple, but I'll leave it to yo=
u.

> +++ b/Documentation/devicetree/bindings/i2c/i2c-cp2120.txt
> @@ -0,0 +1 @@
> +Please see binding for i2c-sc18is600

I still prefer this to be dropped. There is no i2c-cp2120 driver.

> + * Datasheets:
> + *  - http://www.nxp.com/documents/data_sheet/SC18IS600.pdf
> + *  - https://www.silabs.com/documents/public/data-sheets/CP2120.pdf

Nice pointers.

> +static int sc18is600_read_write(struct sc18is600dev *s600dev,

This function used to be named '*_read_after_write' which is correct.
'*_read_write' sounds like it does the opposite!

> +static int sc18is600_xfer(struct i2c_adapter *adapter,
> +			  struct i2c_msg *msgs, int num)
> +{
> +	struct sc18is600dev *s600dev =3D adapter->algo_data;
> +	int read_operations =3D 0;
> +	bool ignore_nak =3D false;
> +	int i, err;
> +
> +	for (i =3D 0; i < num; i++) {
> +		if (msgs[i].len > s600dev->chip->buffer_size)
> +			return -EOPNOTSUPP;
> +
> +		/* chip only support standard read & write */
> +		if (msgs[i].flags & ~I2C_M_RD)
> +			return -EOPNOTSUPP;

This will bail out on I2C_M_IGNORE_NAK which you added support for.
Didn't you test that?

> +
> +		if (msgs[i].flags & I2C_M_RD)
> +			read_operations++;
> +	}

I'd think the for loop can completely go by populating an i2c_quirks
structure. From what I see, you'd need I2C_AQ_COMB |
I2C_AQ_COMB_WRITE_FIRST with max_comb_1st_msg_len and
max_comb_2nd_msg_len properly set. But please double check.


> +
> +	reinit_completion(&s600dev->completion);
> +
> +	if (num =3D=3D 1) {
> +		if (msgs[0].flags & I2C_M_IGNORE_NAK)
> +			ignore_nak =3D true;

Why do you ignore NAK only for 1 message?

> +
> +		if (read_operations =3D=3D 1)
> +			err =3D sc18is600_read(s600dev, &msgs[0]);
> +		else
> +			err =3D sc18is600_write(s600dev, &msgs[0]);
> +	} else if (num =3D=3D 2) {
> +		if (read_operations =3D=3D 1)
> +			err =3D sc18is600_read_write(s600dev, &msgs[0], &msgs[1]);
> +		else
> +			err =3D sc18is600_write_write(s600dev, &msgs[0], &msgs[1]);
> +	} else {
> +		return -EOPNOTSUPP;
> +	}

With i2c_quirks, the last else-block could also go.


> +	if (!err) {
> +		dev_warn(&s600dev->spi->dev,
> +			 "timeout waiting for irq, poll status register");

Don't log on timeouts, it is not unusual to happen on the bus.

> +		s600dev->state =3D SC18IS600_STAT_BUSY;
> +		regmap_read(s600dev->regmap, SC18IS600_REG_I2C_STAT,
> +			    &s600dev->state);
> +	}

=2E..

> +	s600dev->spi =3D spi;
> +	s600dev->adapter.owner =3D THIS_MODULE;
> +	s600dev->adapter.class =3D I2C_CLASS_DEPRECATED;

Huh? This is a new driver, why do you need it? Hmm, maybe I could
rephrase the docs a little.

=2E..

> +		err =3D clk_prepare_enable(s600dev->clk);

You never disable the clock anywhere.

Regards,

   Wolfram


--urhqvcyybnnm2zna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll8eZYACgkQFA3kzBSg
KbY6Jw/+IA+x5vhVh444r494EkCbrn/hAijFOmgfzWjpGt4KYhdlgDTVB3QoxsS0
w2iC+6H9+naqAxRRR5QumABU4Ni/4vGqcWRETB/95mLTugLyjQWQiMc0fZuKwWmA
i17J63K6AN/5ue8lthtjoiKa5Ff4lQy6Cc1GgtTOzGjg4yDchPMI6zi4lj5Pd8IY
rCNj6dDwBULEyjpzQfLe50B7yBTX4MyDF8tTmZrI6WUeooyT89wuNqiZZIj/UKfb
rq9gWmHRMDSyvLP44ZpmVAHnm1wZl6YM/W8Gh7NNfyjWUeEHDeaikRMf5SJB4iOU
h90D5LnzgztyPCKG45T54GIQTT5Z62XcZHb7g5qMwmyWebxnMnXB377zg5BpudCj
2KnKCXTXPqhXqSQlV3pFsqO5+vTMUMEhLiEKLqWYm8jCadYxd0jB1C6QpU+ua4T9
G9wxecNBLlsfHrmvf1TzYlYVkt9jJHOHZR+7q4/yvATdUNfs7buIwS6AyiFyLLH8
KP/1QOa/UYt1CjDtVqGzJqWi89RRER/LPbb4XxiyJEnGwjQQYXGYMr3S8U6TyPX+
6F3bpjhrQCRd1buM43T8Pol9m4R8PR5d8xkXvQrfoZtj9Bleh6S7iulkoVk6Lppf
x6TcI3T0+mIJVrDugAoXVAmBTcPmg6KrH86GTrxBHxg54C6nv+8=
=Iuws
-----END PGP SIGNATURE-----

--urhqvcyybnnm2zna--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
