From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: i2c: designware: Allow reduce bus speed by "clock-frequency"
 property
Date: Fri, 18 Nov 2016 02:08:58 +0100
Message-ID: <20161118010858.GA31575@katana>
References: <20161110113720.16464-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:48990 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbcKRBJB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 20:09:01 -0500
Content-Disposition: inline
In-Reply-To: <20161110113720.16464-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2016 at 01:37:20PM +0200, Jarkko Nikula wrote:
> Allow more flexibility to bus speed selection. Now if there are I2C
> slave connections defined in ACPI the speed of slowest device on the bus
> will define the bus speed. However if also "clock-frequency" device
> property is defined we should use the slowest of these two.
>=20
> This is targeted to maker boards where developer may want to connect
> slower I2C slave devices to the bus than defined in existing ACPI I2C
> slave connections.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLlSqAAoJEBQN5MwUoCm2cgcP/iwaw0QkTUNCboQZ7cO/wGgT
W47+AKhPvsntIKBXYDOOhnCvfAEBxGssGe2RlJIHsJBzgdOcpdOkZU1Lr1IukwEw
zC7Zlmp/Zjb6d/368Zw4PAp8pwKqgW4EC8vUelHKmQf6Tz8p7XPjIRLjv9e5gOm/
VevOxrL4+uux/LM9ancGbVDm7l1LkzQkPYTtOUPUE1nlncodHtz2ghZVaH+kYznv
xzNbWYTGfFcY4YCaclFD68td8qXpCF4gJ9Ym/ZDLdQba2re36GXrmYqt51Di4V5X
JgCSA53VOL6soUOhb6eTOAWu9+wWREha/fRPmHXjLwy/2TL0dHuc5LQh15UfN7Jt
x5K1ZikNdNAts91sQwwwg1pzR8FFDI0nB4+kCZB22Fbh/3Dc1AetVWyVIw5s8bLJ
3/VWAFu51uBxmuKFZNYQz2NcVSDvO8AmGqQYgwC87lA42YoCM/4J7PtIwf91Tjir
F7t0tAF4XJ48XQRVGLoJlUaUjtulGvYBENyXAtCmCJK/QqqsnC8qwmpjOTrR04oj
fA0vLU1t23CEqWRf58X86ggZEjby+YYjY81A1NpxaW1uBPO5lFfi43PuqimwqlX3
MD94htq1H2XUh+FWStEDZ5anGQdLC445Kh02u56cLrMsK91tvoAnyHlZV/4/0CHf
I05LBmapHmc78t8CJ4p1
=O7+6
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
