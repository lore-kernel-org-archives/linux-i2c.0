From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: support elder Nomadiks
Date: Sat, 15 Jun 2013 16:19:46 +0200
Message-ID: <20130615141946.GA2923@katana>
References: <1370815258-1351-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370815258-1351-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2013 at 12:00:58AM +0200, Linus Walleij wrote:
> The Nomadik I2C block was introduced with the Nomadik STn8815
> SoC (the STn8810 incidentally is identical to the one named
> i2c-stu300.c). However as developments have only been tested
> on the DB8500 family, it was not properly working with the
> STn8815 anymore.
>=20
> Rectify this by adding some vendor variant data in the same
> manner as other PrimeCells, and switch code path depending
> on version.
>=20
> Tested on the S8815 Nomadik dongle.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvHgCAAoJEBQN5MwUoCm26eIP/0vSKTcdWCO08hXP8fOv17gc
FnL3zs/5s8pIF91z+jS8ovG5tuV8ud1ZBhU66vC/KLYvpgtpOl7/ujqinveFJ+5S
8WBV4/7qSBsuLGoYB3ULGsLxE3WmrIwOxyLwFRkazPyQuq/p+jn0Sb4JsDC7ZhbD
s9KVdrc7W1lN5JAM/VZqkSLNeEEXPSRKtNprZ5Ce8ddfhDF6FqPAhZInvFX01QH1
jxL2rBGur4llP6emLm21+++A5dm/RHan/ccm2s011Ggt/QoEM9UKlDqZTi4YwCz1
FbhDRKFuKaIxrEXR8UStL0IObRztnWwekJmLBvZCaKPMxXdEtsNhqUsFNMMNM0u3
ri7FHoahPdjMI+ot/NSrBx1wL43E3meSJp8pMuv7UyaseNmU8M8JyOsAu7hrQxut
Gqvndx4towziyMvMpGu44B7JC+/q9bwljwIhvF+wyBvDxKMJwDaeHdZsE6Fhshdp
liA/E2Fqv6qaxvty7U6KIG+YzwLdpA9W10v06SA6E3i3MrKfaDwXae8Ug7f5MGj2
AKhWDUNuxzNbSi3SOuKy2DWAPxHnmscRg8bV0x/ePd1VIyf4q9091c48kysbdyPn
tqU304RQBklmtlS3DHWjlNjH4RA0uemwOMYfXdKzCDhwnbgWTCicqZ1WFu15B3gP
wQm2LPzJlB4M/qmHMIKx
=bdi1
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
