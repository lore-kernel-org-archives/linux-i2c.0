From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Mon, 21 Nov 2011 13:52:43 +0100
Message-ID: <20111121125243.GA4768@pengutronix.de>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1321220474-11378-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2011 at 10:41:14PM +0100, Wolfram Sang wrote:
> Analog to ca632f5 (spi: reorganize drivers), introduce a standard pattern
> for naming the muxes. This is done for the rest of the I2C subsystem alre=
ady, so
> we stay in sync with that.
>=20
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---

Ping.

>=20
> Only build tested.
>=20
>  drivers/i2c/muxes/Kconfig                          |    9 ---------
>  drivers/i2c/muxes/Makefile                         |    6 +++---
>  .../i2c/muxes/{gpio-i2cmux.c =3D> i2c-mux-gpio.c}    |    0
>  drivers/i2c/muxes/{pca9541.c =3D> i2c-mux-pca9541.c} |    0
>  drivers/i2c/muxes/{pca954x.c =3D> i2c-mux-pca954x.c} |    0
>  5 files changed, 3 insertions(+), 12 deletions(-)
>  rename drivers/i2c/muxes/{gpio-i2cmux.c =3D> i2c-mux-gpio.c} (100%)
>  rename drivers/i2c/muxes/{pca9541.c =3D> i2c-mux-pca9541.c} (100%)
>  rename drivers/i2c/muxes/{pca954x.c =3D> i2c-mux-pca954x.c} (100%)
>=20
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 90b7a01..a112d9d 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -14,9 +14,6 @@ config I2C_MUX_GPIO
>  	  I2C busses connected through a MUX, which is controlled
>  	  through GPIO pins.
> =20
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called gpio-i2cmux.
> -
>  config I2C_MUX_PCA9541
>  	tristate "NXP PCA9541 I2C Master Selector"
>  	depends on EXPERIMENTAL
> @@ -24,9 +21,6 @@ config I2C_MUX_PCA9541
>  	  If you say yes here you get support for the NXP PCA9541
>  	  I2C Master Selector.
> =20
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called pca9541.
> -
>  config I2C_MUX_PCA954x
>  	tristate "Philips PCA954x I2C Mux/switches"
>  	depends on EXPERIMENTAL
> @@ -34,7 +28,4 @@ config I2C_MUX_PCA954x
>  	  If you say yes here you get support for the Philips PCA954x
>  	  I2C mux/switch devices.
> =20
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called pca954x.
> -
>  endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 4640436..5826249 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -1,8 +1,8 @@
>  #
>  # Makefile for multiplexer I2C chip drivers.
> =20
> -obj-$(CONFIG_I2C_MUX_GPIO)	+=3D gpio-i2cmux.o
> -obj-$(CONFIG_I2C_MUX_PCA9541)	+=3D pca9541.o
> -obj-$(CONFIG_I2C_MUX_PCA954x)	+=3D pca954x.o
> +obj-$(CONFIG_I2C_MUX_GPIO)	+=3D i2c-mux-gpio.o
> +obj-$(CONFIG_I2C_MUX_PCA9541)	+=3D i2c-mux-pca9541.o
> +obj-$(CONFIG_I2C_MUX_PCA954x)	+=3D i2c-mux-pca954x.o
> =20
>  ccflags-$(CONFIG_I2C_DEBUG_BUS) :=3D -DDEBUG
> diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/i2c-mux-=
gpio.c
> similarity index 100%
> rename from drivers/i2c/muxes/gpio-i2cmux.c
> rename to drivers/i2c/muxes/i2c-mux-gpio.c
> diff --git a/drivers/i2c/muxes/pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9=
541.c
> similarity index 100%
> rename from drivers/i2c/muxes/pca9541.c
> rename to drivers/i2c/muxes/i2c-mux-pca9541.c
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/i2c-mux-pca9=
54x.c
> similarity index 100%
> rename from drivers/i2c/muxes/pca954x.c
> rename to drivers/i2c/muxes/i2c-mux-pca954x.c
> --=20
> 1.7.2.5
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7KSZsACgkQD27XaX1/VRvphACfV/lSac3jWxnqI7TxDZ2VjqVF
aGEAoKoqCnoqNrILN+hocsPOz6wBYynE
=4zEV
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
