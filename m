From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: Make comment about I2C table requirement to
 reflect the code
Date: Mon, 14 Aug 2017 21:34:23 +0200
Message-ID: <20170814193423.er7hpbxpddztltwp@ninjato>
References: <20170809092128.29202-1-javierm@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u72mrwjl2p4zu6vs"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50537 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdHNTeY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 15:34:24 -0400
Content-Disposition: inline
In-Reply-To: <20170809092128.29202-1-javierm@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--u72mrwjl2p4zu6vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 11:21:28AM +0200, Javier Martinez Canillas wrote:
> I2C drivers were required to have an I2C device ID table even if were for
> devices that would only be registered using a specific firmware interface
> (e.g: OF or ACPI).
>=20
> But commit da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed
> devices") changed the I2C core to relax the requirement and allow drivers
> to avoid defining this table.
>=20
> Unfortunately it only took into account drivers for OF-only devices and
> forgot about ACPI-only ones, and this was fixed by commit c64ffff7a9d1
> ("i2c: core: Allow empty id_table in ACPI case as well").
>=20
> But the latter didn't update the original comment, so it doesn't reflect
> what the code does now.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Applied to for-current, thanks!


--u72mrwjl2p4zu6vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR+z4ACgkQFA3kzBSg
KbaX8RAAq1r+TnY1suuSHqaMFF91h9RmRq3qu5Qop92OJxGvg+Wb3KXv61qUyiGK
Wn1OkiItS8AsY8LdMyB1KrtLDecGXsCIFgV0tJL6jypyJDDpS4OsHl/YRqP9QO7Z
otpV8gooU8Eonkd1CNWAijHCvrwMc6QLCxVKYxBM48abr+NMXf8pUjfB8K6t1VBh
UO/fMGEFDvlJrEhrzZ/KoCEclhI2/019y/qxoJwo0RJvNZxpzmZxk6bFtjfusJdJ
b4Z15W/nsV5Wg7bKEDL4Od4xDiKy9tDhJGj6JYyUSwoRsRDpvWnK8Hanerwzx6KT
V0mJrow8ACenTPOLHTs39HM6hb+njToWnGqxxN3S7Dfjxb90Z6I4WMmgG1hCzf59
OyIEu444noIS1S0pv+CSEWt3yFICr2b/cV4zrlTBwkBul4WAlnfZB/FyhPbMYihf
n+H8ridLm5RtCxoaoUfgiw+csMv6MDiG2B8wYvMErfq9yFAUBOZcf2bT1vo54v0v
YE1FK8F2YqyzqrI0BbBACprrJDCm2KXhxlFQwQCIPZ37Ori3zaipBGzz57P3aMFx
h92gtQooDqqrgAeo66j8ICHptG4aI9aNmUyHHkAb/YH3QqBRQT9xiC+z8twGdmJU
IOciGvACcpn88p1ynfO2i2obANlbW4GtuRXtlN+8sr5t+IwlxnQ=
=iqDG
-----END PGP SIGNATURE-----

--u72mrwjl2p4zu6vs--
