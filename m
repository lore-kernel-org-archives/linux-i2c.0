From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-baytrail: use proper Kconfig dependencies
Date: Mon, 26 Jan 2015 17:51:15 +0100
Message-ID: <20150126165115.GF13494@katana>
References: <1422290974-24561-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422290974-24561-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 05:49:34PM +0100, Wolfram Sang wrote:
> IOSF_MBI depends on PCI, so we should not select it but depend on it.
> This ensures also we compile on X86 only, other archs will break because
> of an arch specific include. Also depend on ACPI since this driver uses
> it.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Depending on IOSF_MBI also helps against the I2C driver being built-in
and IOSF_MBI being a module.

> ---
>  drivers/i2c/busses/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 83062b2c0e6b..442408d2e7b7 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -467,8 +467,7 @@ config I2C_DESIGNWARE_PCI
> =20
>  config I2C_DESIGNWARE_BAYTRAIL
>  	bool "Intel Baytrail I2C semaphore support"
> -	depends on I2C_DESIGNWARE_PLATFORM
> -	select IOSF_MBI
> +	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI && ACPI
>  	help
>  	  This driver enables managed host access to the PMIC I2C bus on select
>  	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows
> --=20
> 2.1.3
>=20

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxnCDAAoJEBQN5MwUoCm2z+kP/jXfS+x4EcMnhK6NwyDWNW7l
IYIYumKOihfNLl1ZMuZ3eCu0cCDtAHu/uQHCUfSqV9DROHEoxA9nP29x9Koa2TYk
eOfwsfkW6o2+10iujo/vL8TPL/BqMjAIH3xGPOxP16z4A8OwEXk+LT9jo4FAI4r4
+/DY58vK7m8PtSbK2uIN6LuIw2+dpj5iMB3FBYR+cE89eqIvIFUUVJioq+hJNy+0
31iEr7C+nBjOF1OfYRjydE2P0Wib1PAXLxGLa1rv6UCmcNiBsCDYEyECLMqEoIoN
BfDhqAIewN66Mjznp24ulLXPWKA77aa7MjnHgRLhExjN/ret4+J3nyWuCC9JYlOU
+v2MhyAWnH/5fPxPhbMMd0PQz2YdMQsB6yfJU1B8ANP38vluSNxHtubwYjyi+O5m
LL2fM4RpZeKOslUaiDm+IGMab1WTYVe1f2X4QMEIbTGm4ZRre+T6iEuCVXrK8ovP
U/c9ZymQfV7+ScOi0JqKxHkqXw2NHkg28KFJHHEQEYhpFYh1Jw3Q8drlgJoPVh9S
bK9wLNwKa7Ra79p2yoVejF5t/BU/BQWcWaRTjbQsyyIb3c9U7kfW+R9LlLY++EY+
3gxqLck1LK5FxmqF0sWIuBovEyKb1Xfkixf5D5Kgik76YSeABSEbUkFBANRiSnsG
zu35ulygH5+3rAS9sl+T
=13Jn
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
