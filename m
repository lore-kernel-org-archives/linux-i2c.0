From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] Add support for SCCB devices into PXA27x I2C controller
Date: Sun, 23 Nov 2014 09:31:12 +0100
Message-ID: <20141123083112.GA1932@katana>
References: <54711397.9060601@tul.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54711397.9060601-qphu/3gb4gc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 11:52:07PM +0100, Petr Cvek wrote:
> Add support for SCCB devices into PXA27x I2C controller.
>=20
> Fix generated START but no STOP for message without I2C_M_NOSTART flag. A=
dd
> support for I2C_M_IGNORE_NAK flag.
>=20
> Signed-off-by: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>

I can't apply the patch. What is this based on? Can you rebase it to
i2c/for-next or the latest rc or at least the latest stable?

> ---
>  drivers/i2c/busses/i2c-pxa.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..adad044 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -885,7 +885,14 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c,
> u32 isr)
>          return; /* ignore */
>      }
>=20
> -    if (isr & ISR_BED) {
> +    /*
> +     * Ignore NAK when flag I2C_M_IGNORE_NAK is present,
> +     * this enables use of SCCB devices
> +     */

I'd think this comment is not needed since I2C_M_IGNORE_NAK is
self-explaining.

> +    if ((isr & ISR_BED) &&
> +        (!((i2c->msg->flags & I2C_M_IGNORE_NAK) &&
> +            (isr & ISR_ACKNAK)))) {
> +
>          int ret =3D BUS_ERROR;
>=20
>          /*
> @@ -919,12 +926,15 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c,
> u32 isr)
>          icr |=3D ICR_ALDIE | ICR_TB;
>=20
>          /*
> -         * If this is the last byte of the last message, send
> -         * a STOP.
> +         * If this is the last byte of the last message or last byte
> +         * or any message without I2C_M_NOSTART, send a STOP.
>           */
> -        if (i2c->msg_ptr =3D=3D i2c->msg->len &&
> -            i2c->msg_idx =3D=3D i2c->msg_num - 1)
> -            icr |=3D ICR_STOP;
> +        if (((i2c->msg_ptr =3D=3D i2c->msg->len) &&
> +            (!(i2c->msg->flags & I2C_M_NOSTART))) ||
> +            ((i2c->msg_ptr =3D=3D i2c->msg->len) &&
> +            (i2c->msg_idx =3D=3D i2c->msg_num - 1)))

You could factor out the length check. And you should check for
I2C_M_STOP, no?

> +                icr |=3D ICR_STOP;
> +
>      } else if (i2c->msg_idx < i2c->msg_num - 1) {
>          /*
>           * Next segment of the message.
> --=20
> 1.7.12.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcZtQAAoJEBQN5MwUoCm28ecP/07NoHsDHzaVQ8bOGO5uSWuu
GSrXm0fKtJ+fIlyfMp3QD6cAOO0nHwmmVORA83l466XhTcWt+GPymP9RXT/XE3ts
NR6UWSOhN5e4AJZlAl1cbT9CrAlja63EYWj2Copdp5ItMZnReTBunxggQ5Wgrut9
CRdi43z0foCOhhGkWfWL7PQf2FoITZaBmXeRB0+/BmKGra7zV8Rb9mRefcLDE7AZ
7PqrL0UAwcKw8Czs8hez+FuU4ocEOdPnA3nLgoCQBz0CEWCjmNOUniMLAmDrhP+P
Y9wV3zZlfuSWhoPx1KKhFH9/CnD0x6hCOVN2N6Zea7fDRLRDRiqrlISzVGUkyevZ
5SwvLPNADdA/hIgjtK/iqxbUvUN831HkEZVKfoc18aeHMfkZxpnvl49nDaDxdjB0
8xnXrAzRaSUfonByO3g6qqts1sksR/NsbEuPh5vGjs8IaVAE8bQO86zfT2I9aXZL
WNIyvHd0wshKrOP9YiWFKPjNiamOtia2XpkmbR9kc1nRM71KnYbcxwGzGJN40U+k
HcGnFyRF2WR53kdEfw4kFOT/AYI1zfL+zhVB7x4eFHlkN7vRVosbqmYe9ePW7G/g
BArEymxpz0ZVrpHPc3hPL3R2VnoR0ri6KFk4ba+quijabB0cI3UBwGCzZ9azemso
tML3QybdGNiM30qndlAe
=UEe8
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
