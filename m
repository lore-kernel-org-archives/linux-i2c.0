From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-dev: Create 'name' attribute automatically
Date: Wed, 25 Sep 2013 22:20:35 +0200
Message-ID: <20130925202035.GB4290@katana>
References: <1377966619-20197-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377966619-20197-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2013 at 09:30:19AM -0700, Guenter Roeck wrote:
> The 'name' attribute is needed for all i2c-dev class devices, meaning
> it can be created automatically by pointing to it in the class data
> structure. This simplifies the code and reduces the probability for race
> conditions.

What race condition?

>=20
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
>  drivers/i2c/i2c-dev.c |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index c3ccdea..46eea02 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -111,7 +111,11 @@ static ssize_t show_adapter_name(struct device *dev,
>  		return -ENODEV;
>  	return sprintf(buf, "%s\n", i2c_dev->adap->name);
>  }
> -static DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
> +
> +static struct device_attribute i2c_dev_attributes[] =3D {
> +	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
> +	{ }
> +};
> =20
>  /* ---------------------------------------------------------------------=
---- */
> =20
> @@ -538,7 +542,11 @@ static const struct file_operations i2cdev_fops =3D {
> =20
>  /* ---------------------------------------------------------------------=
---- */
> =20
> -static struct class *i2c_dev_class;
> +static struct class i2c_dev_class =3D {
> +	.owner =3D THIS_MODULE,
> +	.name =3D "i2c-dev",
> +	.dev_attrs =3D i2c_dev_attributes,
> +};

Have you tried this with two instances? I don't think it will work since
class_register modifies the class struct.

Regards,

   Wolfram


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQ0WTAAoJEBQN5MwUoCm2/84P/jJ8iX4BwcdXvshkpfzA25ks
TXXb2uK7KGnIqoJaVzGs8gY1mUDufZ+eDv5AWdcWTJ+zRer0fFqM7PxVNItmzNPd
9XqNNe32Fkl9cjtxwFqgKQyaa6TnZemSUseQL2KxAq+InfXV1B6Rt2Nx0+XA7vVZ
kzVE0z4yUMKgl5FZW20NSSyAsijy08/Q1/0EAz4BXWP6bVxQI7nDKPJLLEhOm+qE
E9eeE/jyUuxjNPB14jNh9MwJF8Rc2BAiGMf9Apf/LvjpNW6LoskmuPrDlt0e1DNN
f3gjOUnrwXn8sKJUIqkd2xVBOkBwK31xxluo4vthCoxaIlpuuRtQ+YzPQoGJ+juj
8LsNau0ZJfWF96j5phoKvNaM7HAZ/HfEtHdwuLJl3X+4F24x5jLjk2kqLdUjougT
Wriz94eDoQJ9T4M92/Juw9aP66u/cFyKUXUTAXcc85jcw+xUgBQ8nEBbLiDP5lyq
+uxXK57U7IoQ/R1vIagXF7ZlVsJxT0b+HJhyr/1hYd93lXnjEd/NG2AquFgv2Bmw
FcjmgQVl4iqEC5Pb4hIe9D1+qYvArngIslb4gMw0WeibkafU0Kr6mLFtKdH0ZLTr
2LQ8ql8i74+/Y6Pkz0ii0a256TvU3zPkKhbiGdI6Af6xeppxzb10sDQDLIQzklGg
0UHOHkY/XqAqRq/q/0G+
=2/rz
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
