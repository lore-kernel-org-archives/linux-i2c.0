From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: img-scb: match return type of wait_for_completion_timeout
Date: Mon, 9 Feb 2015 10:53:05 +0000
Message-ID: <54D89191.1060909@imgtec.com>
References: <1423401155-8955-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Vh5m031lWx4NIo3xHBwbpQDHWhdSQrf90"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423401155-8955-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--Vh5m031lWx4NIo3xHBwbpQDHWhdSQrf90
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/02/15 13:12, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int. re=
t in=20
> img_i2c_reset_bus() was exclusively used for wait_for_completion_timeou=
t so=20
> its type is simply adjusted. In img_i2c_xfer an appropriately typed var=
iable
> is added and assignment fixed up.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Looks good to me,

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Thanks
James

> ---
>=20
> Patch was compile tested with x86_64_defconfig + CONFIG_COMPILE_TEST=3D=
y
> CONFIG_I2C_IMG=3Dm
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
>=20
>  drivers/i2c/busses/i2c-img-scb.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
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
> @@ -1007,6 +1007,7 @@ static int img_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg *msgs,
>  	struct img_i2c *i2c =3D i2c_get_adapdata(adap);
>  	bool atomic =3D false;
>  	int i, ret;
> +	unsigned long timeout;
> =20
>  	if (i2c->mode =3D=3D MODE_SUSPEND) {
>  		WARN(1, "refusing to service transaction in suspended state\n");
> @@ -1068,11 +1069,11 @@ static int img_i2c_xfer(struct i2c_adapter *ada=
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


--Vh5m031lWx4NIo3xHBwbpQDHWhdSQrf90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU2JGRAAoJEGwLaZPeOHZ6arsP/RHxNeYhMw+D8FXNBicCh3Mt
E3ObcggBbPcb7QddWR2iTW+UuTENhHCTO6Bbx+/gHDnw1eqUU+Pj5Y3agDZFXLQj
FvhmaO9hWkUb3BaIM8Uu6W8c+fyh/cQH1RNPe61ZUxWaGQ6hh8mNNzJDlL6XHq1w
Cj5LJwQ3RHf9dH8zDc/PkGp5HMOvana30NrMQnG0dnTKf0M6qiY7vKlScYO7/KRr
5vZSmtzT/JbDosJuB+Lioc0FlKwngxmtBbzYk+9o0tU2RopIqZ+ajTyfOxycIV7q
dayzmmE2fVLsH1dlHaPHqvwY/T4CYqFz8SiwwgTE4zjNvsVpkT4F61BIehlP83SY
pqYx8VjjqbqcREw18D8oEM+pTrMD+uLeOm1j03NAQZWi+so9B4oXBl2y/8yPc9pl
NSZGBGQx6hsW2Eg+EPvQoptZ7fw5NnXsthbGNEMe17U2lblV/TA+MTMtQNnq6HIY
cSZf5ZxmH8jBNCV8Pk4GjDJ6/rGgSXfxKoZLnlSHPlMiOhwuGu8+uXl8l7zNKlvx
Nzuv2JsfYUaJGd1IZRo9Pe3nEvJ88Bhs3s/9m8T5PbfT9cSWOxCBJF4oXJahtwtj
1l47vu9NI4DcoLNDs20AdUZ9VbtWygcj3nXY/+mrPN/3rig7VHrRE3S389TOkOEp
P3tjisxxgIUQ3KFbZwfQ
=nwXb
-----END PGP SIGNATURE-----

--Vh5m031lWx4NIo3xHBwbpQDHWhdSQrf90--
