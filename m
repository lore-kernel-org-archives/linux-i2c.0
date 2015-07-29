From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 7/8] i2c: img-scb: improve transaction complete handle
Date: Wed, 29 Jul 2015 13:22:02 +0100
Message-ID: <55B8C56A.7050102@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-8-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="38110gI8hgluvErkHAfFjgdAk8DTg7BRO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437997641-32575-8-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Stable kernel (v3.19+)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--38110gI8hgluvErkHAfFjgdAk8DTg7BRO
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sifan,

On 27/07/15 12:47, Sifan Naeem wrote:
> Clear line status and all interrupts when transaction is complete,
> as not doing so might leave unserviced interrupts that might be

Do you have a specific example of when this might happen, and whether it
could occur after img_i2c_complete_transaction()?

I'm just wondering if it would be better to do this before starting
every new message instead of after handling the last irq that is of
interest (maybe somewhere in img_i2c_xfer).

> handled in the context of a new transfer. Soft reset if the the
> transfer failed to bring back the i2c block to a reset state.
>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driv=
er")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: Stable kernel (v3.19+) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 341130e..bbfee33 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -626,7 +626,10 @@ static void img_i2c_complete_transaction(struct im=
g_i2c *i2c, int status)
>  	img_i2c_switch_mode(i2c, MODE_INACTIVE);
>  	if (status) {
>  		i2c->msg_status =3D status;
> -		img_i2c_transaction_halt(i2c, false);
> +		img_i2c_soft_reset(i2c);

This seems like overkill. This will only happen in a couple of cases:
(1) an automatic mode ack error, which is completely recoverable.
(2) a fatal error (clock low timeout), which switches mode to MODE_FATAL
anyway, preventing further transactions.

Cheers
James

> +	} else {
> +		img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
> +		img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
>  	}
>  	complete(&i2c->msg_complete);
>  }
>=20


--38110gI8hgluvErkHAfFjgdAk8DTg7BRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuMVqAAoJEGwLaZPeOHZ6tIoP/2BoGTkFCESmoKV0I9Gq7OnC
4doQiR6h4RumBvBM99ZPOb2N3l3HE++/T0ii9bMXevyF+WMMgbloSn2q7iVnay5E
slrjBlZgY13FoACQApNF1xBPObD9GgQMzn0XDzu7o2uLT2hSjbQCJOTI4cXymLhU
ei4Y8EnGguFqMzvufd0IsSVDQZ33JtPFqCZYVmhWXVA1V6ANBKvpc7SHfW4SY6vg
p5Mtpzz1k9ia3R/SoBbdYunPeyqyx7o9bK0uTc4ZDUj9JrGJKAMFYvYP/MWf1qx1
FOSq1b3PMONf04EbBFRq52Cx9tCli7R9M1y8iwPlIWwABP6kczOuwGDWaeutYYag
LtlNlE6LPwOUx+V4ZhLExkmB1Kp84TIOZ/72qIZrnyrCHrZVJ0z/0DtHNx+Ya6DI
notZkiytZl6waPFkJuarQBOAYLF929eNSanXgmM2n3Y2Ul0PcmDM9zMOBUpQBvjv
ZFb3K331qzHMpb0VWt+BwObYUOi8gXZLbVO9WpXer7Dj8eGUXmCGMoVUU6XFT4f8
YjCsg14jHjDGlVNXM3199QzJi2+Ws6B+9tCbr/j+HG95PxWfimC7wEQgTi8TzgqA
bSwMMGNGSBQPua88lZ8hxoyj5Qp/5G4fP17mExqbXnw22q8gqCR8cifKtTLiiiAN
b57FJ9xbO/GE0nHf1NA0
=EJfV
-----END PGP SIGNATURE-----

--38110gI8hgluvErkHAfFjgdAk8DTg7BRO--
