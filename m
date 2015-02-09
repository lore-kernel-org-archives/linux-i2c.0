From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] i2c: img-scb: fixup of wait_for_completion_timeout
 return handling
Date: Mon, 9 Feb 2015 15:25:08 +0000
Message-ID: <54D8D154.4070402@imgtec.com>
References: <1423494921-2708-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="n75ckniPLrid1mabnP4gMGlc5vGCoT5ur"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423494921-2708-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--n75ckniPLrid1mabnP4gMGlc5vGCoT5ur
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/02/15 15:15, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int.=20
> Appropriately typed/named variable are added and assignment fixed up.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

v2 also:
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Thanks
James

> ---
>=20
> v2: int ret is an idiom - thus rather than just changing the type, rena=
me
>     the variable, as suggested by Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>.
>=20
> Patch was compile tested with x86_64_defconfig + CONFIG_COMPILE_TEST=3D=
y
> CONFIG_I2C_IMG=3Dm
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)
>=20
>  drivers/i2c/busses/i2c-img-scb.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 0fcc169..6e4e990 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -988,15 +988,16 @@ out:
>  static int img_i2c_reset_bus(struct img_i2c *i2c)
>  {
>  	unsigned long flags;
> -	int ret;
> +	unsigned long timeout;
> =20
>  	spin_lock_irqsave(&i2c->lock, flags);
>  	reinit_completion(&i2c->msg_complete);
>  	img_i2c_reset_start(i2c);
>  	spin_unlock_irqrestore(&i2c->lock, flags);
> =20
> -	ret =3D wait_for_completion_timeout(&i2c->msg_complete, IMG_I2C_TIMEO=
UT);
> -	if (ret =3D=3D 0)
> +	timeout =3D wait_for_completion_timeout(&i2c->msg_complete,
> +					      IMG_I2C_TIMEOUT);
> +	if (timeout =3D=3D 0)
>  		return -ETIMEDOUT;
>  	return 0;
>  }
> @@ -1007,6 +1008,7 @@ static int img_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg *msgs,
>  	struct img_i2c *i2c =3D i2c_get_adapdata(adap);
>  	bool atomic =3D false;
>  	int i, ret;
> +	unsigned long timeout;
> =20
>  	if (i2c->mode =3D=3D MODE_SUSPEND) {
>  		WARN(1, "refusing to service transaction in suspended state\n");
> @@ -1068,11 +1070,11 @@ static int img_i2c_xfer(struct i2c_adapter *ada=
p, struct i2c_msg *msgs,
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
>=20


--n75ckniPLrid1mabnP4gMGlc5vGCoT5ur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU2NFaAAoJEGwLaZPeOHZ6LcEP/R6Q+MfTdKZ0R4a17sDpCh5T
oNp0PUdogCj85x1haEHfvH4SZqxi6KJ3WZT0hOExc+pObdCqxdRqa6sGgGw5XwYt
JiGdW6wpkSaj+v8huhqSRQtoeQrdoBgBMucHfxvVCPjIDVxMKHTXnI/e+HliO9np
QAhWJDZ6+4JRmkaEECM0GjrUzXWW4HvXYY4SQTUNKDJVdPx8a4KvlqhHftGJRVhe
S6t/UWSRUsPlk1F56aZ72TRZHkMHUEzQrFevG3aCEtl2FCk2MfYYlC8Dv9XEFJ5I
Ujx2fcVixDcFODWlKg5Z3r9DNk4M6AymTeSZTBEiBRLYoP+sWvwoM3FXlXfCxZAR
R70TtUyhKTqv8t7SKP+9mPEWDfBrEwdkA0HkU4NMRWz7kAEpgbGQAI1Oc4KaQoyu
jqxhF/baeUpdmdBLjLO2H3JXaxH+ELzUzY3LNI6Q9nZ0vZn6r4VWTrsKFr7uxbHO
sfajFJ0BjX7mZSJvJwUx4Y8AzF4YWT4A/T+nPmFPCVdWSLGRxmPo/YXgeUI5pBsI
sM0iT3eveKY1hzBy63f/3yeX2kqQFYasuwhJbjtOXEBkIncSFsNZU3oeOF098zfy
CxtSd3ZouRkzQ2srWNWDf3CguevSU2hQtzSWWHyIqT3M935JQA1Y85s9jd9deC3Q
g4FWD7cURnZZNWFedK8W
=SC6Z
-----END PGP SIGNATURE-----

--n75ckniPLrid1mabnP4gMGlc5vGCoT5ur--
