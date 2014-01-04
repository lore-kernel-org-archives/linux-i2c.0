From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: remove HAVE_CLK build dependecy
Date: Sat, 4 Jan 2014 23:48:46 +0100
Message-ID: <20140104224846.GH3150@katana>
References: <f3ebead75d45623e4b649c7a8d0112584ffd1788.1388392279.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f3ebead75d45623e4b649c7a8d0112584ffd1788.1388392279.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2013 at 10:31:19AM +0200, Baruch Siach wrote:
> Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h n=
eed
> not depend on HAVE_CLK. Also, remove a redundant clk.h include from core =
driver
> file.
>=20
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

Is the patch description correct? The core driver simply does not need
clk.h and thus the dependency. No redundancy here, or?


--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSyI/NAAoJEBQN5MwUoCm25F0P/A+EGkDwSm/B2ruYma5f+AE6
o+5zkkYczTTCOPWprSC0kFFA7s1VsB6tVNVIDhLsgO9LBcfXZH7pIMYAuYKN0CyS
Ar2rNve/UvRiOfFehn80lw8q/LdLviWTqJPMSvhhngcVEVQxV9snZGiRUtaLGLGv
3U3Xpb86OaAa/hsqws43VY64H+i6hAJnNd9CcpWpIRvLQAMMy6xAuxJUG6wK4StT
070zo1TEIJEpH28HkiiiH27o7YULqejW/npCkdL8qVa/6X2wBNjLxyJRCwuKYLV2
zeqSq1Zby7UVg1Bz0eZPQ6Ookye8jOn2CFjGuxWiom48ZHPdsMAs6qaCtjF8LQe3
+83www+QAMtorMaucS0HBJGoZiU9USpXO1lzN2lxyqI9TsChFwKiyRlG0A8CgCNv
weYvXVRsej/oPRw+wBQcPpmWZdW2U2KPXusI0Q5xLFllDLt4hFHDvOT5QxbU48ZR
TK17jfmGVTlqI3WwUZ6zJmbPAiniY84l89+rns5K4yG914rp1+A1QBRVvr+WaW1p
MyiVcLefQznxS5t5RchYDpoi7rvPvj9sX7CUUtver5auBZ36Z8vbEYt1SgbmYIdu
JPPpH8rErio4c3bBkmPW7Z7gGgNYBEc8UQaWHkd60mLpyKe7SlVXXxjey6Ph6nI+
WFBiCUolI2kPyi0PUxmF
=xBZF
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
