From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c: i2c-imx-hdmi: add support of iMX6 HDMI DDC I2C
 bus
Date: Mon, 24 Nov 2014 13:20:52 +0100
Message-ID: <20141124122052.GI3733@katana>
References: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVyHzDF4yf4A8jkR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416073759-19939-1-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qVyHzDF4yf4A8jkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2014 at 07:49:16PM +0200, Vladimir Zapolskiy wrote:
> Please review a proposed iMX6 HDMI DDC controller driver written on
> top of I2C framework.
>=20
> Changes from RFC to v1 version:
> * added I2C bus ducumentation,
> * updated iMX6 HDMI device tree bindings documentation,
> * device resource information is collected from parent HDMI phandle,
> * minor clean-ups.
>=20
> The driver intends to support HDMI on-controller I2C master bus with
> limited cababilities, however by nature of the sub-device it seems
> reasonable to separate it into a stand-alone driver, which also can be
> used independently on general HDMI controller driver, for example as
> an additional I2C bus on a board, but please be aware that the bus is
> not compliant to I2C specification.
>=20
> In my practice I've met iMX6Q boards, where HDMI DDC lines are
> connected to iMX6 HDMI DDC pins and not to any of 3 I2C busses, so
> support of iMX6 HDMI I2C bus is important to have.
>=20
> Main issues with the device/driver:
> * iMX6 HDMI controller becomes a shared device (both interrupt and
>   memory region) between HDMI driver itself and this I2C bus driver.
> * Only two patterns of I2C transactions are supported due to hardware
>   limitation, these patters are described in driver's code header.
> * The bus controller supports one more multi-byte read pattern (so
>   called Extended Read Mode), but Freescale documentation is too vague
>   to easily add this mode into the driver.
>=20
> The bus driver may be used independently on presence/absence of iMX6
> HDMI controller driver, so build dependeny is not set.

I think there are now 3 drivers in my queue which are not fully I2C
compatible but more supporting the very minimum to, say, read an eeprom.
I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
think about ways how to communicate deficiencies like "only 255 byte" or
"only WRRD messages" to users of that I2C controller. This is most
likely not happening before 3.19. But assistance is very welcome.


--qVyHzDF4yf4A8jkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcyKkAAoJEBQN5MwUoCm2RXoP/jUcIoLckeLfZGMqxFcEdOXp
ttWeMr5DblfvymiBB/wMszi/o3PLpM73sONZAiGrxN6LK6kC2KtGCjdMhpOtW4mf
90SHWoAdVngqre7D+3DZaCk8kIsdV3jkFGx6h0XUwixCBC5z1tjMd6NcUlrtORs0
rPux2M0UFTjXTptt/Y3mGLZ/O+y4fvk85Ny72k2xC8zN9Cox0uil2LqB4/mYwCwH
gDl4hfotUXqcnJrRGa5n4zChrxDCCdq/C+iZ0dQHkeeBzPR8rUTRyERHBM3pkEUy
59KMGb41jJYB/pGOVPCJujO+eYsdE0VoGhn+EwljNZRiPHBc663uNt63D+WLeh4s
C8Ra7XfkB9w0zWKLuSfWz0FXe4Cx/DiiqrmsVaJPrZcwWDqI+PV67hfuaZ7Nh1cY
Tq6+IHu4IIxlw9ucCh3RLglyeBpceBvi7Ybe7dzvVzTVoHUdQQNVut3677/1UPLy
25WOFDPeuzhQWrxatOKbAycYJKGvOAxRgSADwyWxs88FBTfmarRYr4e4CqzzMckV
eXMnXLjptm5iz3oV2Q90aGT/n5SS2R8lSxmU1Epl/CTpnGinYuuaI46WSWNqwfaS
kYnuuGPJFvIzb+980PqRDcizgc2/E/JCjjdvc5HtYufA6DUz27CNSAZ9dITUyvlH
phOCKNBeYys6tPRSmb0+
=3Cf6
-----END PGP SIGNATURE-----

--qVyHzDF4yf4A8jkR--
