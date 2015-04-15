From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: jz4780: Fix build for m68k and sparc64
Date: Wed, 15 Apr 2015 17:41:50 +0200
Message-ID: <20150415154122.GA914@katana>
References: <1429068073-7595-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429068073-7595-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guenter,

Thanks for catching this!

> Fix:
>=20
> drivers/i2c/busses/i2c-jz4780.c: In function 'jz4780_i2c_readw':
> drivers/i2c/busses/i2c-jz4780.c:181:2: error:
> 		implicit declaration of function 'readw'
> drivers/i2c/busses/i2c-jz4780.c: In function 'jz4780_i2c_writew':
> drivers/i2c/busses/i2c-jz4780.c:187:2: error:
> 		implicit declaration of function 'writew'
>=20
> seen with sparc64:allmodconfig and m68k:allmodconfig.
>=20
> The driver depends on HAS_IOMEM, and must include linux/io.h.
>=20
> Fixes: ba92222ed63a ("i2c: jz4780: Add i2c bus controller driver
> 	for Ingenic JZ4780")
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig      | 1 +
>  drivers/i2c/busses/i2c-jz4780.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2255af23b9c7..c78b6cbd1106 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -586,6 +586,7 @@ config I2C_IOP3XX
>  config I2C_JZ4780
>  	tristate "JZ4780 I2C controller interface support"
>  	depends on MACH_JZ4780 || COMPILE_TEST
> +	depends on HAS_IOMEM

You sure? We have

menu "I2C Hardware Bus support"
        depends on HAS_IOMEM

in drivers/i2c/busses/Kconfig. For me, menuconfig shows that the driver
is already depending on HAS_IOMEM.

>  	help
>  	 If you say yes to this option, support will be included for the
>  	 Ingenic JZ4780 I2C controller.
> diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4=
780.c
> index ce1d69324169..f2761ab2ef32 100644
> --- a/drivers/i2c/busses/i2c-jz4780.c
> +++ b/drivers/i2c/busses/i2c-jz4780.c
> @@ -21,6 +21,7 @@
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> +#include <linux/io.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>

The sorting needs to be fixed.


--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLoa+AAoJEBQN5MwUoCm2FfAQAJhvchEJ7X6LC1crpiyAfTYa
ZCwd9bL0MsJyB1RtTFMtxO7LEUgOjtTxtk/JjGkfSIiBWKvmnrsgy9fnUHeKUvzl
cRloPHWPNorXYkRWigZnjcLmsamrBufRygdMSHdaEsOn1496tS1nIz/+ER9AdPaR
CNUVAuwsnfDEOPcxt2GcHRumJNAPP7nBxPYs4aljZz/m4KuQFpQbMq235TdjkmoP
Q/o0l74KWfBtfLqHBoq4Z7ul7UFamNFa6KgJSFhJ/sb6TZA08SpUWY9AtUTs2IJW
SJfCslnGPySuGID+qddBghYkw3X6ttwMHQoXjJ0GQ/VPW18WhASCs8iKsVuem49S
rIfM/MT7z6NPhsN6XEHcwCIwmq15IZRgSLj/Xw+1gdRDRtmCn33RuhL3FnMZp76Q
+7GkWa4ooFew64cMvvsp1zxuDO40apZueuG6krCTRuk2yxQEwfaGPS1YoO0xXOUE
5L4tAxAofUGVYDNQ0EojolZm0Z1xL8o76HGfsbCBk2w8inu+WLWAlasgG4X7omZ9
jAXWp/CLJ5hgvVO47xH9vTY9CYRW4X/Hl5JwqB8twkFSJZ4HcuLUF0Qa12CKeIsd
rGTFscJJ4AFJpfVDl5/atKbKWuWSrAbxhsoYYQnDwRTpNC55C22Jr2aC6vKe5lUE
KYtGeXpF6F8Sxur32xvS
=JtMm
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
