From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/7] i2c: img-scb: add handle for stop detected interrupt
Date: Wed, 29 Jul 2015 16:34:09 +0100
Message-ID: <55B8F271.6060003@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com> <1437998162-32724-7-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cPFClCCr7XAMcgDGICm4FGJTpkmI0cwMv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-7-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--cPFClCCr7XAMcgDGICm4FGJTpkmI0cwMv
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:56, Sifan Naeem wrote:
> Stop Detected interrupt is triggered when a Stop bit is detected on
> the bus, which indicates the end of the current transfer.
>=20
> When the end of a transfer is indicated by the Stop bit interrupt,
> drain the FIFO and signal completion for the transaction. But if the
> interrupt was triggered before all data is written to the fifo or with
> more data expected return error with transfer complete signal.
>=20
> Halting the bus is no longer necessary after a stop bit is detected
> on the bus, as there cannot be a repeated start transfer when the stop
> bit has been issued, hence remove the transaction halt bit.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 10141a9..90faf48 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -152,6 +152,7 @@
>  #define INT_TRANSACTION_DONE		BIT(15)
>  #define INT_SLAVE_EVENT			BIT(16)
>  #define INT_TIMING			BIT(18)
> +#define INT_STOP_DETECTED		BIT(19)
> =20
>  #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  | INT_FIFO_FILLING)
> =20
> @@ -175,7 +176,8 @@
>  					 INT_WRITE_ACK_ERR    | \
>  					 INT_FIFO_FULL        | \
>  					 INT_FIFO_FILLING     | \
> -					 INT_FIFO_EMPTY)
> +					 INT_FIFO_EMPTY       | \
> +					 INT_STOP_DETECTED)
> =20
>  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
>  					 INT_ADDR_ACK_ERR     | \
> @@ -907,6 +909,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
>  				return ISR_COMPLETE(0);
>  			}
>  		}
> +		if (int_status & INT_STOP_DETECTED) {
> +			int ret;
> +			/*
> +			 * Stop bit indicates the end of the transfer, it means
> +			 * we should read all the data (or drain the FIFO). We
> +			 * must signal completion for this transaction.
> +			 */
> +			img_i2c_transaction_halt(i2c, false);

to get a stop bit detected, wouldn't transaction halt already have to be
off?

> +			img_i2c_read_fifo(i2c);
> +			ret =3D (i2c->msg.len =3D=3D 0) ? 0 : EIO;

If it wasn't fully transferred, wouldn't that already imply an
INT_WRITE_ACK_ERR or INT_ADDR_ACK_ERR, which should've already been
handled?

Could it then be as simple as this? (untested):

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
index 00ffd6613680..f694b47dcf74 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -867,6 +867,13 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c=
,
=20
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
=20
+	if (int_status & INT_STOP_DETECTED) {
+		/* Drain remaining data in FIFO and complete transaction */
+		if (i2c->msg.flags & I2C_M_RD)
+			img_i2c_read_fifo(i2c);
+		return ISR_COMPLETE(0);
+	}
+
 	if (i2c->msg.flags & I2C_M_RD) {
 		if (int_status & INT_FIFO_FULL_FILLING) {
 			img_i2c_read_fifo(i2c);

Cheers
James

> +			return ISR_COMPLETE(ret);
> +		}
>  	} else {
>  		if (int_status & INT_FIFO_EMPTY) {
>  			if (i2c->msg.len =3D=3D 0) {
> @@ -916,6 +930,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
>  			}
>  			img_i2c_write_fifo(i2c);
>  		}
> +		if (int_status & INT_STOP_DETECTED) {
> +			int ret;
> +
> +			img_i2c_transaction_halt(i2c, false);
> +			/*
> +			 * Stop bit indicates the end of a transfer and if the
> +			 * transfer has ended before all data is written to the
> +			 * fifo, return an error with transfer complete signal.
> +			 */
> +			ret =3D (i2c->msg.len =3D=3D 0) ? 0 : EIO;
> +			return ISR_COMPLETE(ret);
> +		}
>  	}
> =20
>  	return 0;
>=20


--cPFClCCr7XAMcgDGICm4FGJTpkmI0cwMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuPJxAAoJEGwLaZPeOHZ61MAP/Rr9MO99FRoQuY3H85i3pAto
PRYkuRKhBoBqyhrQMP5lVba+JbOrC1ifGuCEVw3d1IQuLWvl9k/WH+iPL8wGOG4Y
k5bjILBP7NPxG32XI2F9HoaYfHhQOSG0vNJYnMpT/UHOSzyHOvA1AExGPxfRtVH5
n2ZSrl//1Z77Cw6FxqpM0B46XtL8ol9ndX78hixn7f7ag/crqPRVGRyXrT4H1gKB
UH/cjveJHgwMfrZUIjcTCThojS3IJiUzAcZkXKDlpkNiAOFB/1aHdXHjE8iyb0v8
0BOy+xd2rjqn+ePx0GG5scsmnUXmrXvzkivksOYmPMS5axHopFQrM+53KypqXZ8C
aKBBHR98l7llLUSDdcouNMew3SO0orqGPXV6MqM/CQBHvMg3AFYRlQ2tg/+Ajj6L
J//KiK7xLnfaAxRP85H5sviZ3ava26qU+1LAHAL18HCFWwcA+fctDoM7C3spJ2aS
Y11c1Q3vuuVWb3GzZRTOz/v3vsYcllJZw9S3mi3H0vLmUWvRl14ztcPX+798skyy
7psm12leX3mGatzAHDwdal5LpZeBhhehzR393g0Vn4tOeVeOwPVghYe3XUka75L1
T1jf/5k0PFgQJVVf9MifnY6T//P3EoxzdbkQMkkX28ry9bXwYY0ocD9pWE57pHl0
7OsPaYxgmMdJdVEX7wsG
=gUz7
-----END PGP SIGNATURE-----

--cPFClCCr7XAMcgDGICm4FGJTpkmI0cwMv--
