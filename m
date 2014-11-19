From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: introduce probe deferring
Date: Wed, 19 Nov 2014 10:16:47 +0100
Message-ID: <20141119091647.GB1439@katana>
References: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415972879-26509-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2014 at 02:47:59PM +0100, Ludovic Desroches wrote:
> Return probe defer if requesting a dma channel without a dma controller p=
robed.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 77fb647..df3f4c4 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91_twi_d=
ev *dev, u32 phy_addr)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
> =20
> -	dma->chan_tx =3D dma_request_slave_channel_compat(mask, filter, pdata,
> -							dev->dev, "tx");
> -	if (!dma->chan_tx) {
> +	dma->chan_tx =3D dma_request_slave_channel_reason(dev->dev, "tx");

Will it cause regressions if you drop the compat-version of requesting
a channel?

> +	if (IS_ERR(dma->chan_tx)) {
> +		ret =3D PTR_ERR(dma->chan_tx);
> +		if (ret =3D=3D -EPROBE_DEFER) {
> +			dev_warn(dev->dev, "no DMA channel available at the moment\n");

I'd say drop this warning. The core usually prints when deferred probing
takes place.


--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbF//AAoJEBQN5MwUoCm2dfYQAJ8tnLaLV+RW6BU1nnmk4WoB
dvuvaVtoFRv4M903dHgCKKZWcj6vNaYp5gcd23ybBaANSSZ3ajlc0Y7BHIA8HpoQ
UsOCMVommBfijEQwcBh9q5dk8AAJ0vva2TuAX/cji9ucRsABBgO/q6hI4l18DXhh
GwsXedNWs9kC4W3A1As9qwFcwYsXHXiBfu2LxoIzo1n7eK/mifvimi0AfMPIjd6y
auEvL8Yx1qQ6V7PRK8er1wgWjBOeWoZOLsIU16iGjjwPzJZ9mkcdj8dY7SjazXDz
qcluN+9kC4Q85jE04L7CSFIgUs86MsRhheU92fVeSod+j+4ZeLIRvp5yCJ0DrUQQ
oGhsCCirDJrIzi/Y+CPsj4hPt1tLUvfDqjfG27cZyRX8ksJrQlEs76m2ZNYCYkOk
P5w6LdPtDA5HAZc4T5n6MpB9fiJui5j0XokHDJwJl637qD0WJwV0/ke+NL+oevvm
WycZjdddLIQNply7PjeDVyyqCw58r24lt1GB7p3jog+vhzHFn7DqLaYDgLczaL9Z
otW3tbqmmnK1q0Bo8e2iXZlm4EPSswQdcdSbAPbVrpUwqXnDoc+lzpdO/8UDQIe7
AkgXBEbYyMy4+VOoA243BRrBX87CEuyEsXzFRThy/EAKzukTL2Xy4XzfVSwI932x
o54CaqhVvw2MQIq2Ua2R
=4WN2
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
