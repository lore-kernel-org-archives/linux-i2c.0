From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-algo-bit: declare i2c_bit_quirk_no_clk_stretch as
 static
Date: Wed, 11 May 2016 17:16:54 +0200
Message-ID: <20160511151653.GI1716@katana>
References: <1461785871-22530-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37868 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcEKPQ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 11:16:57 -0400
Content-Disposition: inline
In-Reply-To: <1461785871-22530-1-git-send-email-michele.curti@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michele Curti <michele.curti@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 09:37:51PM +0200, Michele Curti wrote:
> i2c_bit_quirk_no_clk_stretch is used in i2c-algo-bit.c only, so
> declare it as static.
>=20
> Signed-off-by: Michele Curti <michele.curti@gmail.com>

Applied to for-next, thanks!


--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXM0zlAAoJEBQN5MwUoCm28zsQAKXvYlpFQllItPd2uvhL7O5Z
LHnr2x2UgKz7qntpa2x/glSam1Pvp3DNEJ59eBLvsanIyGJxOG9Ob40rqiTWzTEe
cgKTUGIkXLor/m2FaumQo0aGnmqGLqRx6BkYTJW7DdPhOlqher50rjPgJ9cx/0z7
Uls1EGQ/68pRubh2we1TsZVJYDuI2qV+IXxnONtbxHK1SpVhukR9MgMkNEfVZ46U
F6ppdeuGrVilhgNT+U78XQ2hQ0eyH2uhzGjJuMQHPsuHkavUjaPpR0GkB9A5agEK
OgBHwZlr8dIdfxE0kYEr/rLvw65JXsYHQDminoKO3CqrckxtpmjVKqeUvkt7CFxl
uHGTnszc5Rsq66r2pEsiD9F3p2EREdPwf9nR6BVeYFDahz2gAzzBSggiZ+tSxNEk
46dC5gkvLBPn9UXbKomd1FBkCSDUrrsHLnrFYY2hvAZ74ONfH73pT5K48h1+yaNs
ts2puIyHHdCxgUtJvIHb5oIuQpVwGDqAubaliWJFT2GiaENW4GrvAwGkMHHa5mD7
HDT/JuiGNw36GUX5mFzHwMYmKlzj6etL5AHd4KvKPhVEY3Kyl3BMn2NdkeJ3hZmH
rSQKXOkjaCiCpx7s6JBzOnGBWI7KsXlKwqf3p7gtvOXhtmX1bHzmYR6fmgYvBpJC
jxtoZPZyTqBbVPL/hnVf
=N3Za
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
