From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/8] i2c: img-scb: reset interrupts in img_i2c_soft_reset
Date: Tue, 28 Jul 2015 12:35:44 +0100
Message-ID: <55B76910.8030006@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-6-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1JhKAIduck3F2ubANSNt26VTCanNl9riu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437997641-32575-6-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Stable kernel (v3.19+)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--1JhKAIduck3F2ubANSNt26VTCanNl9riu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:47, Sifan Naeem wrote:
> Reset interrupt enable register and clear any generated interrupts
> to make sure of a clean slate after a soft reset. Not doing so might
> leave unhandle line status or generated interrupts which can cause
> issues when handling new transfers.

That already happens after the call to img_i2c_soft_reset, you've just
moved it to while the clock is off and the block is in soft reset. So
are you saying its important for interrupts and the various event bits
to be clear before taking it out of reset and enabling the clock? TBH
I'm confused how they could do any harm.

Cheers
James

>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driv=
er")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: Stable kernel (v3.19+) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 51a5be8..653f9bd 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -507,8 +507,22 @@ static void img_i2c_soft_reset(struct img_i2c *i2c=
)
>  {
>  	i2c->t_halt =3D false;
>  	img_i2c_writel(i2c, SCB_CONTROL_REG, 0);
> +
> +	/* Disable all interrupts */
> +	img_i2c_writel(i2c, SCB_INT_MASK_REG, 0);
> +
> +	/* Clear all interrupts */
> +	img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
> +
> +	/* Clear the scb_line_status events */
> +	img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
> +
>  	img_i2c_writel(i2c, SCB_CONTROL_REG,
>  		       SCB_CONTROL_CLK_ENABLE | SCB_CONTROL_SOFT_RESET);
> +
> +	/* Enable interrupts */
> +	img_i2c_switch_mode(i2c, MODE_INACTIVE);
> +	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
>  }
> =20
>  /* enable or release transaction halt for control of repeated starts *=
/
> @@ -1242,18 +1256,6 @@ static int img_i2c_init(struct img_i2c *i2c)
>  	/* Take module out of soft reset and enable clocks */
>  	img_i2c_soft_reset(i2c);
> =20
> -	/* Disable all interrupts */
> -	img_i2c_writel(i2c, SCB_INT_MASK_REG, 0);
> -
> -	/* Clear all interrupts */
> -	img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
> -
> -	/* Clear the scb_line_status events */
> -	img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
> -
> -	/* Enable interrupts */
> -	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
> -
>  	/* Perform a synchronous sequence to reset the bus */
>  	ret =3D img_i2c_reset_bus(i2c);
> =20
>=20


--1JhKAIduck3F2ubANSNt26VTCanNl9riu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVt2kQAAoJEGwLaZPeOHZ6lNAQAL2xRvpl3PbUe1aYnZl1RsJ6
TCOgey+BsdCLDWna4QCVw0OuAAIxCU2v+XYcXVhqwGYsird8T/PSp+7HP53PreWj
+nhiKdtNiaKmbdVsZgMrKFhxSsWGrgxTVlmqyEf2GHEkkjB+2BKzVJTWKKvEpAvh
8F3EMPNQ01xCHxzy/tY/02W2VjLLcwObZHC5UJV4Q4sMnz2fgkacj0cvUdEmrJU8
8S9zfOwDSU9wcgjs2OPpehpzPVGWrMOkVD1DTeZ4XurCnbzO/nHvAQrJxsRqu6Vf
4PwnGTKJ1xLJXIOlWcXmwSXoRk5XxjQ5ftJykLJK7nWWbeCtV4l1Qs6BU5QxeXZo
xGleJ91sZYfmoAz2G6T9nEIG/NII2l54/mVTD79QYoLLKnbDDOxGokCeS2HdBspy
e4Sfu55TLAsqF63YfHTxPIn4HI4YBUCoQ3nijO47yMuAj9eheWuFG0Hl40yRMmcG
FTvOLxTDltm9P5cXQRAJhTkqGfZDS+J6v8XGX1BpQ/bxpbU+jZzovPlbiwg4qRbz
WtaHykhZe7e0KTMPvAy3l5JaWdiYaY5d1/Pf/TrgsB6Rb5Wvc+y4jGlL+3WMMkYB
xcf0IBMnAVp/kX8mS9Tdfhzn6v5b1xHi+wGObTKi6q9K84AIkRC7WeDSOmXNR9q/
siJbdNqRfVN1I/rGRa2T
=x8cl
-----END PGP SIGNATURE-----

--1JhKAIduck3F2ubANSNt26VTCanNl9riu--
