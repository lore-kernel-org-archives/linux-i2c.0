From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [patch] i2c-scmi: remove some bogus NULL checks
Date: Wed, 30 Oct 2013 17:02:58 +0100
Message-ID: <20131030160257.GF3663@katana>
References: <20131019084622.GA9312@longonot.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131019084622.GA9312-dZEljifmRObu9KfB+GxooP8+0UxHXcjY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Jiang Liu <jiang.liu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2013 at 11:46:22AM +0300, Dan Carpenter wrote:
> "obj" can't be NULL here.
>=20
> We already know that "pkg->package.elements" gives us a valid pointer
> so the next pointer after that is also non-NULL.

Why is that? Can't see it...

>=20
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>=20
> diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
> index c447e8d..5992355 100644
> --- a/drivers/i2c/busses/i2c-scmi.c
> +++ b/drivers/i2c/busses/i2c-scmi.c
> @@ -223,7 +223,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 a=
ddr, unsigned short flags,
>  		goto out;
> =20
>  	obj =3D pkg->package.elements + 1;
> -	if (obj =3D=3D NULL || obj->type !=3D ACPI_TYPE_INTEGER) {
> +	if (obj->type !=3D ACPI_TYPE_INTEGER) {
>  		ACPI_ERROR((AE_INFO, "Invalid argument type"));
>  		result =3D -EIO;
>  		goto out;
> @@ -235,7 +235,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 a=
ddr, unsigned short flags,
>  	case I2C_SMBUS_BYTE:
>  	case I2C_SMBUS_BYTE_DATA:
>  	case I2C_SMBUS_WORD_DATA:
> -		if (obj =3D=3D NULL || obj->type !=3D ACPI_TYPE_INTEGER) {
> +		if (obj->type !=3D ACPI_TYPE_INTEGER) {
>  			ACPI_ERROR((AE_INFO, "Invalid argument type"));
>  			result =3D -EIO;
>  			goto out;
> @@ -246,7 +246,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 a=
ddr, unsigned short flags,
>  			data->byte =3D obj->integer.value;
>  		break;
>  	case I2C_SMBUS_BLOCK_DATA:
> -		if (obj =3D=3D NULL || obj->type !=3D ACPI_TYPE_BUFFER) {
> +		if (obj->type !=3D ACPI_TYPE_BUFFER) {
>  			ACPI_ERROR((AE_INFO, "Invalid argument type"));
>  			result =3D -EIO;
>  			goto out;

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJScS2xAAoJEBQN5MwUoCm2dwoP/2c0ZNZcUPVJajen55v6xVpO
Jiawq7KDlJs0hYI7z5KDEiM4rqEgKT5mbl0ETRAP2hxHyfdEGcArP0iOXAf5se4t
GFq5G8xHQBcrzOHCKLru8EtIXXrxzh/p1Q9W/+MPLs5lvY/bN069/P8KAdtPv0rX
OJKfGNCPG4CGAooD0fB2AbijJLi3tMuIseTO8Ii8Vk+Q9EIydTOYRqpRMraAslzd
lxaXvh2+C2ppZSvnyCTdrhbTg/Uf9IR7bMeJVgCPtDhmKM4TtBF4CUqWGp1iHPjb
lR2jMuWsRA6lx/HgZN7gSW5OAYJ6RkZIczR3A/2yEua5JkF+/Rs/pAxe/btH1sRb
tXxKHNEeD7aFMHFYB7vuPFBVGry+JgOL0VFzRMQaLOCCDN60WkrqcsD+/dHx7hXk
PwtWlGVKX4J+PnFSM7+INoo0HCByAWYdjL9hM0xn7ipgACZ1yOGgFgr4yTAkg+y2
Gs6CXVtOKHCpXsKrpGScCALFJO2VphGdWcssJMx2BeTm/11gP5FYnw0SCprHJAXK
1882yB481j9oDnYF8m0M7EuGg5u2MBPA0Y7wjVB41j/9rOX+0ZRKmiJ3hasaD5Ho
t65iJHdRgZ3CQJAixzxr392PfBxsKzNAqFLohItjizAqBjyRUO/4e00HGBVoStfL
jOkj4AVs2oySS5ELgrff
=/FGD
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
