From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 3/5] i2c: img-scb: add handle for stop detected
 interrupt
Date: Wed, 2 Sep 2015 16:47:35 +0100
Message-ID: <55E71A17.8040406@imgtec.com>
References: <1439567447-8139-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567447-8139-4-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xcGaSUaDSb8U19fjTi2F7u3IDoQJ2ARpC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567447-8139-4-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--xcGaSUaDSb8U19fjTi2F7u3IDoQJ2ARpC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/08/15 16:50, Sifan Naeem wrote:
> Stop Detected interrupt is triggered when a Stop bit is detected on
> the bus, which indicates the end of the current transfer.
>=20
> When the end of a transfer is indicated by the Stop Detected interrupt,=

> drain the FIFO and signal completion for the transaction. But if the
> interrupt was triggered before all data is written to the fifo or with
> more data expected return error with transfer complete signal.
>=20
> Halting the bus is no longer necessary after a stop bit is detected
> on the bus, as there cannot be a repeated start transfer when the stop
> bit has been issued, hence remove the transaction halt bit.

This patch looks okay, but does this paragraph still apply?

Cheers
James

>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 75a44e794d75..17e13ff475bb 100644
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
> @@ -873,6 +875,13 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
> =20
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
> =20
> +	if (int_status & INT_STOP_DETECTED) {
> +		/* Drain remaining data in FIFO and complete transaction */
> +		if (i2c->msg.flags & I2C_M_RD)
> +			img_i2c_read_fifo(i2c);
> +		return ISR_COMPLETE(0);
> +	}
> +
>  	if (i2c->msg.flags & I2C_M_RD) {
>  		if (int_status & INT_FIFO_FULL_FILLING) {
>  			img_i2c_read_fifo(i2c);
>=20


--xcGaSUaDSb8U19fjTi2F7u3IDoQJ2ARpC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV5xogAAoJEGwLaZPeOHZ6DFMP/3LGfXkGILRvwofzURab/6uL
FHOKx2jEYeDYLFRZhM5f/aNHp50zXtphufDUbrxWJScaQXs9Vf93CvLf+t+yOnwK
VwBiU8bff1jq6xtMpDPpQdWNzMJRbYUbjOOCTy+gwoswecJt6S3ZvWJDQJHX8KDL
a1pOT8PY6m/TX1myhKINOSO4TsEFoSUiZIofGKF1iNs0lLSHyFbGVB15dShT11bt
T7wmFbB30kZFu7mbUImvbFzwGawcdvjd90V74bmQz+kBoZRnq07Ihe7dYES8agH0
Pq7UYgul/2li6up+zYLiwh0TqwaAJFbyuZ0EFZOUXo3+XxKoyn6aqUgUOUEHJT4F
rS/7WtAJWDPBbQUUhD/D510J/3/llL4vnR+Zb8y3bCZpL08P3/P74Lb1jEcP0QJz
9a+xSF5dlnhhjDYHFLC9ehVg+EUE0+Nn5nI3LWivK6k6J3x0MHu6l6Ov5aJSb2SX
qoVJQRuwt5demggWuR6/cECDocEwcN9lzWQh7ZpO8zFPcy0mNL0znRqUJ/aCXNU7
gEh+JwLab0PVxOfdCneRJlWkS2cx76plvo6zwwm/Cj90qixbWQpj0cCL1NcU/jBq
62U6ndFKuMh/OxaaGZmyQeyiIDWi1bys/qIcymJGJ9xQBol3mObp1SBYYAAJXw7e
f33LQNN1MYEQuB4yAtzj
=Swwt
-----END PGP SIGNATURE-----

--xcGaSUaDSb8U19fjTi2F7u3IDoQJ2ARpC--
