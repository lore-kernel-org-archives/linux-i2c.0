From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix transfer error code
Date: Thu, 20 Jun 2013 21:23:37 +0200
Message-ID: <20130620192337.GB2961@katana>
References: <1371678832-26889-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371678832-26889-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 02:53:52PM -0700, Guenter Roeck wrote:
> The driver returns -ENODEV as error code if it did not get an ACK
> from the device. Per Documentation/i2c/fault-codes, it should
> return -ENXIO.
>=20
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Thanks, have you checked the other error codes as well while you were
there?

> ---
>  drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 1a3abd6..6972032 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -227,7 +227,7 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u3=
2 status)
>  		/* Doesn't seem to be a device at other end */
>  		drv_data->action =3D MV64XXX_I2C_ACTION_SEND_STOP;
>  		drv_data->state =3D MV64XXX_I2C_STATE_IDLE;
> -		drv_data->rc =3D -ENODEV;
> +		drv_data->rc =3D -ENXIO;
>  		break;
> =20
>  	default:
> --=20
> 1.7.9.7
>=20

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRw1a5AAoJEBQN5MwUoCm2ee8P/j9VxfXxhzIHlI0IpCtQdOYA
fyHdjmdtpwfC+76X3OoV2zB1NZYynlSJ/xuH4Gp3ABYKJvl2eJ8KLokNTfkHtpS3
VlYP7+fEEJLByUVhbixzGMqjslk8ntlXwbhxf3176eJ5reMtZ30jF04sJPGSmSbG
eWMJtUOdJiqwM73mrrXJ/pGW9qubD/aDEzPm7aLARJzCOfnmp2F5nsMI1yImw4tX
MgAbp1r5iklDmcHqlKfHIfpoq9gdYgyRdhfEHRen7DyN3ZFw6FB0CPlvHijEb93Z
OhjYEsZ+rfAF97yABpNfuu+ZgxUnDX/sM9pPQK0bx4gZS0o+1+WGz7QnvZXf5+nQ
NGtPLzY7GI6lIRXJzC7XpFXX0MK6X+AV1AiaV2Bi9MKDXHKt6kACjDRy4qrXEy93
/T10E1Rpy3x/zS41GM+BCCOsz7E0RrGfmawP3tSK+lfr/FMpQOrQM/lThWlCmDBo
rnEiY0+pbWxBMAkm2dCPG9lR2ax2TiMCHYrBnupoLuAewJWszV+zAXNGXFqA/Jry
fzwCQpB6Jsw/CvIqXw78op2CDvmoQUo9byYDtX8Dvxko0TXiQUFTV1MnNi6StVV9
tbaTz5NrezXWGYTNqJN6doHX6i36PXbXE/4zcTorOcdvQ1GwV0vOk1HGk+wuKuiU
J+07v+YZ3mGrViBGPQP9
=283O
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
