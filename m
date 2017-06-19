From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v11 5/6] i2c: designware: add SLAVE mode functions
Date: Mon, 19 Jun 2017 18:22:35 +0200
Message-ID: <20170619162235.o2i4wzuyvcyoguwk@ninjato>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <bef9f237bed23f0ea05499b085103f7eea9058a1.1497025304.git.lolivei@synopsys.com>
 <CAHp75VeHoUrq-PfayNZYGP0f-bbnKQQEN4uMBg6ZASJs46b_PQ@mail.gmail.com>
 <6e332d71-1891-21aa-4479-b91a7550f8af@synopsys.com>
 <20170619155858.xjs5nvdkg42b73vg@ninjato>
 <CAHp75VfpgOZ72=5F3aN_tfau3TnyGLsdKt=sdx_ZJ04wtxMtJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rxltu7seu2jbc2w"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfpgOZ72=5F3aN_tfau3TnyGLsdKt=sdx_ZJ04wtxMtJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ramiro Oliveira <Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3rxltu7seu2jbc2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I wonder if we haven't reached a state where Luis just could fix the
> > buildbot error (missing 'select I2C_SLAVE') and the thing pointed out by
> > Andy and we handle further small fixes incrementally during the v4.13
> > cycle? AFAICS there is no major show-stopper, or am I wrong?
>=20
> I would go with the following plan:
> 1. Push 1-4
> 2. Resend 5-6 with addressed pointed issues for one more (fast) round

Good, so I'll pick up 1-4 now. Thanks!


--3rxltu7seu2jbc2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH+ksACgkQFA3kzBSg
Kban8hAArNmi3IxkPmmffXCWBbjbTNc5KDbdt1viDzVij8HZLpEa8BYVtg79Ns9X
/GJXfuAkvFO7zlEKweldBgmvNX4uZtoJL8Ll6kVGu+xMhvnelhfzZulwL80JYL0u
eAPYD4k+asXHFQMfg/JuRZw0YqCDhqmMtPgDjiBIr3+AwTBleOcqLOgPdGk7jTdJ
zHKYfNkpqFknK9rYTY7r3QUwDV15smZxyhqlikONO7BaAabwtjH2dqoeZbTOmKhs
OX3KgxdYvpCZeMIfnEdznHXGXH1OEwqrhlo5OAUp2gf/4UX8uBRyiwlCPCpBjB01
F5bTlPPYPTacwDErnCQnYCUpCyFBiYFIl255IU8VYRL6T2T2geHTpMzY1YKzuedb
jHcgu+XYFjj23B1R7jvPTCUQcSS9Yk3/JBlmIJugPH0v4j0NMA9BxcdZ5asdm4Lm
fcY0o5h695+uOOrBCAzyFkGxdbj8mEfi2uLS+fmN3pX5fVB69A4jioBc0wNY0hp0
UxMrTHxukwmrvDBSqnwVXj4ifFEWTcyfxRlSTWR9IknpcoryJBh9o/q+x2ijK6hH
zf//IPRA8nucjyUgtqYezfJmOU5/RCRO91kJ9bIe65EYluHVbDbmGZ+Pbzuoslh1
7IZ41xjlO7Guj3zUEBQeyn/ewcMeNGxRS6mSB08fH5MuSDAk/Hs=
=lrgm
-----END PGP SIGNATURE-----

--3rxltu7seu2jbc2w--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
