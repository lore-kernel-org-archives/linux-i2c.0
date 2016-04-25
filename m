From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Tue, 26 Apr 2016 00:16:22 +0200
Message-ID: <20160425221621.GI1550@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-4-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47287 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbcDYWQ0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 18:16:26 -0400
Content-Disposition: inline
In-Reply-To: <1461594824-7215-4-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:32PM +0200, Jan Glauber wrote:
> SMBUS QUICK never worked for the read case, because EINVAL was returned
> for a zero length message. The hardware does not support SMBUS QUICK
> messages so disable the support and remove the zero length check.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

I see better now and I think we need to drop this patch. It looks like
the driver supports only SMBUS_QUICK_WRITE which can be used for
scanning devices. The driver probably works with 'i2cdetect -q'. This
will regress if I apply the patch.

It seems it can't do SMBUS_QUICK_READ thus the extra check in the code.

I2C_FUNC_SMBUS_QUICK should have been split up in READ and WRITE to
support this scenario.

Are my assumptions correct?


> ---
>  drivers/i2c/busses/i2c-octeon.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-oct=
eon.c
> index 0f536a1..ad563cf 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -459,9 +459,6 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, in=
t target,
>  	int i, result, length =3D *rlength;
>  	bool final_read =3D false;
> =20
> -	if (length < 1)
> -		return -EINVAL;
> -
>  	octeon_i2c_data_write(i2c, (target << 1) | 1);
>  	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
> =20
> @@ -597,7 +594,7 @@ static struct i2c_bus_recovery_info octeon_i2c_recove=
ry_info =3D {
> =20
>  static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> +	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
>  	       I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_SMBUS_BLOCK_PROC_CALL;
>  }
> =20
> --=20
> 1.9.1
>=20

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHpc1AAoJEBQN5MwUoCm2u8IP/jgAbprx2Mr0eLqaqXifdqwV
JtAFdPNRq0t/xzVi6U488GsEbGpA1ZvyjAYeTSCuIznEyIQKXjZheXbUhuCtyI5f
CIYZuadllywPU/qL2XIVJB6sTnpDWU9Yhr80gYf1psVK8cgzAXqWyheREz4zJEp6
4e9EPiOX54uWZpuLKBY51N3VXVgLaBpMYdt5KERbaxnqGTVxv4h2jRKZCcEoIEdx
j6dstWY/O3dJ3aiCgLnrOer33LIyeXhMIEVLApcTvU3SFSviWuV55ijxBDy0kgek
GLzInqce318ztoAXTVLTty/cA218q3MOdUod8xMitoWFOqWLH2Vmr63pi5at5VzK
oOJxoGyz68aSrnVNepF8CElLfeHJFgeQBc0FcafW57EHhDuAOP8bzu3RVTTN1qIH
4zRaEGzBqyWF0bp3wVK51fegCKArJGjiwS0fU3QJf8TrV8q5eEGL4TdluGP+igmD
7YiUQLMzOvKH3uHhjT0ZaijpWqrFrlJYkE9TlEsDj7VwrTa2ukZO+V//nmf8hPlg
42fFkL4Rq/IAFOzuk3RjnHELCzbnkZNKFiJHVlK5LA5T6qTOCBQOmpKZ2zWiFb/s
n7x413ofLhQPA3Df8K7zqWB10uhP6cx3znJqTechxRoRic2ib+y943FY/Vwll6EL
5nuQX6dUME96182+J1P9
=pdFX
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
