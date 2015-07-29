From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/7] i2c: img-scb: remove fifo EMPTYING interrupts handle
Date: Wed, 29 Jul 2015 17:01:05 +0100
Message-ID: <55B8F8C1.8030507@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com> <1437998162-32724-6-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8i7trFtvvtdlU4srrgO2eW9nu2GMi88Pm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-6-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--8i7trFtvvtdlU4srrgO2eW9nu2GMi88Pm
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:56, Sifan Naeem wrote:
> This interrupt could have been useful for repeated start transfers
> as the current transfer could be marked as complete while it's
> processing the final byte of the transfer.
> But having to use the transaction halt interrupt to safely control
> repeated start transfers, means handling of the fifo EMPTYING
> interrupts is no longer necessary.
>=20
> Handling this interrupt along with Transaction Halt interrupt can
> cause erratic behaviour.

I'd be interested to know the cause of the erratic behaviour. It feels a
little like we're just masking a real bug somewhere.

Cheers
James

>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index efad4d7..10141a9 100644
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
> =20
>  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
>  					 INT_ADDR_ACK_ERR     | \
> @@ -910,7 +908,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2=
c,
>  			}
>  		}
>  	} else {
> -		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
> +		if (int_status & INT_FIFO_EMPTY) {
>  			if (i2c->msg.len =3D=3D 0) {
>  				if (i2c->last_msg)
>  					return ISR_WAITSTOP;
>=20


--8i7trFtvvtdlU4srrgO2eW9nu2GMi88Pm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuPjBAAoJEGwLaZPeOHZ6rnkQALoi+44L3tSez1aOzFdCqop7
HK2io0bb08ifYt0ocVGGXmjfSGo7nlbax2KpGM+jAOmN3jX/raBrEAZz0bjoWSAm
f1OSL9S3CBO5nnMOmsCGqBc4UfgxcfCPec7COM2uOZHsWzjSvsSdvLRykaoj8fUE
Tj6rlMMLmxTLm/uLlUVSbrtE0iklqZvr5pISWnE13UCvlejjdT1s1b2GyQDZUbPj
rrHBXq6jltS9OC7NX3MKGg67uFoN/AKq4wb1efkKEHiFlwFfptbTcdu5qipSWdGt
RJX1bdrZz+XfTv/Nt9hqzCCPvJ/JdVPRkoWQ+aOqZx/WyeCjdPdBfzwoWdcE62lR
eAq5yLeeDfnSjkL0LJLbqyHbo44RvozsLrzwoosYvsqf99zI+0GVODA2mUV7tAeC
Kbp2uzvEcFlxc7BjuyPLDdnkfqD08TNGu/GWPYdI/aRmTiUMZoppcR1XtKqUPQkv
o4Pw4p+4OgSLMY4Mfa0a1zw8Gjxn7SpdMxk+MaEgg86Ng4hEyWRNIej5YhPO2OIS
s6rnr36/TcG37l+MurQJGZtt2LULGnAViZKBFfQwJh3gqwpPOg/L+1IhunR4Cr/I
UVTp0P61iySEmZd1vJSEHnMtsm3oekrKvjdBvDEGyd76rvBtaQBsT8w7AozVt7p0
q2PTgUrSslC0q08/HJAf
=8psK
-----END PGP SIGNATURE-----

--8i7trFtvvtdlU4srrgO2eW9nu2GMi88Pm--
