From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 7/7] i2c: img-scb: add handle for Master halt interrupt
Date: Wed, 29 Jul 2015 16:59:05 +0100
Message-ID: <55B8F849.4080105@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com> <1437998162-32724-8-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NhV2CcsDDgswoMvXsHrunGMM4wdRIWxRV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-8-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--NhV2CcsDDgswoMvXsHrunGMM4wdRIWxRV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:56, Sifan Naeem wrote:
> Master halt is issued after each byte of a transaction is processed in
> IP version 3.3.
> Master halt will stall the bus by holding the SCK line low until the
> halt bit in the scb_general_control is cleared.
>=20
> After the last byte of a transfer is processed we can use the Master
> Halt interrupt to facilitate a repeated start transfer without
> issuing a stop bit.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 90faf48..df3d25a 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -151,6 +151,7 @@
>  #define INT_FIFO_EMPTYING		BIT(12)
>  #define INT_TRANSACTION_DONE		BIT(15)
>  #define INT_SLAVE_EVENT			BIT(16)
> +#define INT_MASTER_HALTED		BIT(17)
>  #define INT_TIMING			BIT(18)
>  #define INT_STOP_DETECTED		BIT(19)
> =20
> @@ -177,6 +178,7 @@
>  					 INT_FIFO_FULL        | \
>  					 INT_FIFO_FILLING     | \
>  					 INT_FIFO_EMPTY       | \
> +					 INT_MASTER_HALTED    | \
>  					 INT_STOP_DETECTED)
> =20
>  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
> @@ -901,6 +903,17 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
> =20
>  	if (i2c->msg.flags & I2C_M_RD) {
> +		if (int_status & INT_MASTER_HALTED) {
> +			img_i2c_read_fifo(i2c);
> +			if (i2c->msg.len =3D=3D 0)
> +				return ISR_COMPLETE(0);

don't you still need to wait for stop bit on last message?

I suspect you could have a bit less duplication with something like this
(again untested):

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
index f694b47dcf74..2de2d63083e5 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -875,13 +875,14 @@ static unsigned int img_i2c_auto(struct img_i2c *i2=
c,
 	}
=20
 	if (i2c->msg.flags & I2C_M_RD) {
-		if (int_status & INT_FIFO_FULL_FILLING) {
+		if (int_status & (INT_FIFO_FULL_FILLING | INT_MASTER_HALTED)) {
 			img_i2c_read_fifo(i2c);
 			if (i2c->msg.len =3D=3D 0)
 				return ISR_WAITSTOP;
 		}
 	} else {
-		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
+		if (int_status & (INT_FIFO_EMPTY_EMPTYING |
+				  INT_MASTER_HALTED)) {
 			/*
 			 * The write fifo empty indicates that we're in the
 			 * last byte so it's safe to start a new write
@@ -895,6 +896,14 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c=
,
 			img_i2c_write_fifo(i2c);
 		}
 	}
+	if (int_status & INT_MASTER_HALTED) {
+		/*
+		 * Release and then enable transaction halt, to allow only a
+		 * single byte to proceed.
+		 */
+		img_i2c_transaction_halt(i2c, false);
+		img_i2c_transaction_halt(i2c, !i2c->last_msg);
+	}
=20
 	return 0;
 }

would that do the trick?

Cheers
James

> +			/*
> +			 * Release and then enable transaction halt, to
> +			 * allow only a single byte to proceed.
> +			 */
> +			img_i2c_transaction_halt(i2c, false);
> +			img_i2c_transaction_halt(i2c, !i2c->last_msg);
> +		}
>  		if (int_status & INT_FIFO_FULL_FILLING) {
>  			img_i2c_read_fifo(i2c);
>  			if (i2c->msg.len =3D=3D 0) {
> @@ -922,6 +935,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
>  			return ISR_COMPLETE(ret);
>  		}
>  	} else {
> +		if (int_status & INT_MASTER_HALTED) {
> +			if ((int_status & INT_FIFO_EMPTY) &&
> +			    i2c->msg.len =3D=3D 0)
> +				return ISR_COMPLETE(0);
> +			img_i2c_write_fifo(i2c);
> +			/*
> +			 * Release and then enable transaction halt, to
> +			 * allow only a single byte to proceed.
> +			 */
> +			img_i2c_transaction_halt(i2c, false);
> +			img_i2c_transaction_halt(i2c, !i2c->last_msg);
> +		}
>  		if (int_status & INT_FIFO_EMPTY) {
>  			if (i2c->msg.len =3D=3D 0) {
>  				if (i2c->last_msg)
>=20


--NhV2CcsDDgswoMvXsHrunGMM4wdRIWxRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuPhJAAoJEGwLaZPeOHZ6mIgP/2NR3519FAYFykxD+mhxGLgS
mo53sWADgWIX6xM34oVVevZKyHfcDnYaKsD7YHitFV+bLjChTaH3P+0vGABshslO
Im0eMyoeCL1Za2CO8kUazfz5sPubq4OsM72sJVcZz6V9NUZAIQSsEMHwkSBJWRGo
4VmWkD6GKieqD2LpbttYQwOUQZ/miUStOxO82CWe24vbb1OJ0MFxLuo2G0NiYUiJ
ayqkvVmYFs5aPNXrNi37Fp/pN+KtItYvUk0fOZ1QY62SDo6kOqvSmm7CRVIaBZ18
VD3AWkjqLDKK4wUf3vzl970107V2T7bZyXiYrkiu015eENO4qjZJMgDqn74oLAZQ
NULvZmfSfQBjJNpltpTtzO6to0dDXmJx3W/VEUR3bb/xTe++R7tnLbRmPM94Mft+
dcLBC/fNhITAj8hnJQyRxy5gmbA8JHOEuD9C+SVkVX732E+KET7YpfhMHM9EZ/YY
lWOdMZIyjN077OPWSe7POdAvEy6GsM7yEYzm+ZkN0GDQMZFBhQdz5Yx+Xivbd5XV
D49RfNy4Zfr5lAOUO73sZIH5uGc6Fo0mqBpgNTh33V3MbIQmXxWrbjRPmhDEWyIO
1iOYnJ2CNqnD79yWOIcY3l6FhU+ARzCiozFQU/BrwcoqAKZUnOlO0+aQtKnyoDqT
PLvQZc9YnIGIm+4zzZbC
=051K
-----END PGP SIGNATURE-----

--NhV2CcsDDgswoMvXsHrunGMM4wdRIWxRV--
