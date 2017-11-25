From: Aurelien Jarno <aurelien@aurel32.net>
Subject: i2c-tools: library licensing issues
Date: Sat, 25 Nov 2017 17:47:17 +0100
Message-ID: <20171125164717.kg5vv6zsuztr3vkn@aurel32.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6k3ecbbufuefenog"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hall.aurel32.net ([163.172.24.10]:56508 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbdKYRG7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 25 Nov 2017 12:06:59 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>


--6k3ecbbufuefenog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have been reviewing the i2c-tools licensing, and it seems there is a
contradiction between README and lib/smbus.c about the library
licensing:

=46rom README:
| The library is released under the LGPL version 2.1 or later, while most
| tools are released under the GPL version 2 or later, but there are a few
| exceptions.

=46rom lib/smbus.c:
| This program is free software; you can redistribute it and/or modify
| it under the terms of the GNU General Public License as published by
| the Free Software Foundation; either version 2 of the License, or
| (at your option) any later version.

On the other hand, the license in lib/Module.mk matches the one from
README.

I guess one of README or lib/smbus.c has to be fixed. Can someone
clarify that? In meantime I think the library as a whole should be
considered as GPL v2 or later.

Thanks,
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--6k3ecbbufuefenog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUryGlb40+QrX1Ay4E4jA+JnoM2sFAloZnpUACgkQE4jA+Jno
M2sOGw//avKREM1O8MszLjON9HbTCEcfp4kXihnTt1eLRDciSkUBUSrXY4Squ7FQ
xJm6HHBHUqbDTXv1M/NJhhEeja4l0LYr2UovME3DDAVQVuzimfy4l4AmA3fhLZwL
Ss4WjvdJ9pIypp8aEc5LFcyzOz8nzopQkp8fhR4h82dAYic1VC7JScsztAJF7Er6
+GGpVouCZw9i1J/hhbZHB9fzq3pacdquFDVHLPmkb32238qW7jhVEzjo980DU3KO
7754YaPMxxD5cF+1qTQPxBnCnx6GECbB4qSDRJn5DMihuXC3J5oxisT68ZgE8nKk
FMUuTg4bF1Xp50lwi6hAtBq2MDIxKSjYHg4dIZrpLDUZh01QO0Ac2+Q2GohcyMYE
conccYgDYcALzak7rMn3e1L9mpVxWKIcHWMXwO18jbWzfTGSWztb5D50FlU3utY0
LG/gwn8NRbGMOpu8i25Di6vljJt8XQBxvd7fHkCC1+2qDsFfUrp2iZligcVhc87h
AfgVvwzceItNgTDXKCnwi2f5d61UhtWsbQzUxpnQB6NgRtpjoPLC3vJHLXf6ZWTI
vOlJ1nrCS6UQTavm6Qf8tgpmLmwTxMLWzTGCpCJS+4xo/u2XyNLEnmDdaLiFN0rF
I7lbN53Fcf32EIIs09WDZ2XXad7ag0hKOoRsRpoYGUxyPDylfiU=
=7uij
-----END PGP SIGNATURE-----

--6k3ecbbufuefenog--
