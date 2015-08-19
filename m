From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 5/7] i2c: img-scb: remove start bit detected status
 after handling
Date: Wed, 19 Aug 2015 22:46:04 +0100
Message-ID: <20150819214604.GE8443@jhogan-linux.le.imgtec.org>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567424-8094-6-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439567424-8094-6-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--h56sxpGKRmy85csR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 04:50:22PM +0100, Sifan Naeem wrote:
> Remove start bit detected status after it is handled,
> doing so will prevent this condition being hit for
> every interrupt on a particular transfer.
>=20
> Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I=
2C SCB driver")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
> index e4daebcdf824..200108dbd194 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -857,10 +857,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i2=
c,
>  	}
> =20
>  	/* Enable transaction halt on start bit */
> -	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {
> -		img_i2c_transaction_halt(i2c, true);
> -		/* we're no longer interested in the slave event */
> -		i2c->int_enable &=3D ~INT_SLAVE_EVENT;
> +	if (line_status & LINESTAT_START_BIT_DET) {
> +		if (!i2c->last_msg) {
> +			img_i2c_transaction_halt(i2c, true);
> +			/* we're no longer interested in the slave event */
> +			i2c->int_enable &=3D ~INT_SLAVE_EVENT;
> +		}
> +		/*
> +		 * Remove start bit detected status after it is handled,
> +		 * doing so will prevent this condition being hit for
> +		 * every interrupt on a particular transfer.
> +		 */
> +		i2c->line_status &=3D ~LINESTAT_START_BIT_DET;

If we start checking line_status instead of i2c->line_status, this
masking off of START_BIT_DET from i2c->line_status seems redundant as it
won't have any effect on whether we hit this condition again on the next
interrupt.

I think the one line patch with just s/i2c->line_status/line_status/ on
the condition should be sufficient to prevent it handling the situation
repeatedly (that line status bit is latched, and should have been
already acked).

Cheers
James

>  	}
> =20
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
> --=20
> 1.7.9.5
>=20

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV1PkcAAoJEGwLaZPeOHZ6GJsP/i1xT9GpQ2GNXfQKNLC0YKrm
PmCd/eRZt8wyxjAWkMYMxMd9we307jW3KStVDRDYqI0GOLLKqr3XO75QUeqfBF36
lePS6VyA2HVNV6w4v+Fx7T8aMUH2YKc1EfvPubDY9+54fJKfDPXqCubEW//OxtvQ
SNZ25l8GmDxAmr1aKvgtyfWpGnKPFnCPeegEUUp0leaayjz7r55FqXSaHZXSqxdK
rqnHWMqEKRfC9PO1zQJK9dtm8iO4DspfWnSyFZbag19AoeE8WxebhZ0t2GHEXGLc
BwNua5oPlruJ2x/TGA/ISE6HR+HA9wlTKk/eQJOlKCMBrkd4S3ja6jvtGeZmZF8J
e7d3VV2zEJiCFZHUO4qnFDvDkEQY76Hgdm6kJKfLXmvYPEcPie4l/qDsTpLSZ5Ih
tt2DyA/tYpqzqf5lEYRZW6fyzhidAVY+IlpmDCGhz3urYyMfEHW4Hs9IBP+IiMij
s9qgljt1QzXvJsOG5OR+YBizWayAbp0OkMotCP4E80HTguX4n6w+HYECgn/OOSUe
xhka0H9bEbG747n8jSkyuJA1GtMQmdVykNQOcwToMlDj221rsW5cwGc8hJF0By8O
gAQHt7zyNwM3UcIkg8h+MgshwDl8H3X7uyBTBAhOGggxDqSAuunpLl9yujrSa1zY
z/w4QSxFaIIX7S0yujxY
=XIn2
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
