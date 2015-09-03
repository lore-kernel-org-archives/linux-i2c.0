From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: img-scb: support repeated starts on IP v3.3
Date: Thu, 3 Sep 2015 09:29:46 +0100
Message-ID: <55E804FA.7040401@imgtec.com>
References: <1439567447-8139-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567447-8139-6-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9viGNQtkrVCBwFQdJHOjakeW93lSR2kUb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567447-8139-6-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--9viGNQtkrVCBwFQdJHOjakeW93lSR2kUb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/08/15 16:50, Sifan Naeem wrote:
> In version 3.3 of the IP when transaction halt is set, an interrupt
> will be generated after each byte of a transfer instead of after
> every transfer but before the stop bit.
> Due to this behaviour we have to be careful that every time we
> release the transaction halt we have to re-enable it straight away
> so that we only process a single byte, not doing so will result in
> all remaining bytes been processed and a stop bit being issued,
> which will prevent us having a repeated start.
>=20
> This change will have no effect on earlier versions of the IP.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   45 ++++++++++++++++++++++++++++++=
--------
>  1 file changed, 36 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 837a73a43a6d..7a51f39528d7 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -513,7 +513,17 @@ static void img_i2c_soft_reset(struct img_i2c *i2c=
)
>  		       SCB_CONTROL_CLK_ENABLE | SCB_CONTROL_SOFT_RESET);
>  }
> =20
> -/* enable or release transaction halt for control of repeated starts *=
/
> +/*
> + * Enable or release transaction halt for control of repeated starts.
> + * In version 3.3 of the IP when transaction halt is set, an interrupt=

> + * will be generated after each byte of a transfer instead of after
> + * every transfer but before the stop bit.
> + * Due to this behaviour we have to be careful that every time we
> + * release the transaction halt we have to re-enable it straight away
> + * so that we only process a single byte, not doing so will result in
> + * all remaining bytes been processed and a stop bit being issued,
> + * which will prevent us having a repeated start.
> + */
>  static void img_i2c_transaction_halt(struct img_i2c *i2c, bool t_halt)=

>  {
>  	u32 val;
> @@ -582,7 +592,6 @@ static void img_i2c_read(struct img_i2c *i2c)
>  	img_i2c_writel(i2c, SCB_READ_ADDR_REG, i2c->msg.addr);
>  	img_i2c_writel(i2c, SCB_READ_COUNT_REG, i2c->msg.len);
> =20
> -	img_i2c_transaction_halt(i2c, false);
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
>  }
> =20
> @@ -596,7 +605,6 @@ static void img_i2c_write(struct img_i2c *i2c)
>  	img_i2c_writel(i2c, SCB_WRITE_ADDR_REG, i2c->msg.addr);
>  	img_i2c_writel(i2c, SCB_WRITE_COUNT_REG, i2c->msg.len);
> =20
> -	img_i2c_transaction_halt(i2c, false);
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
>  	img_i2c_write_fifo(i2c);
> =20
> @@ -863,7 +871,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2=
c,
>  	/* Enable transaction halt on start bit */
>  	if (line_status & LINESTAT_START_BIT_DET) {
>  		if (!i2c->last_msg) {
> -			img_i2c_transaction_halt(i2c, true);
> +			img_i2c_transaction_halt(i2c, !i2c->last_msg);

This hunk seems pointless given the "if" conditional it resides in.

Otherwise
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Cheers
James

>  			/* we're no longer interested in the slave event */
>  			i2c->int_enable &=3D ~INT_SLAVE_EVENT;
>  		}
> @@ -1093,12 +1101,31 @@ static int img_i2c_xfer(struct i2c_adapter *ada=
p, struct i2c_msg *msgs,
>  		img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
>  		img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
> =20
> -		if (atomic)
> +		if (atomic) {
>  			img_i2c_atomic_start(i2c);
> -		else if (msg->flags & I2C_M_RD)
> -			img_i2c_read(i2c);
> -		else
> -			img_i2c_write(i2c);
> +		} else {
> +			/*
> +			 * Enable transaction halt if not the last message in
> +			 * the queue so that we can control repeated starts.
> +			 */
> +			img_i2c_transaction_halt(i2c, !i2c->last_msg);
> +
> +			if (msg->flags & I2C_M_RD)
> +				img_i2c_read(i2c);
> +			else
> +				img_i2c_write(i2c);
> +
> +			/*
> +			 * Release and then enable transaction halt, to
> +			 * allow only a single byte to proceed.
> +			 * This doesn't have an effect on the initial transfer
> +			 * but will allow the following transfers to start
> +			 * processing if the previous transfer was marked as
> +			 * complete while the i2c block was halted.
> +			 */
> +			img_i2c_transaction_halt(i2c, false);
> +			img_i2c_transaction_halt(i2c, !i2c->last_msg);
> +		}
>  		spin_unlock_irqrestore(&i2c->lock, flags);
> =20
>  		time_left =3D wait_for_completion_timeout(&i2c->msg_complete,
>=20


--9viGNQtkrVCBwFQdJHOjakeW93lSR2kUb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV6AUEAAoJEGwLaZPeOHZ69x0P/jfW0Y/AbR6132lovLkHKYsH
mmWugQj/RbNFt2SCUf9OdWPwsDDoGp/gQfgmVHln7L+EDdtzXmj94U1PGIobA8rF
7vaUcM7AKVT7C2fVfi7E7GJj6COenUn3oSPI/vuk50sAR00pEQefW71mn/Cp4EaY
DpK+02aM+HSw432LnJUMws0UmyIw+gi8fglujWDd2TWYtrxLA/pGttXw7zxrWQEQ
WCwpuawPrAMborxuMFCXD6O4ugm20hNqTBxGMRYxQrAqYaFAzlv16hJp41TTgEtX
v2skQRBAg/xMv48JTQRrkvE83nSv/RpsBX9GeRQV1vmeL+jiVy9B+2rfKG66XSHk
1xViqIkZHNR50t4naTYzEDvddsHckn7ZcPqCLkzxh4HLTGNA4vbQVVNZBbwaLEU/
Y8wSXl8qd637/sv+JcgB37vSCFzl/9Gocb5Qds1I+Q7lfRQGDJndTSD3Z3eFZLJM
sj3MCCEYMyCNrgRdrD+2GyXonFYzmwG5pHdkkNdOes4AOiHqhqVLw1xC9y9C13Md
BzWp9zGeChZAfiNiyHj8QZUVCPEVRSK/mViE/5H524cTr8xcplRLj0PJL2ILUevZ
8EYr0G3K/M1+j4L13q+s7U3W3S71CLpBCwqpl2B0iutJmnFMsuRYeCKItmF7csXB
YwJ4yh4AepL8HbRMFRhs
=uojn
-----END PGP SIGNATURE-----

--9viGNQtkrVCBwFQdJHOjakeW93lSR2kUb--
