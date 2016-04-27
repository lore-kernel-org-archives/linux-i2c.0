From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] i2c: i2c-mv64xxx: misc small improvements
Date: Wed, 27 Apr 2016 19:03:49 +0200
Message-ID: <20160427170349.GA15161@katana>
References: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57161 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbcD0RD6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Apr 2016 13:03:58 -0400
Content-Disposition: inline
In-Reply-To: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 03:19:50PM +0200, Thomas Petazzoni wrote:
> Hello,
>=20
> Here are four small patches doing misc improvements to the i2c-mv64xxx
> I2C controller driver. The first two patches are really needed in
> order to be able to use this I2C controller driver on the ARM64
> Marvell Armada 7K/8K platforms. The last two patches are additional
> cleanups/improvements made along the way.

All applied to for-next, thanks!


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXIPD1AAoJEBQN5MwUoCm2zoQQALFvlC4sgv9I3pBAjamvIf1j
q/JN4FYoXMh4yr+OYISmP1bMY1ewxfs9M7MotCzL2UodC9k0PFCL92kYHE4Ak35H
aiiKlhk7/y6r3s9sFl6/K7TMmyZr+4UO0iE7hqK322LkyFGKFGiYEHdirmGoUGo5
qUdNnKYfxKfVqPZn3U9UsGK/xZuGSritSaLgmZZTms93a3dO7YBvek0LBUNzsNnJ
QW2Qd8A3OwdJnOyJN7GXme6SbkCo3nuTvqQih/l28Jx0ZDRHO4dn0p1zGJF6W7iU
KIjo1Qvw6p6e96Sw0Lsvdhr5hsno5/u4SklBRlMGCN+eog761fHt+rQNBKvlog/W
oZeFE6vFs3C3fvrFQ196aIVp0a4v9S68VADmVQ5lnyFAjEY8Wwi7+SDziI5E7LKW
sa+AEfPBSUcB0Sc19PJ+f5mPDrpi2uT9CI2MtVfJ3Lo5PSBKmntOSslgEQYDgegG
BrveCFJiDkhgfPrShJ9KKqi9FTdjUZtGS3WiYjVaYBiQZAx5zv0hb2nJ0xO9QMpI
tysIgPA7FIqFHVMPCw1gR3Q2eUsD+L+PDMKyi+PYf5rTWtGyRDsN1PQMXelZEvAT
15PbGvTN1Rj87rR4P/vB3yTMSK+ccAb7x9vAyv4r/U1LBXe+SP2PjPXvVDtWigGR
M1FeoHPlI9EnIT4dYdp1
=XESQ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
