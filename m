From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: omap: Prevent NULL pointer dereference in remove
Date: Sat, 18 Aug 2012 12:09:23 +0200
Message-ID: <20120818100923.GD24812@pengutronix.de>
References: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
 <1344519467-14295-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344519467-14295-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 07:07:42PM +0530, Shubhrajyoti D wrote:
> Prevent the NULL pointer access by moving the platform_set_drvdata functi=
on
> after the access of the pdev.
>=20
> [  654.961761] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000070
> [  654.970611] pgd =3D df254000
> [  654.973480] [00000070] *pgd=3D9f1da831, *pte=3D00000000, *ppte=3D00000=
000
> [  654.980163] Internal error: Oops: 17 [#1] SMP ARM
> [  654.985076] Modules linked in:
> [  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #33=
9)
> [  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
> [  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index c8e3886..0c593d4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1217,8 +1217,6 @@ static int __devexit omap_i2c_remove(struct platfor=
m_device *pdev)
>  	struct omap_i2c_dev	*dev =3D platform_get_drvdata(pdev);
>  	int ret;
> =20
> -	platform_set_drvdata(pdev, NULL);
> -
>  	i2c_del_adapter(&dev->adapter);
>  	ret =3D pm_runtime_get_sync(&pdev->dev);
>  	if (IS_ERR_VALUE(ret))
> @@ -1227,6 +1225,8 @@ static int __devexit omap_i2c_remove(struct platfor=
m_device *pdev)
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);
> +
>  	return 0;
>  }

I think this patch is correct, because drvdata is used in the PM code of
the driver and thus cleared too early.

As such, this is a bugfix and should be not based on the big cleanup
since it should go into this rc series.

I will pick it as soon as the comments on the other patches are
answered.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvadMACgkQD27XaX1/VRtiiwCgjtwwFbrh8jY4YaZRXVwfvycx
NmUAn0ssWmtMxSJM/KFuMo9MwlYo3UJ1
=ppae
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
