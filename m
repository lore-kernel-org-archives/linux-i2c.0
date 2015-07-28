From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 6/8] i2c: img-scb: remove start bit detected status after
 handling
Date: Tue, 28 Jul 2015 14:53:01 +0100
Message-ID: <55B7893D.4020409@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-7-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="02H6emxTx3cL9S3mB3jxX5vTadphQT0wx"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-7-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--02H6emxTx3cL9S3mB3jxX5vTadphQT0wx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:47, Sifan Naeem wrote:
> Remove start bit detected status after it is handled,
> doing so will prevent this condition being hit for
> every interrupt on a particular transfer.
>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driv=
er")
> Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 653f9bd..341130e 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -871,10 +871,18 @@ static unsigned int img_i2c_auto(struct img_i2c *=
i2c,
>  	}
> =20
>  	/* Enable transaction halt on start bit */
> -	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {

i2c->line_status accumulates the line status bits that have been seen
with each interrupt. If we're only interested in that bit from the
current interrupt, should it just be referring to line_status (the
argument to img_i2c_auto) instead of i2c->line_status?

Cheers
James

> -		img_i2c_transaction_halt(i2c, true);
> -		/* we're no longer interested in the slave event */
> -		i2c->int_enable &=3D ~INT_SLAVE_EVENT;
> +	if (i2c->line_status & LINESTAT_START_BIT_DET) {
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
>  	}
> =20
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
>=20


--02H6emxTx3cL9S3mB3jxX5vTadphQT0wx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVt4k9AAoJEGwLaZPeOHZ61g4QAKrytWf0ghQUfLSXU9GzR6lj
XevCNpFS5HS1FAE/M/I6C83wAZyz+0dRnhZC6vkt+iza4+Gmpt+ugvK/Qp7Gi6DR
SzxbNy2wQu05aNTojGc4DJJqRP+6EXoZAhybZLAR6iX4T65ClCTXzSVhNywtvhvK
5HYvtu2y34OGAjKr3p9SqewbO2KkIcJxbrdcVJ2ET7ayUsHfbQADqKxTHVZlMBsN
DD1xxa1sbnLaMPU0QUT1y4u+q2bzntlTLIlqwUjH/VSlUYf5xfL5myEtbJRb36u8
HcM9/thsS8E2o7vxMBOET/+vPNj4KapBvqJYH7Yu2yzR948xLs6lFaDJ/LsOP7nV
2N5AK+rh0OsH1XX3P45vcgcJZatdcPBeeM9bl9/+FfxniO7BHP5X6r9Crz0UNFYN
nysmkoAQo0gNNGWdzMrk5+7g7m8FcWN+53TdxKbZFMt2nSYjoltNn23Ia4SyFFg0
pbzkIeUcBT1SJdGNFkuMqpuwXtfhVGbr5r13hzBZuBhLK8mbZ1l9kShfscevkd77
drBQWHDj2CqoPHl4ygxUawEbx8DXYue0Q5hC2iDNaJ7U3/VNMTMm4jU8dEDmZGhp
atXwl2ikftAPXEbQr+JzXFCbGc31UahX/+noOmUOnpb1VInWr3DaKh+nX/FGW/1y
s1GIMUt4vgkC67vcaAqD
=2Shx
-----END PGP SIGNATURE-----

--02H6emxTx3cL9S3mB3jxX5vTadphQT0wx--
