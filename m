From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/3] Support multiplexed main SMBus interface on SB800
Date: Mon, 30 Nov 2015 14:37:29 +0100
Message-ID: <20151130133728.GC1513@katana>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60917 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbbK3Nhc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 08:37:32 -0500
Content-Disposition: inline
In-Reply-To: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, galandilias@gmail.com


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2015 at 08:13:46PM +0100, Christian Fetzer wrote:
> This is an attempt to upstream the patches created by Thomas Brandon and
> Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
> chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757=
=2Ehtml)
>=20
> I have mainly rebased the latest patch version and tested the driver on a
> HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor=
 data
> from a w83795adg).
>=20
> The patched driver is running stable on the machine, given that ic2_piix4=
 is
> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
> sensors triggers some errors:
>     ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
>=20
> While the kernel log shows:
>     i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=3D03=
, DAT1=3Dc0
>     i2c i2c-1: Error: no response!
>     i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=3Df=
f, DAT1=3Dff
> Unfortunately I don't know how to tackle this specific issue.
>=20
> Please review and let me know required changes in order to get this upstr=
eam
> finally.

Applied to for-next, thanks! And thanks to Mika and Andy for the review!


--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXFEYAAoJEBQN5MwUoCm24CQQAKQ0WjbT7FlvNrW9V2eBxBb/
CmIVdW8sTX1BPirWqx+ZZ/+VLkis+ERftl8PtazfbajcaDXfLC+mU1bHTL+t6S1L
JCIOEYgZuqRv0cG7zRC264fP9NAkHT9Hv/6J//73RXOOd46T3mPXo+GQLP5emAk5
50W/X4i6teBkAB2JKpv8rYyTq9RZywFxIsfca3j1Qr9os20yr4isbggomnx08c5N
bP3+hwzSiqESRpSqhbvYtlKmZK3eqw7Ljlv/gtkTu4R3m//jIzUgdaMN01PUix0y
OggmBy+dZrk7w5m4f9nIkrOG1ZkQVNqk5LowG0pquBjXx9sr1QMSMYdJimCjtTtH
UkGxvYlnYZljeS6smJD6pbO+sMr3Qrc28d9Qj6qO1I5tyNb4d4kR4z2aGSjrYaxo
g5LkZmW7kqderrCd8HJAdDFyxQ/uP/g9sXWMuSZnQ+nswZ8WLFNlQ+9B7tNJmaXU
sVdlXCPhn0zuuJOh2M/D/BE6L/s5AYXqx0LrUOqMnS45n90NUInGsobK/pBf2p4g
5HyrWeIGpgyQJr0hZV66FIX/rgKjWaSO0lIK76dhtXA0XXT08I8Y+ICvr+9SWH0T
QG7cDgcB12mH+zL0dKweSaGfLPvdAQD8Q0XhPcz8EJUtN11ezgOZxQv/jioTTbmr
fiyQgPlcMz4Ea7oa/8ML
=jZmn
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
