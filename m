From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: img-scb: match return type of
 wait_for_completion_timeout
Date: Mon, 9 Feb 2015 14:22:05 +0100
Message-ID: <20150209132204.GE2491@katana>
References: <1423401155-8955-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423401155-8955-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 08:12:35AM -0500, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int. ret =
in=20
> img_i2c_reset_bus() was exclusively used for wait_for_completion_timeout =
so=20
> its type is simply adjusted. In img_i2c_xfer an appropriately typed varia=
ble
> is added and assignment fixed up.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Same as for the axxia driver: Please rename the variable because ret
being an int is kind of an idiom.

> ---
>=20
> Patch was compile tested with x86_64_defconfig + CONFIG_COMPILE_TEST=3Dy
> CONFIG_I2C_IMG=3Dm
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
>=20
>  drivers/i2c/busses/i2c-img-scb.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
> index 0fcc169..4f3a153 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -988,7 +988,7 @@ out:
>  static int img_i2c_reset_bus(struct img_i2c *i2c)
>  {
>  	unsigned long flags;
> -	int ret;
> +	unsigned long ret;
> =20
>  	spin_lock_irqsave(&i2c->lock, flags);
>  	reinit_completion(&i2c->msg_complete);
> @@ -1007,6 +1007,7 @@ static int img_i2c_xfer(struct i2c_adapter *adap, s=
truct i2c_msg *msgs,
>  	struct img_i2c *i2c =3D i2c_get_adapdata(adap);
>  	bool atomic =3D false;
>  	int i, ret;
> +	unsigned long timeout;
> =20
>  	if (i2c->mode =3D=3D MODE_SUSPEND) {
>  		WARN(1, "refusing to service transaction in suspended state\n");
> @@ -1068,11 +1069,11 @@ static int img_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg *msgs,
>  			img_i2c_write(i2c);
>  		spin_unlock_irqrestore(&i2c->lock, flags);
> =20
> -		ret =3D wait_for_completion_timeout(&i2c->msg_complete,
> -						  IMG_I2C_TIMEOUT);
> +		timeout =3D wait_for_completion_timeout(&i2c->msg_complete,
> +						      IMG_I2C_TIMEOUT);
>  		del_timer_sync(&i2c->check_timer);
> =20
> -		if (ret =3D=3D 0) {
> +		if (timeout =3D=3D 0) {
>  			dev_err(adap->dev.parent, "i2c transfer timed out\n");
>  			i2c->msg_status =3D -ETIMEDOUT;
>  			break;
> --=20
> 1.7.10.4
>=20

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2LR8AAoJEBQN5MwUoCm2XogP/0cl/fLyLcCiGSFKLXAP4Og/
0gjTtCuLuZi3jeRuhVzLBYiu8pXUrs/D1LjbLNvtYseL097xqn0vouXGf9/meYZI
yY8cLmaigyxvKycdPVUV3JU2O833T6WRMB6sqlMsmzXX6RcnDzFpqK/B7UJFrB6d
h6cnr4tQWnHzo8+A1aVHkh2sc1WaeGBKN4YHWcL/Bbhqh7gVMrceJ/pdNCarLbpt
KJdvcUq+39/XbREUjJegGClrRMc7LfrVxStAZ10mF+BawmP4UXYnY/MYGWgLJXRE
OSd7a9wHyOGp6rbihOWTjifjqZwq/d6zqwdILoA7gqNersE55ZrsQifuWew8LrTh
DyGaUceqI+53+SE2S8UsDzsLfPPzPqYWM9fgyIt9pfc56M7FT7NBB66BqkLV8krd
v01Y5PjIuhYBVRj5jmZbGSakVh+QYWk296D1QOZyVXXQbVRBhFqnRnZzClJ4P8jc
8R66s6jnuWnc5dmUT/ZyUONdQK+GVkYKgfLumdVuR1Iv7ASmXCkQOsySdKV0J1rS
BnMW1QfYsbRG+XrdEvwbE9hE+FnLyIea1b9PHoFU70/HAOtd4S5TKFaYVcMzriXg
C/j8kn2K0MJPGvCTatIZ9jcz+zUUYdqc+Fl70Xh+bTkPKiTGCI8ySZD/tEZOnpX8
Ak6N9pXn+NXdL8qwAgVf
=4R8O
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
