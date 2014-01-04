From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 12/13] i2c: viperboard: Use devm_kzalloc() functions
Date: Sat, 4 Jan 2014 22:16:59 +0100
Message-ID: <20140104211659.GC3150@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <003001cefaf5$d6618590$832490b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003001cefaf5$d6618590$832490b0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Lars Poeschel' <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 04:01:41PM +0900, Jingoo Han wrote:
> Use devm_kzalloc() functions to make cleanup paths simpler.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

OK, this one got an Ack and even fixes a bug (no kfree in remove) what
should have been mentioned in the commit message. Applied to for-next,
thanks!


--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSyHpLAAoJEBQN5MwUoCm2WcIQAIKicvCBrsBe9ZzMbOJ+FAJK
Y5Iueum64/G0fUroawKUKq8Ilq+XTx91RWalOoN/qeNZHN7iep6wPHX94fAmdQBy
7LNu1ZwnkaI33+chgXxi/xOfL9Q1kKbXHChb2X7iFcLcWYwij9pYh6fe9Um6iXHo
HN1E9KXWsAY/Dj6GsA9eBhGEb1hnkslYiFYbOoXQO1LXALAZjWGrV2kMyIkl13QI
W+WqR1ditKQ9Gsrw29baDwEmiHh6XLH3e5hjXvF1rCH3giQL+aoUmOCsc+WueU0F
zmvPZts2fHJi8gd4+SOj6p5Ng6B1A0DZo2lLkoaf6a6sSpGKfaq7Evq3bjDU4GJD
GtlTaq0WfooPCZLw/jbKKONoAbxi3AGB6P06lHKtY7dDpMOGTYmBxAVbIlcjnaxG
kGV2+liyZ88ROeHlyJ2cl7do+plsHICFZAZFsn+rEiUt8y8QiPNfIeaafxdLtUbf
2+vo4x14vdnUtvFPeZ4K/iVK/am/IVXOMnsWXVLhhGvIRbRluT0xEquC8kIbIqb+
A5ZLJo5F38CoPH6nL5QTn0hX9G3iZCFnL1bJDJzpjxFsySE6Dd+N3iSN6e878QMK
oZtzcnACDrHM5kWVNajHPnzrpvaSU1TCHCGp2NTaU7zE9KMglGmTwP7U+sceklip
cBkYZavuU2GzvHl0jecv
=sCfr
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
