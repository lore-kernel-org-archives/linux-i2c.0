From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/5] i2c: img-scb: remove fifo EMPTYING interrupts
 handle
Date: Thu, 3 Sep 2015 09:54:00 +0100
Message-ID: <55E80AA8.9070501@imgtec.com>
References: <1439567447-8139-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567447-8139-3-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hWF5iSKEuKBWHUNK7QN1LDvgaTghQivX2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567447-8139-3-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--hWF5iSKEuKBWHUNK7QN1LDvgaTghQivX2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/08/15 16:50, Sifan Naeem wrote:
> Now that we are using the transaction halt interrupt to safely control

Is that referring to patch 4, which comes after this one?

> repeated start transfers, we no longer need to handle the fifo
> emptying interrupts.=20
>=20
> Handling this interrupt along with Transaction Halt interrupt can
> cause erratic behaviour.

You said in response to my question before:
> EMPTYING interrupt indicates that the transfer is in its last byte,
> and in old ip versions it was safe to start a new transfer at this
> point.  The erratic behaviour I saw was due to how the latest IP
> handles Master Halt. In this IP a transaction is halted after each
> byte of a transfer.  Having to halt the transfer after the last byte
> means we can no longer service the EMPTYING interrupt, doing so may
> cause repeated start transfers to fails.

That doesn't look like its what the code did though. If emptying and not
empty, it only wrote to fifo, but didn't start the next transaction.

>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index ad1d1df943db..75a44e794d75 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -154,7 +154,6 @@
>  #define INT_TIMING			BIT(18)
> =20
>  #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  | INT_FIFO_FILLING)
> -#define INT_FIFO_EMPTY_EMPTYING	(INT_FIFO_EMPTY | INT_FIFO_EMPTYING)
> =20
>  /* Level interrupts need clearing after handling instead of before */
>  #define INT_LEVEL			0x01e00
> @@ -176,8 +175,7 @@
>  					 INT_WRITE_ACK_ERR    | \
>  					 INT_FIFO_FULL        | \
>  					 INT_FIFO_FILLING     | \
> -					 INT_FIFO_EMPTY       | \
> -					 INT_FIFO_EMPTYING)
> +					 INT_FIFO_EMPTY)

img_i2c_write_fifo also clears INT_FIFO_EMPTYING from int_enable if
nothing left to write. That would seem redundant after this change.

Cheers
James

> =20
>  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
>  					 INT_ADDR_ACK_ERR     | \
> @@ -882,16 +880,8 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
>  				return ISR_WAITSTOP;
>  		}
>  	} else {
> -		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
> -			/*
> -			 * The write fifo empty indicates that we're in the
> -			 * last byte so it's safe to start a new write
> -			 * transaction without losing any bytes from the
> -			 * previous one.
> -			 * see 2.3.7 Repeated Start Transactions.
> -			 */
> -			if ((int_status & INT_FIFO_EMPTY) &&
> -			    i2c->msg.len =3D=3D 0)
> +		if (int_status & INT_FIFO_EMPTY) {
> +			if (i2c->msg.len =3D=3D 0)
>  				return ISR_WAITSTOP;
>  			img_i2c_write_fifo(i2c);
>  		}
>=20


--hWF5iSKEuKBWHUNK7QN1LDvgaTghQivX2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV6AqxAAoJEGwLaZPeOHZ6SgoP/jR0CMi6BPKpilUdnOppsOjh
FBBO6BNmADuR8Xs2FVAVbTDfcb0I0RSeLhauqCZtxqaZWyx105YtDZ/Buicn3xeT
dRYLtbEzDSe5SuXpCclAwZi2tn9qZlJf0br39VtT1m47IOwmmxMigrdXZo9zQigX
bKqX3d4vhFVnON+7j+ZwxWjvt6hgYJii74m9CkbQ5Y7O8LFfiB1bxs1NPzyXmAOq
BMN+XmZtGhXPJZ7GSruiIrMoDBMzB0BBLn+Qv5OruDWYrIl8Yc/x+7j9zHuo4vKT
ElR+8TWoYw1wYYTklJuGWhhjOlZtqY0YBCYJmGTjboS8ctCtdAcXdy8VE+oJ21ZO
wuTT+/n6tCZu3kR6gl+4p8eF6OYMAbQnmVvPacyBaE9os1OeLeahqtYobULvu+Df
aGM6grBIt0HX/qk9eXHYvIQd9Lgc34t+2YSMZQIhR3AkKkKfa/JQfbvXBvE5DZCh
coBHHQrR2YbMJP7FraBdYyL+13OFuyRy+oG1XeRyNbV14IJds6FmzeyK22wRRDGo
Y/jWcfy1+X03C5KlWHqoCMlkSFPRmEdpBEQHUrYhim6apYnutGZB3HrE5LAmpslo
/g9/T5ISyQxJ+rTmz2AZkOikpEhPwGg6L1aZ1Gac8bO1Y6KuyIRHqcvNT6H+2qQM
TUuij3QpNkkojFbWPKS7
=GCc/
-----END PGP SIGNATURE-----

--hWF5iSKEuKBWHUNK7QN1LDvgaTghQivX2--
