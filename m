From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/3] i2c: designware-pci: refactor and add Merrifield
 support
Date: Sun, 19 Jun 2016 20:17:43 +0200
Message-ID: <20160619181742.GK2933@tetsubishi>
References: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160619174239.GH2933@tetsubishi>
 <1466359691.30123.171.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59380 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcFSTB4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 15:01:56 -0400
Content-Disposition: inline
In-Reply-To: <1466359691.30123.171.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* On Intel Merrifield th=
e i2c busses are enumerated [1..7]. So,
> we add
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* 1 to shift the default=
 range. Besides that the first PCI slot
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* provides 4 functions, =
that's why we have to add 0 to the head
> slot
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* and 4 to the tail one.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* On Intel Merrifield th=
e user visible i2c busses are
> enumerated
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* [1..7]. So, we add 1 t=
o shift the default range. Besides that
> the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* first PCI slot provide=
s 4 functions, that's why we have to
> add 0 to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* the fisrt slot and 4 t=
o the next one.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (PCI_SLOT(pdev->de=
vfn)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case 8:
>=20
> Should I send a new patch or you can fold it?

I already pushed out. Also, this patch has line break problems.

So, send an incremental one.


--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZuHGAAoJEBQN5MwUoCm26LsQAJyleffMYrq06heD3fg6KuzY
Rl1//+Kd3DcQuzJ+qM1fdmGvid0eRP8/J0WY4Lj//2F+zgO+Ymvoj9v5uMKI16Hj
w/akeXujVtRsTashxoUvrthJ/C5Xr7pnUk4VGPw7mKmG6r7ANTRdnqxH7dIba408
XF7ytGlfDdrX8TCkR07Tls+ZesBcApVgZZW9cx52Fn2FZXhi/BnQQMrXIfHsaOq+
yMIYrqPFtmntZfYbjQRoTqPhqF5E6ZcdKJvV21a48XyPyAs3lmh0b0a9FH/YuR9+
rsSXCeiJuoYB4xV8HS9+6YXafFJHbZaX41K6gRaKbMXxLl5Wx8EngB3ZPFAr8VBT
SyNDvKCRWYd2UyNaIVZM7cGgAg0/4SZowstuEeqCLuYF9QWhDN48CMA7Ckr6sMYc
3I8riMxkxPV2m2lFLZ6CF0o/NTDji9svvr8er7ZYM64qcPlnyTtJqebqmzHU4wzp
Y1hfDc7fgec3UIrIp1gZlDQmIUr/8Dppt/iXfbnroR3lie2Ijdkh3V9gIMrzdJBO
A2JlbG1vahQ7LPAAaqtT+gjgeyBLI7PYTgrmUCt4isRpcjTvUzbEH13HiVLGm3m4
F7dSQLig8QQThIjpTP2zCa+xZPBh8HbRppPwSVgsYpa8jxA3zVuki9+z4qjXnt04
sFBoh1tI4iLu4aGKlMq1
=gl8F
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--
