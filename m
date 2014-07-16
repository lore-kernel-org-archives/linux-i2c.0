From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Add device ID for Intel Wildcat Point PCH
Date: Wed, 16 Jul 2014 19:42:04 +0200
Message-ID: <20140716174204.GH2759@katana>
References: <20140629210054.6a51c91f@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140629210054.6a51c91f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2014 at 09:00:54PM +0200, Jean Delvare wrote:
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

I will likely take this patch, nonetheless an Ack from someone from
Intel would be much appreciated.

> ---
> Untested, but the datasheet show full compatibility with previous
> chipsets.
>=20
>  Documentation/i2c/busses/i2c-i801 |    1 +
>  drivers/i2c/busses/Kconfig        |    1 +
>  drivers/i2c/busses/i2c-i801.c     |    3 +++
>  3 files changed, 5 insertions(+)
>=20
> --- linux-3.16-rc2.orig/Documentation/i2c/busses/i2c-i801	2014-06-16 05:4=
5:28.000000000 +0200
> +++ linux-3.16-rc2/Documentation/i2c/busses/i2c-i801	2014-06-29 20:49:27.=
079679858 +0200
> @@ -25,6 +25,7 @@ Supported adapters:
>    * Intel Avoton (SOC)
>    * Intel Wellsburg (PCH)
>    * Intel Coleto Creek (PCH)
> +  * Intel Wildcat Point (PCH)
>    * Intel Wildcat Point-LP (PCH)
>    * Intel BayTrail (SOC)
>     Datasheets: Publicly available at the Intel website
> --- linux-3.16-rc2.orig/drivers/i2c/busses/Kconfig	2014-06-23 10:45:34.37=
2425164 +0200
> +++ linux-3.16-rc2/drivers/i2c/busses/Kconfig	2014-06-29 20:48:02.9040006=
52 +0200
> @@ -109,6 +109,7 @@ config I2C_I801
>  	    Avoton (SOC)
>  	    Wellsburg (PCH)
>  	    Coleto Creek (PCH)
> +	    Wildcat Point (PCH)
>  	    Wildcat Point-LP (PCH)
>  	    BayTrail (SOC)
> =20
> --- linux-3.16-rc2.orig/drivers/i2c/busses/i2c-i801.c	2014-06-25 18:19:11=
=2E531786078 +0200
> +++ linux-3.16-rc2/drivers/i2c/busses/i2c-i801.c	2014-06-29 20:49:14.0624=
20369 +0200
> @@ -59,6 +59,7 @@
>   * Wellsburg (PCH) MS      0x8d7e    32     hard     yes     yes     yes
>   * Wellsburg (PCH) MS      0x8d7f    32     hard     yes     yes     yes
>   * Coleto Creek (PCH)      0x23b0    32     hard     yes     yes     yes
> + * Wildcat Point (PCH)     0x8ca2    32     hard     yes     yes     yes
>   * Wildcat Point-LP (PCH)  0x9ca2    32     hard     yes     yes     yes
>   * BayTrail (SOC)          0x0f12    32     hard     yes     yes     yes
>   *
> @@ -175,6 +176,7 @@
>  #define PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS	0x23b0
>  #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
> +#define PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS	0x8ca2
>  #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS	0x8d22
>  #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS0	0x8d7d
>  #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS1	0x8d7e
> @@ -823,6 +825,7 @@ static const struct pci_device_id i801_i
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_M=
S1) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_M=
S2) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS=
) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBU=
S) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_S=
MBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
>  	{ 0, }
>=20
>=20
> --=20
> Jean Delvare
> SUSE L3 Support

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxrlrAAoJEBQN5MwUoCm2BzoQALHPzs4B6m6tGfPcJgczsVjU
hbVXzHf/j2S8sjIYEYlDf0k0g+ybZqQFXFt5vA+qRFuVXFpdIrmXaKwtD9yGns0G
tuGsnS9FQfYwQofoMH8P0VySWfqinWoI6s8+8RCF5znvNno2sMpT7x7Bw2r4JINU
OvKf/gHEHyXZJj8KbFqBRY84QjoG2rkxivof5hLtphPK6vPO24jiD3zlJ5uI6hxI
S/W/8MJSrMAIsBAkeO40LfpoEMp8E/FSKdlmBSxDvMCf1I3g9pm2qLQ2r5qe5J94
4ow3h02alDHddGTNeKd5QiWYj0UwEE0yZnM99DMOC6rzqGLd+80lQVbq7BFg1oSs
wNslRkOSvlXH/GvenvOMMAtUxsAt+vRnxyD9DXGTyjdV/YgW+yUqXpYfqd76N5FC
fcK/WlcjLJgZvwlivNxTicLwegTj7VanYrsU4CpQUb2gpcccVnEH+QPPo0ys2XNt
bhcdauWcSm7HDkklR9KwPMZ6nseQ/7qD5worPcG7noOMt+9D8JpMgbLdibcObXqt
Lkx3CIZ4cPXsLqgcWjPckVU+/0Ve1dy71HGyefXpbCEMKdHWrRJKmHFxoJh+7xDF
t0o0EQ4ixo2wlgM4T+OmUSU8Lg/1M70KJAYKAVJb3J2aH1dnBJNyTTvlduF6l1ax
YF+qAA4sVwbhoBcyJ184
=MsqJ
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
