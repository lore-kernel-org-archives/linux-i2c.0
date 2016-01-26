From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-piix4: Fully initialize SB800 before it is registered
Date: Tue, 26 Jan 2016 06:50:31 +0100
Message-ID: <20160126055030.GC1533@katana>
References: <20160125121707.7109c0d3@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50975 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcAZFue (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 00:50:34 -0500
Content-Disposition: inline
In-Reply-To: <20160125121707.7109c0d3@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 12:17:07PM +0100, Jean Delvare wrote:
> This closes a race window where I2C device drivers attempt to access
> I2C buses which aren't fully initialized yet.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current, thanks!


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpwkmAAoJEBQN5MwUoCm2IiIP/RFQZgY8LqMAhr/i56WioHvL
LuvfHK9Wxi1BcGGgYi22j8Itq37Dda/HIJmYcWqohhD+rsSFQaa31V9t4PmYJr7w
9AtUbsqiYoDSDKmE3C5b3RYSzG9mECJ53aA8WAML8OCfs76tyZLRUV0KDIsYL2Nr
um7bsgMd/Z+nCe9qW0API4s1epjJXt/DaChFr9Xt3ZQpaIufBx7foDvb3lHNLPs0
+A7n2fPvZm/2ma2HpClDaOLuQ4bfeB2yd8d15nM0tqIILud0XmceNzmYVIUrP4JE
FxJNfVl84rdBcbzpJ33bohdScx57o5rzc6ialM3DWDcfySYTtK7HRzdSFQm8exP5
WJmlQfC0/G3Y+3MK/iDubE9SeA9e+r/KDbr2Q+ZmgLQfBK04IWHuvwD3WxKIuQSj
eMcQD3cVHjtOxTCkqPZMJBin6CScmDqSGzbdFLOeekP/emFr/pY3u2y3Mkzpg5xk
LdPTvnN62TbDZLTpVGC3DiPu7GkytjXrU75IzvY+iI7sEAbyIsmlv+H01chM1e4y
OkkUuCeLwHsC8lXTw/vpTmNsCqoAOZk3AWkdJBgssa4vzZDYWgy0zLFZyIAu4MO4
hqOW7zESqdC2rIo8cQcXVGgPv4Jlj/xWMYvBETFOQMG4q+Qu06HNGz1rD5tfmjTz
xYr93rS4KuDsTjSftCCK
=lbZa
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
