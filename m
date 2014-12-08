From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
Date: Mon, 8 Dec 2014 18:34:32 +0100
Message-ID: <20141208173432.GA5732@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1418007589-3688-1-git-send-email-addy.ke@rock-chips.com>
 <20141208085202.GA13486@pengutronix.de>
 <CAD=FV=V=PDPiDhDmd+j8ePsF43EvuFP-LxKgMKo7ZRBzSMyOJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=V=PDPiDhDmd+j8ePsF43EvuFP-LxKgMKo7ZRBzSMyOJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?utf-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, caesar <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Han Jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > There are different capitalisation of i2c in the patch and the commit l=
og. I
> > don't know what Wolfram prefers here, but using the same spelling
> > everywhere would be nice.
>=20
> Can you please point out?  IIRC you should always capitalize I2C in
> prose (descriptions, comments, documentation, etc).  However when used
> in places which specific capitalization standards it should be
> lowercase.  That means file names, directory names, device tree
> property names, etc should be lower case.

This is what I prefer, too. However, I am not too strict about it.
I mean, both are readable.

> >> +     /* Read rise and fall ns; if not there use the default max from =
spec */
> >> +     if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-rising-time=
-ns",
> >> +                              &i2c->rise_ns)) {
> >> +             if (i2c->scl_frequency <=3D 100000)
> >> +                     i2c->rise_ns =3D 1000;
> >> +             else
> >> +                     i2c->rise_ns =3D 300;
> >> +     }
> >> +     if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-falling-tim=
e-ns",
> >> +                              &i2c->fall_ns))
> >> +             i2c->fall_ns =3D 300;
> >> +
> > I don't know if other drivers do the same (I assume they should). If so,
> > moving this logic into the core would be nice. I guess this can still be
> > done later.

Let's leave that for later. If we do it, we should start with bus speed
setting first, probably.


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUheEoAAoJEBQN5MwUoCm2d50P+gLCIO+q+hHdrmpuN+gSsgrW
ZOA2Pzu/OIxSROcIkaflb189RUpZ0NNBKCF5R4WxeHPYJy38B2S9kMYKSw9HF4Vl
66cg/x/RQX7Tdd4RH15ItXILN/OvegotwDY/Qmh3zE1+FpnjBGnQmHWzVNcBfPFF
84/50dwmFUznSDr/8ZkrCgJXe2tmdOWdSleY0lqoq+9pYcCmhtcyHoiUm9RZ19HV
DOu2fODtH8flhVM7EO6K0QV2+QQmeMInSvw3TMTwFKtdVivXBcGlcFvA9PqnvicD
+srv6WzV22lU6lMEvdOLlzCOC/kzR1uq3Fo0TuMvk6nDwg7x3RevE4+Nauu+iNp8
c+mc9JHyYmeSUctrLHGQek7AD8i6dsYosXlf0Iq8lyNTVl00kwA76CcbWU/+hVqY
c7fu8M96E/jKloduJX8W1vxTdJZGOfU1j3adC19I/TU4UGTvEPleQcEHOe5hxWgK
ThN8YXAyE/6dKgYC5Kj2uXpHZK+KXf/xfi1S4ZumhPGtHxnoLDPbBKRGbZ2u0B6T
Ok/I918QoGy4NcxXLQI+4zGxxwSJ1EEIK9+dg4VFTmtao2sjoh9zHEwKprujrBXf
tZdFkFYhI6LBJAszLlNttOxBZez53dmj7ykRsqEY/Wia9xJDK6ezRXuKOvsWl0Mp
2s8PGFp05PsHCRhAZiZ/
=F7XD
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
