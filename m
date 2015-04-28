From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6 3/3] I2C: mediatek: Add driver for MediaTek
 MT8173 I2C controller
Date: Tue, 28 Apr 2015 10:36:17 +0200
Message-ID: <553F4681.7040404@pengutronix.de>
References: <1430209869-6631-1-git-send-email-eddie.huang@mediatek.com> <1430209869-6631-4-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="strugOIPrhtkMu7xpMJ5sn02K6wJEBeqw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430209869-6631-4-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Glass <sjg@c>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--strugOIPrhtkMu7xpMJ5sn02K6wJEBeqw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2015 10:31 AM, Eddie Huang wrote:
> Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> also increase message size to 64kb.
>=20
> Signed-off-by: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c | 106 +++++++++++++++++++++++++++++---=
--------
>  1 file changed, 77 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-m=
t65xx.c
> index 2ecf0d1..c501421 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
[...]

>  static const struct of_device_id mtk_i2c_of_match[] =3D {
>  	{ .compatible =3D "mediatek,mt6577-i2c", .data =3D (void *)&mt6577_co=
mpat },
>  	{ .compatible =3D "mediatek,mt6589-i2c", .data =3D (void *)&mt6589_co=
mpat },
> +	{ .compatible =3D "mediatek,mt8173-i2c", .data =3D (void *)&mt8173_co=
mpat },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(of, mtk_i2c_match);
> +MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);

This should go into the previous patch, as 2/3 will probably not compile
without this change.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--strugOIPrhtkMu7xpMJ5sn02K6wJEBeqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVP0aBAAoJECte4hHFiupU8fEP/R7h/An9h7fR28t6JsdXYVk0
wCiSKMOfx139tGk+iaTxwtAGOBL94K+XiDJQN0N4MZk/sdXzn+vbMXv0mKt+KigZ
SRj/3kRURQ/ssDEvVtlLhUz/3anBj7f/DjYOw0gFUUuXSkG3YK6lxH1xiVNStjv6
amM+NsVD6NLp/nbm4T9reqi2LndkJo7A0XtrNR3ZT9dCBi14/An+We/pwFDsXBcV
BxSv1yOQYzpYwrRzftiBR6b7P0RhRUsmFrbruk5h09LomlXk2wK2G+/LSYih3A2h
jGqSIz2HCEyn/rL7IoRQEorBfuPsEsz6kFsMHTFcPbSvIFE67OHWrYj//61irm62
+3sgfId0CpLM9IJBOfHDZPsjHF4L91nTCEqK9bs8IrzE6BtpwhFyg5RtRs/9spKQ
yiukf7aJvom5hslPCq1WuznkYPyzdWI8Wae0PCkrY0kE/POMbSY4P8EIN4fnblFa
x56GwRF4CssPSaEgIl9I5OJMNV4uJCsH0EkGWOzA7+SJg7ny0T1gzx2HvefQk8hg
MPJgsPJdPofzorN0CP37xttP3K7UEbTIhqNJQRea42layZ9kitojD0DZ/5uF+tki
n82ErEDffLzNZVFkHNtVp8viplz5DFRl6pdV0j1wmCbBkNtczUiqsAuLjm+/v4DH
vDKj9xzYmct+N17hJja1
=sfma
-----END PGP SIGNATURE-----

--strugOIPrhtkMu7xpMJ5sn02K6wJEBeqw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
