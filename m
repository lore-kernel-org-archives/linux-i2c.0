From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 5/7] i2c: img-scb: use line_status instead of
 i2c->line_status
Date: Mon, 14 Sep 2015 13:15:53 +0100
Message-ID: <20150914121553.GJ29072@jhogan-linux.le.imgtec.org>
References: <1441896607-16310-1-git-send-email-sifan.naeem@imgtec.com>
 <1441896607-16310-6-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441896607-16310-6-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2015 at 03:50:05PM +0100, Sifan Naeem wrote:
> i2c->line_status accumulates the line status bits that have been seen
> with each interrupt. As we're only interested in that bit from the
> current interrupt, refer to line_status (the argument to img_i2c_auto)
> instead of i2c->line_status.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Thanks
James

> ---
>  drivers/i2c/busses/i2c-img-scb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
> index e4daebcdf824..049d193d01ac 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -857,7 +857,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
>  	}
> =20
>  	/* Enable transaction halt on start bit */
> -	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {
> +	if (!i2c->last_msg && line_status & LINESTAT_START_BIT_DET) {
>  		img_i2c_transaction_halt(i2c, true);
>  		/* we're no longer interested in the slave event */
>  		i2c->int_enable &=3D ~INT_SLAVE_EVENT;
> --=20
> 1.7.9.5
>=20

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV9rp5AAoJEGwLaZPeOHZ6ij8P/0cS/4Kh1FA4ZeYqTzyfmT0k
LLxB7qGYkRkNIipAzKgJTJUq+T8Xs9qkv2w7f2YNobfntgXtZmKtgT8T/GtcUWPg
VPcZDSDqM87zhh2ebIa3GjORhyc/2BSr9MQdXDnk9WmVAeeRixx80ETX+00miDbr
SwwakNiU2g5D0Fs20423LOK8uVRwrtndUracXrXoUaJNgPvDylmN3NcuxM3ci31Q
gkf8Lvc47PdtpZYIQFQsHi3FxxQuiyY/YY955Qr0bQsKM6ZVsns/QwtPvKBxxMTE
wQh83VrVeuJ6eQK6hcoIFW0KAaEO2/0zBYjer0eJpEz1mznJGmENx9yn0vTLzQQH
ASiOJL8czEtaQcdlU1gkMYeZxLCYuZ6XASO+SLiSDPbzQEjc0JColfQSzP5160JT
L6hbO8yptEcVlCV7SKhSZTvVmLjS5HhjN7f8ekbC3+aX3srsvE7mf8v/4pTQr+vD
rAJFJli2FVoqg9HIKh/lfKEBpC30CM/u4bM9O4/JMK/ShnlxqOPWZkTnB8x5WKDq
VYVyXSUyOWhU2jrm7aDCX0WZLKwvkp9JC68WzTbcSxmIpq/MnvvDtt0cfoRrmkSP
iQI5J8lTm3z8Sqy7arqygjz78irm0p11zrBihEI+/6vPqjWdpxTBvF2O29LB+CLn
vX3GY2eRXRVMLmNZm3Fo
=rucf
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
