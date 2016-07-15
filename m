From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v2 1/2] i2c: brcmstb: Make the driver buildable on BMIPS_GENERIC
Date: Fri, 15 Jul 2016 15:02:40 +0900
Message-ID: <20160715060239.GB1629@tetsubishi>
References: <20160715034509.58148-1-jaedon.shin@gmail.com>
 <20160715034509.58148-2-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36846 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcGOGCu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 02:02:50 -0400
Content-Disposition: inline
In-Reply-To: <20160715034509.58148-2-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2016 at 12:45:08PM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS based SoCs share a similar I2C hardware block.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to for-next, thanks!


--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiHx+AAoJEBQN5MwUoCm2Jo8QAII4f8bBYxeGMgj3lidXRVaq
L7PJZMbeqEKumBCMcvHP4e4rGpnBlvgCDYEd0EDBTIrNiw9o0VmQkkRJc4FFp/jF
T4Cmz/H7T8MWnSTkjnbykrsl2yJU3JaJJbxV7nzsQiV+ojfZGl+gN0NO0XfDtuzC
6rHLhit76LiOCGl9NX62oHtK6BLuPR2eh07U1XT8kH1BnQT745thFK/pSwl5yP8B
Cm/kKK4RfG79JJxkQcNfAnz0zxucG0nx80oANzKRHHZTK/jF+hMy4fsQrv2pxFY0
+pWgEBKzJDycU4mdUm17AqJ6MlF7BDZgQSUp++EM+OkltWoF3kSHFv75W+ldOY3Q
b2zntTJ7OwwwbZSct2C0B/giJ+0N7IJA0cWWQQxjMux+wFDQtUWlXh2eoQdZcphY
bl0J0ZFGuw2M7a/J35xpYPIR+1i0ibQj+yyfwSjmFr5NSP+0kWSZQDPanhOVbTwy
kOp9EFyyTvRz0SU0gtDz0JEo0ufDURmTMQSXbVNeO69EfLKc0f89ywxi8wy3Ns//
fMgpm/vRL5n+iMH6o1cdyvpYKgTguqm3Wy+FrHt8G+1Dx2XzkAKZHfIo+Cfsg7gM
qE6yELDQBLnSxHs0GeCLHYuOFb7o8YwBeUP24+l4JvmqA5F4jREU6AQc/3vh7CF2
o4TYgcdLG1zvetympqyP
=SXq5
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
