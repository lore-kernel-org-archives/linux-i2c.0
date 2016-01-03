From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: imx: make bus recovery through pinctrl optional
Date: Sun, 3 Jan 2016 19:30:12 +0100
Message-ID: <20160103183012.GE1522@katana>
References: <1448055950-21190-1-git-send-email-leoli@freescale.com>
 <CACRpkdbb-GFJSVvxOLda6CVG_fB2zAPPC2MMzQ6P1mAfvsrkPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbb-GFJSVvxOLda6CVG_fB2zAPPC2MMzQ6P1mAfvsrkPw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Li Yang <leoli@freescale.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Gao Pan <b54642@freescale.com>
List-Id: linux-i2c@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 01:55:19PM +0100, Linus Walleij wrote:
> On Fri, Nov 20, 2015 at 10:45 PM, Li Yang <leoli@freescale.com> wrote:
>=20
> > -       if (IS_ERR(i2c_imx->pinctrl)) {
> > +       /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other erro=
rs */
> > +       if (PTR_ERR(i2c_imx->pinctrl) =3D=3D -ENOMEM ||
> > +                       PTR_ERR(i2c_imx->pinctrl) =3D=3D -EPROBE_DEFER)=
 {
>=20
> This is one of the evils of deferred probe: you never know if
> something will eventually turn up. It feels wrong to bail out
> on deferred probe...
>=20
> I have no better idea though.
> Acked-by

Linus, proper ack next time please, so patchwork will pick it up
automatically.

Li Yang: There have been some other changes to the imx driver. Could you
rebase against my for-next or for-4.5 and add Linus' ack? Thanks!


--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWizAAoJEBQN5MwUoCm2O1gP/3ugwGZqeMECR7j68401jLvW
YH78WTFzXwGIppJ+RhaCWp5CdNZK5n6oKnSVoVonIGBcy1MKt5lc09PaJo7FTNC6
xBxJ5S4hgpLcr0BJ376+sUPHbRHr6pnFjAg8XoutHjifmcaH89KwN+yWDGHq+NXB
Dv2O96p2Gcsqf+tlLMa462OvCLpHGMqtyUThTYXKHkM4GzAc4PedRTuO9zbhEPCb
syrLMGy/eRGGKZicJK+bn6eXxIwI0Xg/z5hesIvD/g3dQFnAjcywQZD0mv9EkkFh
DO+Htr8Eu3wyKtftCuUqhRqLm0u4dSD5a1yP2yV2snIsbghl07LEFHsp3yAo3kfC
kFr46ngwlXH0DGpU4P2rf4AI2IIhqPUr6Xa5yJ5z92BVoPgQtnStV9WSZLXSk1ro
5Cx7WMOfZUlPqwTd5xQeRbePvGKhETqc1xPifZhUG1yDLpbQHGXtW+bgSo+bmJr8
VRrR4uhJKgL0R3nbxSfumGZLVZp0AORE0yXyTrnh4yQQdN3O8AowKUN++rwkt+1/
uijny0P4xkGBVAc+xv7dJWoi0Kb/2+ul/bT3NnLUO9ObVzr+KWGMrCHwuNfpeH4B
Sz7trNf9M0AUXbjRqEJaVWUA3jHKqGXytDSblKGpERXxPDh1R0gsqBj/J+690Uvb
xbXfSSV3jys/1UAQWZWd
=oeyQ
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
