From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3 V2] i2c: mxs: distinguish i.MX23 and i.MX28 based I2C
 controller
Date: Sun, 6 Oct 2013 15:54:53 +0200
Message-ID: <20131006135453.GC4173@katana>
References: <1380497035-7457-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380497035-7457-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 01:23:53AM +0200, Marek Vasut wrote:
> From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> It seems the PIO mode does not work, or at least not like it works
> on a i.MX28. Each short transfer needs about one second (without an
> error message) but does not send anything on the I2C lines.
>=20
> From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> Cc: Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

This lacked your SoB. To ease things, I added it here. Please shout if
you don't like me adding it...


--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSUWusAAoJEBQN5MwUoCm2eZUP/jS6vZY5V4vbx7e6vHMmpZ2s
sFeaZv1qRPK4I+I+cAN01V2e/lYM6ACvaBMNBA4V0upwb49uOe2WdvRZr7IoGHUr
IJL609tGG9hMixwljLYFiFEO3fMcep11aDekBXxh8z94jJtye+bYjwnk8Ze+MOGZ
Dw/ki8TlVgXKAdZ1tqiE7Y7xpwLWxewh9qDB4bSI6cTROHIpeADiBAbud6GCAQJk
EkeMHGXR7oVKJEtz76p+aSD8skTn1vF5y0i6kO3/gmhheJwxgQ6sYD/FsZnfUm5n
XLDGE9nBmLx3z0W3CIQMkN88q6QRch3Aoic3LucEp4swekFZHCD9VvNLXraFl/xE
pGTVFxiL6ltFLmXfn1WHQ0SSJtvCOMzjmNY26uuwT5E1hBNaVSv2+PlsIUdJn6Z4
APsBI6vW58aMOD9ZHb1zz0J21D0hEVACGjFkEstUJXemGsY0qIBfB8k5iJra5o7c
USQ7sTivSGIGIGHdkEk6snlWZs/jiiMUiCFl9xYdttdiO040vTRwel72xDV5l0bp
29iWD+nolMKcN5mvJ7J2Oi+rJ3PdKoinpt3zAv9rtWTEdiVBy54lpnSVqWhDBsQC
S5tEaupZ07xlR+2B5Gg9cnVkpugx0lDjSoo5nhFWbGhld1Uj26v7bueIYBwriLtp
0T2NAaDV3LFlFoffSIlE
=GvYW
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
