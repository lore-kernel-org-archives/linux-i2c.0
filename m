From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: dln2: Pass forward ACPI companion
Date: Sat, 16 Apr 2016 23:33:04 +0200
Message-ID: <20160416213304.GF1522@katana>
References: <1458845956-30991-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52840 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbcDPVdL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 17:33:11 -0400
Content-Disposition: inline
In-Reply-To: <1458845956-30991-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2016 at 08:59:16PM +0200, Irina Tirdea wrote:
> Share the ACPI companion for the platform device with the
> i2c adapter, so that the adapter has access to the properties
> defined in ACPI tables.
>=20
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---

Adding Mika for my question: A few drivers do this, does it make sense
to put this into the core?

Apart from that, looks good to me.

>  drivers/i2c/busses/i2c-dln2.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
> index 1600edd..f2eb4f7 100644
> --- a/drivers/i2c/busses/i2c-dln2.c
> +++ b/drivers/i2c/busses/i2c-dln2.c
> @@ -19,6 +19,7 @@
>  #include <linux/i2c.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/dln2.h>
> +#include <linux/acpi.h>
> =20
>  #define DLN2_I2C_MODULE_ID		0x03
>  #define DLN2_I2C_CMD(cmd)		DLN2_CMD(cmd, DLN2_I2C_MODULE_ID)
> @@ -210,6 +211,7 @@ static int dln2_i2c_probe(struct platform_device *pde=
v)
>  	dln2->adapter.algo =3D &dln2_i2c_usb_algorithm;
>  	dln2->adapter.quirks =3D &dln2_i2c_quirks;
>  	dln2->adapter.dev.parent =3D dev;
> +	ACPI_COMPANION_SET(&dln2->adapter.dev, ACPI_COMPANION(&pdev->dev));
>  	dln2->adapter.dev.of_node =3D dev->of_node;
>  	i2c_set_adapdata(&dln2->adapter, dln2);
>  	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d",
> --=20
> 1.9.1
>=20

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEq+QAAoJEBQN5MwUoCm2mmIP/icEIXCzbgpA8rjmG+mg+yRe
dNqG0/tFyT5IJHsYIYjU9T87E6OWa0QSOvtZaZIUj2xkmrxCipqK2pD99xAjlXoR
vkc6hmwnWDK+sQKMlo8d3mUcofhVsudRac1Zk6Y5PdL4VWTMVIGitdqEfC0tGJ4x
nA//LNzRyH3Jpm8NArOYnHwQJ1s49rYCyKwFng0rcaX0nKAsAevrhumW1eroSbck
7VchQ0vOkmnQ+U+mP2JnmA8U8V+r4ks/1GmlNKPEIGldujJTfkn3CaLqlqqzqxRa
YIbhsrVquFTH1Xwd9CySMGUJixg1IjiaVR5Vj20tGRRjJhywOaIP02rUIj77aWT+
nQDrC/3pbrIdE/3V/Rtbwr6EocP5vgZv5IANAlazySsfz2+sSe+ucOInOp66WHMX
J7S3dLHldctUW/jG92NnVfK/iOnXyKN0Qq0Qzc03vv+h3PD5ztRAYZvNMjOq0XKB
DrsgVfekikDPRn25lM4MqJqpCriEo7rOAsrymOeUEe+J/+kZsb4ihcsZDSERed68
ukCb3+z8+ttWX+8a6lpWIcfZioVf9vDrlOdWS880dGP7v9WmYVrJVW3fVdWC59bb
KZWv3ycEQGm/tg7dFB1x2oKC3L6QwKN5CRBtOf1vatLO6GdqGqISRZWtfZGtYMsj
0V7hTdcFO/bd8KAcKrc3
=SxXm
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
