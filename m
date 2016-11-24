From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH 1/2] i2c: designware: report short transfers
Date: Thu, 24 Nov 2016 16:18:39 +0100
Message-ID: <20161124151839.GG4271@katana>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:58430 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965876AbcKXPSm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 10:18:42 -0500
Content-Disposition: inline
In-Reply-To: <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2016 at 07:40:04PM +0000, Russell King wrote:
> Rather than reporting success for a short transfer due to interrupt
> latency, report an error both to the caller, as well as to the kernel
> log.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-current, thanks!


--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNwTOAAoJEBQN5MwUoCm2/AUQAJCPhPt/9KPAiIo7/Vtfzhaa
KtQHzwgfEX+qA+zvx+gR1Z6PiEn7K9exbw8hy6+HG/qNwJjZXbvHenEB0p3I51Q+
R6+KDEu5ON+gEN1tKlUns2ei9g8C3+LqVKYso+gDuNRLcrBflKom1SNAqqupjUNR
fLb+q0jHbur0i+oZmikdE/BvQIcil0jX59ILznEhBu7GBeSsFLs/RdgbWpNV89rn
FQnlpVU3Mp9nWfGUtCEg5RzrEQ2ZRLTVNVkzKQV+hxIVWfTHVDkywJ+qKJBRatCw
81Hj65gV3KEsXJNnwFr7pJJBzTeFHTfN1kIRSDZ0C+gzY6tIKuzzKOGm6ZXS1Wd2
DgEqWqFg/gQIspHM/ddHiKqQqE9lbwXEGCdimIxvzLWhhbz+jwuSUtoqBknztVKb
FDdugSBTjMbdxmSu3qG+lEsLLIgh5sGvA95N2/uABbGNJLl4NYhP0fZ87XU4gFym
rn/O4sHTRZW+pdgqBdawQ/HBCNPybAIA3zLlGeR/xyxZ5wvbmyBFVNEEcx4+C7og
zYFzAbdIdG/zwQHSTupFhoYhyqFfQSS1LNNiLXTaloYjDvo0Wazt6H5bnqWQiIi2
vqIs0hyVYh0ukzeBsJhrrwF8RBtGbbz+hbanPBgzTqvDwpvMjtVQJ1YCNwO+6SKl
w5gYCgr6v88f03DwhX7N
=CUKN
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
