From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Clarify the unit of ioctl I2C_TIMEOUT
Date: Fri, 20 Feb 2009 13:28:39 +0100
Message-ID: <20090220122839.GA3042@pengutronix.de>
References: <20090220132137.6a86dda6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090220132137.6a86dda6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2009 at 01:21:37PM +0100, Jean Delvare wrote:
> The unit in which user-space can set the bus timeout value is jiffies
> for historical reasons (back when HZ was always 100.) This is however
> not good because user-space doesn't know how long a jiffy lasts. The
> timeout value should instead be set in a fixed time unit. Given the
> original value of HZ, this unit should be 10 ms, for compatibility.
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

(see minor nit below)

> ---
>  drivers/i2c/i2c-dev.c   |    6 +++++-
>  include/linux/i2c-dev.h |    2 +-
>  include/linux/i2c.h     |    2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> --- linux-2.6.29-rc5.orig/drivers/i2c/i2c-dev.c	2009-01-06 20:24:44.00000=
0000 +0100
> +++ linux-2.6.29-rc5/drivers/i2c/i2c-dev.c	2009-02-20 12:59:38.000000000 =
+0100
> @@ -35,6 +35,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-dev.h>
>  #include <linux/smp_lock.h>
> +#include <linux/jiffies.h>
>  #include <asm/uaccess.h>
> =20
>  static struct i2c_driver i2cdev_driver;
> @@ -422,7 +423,10 @@ static long i2cdev_ioctl(struct file *fi
>  		client->adapter->retries =3D arg;
>  		break;
>  	case I2C_TIMEOUT:
> -		client->adapter->timeout =3D arg;
> +		/* For historical reasons, user-space sets the timeout
> +		 *  value in units of 10 ms.

Double space after * intended?

> +		 */
> +		client->adapter->timeout =3D msecs_to_jiffies(arg * 10);
>  		break;
>  	default:
>  		/* NOTE:  returning a fault code here could cause trouble
> --- linux-2.6.29-rc5.orig/include/linux/i2c-dev.h	2008-04-17 04:49:44.000=
000000 +0200
> +++ linux-2.6.29-rc5/include/linux/i2c-dev.h	2009-02-20 12:48:08.00000000=
0 +0100
> @@ -33,7 +33,7 @@
>   */
>  #define I2C_RETRIES	0x0701	/* number of times a device address should
>  				   be polled when not acknowledging */
> -#define I2C_TIMEOUT	0x0702	/* set timeout in jiffies - call with int */
> +#define I2C_TIMEOUT	0x0702	/* set timeout in units of 10 ms */
> =20
>  /* NOTE: Slave address is 7 or 10 bits, but 10-bit addresses
>   * are NOT supported! (due to code brokenness)
> --- linux-2.6.29-rc5.orig/include/linux/i2c.h	2009-01-29 08:27:20.0000000=
00 +0100
> +++ linux-2.6.29-rc5/include/linux/i2c.h	2009-02-20 12:47:39.000000000 +0=
100
> @@ -361,7 +361,7 @@ struct i2c_adapter {
>  	struct mutex bus_lock;
>  	struct mutex clist_lock;
> =20
> -	int timeout;
> +	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> =20
>=20
>=20
> --=20
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmeofcACgkQD27XaX1/VRseQgCeKJHmviTIV9osQei2VpxFzL5y
AhEAoLX6Z7vy5l8GxdhlMUxDI6qwTp7V
=qx98
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
