From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix request_region size
Date: Sat, 28 Jan 2017 12:00:21 +0100
Message-ID: <20170128110021.GA1604@katana>
References: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
 <1485592582.4916.1.camel@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:43308 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbdA1LHF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Jan 2017 06:07:05 -0500
Content-Disposition: inline
In-Reply-To: <1485592582.4916.1.camel@suse.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > =C2=A0/* count for request_region */
> > -#define SMBIOSIZE	8
> > +#define SMBIOSIZE	9
> >=20
>=20
> Are you certain that all supported devices have this extra register?

Isn't it better to have a potentially unused register mapped than a
potentially used register unmapped?


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYjHnFAAoJEBQN5MwUoCm2nQQQAJk7UwZbQcQkugA34qbmvGiS
pPbCgzgh3iNI62tBerI3zVpzjhxvO1FqT4mQkOEno9uFU22Cxxp5AWbtynNdmsEb
Hv58AUAeUfNsjgp1cDRR30vwI/nc8SOpG49R0D5cDvve3lgi6qklXBE9J7K8soZT
DgkThJpuTogghtfdDRfq7TO57y6Q06iNes1xlXxn6e8a29bjUm8QW6uCFmuReMmZ
4vUKKj1zxQepKiR6vuC8xbXW/NTl8ijCUA4Llii9w89BiOYsKRZQQPNQ58m7Or7y
rqUDcakpV3FhE4RrX2Ldqzk2+i++yxKPJZXJP/eskDyeu/LkEesDIADTvSOmSUid
nMrdy0aJ2yZtY+YY4NVugPkz/IndCrdy6OV8A1FUuXKJw3u4rDYQ6W47v2tGY/ui
h+kNyJYEIKYUtBW3w1X0pw4YEuP5vDqpx2UgjFCbTe9XgRQyrX4Itv4mMaSNS4cl
xili+eUNOp6UBakBAlaqessh2YF0f0CK0Ej2ui6kFhWMfPHB7/rAQpZFBF7R3r1/
1etyeImSlCIIA62GqFC/KMQ55+D3TnXj8KerYYS9CIL3kzk6RSZuh655YiqWeEWO
WVMr1Zxrms0OQ5sUPvwpDaHJ9Ol4qbFwlCuqG3QOhVIslVrAwfAaL/zK9AQjNYhn
JRIrHHBuSf/aYa52oHW/
=h12X
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
