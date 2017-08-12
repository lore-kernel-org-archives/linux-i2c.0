From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: rename files to not have superfluous prefixes
Date: Sat, 12 Aug 2017 16:26:25 +0200
Message-ID: <20170812142625.xugkg2swbuazchug@ninjato>
References: <20170804090736.13404-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="md6z574p5z23lzst"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43258 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdHLO02 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 10:26:28 -0400
Content-Disposition: inline
In-Reply-To: <20170804090736.13404-1-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Michael Hennerich <michael.hennerich@analog.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>


--md6z574p5z23lzst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi peda,

> In the light of the rant from Linus the other week [1], I thought this
> might be a good idea?

I am still not decided on this one. I tried to do it with the core files
and didn't find a convincing solution there. Also, the churn is quite
high: git history becomes less usable, likely broken references, it is
not consistent in the kernel anyhow...

So, I decided to work on real issues for now. The pain point for me is
not reached yet. But if it is for you (or someone else), I am open to
look at an subsystem wide solution.

Thanks,

   Wolfram


--md6z574p5z23lzst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPEBEACgkQFA3kzBSg
KbaThQ//Zf4IdUASLUXvScY4fCBj5aP43WS96LRKqoYR83K61IdgIiKBqQfixvJP
g8OBHWKccMnAJq3yLv6+0CkF9OoaqSKJ6KCXXSiPsh7kqYZtdeSSR90n0h9QNrFV
Y1/gXIdmEIVdKyuPlRAyjlaapOPqwkKcIfNkZ/ZOvfaOMiBDNl54lTkY2cXp3HYm
u5/NSRJBXjcPQEd+PavU31i9IFZiwBukhgxoE4dZ5JqWV8bQZTlJTdEIsdOo68DY
ku6NJIEcXwJ0Uqdh9ORLZ9eDY7vGJZM464zP0PBuUnfnA8werfNaKnvZgy4At1bE
o+kbXF8nfD3ipf9axxV9abHEvPIycnWpgDYR8UuwWzE0S2zX03ES0hlpQo3kzAJ4
PXogt3vtnk1bAbLE3gAT5MgA1xUerjge5GZ7Rl8dSp7l7SigvNgxd6seR8YSE8KK
hvjrL8rpLFnq/OGPIcW1fwKfDjxAZdNlkKzWw7h8qDqB51/m+a0TLw562W8kgZYm
4tOjqePAlvw+KggJd6a7ZoUKstMeuzlyOrb7CJTKZOta2ERT3mzy3U7i5U9UdYdr
zMxspKCmm47jFAc8C2zLNgOGsJLujhaGnzBROgO6uQMZ7Sd9ZWXC8wHFIMFsKUq1
yDWm11Vz/6xCDCc3MBum+Y/DBQIwRWYipVLsadfrwgy+xBaV938=
=piGH
-----END PGP SIGNATURE-----

--md6z574p5z23lzst--
