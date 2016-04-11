From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/18] i2c: make creation of 8 bit addresses consistent
Date: Mon, 11 Apr 2016 19:07:49 +0200
Message-ID: <20160411170749.GC1532@katana>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59828 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcDKRHy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 11 Apr 2016 13:07:54 -0400
Content-Disposition: inline
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 03, 2016 at 08:44:43PM +0200, Wolfram Sang wrote:
> This series addresses two things which have come up in the past:
>=20
> * document that I2C_M_RD is bit 0. It is not good coding style but some
>   drivers (and userspace) silently assume so anyhow. To avoid regressions,
>   let's make that explicit.
>=20
> * use one function to generate an 8 bit address (7 bit address + RW bit)
>   from a struct msg. People did this in various ways, sometimes overly
>   brave and sometimes overly anxious with the operator precedence. That
>   was partly not nice to read and partly triggering code checkers.
>=20
> The new function was tested using a Renesas Lager board with the i2c-sh_m=
obile
> driver. Buildbot was happy with the series, too. A branch can be found he=
re:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/8bit_macro
>=20
> I'd really appreciate more tests on real HW. Also happy for other comment=
s,
> reviews...

Applied to for-next, thanks!


--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC9nlAAoJEBQN5MwUoCm2LMoP/1evDGwY/j98qBu9l801P2rR
xPDW+FKNJUs5JamUsejJmEs0USrOF0ZniOYTqQcytQWNGTSpKd7WkraHPbEzgZ3o
roJAt2jqBppCij+0A1MjIgPw3s+A49riSdqhMN/8Xkdy6PYsD0urnEZ2wbBCvZz0
VpoPf3b+N34AMoXvWbTPGyopbrvvaUB17407VQCClUn7+X1JWu1ZAJe+b9qylkZ8
UfHQwWckzH4V9/YhCkFoBg3bx+vvtJ8atM3p4Fe2l+tmb7SW/u8W3UU1YbmXx586
/G9zFUqQPAl+mv18KxdLTKzTch0QGz4133q3Xp6B6V02oNBX+btMak2A14gY+I+X
VkmW2ar1uRHTjksuZ/1aTa1Ezi9wnMverXbJWzUXJeEEBeEB0Hb029cJ8Ho2CysZ
zjL3XHuf7Y/uzzzfxmxEvtiBqhtKoW3sIScTDl9RifGdkHBDLfQA0CZY/Gfuv3QC
uakr7SsxpCW2qKAF98xRVxWOlWa71Dz1gG6XwGTJnjPveskb2UHfk3Uy1OcunPf3
SEUBs0sNSatvMDlzDi7ExcvP9EQp6Q83zRHAfBouSFQsOzRl+msHMruwd0X369Kw
bJ41rsjDGy6hVTzaAliaYW6103hdlAyq7U5Ov4SVGLhGK/U3Fr49RjFfVvvnklUU
D28YNcN3DmAIot1oi0je
=PPj2
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
