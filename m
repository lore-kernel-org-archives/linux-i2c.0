From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 10:14:47 +0100
Message-ID: <20151112091447.GB2782@katana>
References: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151112074447.GA24008@pengutronix.de>
 <20151112075238.GA1551@katana>
 <20151112080926.GC24008@pengutronix.de>
 <20151112084837.GA2782@katana>
 <20151112090307.GH24008@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53521 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700AbbKLJOv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 Nov 2015 04:14:51 -0500
Content-Disposition: inline
In-Reply-To: <20151112090307.GH24008@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Try adding the following to a device tree:
>=20
> 	i2c-rcar {
>=20
> 	}

"Better safe than sorry" won again ;)


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRFiHAAoJEBQN5MwUoCm22WUQAJE3ldk1JyWJBwcNUY8k+JgD
n/fSNANFndsm6uXp9YDGpxFIZVKS7jR354yljnOE6bUm0R3BlZFoNxwWRMDEE7vd
715Ylokv20UwgXtJf4wQ246ntk7kw9X81P6DbSnrEGKSXOhHyKqerhGzfdtDmDbB
150Fc6Du/fu73AM0PXNWGPeTRRRm9Nq89k81JshyCdPfusObNTqCSRDIzpHsnS+U
2sbBzICNMCgcpHmG/rAs0MNwkt5O0Rs49c2UNcOYglVkm4BR6ddFmjhrPXkDSXiH
aQoHLM3bjcIGtbvjP3mVIHHYTSDBJi/iqQg4UZ0I0nWJQEroLQGCfvR926+Eld9Q
NLUPuoEAkoR2zEUZ1JaMke0CDTwTp/4uk/mRxG4clOM/PUg8jJEQiST+qMoI9YOb
hxfARKEYoko16+mIRli4O8thOgHJLttQyLgaTFXLkSakBBRiNzrz4JKrCXkMJU9F
h1MG/EDG9+S69cryn+X9LrOJyzb+DgwRbNC/3mlXsZlxgiPm8TWgzQKWYYcMCgG1
yajCVSs5++5ORthLpmQTbDT7NQ3yZ1A3wG0/TIws3/9HE3oWd2peXubrRC6SVmkF
Luz8KpDgjEFKXcSE38rxMxvh+kIBw99J/DWOX0+YC15EL6KvVnGmnNBRbf0MzLUJ
GxDDzWT9CB+n2cM7Am87
=+726
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
