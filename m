From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Use reinit_completion instead of
 INIT_COMPLETION
Date: Tue, 5 Nov 2013 11:10:55 +0100
Message-ID: <20131105101055.GA2660@katana>
References: <1383643630-5036-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383643630-5036-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2013 at 02:57:10PM +0530, Sachin Kamat wrote:
> INIT_COMPLETION was replaced by reinit_completion vide commit 2c9627cca471
> ("tree-wide: use reinit_completion instead of INIT_COMPLETION"). Use it to
> avoid the following build error:
> drivers/i2c/busses/i2c-exynos5.c:538:9: error:
> undefined identifier 'INIT_COMPLETION'
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

You can ignore this topic. akpm (who has the change in his tree) usually
takes care of this.


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSeMQvAAoJEBQN5MwUoCm2zTMP/27/dtDrYL4qU9xjxFuG0ix4
8mhDtlGaPR7Xuim9TgVJTxsrh553OAPvJ0NUgjWa2XMrWXkD19HfajqlgB4MKrCt
8iJ4Ay83sZT9bQEoCW4Y6NC5ircEsdqzL0xb1F//73l4mTkrK07/xIDkb2ybvwum
qGzU9XNJ1dtE3vtyeJra+3A1fjHmMelMHgd0PvXKIX5n5e5tC4UZbk8B3DRxcueB
z7tYTidzAlvULbIofAO0D9bJIgEX+ysrEHHydVeFHsE//W5DMPdvNFAE8biIZGv8
vtP2nj2p/DAE6m3F/6sMuhuyHj6OxUzQGX24wddcr5g1IxxHh7y1AXLx5qfZuhAn
tEG0GBZKBf7VVUXexX2qgL8bEkteADCVNIJvD4/KEBhMxqJAgzIxP0nyZ5jKJeXz
HnMAFMCDK6+TKkkg8fDL/u2AUiHjjzdf9hJmilr2hCYbSztaCMUiiX3FuQcDPYFH
gR6uVsDP2bnlV+QlyxDyet++o2e2KOIEJx0RV9GmbfeNxTKr5cu3mtSqaqMTioIw
c7DRYWCA5iqkKp6Xt0rvAV1RFGLy0+s8Y+JhQA2kboqWxvcD+LvwwjVljcVQrBCQ
cS3Gv4pVxK+B/b7UaLqxTW4J6WxpSJvyMlOW2tasyv9KLf7G5jGXISBgItb4Hcgf
jJOsINtaXMfYtQgG900i
=Pxrs
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
