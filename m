From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/7] i2c: img-scb: support I2C_M_IGNORE_NAK
Date: Wed, 29 Jul 2015 14:58:53 +0100
Message-ID: <55B8DC1D.2080106@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com> <1437998162-32724-2-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hpne8vqPWpttDMgm1bnixtWVbux7cL54C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-2-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--hpne8vqPWpttDMgm1bnixtWVbux7cL54C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:55, Sifan Naeem wrote:
> This commit adds support for the I2C_M_IGNORE_NAK protocol
> modification.
>=20
> Such behaviour can only be implemented in atomic mode. So, if a
> transaction contains a message with such flag the drivers
> switches to atomic mode. The implementation consists simply in
> treating NAKs as ACKs.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Looks good,

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Thanks!
James

> ---
>  drivers/i2c/busses/i2c-img-scb.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 07a039c..31cd8c3 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -767,7 +767,9 @@ static unsigned int img_i2c_atomic(struct img_i2c *=
i2c,
>  			next_cmd =3D CMD_RET_ACK;
>  		break;
>  	case CMD_RET_ACK:
> -		if (i2c->line_status & LINESTAT_ACK_DET) {
> +		if (i2c->line_status & LINESTAT_ACK_DET ||
> +		    (i2c->line_status & LINESTAT_NACK_DET &&
> +		    i2c->msg.flags & I2C_M_IGNORE_NAK)) {
>  			if (i2c->msg.len =3D=3D 0) {
>  				next_cmd =3D CMD_GEN_STOP;
>  			} else if (i2c->msg.flags & I2C_M_RD) {
> @@ -1042,20 +1044,23 @@ static int img_i2c_xfer(struct i2c_adapter *ada=
p, struct i2c_msg *msgs,
>  		return -EIO;
> =20
>  	for (i =3D 0; i < num; i++) {
> -		if (likely(msgs[i].len))
> -			continue;
>  		/*
>  		 * 0 byte reads are not possible because the slave could try
>  		 * and pull the data line low, preventing a stop bit.
>  		 */
> -		if (unlikely(msgs[i].flags & I2C_M_RD))
> +		if (!msgs[i].len && msgs[i].flags & I2C_M_RD)
>  			return -EIO;
>  		/*
>  		 * 0 byte writes are possible and used for probing, but we
>  		 * cannot do them in automatic mode, so use atomic mode
>  		 * instead.
> +		 *
> +		 * Also, the I2C_M_IGNORE_NAK mode can only be implemented
> +		 * in atomic mode.
>  		 */
> -		atomic =3D true;
> +		if (!msgs[i].len ||
> +		    (msgs[i].flags & I2C_M_IGNORE_NAK))
> +			atomic =3D true;
>  	}
> =20
>  	ret =3D clk_prepare_enable(i2c->scb_clk);
>=20


--hpne8vqPWpttDMgm1bnixtWVbux7cL54C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuNwdAAoJEGwLaZPeOHZ6lIwP/0PPDVaCBQPJise1Gw9yfHSP
6JixB0o2/2nPTAEFlu81wd7G7IS+mFp2nc1rAFfFm6UQ+I0WEUITI6M06jsscYCX
QbApN7iCjS/ObFc+OXdAmzkOYGkoPZBcygbvftnSt9e0VRBFJID4gM21FBXXZPrB
f9spDqxeT9vO+y0dU+6smiv/gjEFXyK4v0MXIfUfHUzsytV80fsfkNyzDK9gKqTK
AHM0PM2lYfHTAPJviyXgK/kDA7KLFDWCXszwYZRd46qef6Q3KNyYpzSQxDPT5ocJ
+jxlrEvDJE+G4JUqgjdzf+7lhG10v9fX5qcvBbjV0nusbb+XWL+/ezN54aV6KLVQ
xSgQdDCrYc/uN+sbSZEml1fOCLE/+4xfYYQZ2DBEA/Xoao20cSI32uGV4iubH0MI
OAQ0aeqQ+GlCpKeiEy5wTA1IVtSiw6TsRFeHQZijoCK3VsBJ25U8acJe5Y7R1aG0
E5+1oRD+7gTfFmYZWYwrNGvaToFKUPYUF39ZKThwJpaPGAZhnTG29LHLgdAjbnG8
6RoVMGwpgfNKt8x1ZuS+keUdVQN8cKFEXrwV9JZXxy6I62Lbj7E7B0XN5Oyt4mLM
oN05gbLxMkcUUNQln5Fh/T/fdksTTil4uyHQB8ozh3QM+tuMc3tHaWcOHemSsnaV
sL5+WBn7bDd7eh/0QQ5n
=Mh0V
-----END PGP SIGNATURE-----

--hpne8vqPWpttDMgm1bnixtWVbux7cL54C--
