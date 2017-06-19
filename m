From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: at91: Fix compilation warning.
Date: Mon, 19 Jun 2017 16:39:19 +0200
Message-ID: <20170619143919.ncorggbdxzpjbyqr@ninjato>
References: <ad09a3e39508817a96e9a9477b62e992031d5b69.1496214450.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7kmrs4nq4cmbhl7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53542 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdFSOjW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:39:22 -0400
Content-Disposition: inline
In-Reply-To: <ad09a3e39508817a96e9a9477b62e992031d5b69.1496214450.git.arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ludovic.desroches@microchip.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--i7kmrs4nq4cmbhl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 12:45:38PM +0530, Arvind Yadav wrote:
> Replace '%d' by '%zu' to fix the following compilation warning:-
>=20
> drivers/i2c/busses/i2c-at91.c:277:2: warning: format =E2=80=98%d=E2=80=99=
 expects argument of type =E2=80=98int=E2=80=99, but argument 5 has type =
=E2=80=98size_t=E2=80=99 [-Wformat=3D]
>   dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
>   ^
> drivers/i2c/busses/i2c-at91.c: In function =E2=80=98at91_twi_read_next_by=
te=E2=80=99:
> drivers/i2c/busses/i2c-at91.c:405:4: warning: format =E2=80=98%d=E2=80=99=
 expects argument of type =E2=80=98int=E2=80=99, but argument 4 has type =
=E2=80=98size_t=E2=80=99 [-Wformat=3D]
>     dev_dbg(dev->dev, "received block length %d\n",
>     ^
> drivers/i2c/busses/i2c-at91.c:418:2: warning: format =E2=80=98%d=E2=80=99=
 expects argument of type =E2=80=98int=E2=80=99, but argument 5 has type =
=E2=80=98size_t=E2=80=99 [-Wformat=3D]
>   dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
>   ^
> drivers/i2c/busses/i2c-at91.c: In function =E2=80=98at91_do_twi_transfer=
=E2=80=99:
> drivers/i2c/busses/i2c-at91.c:625:2: warning: format =E2=80=98%d=E2=80=99=
 expects argument of type =E2=80=98int=E2=80=99, but argument 5 has type =
=E2=80=98size_t=E2=80=99 [-Wformat=3D]
>   dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Shortened the commit message a little (i'd think one example is enough)
and applied to for-next, thanks!


--i7kmrs4nq4cmbhl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH4hcACgkQFA3kzBSg
KbbV0hAArJsYLPkkA4q70Q29Io0C9LWjhAeeS0mA4jsjID//Q50MnvbDgOC1w+tP
m0sPRE5Z+6z+iLW+Etuex98UBVkopcX3uYPtVqNdTe2iQafE9GdKdGj3MQbZgsOK
eCINK8A51KXbRuuTxP7XjcEcafzfUokTMzT8Z55mWv3az6SewDhAuVuuVVe+ab3+
i/G/lonQYoE/B3OZhzJRxnycXQqPzLukvihEBVYxYUs1mDHqD04W1n814FGB7nay
kzOS4MrBNDtAg2vVs5G9jGVKcAD/6aD5fpAMtFedF9xe9sVwPmnaYW/PusBsiN7A
h9r/B11I4eHnyMSRsT8dWv8EgdDfnLv8hT/HNimdVOak0KDGQsvkq56oA1+rJBZf
BhGPjSZThy1cKYFArvKkZ9UZ1ZzHG+953831HMGbIl1qnD565sH+gw3csgzuZiAw
G30w+4//AbR/2gm2XPAVBKUp8Hft8sCPaCTGz1RgGnN9vQRvg+xZCAqLLINr/+9K
n0YBDa6nyVMYFGQyy42xPtAq3cTIuB/QmOo/AURbzHRZU4oPZsYO89RbnC/KLZcC
DqyscEqCbw8R7XhvAapOPLXqKA1UcozcEWBGj5wf3u+n/fCq3CYCdhsBBUtMbRmW
9enVE+7Do8jFo6b2uSf4839nok9itSUFlUWMPH5p04H4GDjizng=
=0G6h
-----END PGP SIGNATURE-----

--i7kmrs4nq4cmbhl7--
