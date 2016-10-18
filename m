From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated
 ACPI-enabled platforms not currently supported
Date: Tue, 18 Oct 2016 17:17:06 +0200
Message-ID: <20161018151706.GA1433@katana>
References: <cover.1476462204.git.lolivei@synopsys.com>
 <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
 <20161014173014.GA26269@leverpostej>
 <20161014182045.GA1509@katana>
 <55cc91af-8d24-8aea-f74f-2ef40cd8ea5a@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48482 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753493AbcJRPRT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 18 Oct 2016 11:17:19 -0400
Content-Disposition: inline
In-Reply-To: <55cc91af-8d24-8aea-f74f-2ef40cd8ea5a@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Luis.Oliveira@synopsys.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, CARLOS.PALMINHA@synopsys.com


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This is needed because the configuration is different and the i2c-designware
> cannot be master/slave without a reset. To resolve that I added this property
> to bind it as a slave when needed.

Aww, pity that the HW can't do that. Do you have details why?

If that is really a HW limitation, then I'd suggest having a seperate
driver for slave-only mode so we can differentiate by compatible
strings.


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYBjzyAAoJEBQN5MwUoCm2+sgQAJL5LBxfbRgPY79LZF3I5mEh
0oMe+WB0IAdkO1clgwCe/MONSo6JTDSEWHXvjbR4ZSPiIK61u88Y1pJqX1jES6+H
68oRaQHaOEP8DCTFoItqI/O5xpo54PkXOJbDzBjPq9CV/7dOdaBROSiLinJIQudH
uKYqer3xuQUeEsKU0su04bZKMAmRhGtr2PinGw1+RJJoXwGWACVNemeJg63f3EN5
7yb6SdL2z8y3ZoZCJO7RTSYgs93JrKvNiH35yJgABG4ro8wSxixg6LuKc5oStVtv
NX8c6uckKZkaKavY0ZuCOCGYAgZWvvwDY+AQWhZFe3f/BeamZm1ze7cHPQVYuUos
0S1jRoAo2FY8/MJaxzdmY4HxmwM8vsrFcz4ob2mGshWMFpdKm0lTP/g7/X4zp218
JV2Np5WeYjfmTktcYHvj9oDIQTMzStu942REwa8TrvKc4JzpYhOMpAK48D2wE/Oy
M1uPBjKWpE9/43F5Vt7ZJG9UmgyAuBMQzpXmZRzGflyS9BgPc6HRm9/gPgRfEglG
R6GeEmKsNLyQ/L0RawrRwJAgbO0aGc8c25g+iB20cwA2xrGVl0tokWQRVGVr+ary
iFMk8bDYeUrwqGuie3kXylUmceYDa1RibaW+TzDV4xdELI2KXKA2Mg6EZLZ/P7GB
0EexhhFV9jApBxLW13YI
=4Ps5
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
