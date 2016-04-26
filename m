From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 09/15] i2c: octeon: Add workaround for broken irqs on
 CN3860
Date: Tue, 26 Apr 2016 23:17:59 +0200
Message-ID: <20160426211759.GD4587@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-10-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52381 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbcDZVSD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 17:18:03 -0400
Content-Disposition: inline
In-Reply-To: <1461594824-7215-10-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:38PM +0200, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> CN3860 does not interrupt the CPU when the i2c status changes. If
> we get a timeout, and see the status has in fact changed, we know we
> have this problem, and drop back to polling.
>=20
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

My code checkers say something:

    CHECKPATCH
CHECK: usleep_range is preferred over udelay; see Documentation/timers/time=
rs-howto.txt
#37: FILE: drivers/i2c/busses/i2c-octeon.c:390:
+			udelay(50);

CHECK: usleep_range is preferred over udelay; see Documentation/timers/time=
rs-howto.txt
#70: FILE: drivers/i2c/busses/i2c-octeon.c:529:
+			udelay(50);

Dunno if you want to change that? Seems reasonable to me. Also:

    SMATCH
drivers/i2c/busses/i2c-octeon.c:544 octeon_i2c_hlc_wait() warn: inconsisten=
t indenting

This is true as well.


--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH9sHAAoJEBQN5MwUoCm2KcgP/1OYcPoGb2dwKikjHPqU5nRC
gkONUZfgUY8GmpCYKh66A5ZwZ69c3LkekDOdeALxiUW82mUtauDJvgQwZ8Ezh0LS
3lCJR9jGOcDSOeHse9jJb2m76NvwMwPmWBxzDeCi5eYd8F5rfXhGZHGVTQHmaGQ8
zbzPPPxvtlToazeL3P+9HiaOTN7Iqv85qFTUjAU6qY/0eetfL139L9roGkgWFND3
b0u5K2jDVxTj6XvLgs1cihOsHdk40ShANw2PPpnNE8VLK0gPOWu/uDj28AynpiD2
ek53FXnYltpifE2G/i8BI0t98CJGjIynAOCj6L8bOWXRwUXwv9IadygBhg/3+OhH
/B0fyR+KBv+mboHgOZLwsuvaf7NRBSLInKRGidggeRgB2w2DhVHC9DA9wAyqabEw
jCmb0u4aQNiU5EUck0NC/hDIfo3txyNJuqUN+tABMKDYBoMknLb79eLmAe+hZl7I
WBrv10SZ1pVEFd55fLr/axpcJaydRSs28gY84K4kASkdpIE7ylPuoJj3wTCQDXbn
g4oTYXvoUb4hOh3KtVdlUpUVGlQVDEi4rgZofvvAM6TMN0wlDjTowOAL1hljAC/D
4vW1l+QpKi1jcgejPbS9rT7stOfbEOaprpaVpy2/E40EjStlRqq+lzg1r5WMHdpv
kDFnsnK44zIGowy5FFw3
=OGDo
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
