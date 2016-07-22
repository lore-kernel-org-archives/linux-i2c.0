From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 24/32] i2c: bcm2835: Don't complain on -EPROBE_DEFER from
 getting our clock
Date: Fri, 22 Jul 2016 09:26:26 +0200
Message-ID: <20160722072626.GF1605@katana>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-25-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50925 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbcGVH0j (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 03:26:39 -0400
Content-Disposition: inline
In-Reply-To: <1464817421-8519-25-git-send-email-kraxel@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2016 at 11:43:33PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
>=20
> Fixes dmesg spam when we just need to wait a moment for the clock
> driver to probe.
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>

I applied Eric's original patch now.


--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcqiAAoJEBQN5MwUoCm23XcP/RZ2mb/42JjVTfNwT7us8lMM
lX+XECnBbQhlUsDsxUxRBl/XkVVEv8Oa+IgYie3EAi32+OygWz3JaDLKitm6EY3Z
APMEuJJlLZb9ykuR6K6Q6ymHZA3Wm8QD7JyEswFQiqRHj21b2O8hQY239Xr48Pvb
jm82Qwsjd3sklGXjS3da7n5okEsWja44BkkJv3rmoQlAcX3/BngVS+aFuW2BKYn8
vBNyDFK/DZ7TPNb6eQpTpYiDEWrstxvPwS5lniCmTDKOgb4LV7axecfb1dBvhcUu
s5Eu5PJ0fVAWH8ZtZtBOWgzexrh5jgBEvUNgI7dXsuI12nFMuG9aBO7CtbL5Bzg3
QmaqoN1udw+riJEU6W1gOU8VeOlSOXSQVVme/W/SsYIchy2ephCVc5Pgo6N0POlw
Ns63y4LNH5y6KZFQmes4a+gk2nJHJxIMAq3psjn3jwBLxIMnhkG9einykVNyZrQN
S6FwyZnR12pbfeVHpVzPdFE9L0QmWmAQldW4UdpQQdCm99qoqjoMXogtwsOsS+0q
0w7tX3onize6inq8hnQeozMtOMRVeBgSnY9rshlwHRL6R+cipXAGsbKrj2AvFKwi
PMaGoOlGQbD2/ow6FaRJjgL/MEwX3UccOZH1qfQ7Qz+LUJZ7v+34aQZ9y5LLtRrj
MI++SKtE95X3gRmTIuvH
=RMie
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
