From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: davinci: Increase module clock frequency
Date: Mon, 30 Nov 2015 15:56:04 +0100
Message-ID: <20151130145604.GK1513@katana>
References: <564DBEE3.4030508@nokia.com>
 <20151130135504.GE1513@katana>
 <565C566C.7000809@nokia.com>
 <20151130141054.GG1513@katana>
 <565C6254.6080602@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33192 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbbK3O4I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 09:56:08 -0500
Content-Disposition: inline
In-Reply-To: <565C6254.6080602@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 03:51:00PM +0100, Alexander Sverdlin wrote:
> I2C controller used in Keystone SoC has an undocumented peculiarity which
> results in SDA-SCL margins being dependent on module clock. Driving high
> capacity bus near its limits can result in STOP condition sometimes being
> understood as REPEATED-START by slaves (or NACK instead of ACK, etc...).
> Driving the module with higher clocks increases the margin between SDA an=
d SCL
> transitions, making the operations with higher bus rates more robust. The=
refore,
> target the module clock to 12MHz instead of 7MHz, still staying within
> the specification limits.
>=20
> Before the change STOP timing looked like this on 400kHz:
>=20

Applied to for-current, thanks!


--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXGOEAAoJEBQN5MwUoCm2r74P/1OuYz/KQaiHJPPuu0NrSXym
pBJV0FJeLFa8tQN4Gi2R0cccA9rDMw3hXqWvA7/MvzJYg0VS1eak25xCRhQei0KK
sVkQkhoy4dXrADdpwshLSEd0vAL/xzVWTzVyipKe5GpRgiJQoqmRecoCmZaLbyRv
7JbK4us9PDP4lJ7iAX/7GJ+9WDbOUxlimkxs4JObIGCtkw+fbDH744fsG0kv/YMb
/+IDwhGuvOvZCqkU7MuircA+e894uMO38QkD0Hfev0BHnQXT6yhMl9Sakqq8f0/N
e0OY2J0LBlQlRXei5kUYjmSnJiZSnaRYIpykQkDPUE8J0i69iNeLt4LoYOtVQriO
3Awv0qeA/pgsVN6ZO5hOJgOuosGiOIKFvGWUlcHOBgGmbIey75PwlAaZBieSv+Tb
MWcVSseexlmy/B8YtVyl5bkfhAdj9VHu//xcY2n0NxdYRFCyLL1DU0ymCVB2VU0I
cjAYmGbxlMatc387n6pE81rOLSXXtyPIjBzyC4RECF/3xrtn/HovgdDvrRlwXl4c
j7SDidEM0Js2zizBfzXNU6F3viF2u8WKrmvq1vX+1s3kMKOD8xOwu8zZGDuW+tgR
Ts9UgTu2NtlTOjPaqG6fs5vbOsnFmFx38Xp/6rA79XU3dzzwBxdM6QFRN6ArHKag
9v2ogBei1Anc/AeDxNjb
=EfRI
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--
