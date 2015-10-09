From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC v2 1/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Fri, 9 Oct 2015 22:42:44 +0100
Message-ID: <20151009214241.GC1481@katana>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1439580693-5538-2-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439580693-5538-2-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 12:31:33PM -0700, Dustin Byford wrote:
>=20
> Set an ACPI companion for I2C mux channels enumerated through ACPI and
> ensure they are scanned for devices.
>=20
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>

Mika, is this one okay with you?

> ---
>  drivers/i2c/i2c-core.c | 10 ++++++++++
>  drivers/i2c/i2c-mux.c  |  8 ++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c83e4d1..23cc8e9 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -171,8 +171,18 @@ static void acpi_i2c_register_devices(struct i2c_ada=
pter *adap)
>  	if (!adap->dev.parent)
>  		return;
> =20
> +	/*
> +	 * Determine where to start walking the ACPI namespace.  The common
> +	 * case is to start at the adapter's parent device.  However, in
> +	 * the case of a "virtual" I2C adapter created to represent a mux
> +	 * channel the parent dev (pointing to the mux device) does not
> +	 * have an ACPI handle.  Walk starting at the adapter instead.
> +	 */
>  	handle =3D ACPI_HANDLE(adap->dev.parent);
>  	if (!handle)
> +		handle =3D ACPI_HANDLE(&adap->dev);
> +
> +	if (!handle)
>  		return;
> =20
>  	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 2ba7c0f..2731b99 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -25,6 +25,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>
> =20
>  /* multiplexer per channel data */
>  struct i2c_mux_priv {
> @@ -173,6 +174,13 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_a=
dapter *parent,
>  		}
>  	}
> =20
> +	/*
> +	 * Now try to populate the mux adapter's ACPI node.
> +	 */
> +	if (has_acpi_companion(mux_dev))
> +		acpi_preset_companion(&priv->adap.dev, ACPI_COMPANION(mux_dev),
> +				      chan_id);
> +
>  	if (force_nr) {
>  		priv->adap.nr =3D force_nr;
>  		ret =3D i2c_add_numbered_adapter(&priv->adap);
> --=20
> 2.1.4
>=20

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGDTRAAoJEBQN5MwUoCm2N28P/1PNq0YOkNwADTqpZODeCxT3
Siuvadh46y55XKvoUstievDDnLeTG/dqj5wkJQYsxGeAsOuuLucJtKbJyYUaqBzX
7yW7yi/o0CjFamA+69o0mLn80VzvvfthHqpoJ5cPU2waN5IhrB6L3thrA8LSo4S/
WlFmH0m1pzevtY4ib8QNnI7Xw6RiYj80bW9VC1096VLn56kfQ5N3tsgEKEH3GIM9
maq9zMJqJPFMM6qT7G+v6zJWT6PEzeyWOeByJ7Atn5Qdcpd81XDAln19As735nrf
UQT5f/45BQjjPra3HfvVCZfmMKiIPwbQUcUgNcj2If7Tv2osMTDC5895mN6c+2Zp
zrCv+mcbd9b+9FlC862aaW477O4I5//H/1T6Ilu52se8vTXqKfAokDjYm5O/UM6y
yR1gxULcZSaYmJnJqGRauOeulKxr4HlKKY09gzdKHC3Kb6Xue+GoaoK7dWgTHeBX
bsyalZmFPZZlon4O6t/9ekDG2f1aVTKJxCKQJ3ZOU7FSZTua85r7z7kwQO6ioxDE
HU/Xfbx70W/s+2A8GqYABog1LF5/+lzaztIy1y7BzqM9WdxOqoJ6VMcZNICVBRn1
LlHdguDhn8RgdjegUhKbFWo/i9CikWVMPepUlp1Dut5vDdjcXVepqWDGO+wCd5AM
ZOTgKyU1rjMzU21mPSo7
=RfKE
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
