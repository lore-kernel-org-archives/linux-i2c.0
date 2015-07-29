From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/7] i2c: img-scb: mark transaction as complete when no
 more data to write
Date: Wed, 29 Jul 2015 15:22:18 +0100
Message-ID: <55B8E19A.8010302@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com> <1437998162-32724-5-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="il12AVJgbIJlSl5MMwfhkxFRkD5iwlx8g"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-5-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--il12AVJgbIJlSl5MMwfhkxFRkD5iwlx8g
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:55, Sifan Naeem wrote:
> We can mark the transfer as complete without waiting for the stop
> bit. This is important when handling repeated start transfers as
> we have to start the next transfer without the stop bit being issued.
>=20
> This doesn't affect the older versions of the IP.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index e27c3e0..efad4d7 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -911,16 +911,11 @@ static unsigned int img_i2c_auto(struct img_i2c *=
i2c,
>  		}
>  	} else {
>  		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
> -			/*
> -			 * The write fifo empty indicates that we're in the
> -			 * last byte so it's safe to start a new write
> -			 * transaction without losing any bytes from the
> -			 * previous one.
> -			 * see 2.3.7 Repeated Start Transactions.
> -			 */
> -			if ((int_status & INT_FIFO_EMPTY) &&
> -			    i2c->msg.len =3D=3D 0)
> -				return ISR_WAITSTOP;
> +			if (i2c->msg.len =3D=3D 0) {
> +				if (i2c->last_msg)
> +					return ISR_WAITSTOP;
> +				return ISR_COMPLETE(0);
> +			}

Again, already happens in img_i2c_isr().

Cheers
James

>  			img_i2c_write_fifo(i2c);
>  		}
>  	}
>=20


--il12AVJgbIJlSl5MMwfhkxFRkD5iwlx8g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuOGaAAoJEGwLaZPeOHZ6Ij8QALtRPWEDX6tfHPbNiH0LxWlS
8EET5Q973JG8lgqgkz3fSsU4VP3wRF5MJjnUIU1VHEdh22jP2FdaRgy66vFIFnlk
Bozunbj12d+n5XtJExiyl7ssBIwoQl+jgY0CIO3tXR791dbEAo+chUc/pPJ8N+vl
2et/p5raqC6oDzMQOOr4XrQEZI8l0PfsuByIRNOdWif92LhdY2dC2y/jIzBiRFKb
iQdEcsEhvls6sltPynxKjKZN3k6RChaBBfXXvM4Ff7MpqyH+bOC1uzu7xyMqdMiZ
cGx3VQ0egHc+O0dHq/dbgoBko81F9LQFuVXLXZ/MsIjcjHjffK4VbeeoG8FqLc2N
CrC1E4UXGF62scNtVR11AvSyQC3/VTA9nZG5M4up//WnVXZf/SELMoDy/N31lAuU
NKhC4dwkYSZ2zvW4Q3Q7SaVomXkNRZjDXWGvYApB4u+j1LDN+5m5XvwRuGwsBOre
RqoBdefzf8MRS+u92AluijnnYAbH3GZ6M1F8htBR14XDf1JRlGgA5Xe1G8KS1YiO
pw6iV2Tf9hZ/1XAS2BbRIjdWZQxZFX4WFCg2a/kvYbWmyVwDOct0MARPeJOPEZkj
vYZFj79N7Vd5uVHdJffSSp4IJOCy18Q0EKorspHRSfqYvC8Gs8v/ZA66f01MTW9F
hPq1SIp2XW4Z5GsLVOkk
=kq3C
-----END PGP SIGNATURE-----

--il12AVJgbIJlSl5MMwfhkxFRkD5iwlx8g--
