From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-au1550: relax bus timings a bit
Date: Tue, 20 Oct 2015 17:44:43 +0200
Message-ID: <20151020154443.GK5379@katana>
References: <1441695383-87868-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43546 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbbJTPor (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:44:47 -0400
Content-Disposition: inline
In-Reply-To: <1441695383-87868-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-i2c@vger.kernel.org


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2015 at 08:56:23AM +0200, Manuel Lauss wrote:
> The i2c-au1550 driver has to program various setup and hold times
> for the sda/scl signals by hand.  The current values seem to be
> working best when the driver is supplied with 50MHz, however on the
> DB1300 board 48MHz is the closest we can get to it, and the timings
> are a bit too tight for that, leading to the last bit of a transmission
> sometimes being swallowed.  This manifests itself in wrong readings
> of the ne1619 sensor and inability to configure the wm8731 i2s codec.
>=20
> With the relaxed timings, both the sensor and the i2s codec can now
> be accessed more reliably over a wider range of I2C block input
> frequencies.
>=20
> Verified on DB1200, DB1300 and DB1550 boards.
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to for-next, thanks!

Since you have access to these platforms, there is a pending devm
conversion patchneeding some testing:

http://patchwork.ozlabs.org/patch/482140/

Are you maybe interested in checking that one?


--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmFrAAoJEBQN5MwUoCm2M2UP/iPR4u5sGjzy2uBbfdTZ4ZAB
yWbkLtLDqvJ0+onHptRuVcVx7wUIGv/6efF92KWNvhoiKShfAWqtHBHpeE9WQOca
6Wp0E8bIDcnklHfDg59XV4nWyFd1OklAHv8IZQkbqxNVNtI0MB+qjndd/rV1hRMr
cIF+LMUOW5DSq9qW61Mcx2PRxDT/j5V5kXH42tX3DyZ+K0dcW7aag1UEx1Rxdu4Z
KBJu2WtpSTD1UpVAUcgsJjfrHaiGu7eZeTybTVLQbJc5ocoF16zdRZh/a6oaSYkf
WUeZ4CxuPQiMzg/qyUYSDb+dH1TyqtyMcd6nPkNUy2ISOJR0eUN2Gm27O6Yeksac
PJZLG7pDpn7JS21+MtHNgzTZcxvBRCoDeG1hSe530ZzB9jJgiYFiah7Hb5j1hXD9
pKcGpo/ZFaLT1WnKwRU9bFUiMoGT6mBTqV5b12rswswXcH0p0LR69AMZSEiWVkS/
RaqQOrpVw7Fu3gnYWDET5O6mp1CMMNyFcyCMWb3OoCB2LOBdulqRI6avABSpjQ0h
jq7wP1b7ul2HoELyUVNhLqBIUAC9Kxo9NeHQygVxT+nygreomaJyPA4hFIXsvESW
jyji4BxQw5GJiOvgsYivX3mmLVAJDF6iqpJQcBjVnfoKL3H40K8Yt7rYB/gZ9kG3
rerFEBL1HvVVS5hEHXl+
=bYKj
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--
