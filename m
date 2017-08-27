From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c-mux for 4.14-rc1
Date: Sun, 27 Aug 2017 15:27:34 +0200
Message-ID: <20170827132734.sirerpyr4josnqqt@ninjato>
References: <11adddb0-7484-cd3a-9978-30054741c089@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dq4i2cx64xc2xdir"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37212 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbdH0N1j (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 27 Aug 2017 09:27:39 -0400
Content-Disposition: inline
In-Reply-To: <11adddb0-7484-cd3a-9978-30054741c089@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org


--dq4i2cx64xc2xdir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 09:00:27AM +0200, Peter Rosin wrote:
> Hi Wolfram,
>=20
> In this cycle, we have the following:
> - header-file reshuffle
> - pinctrl driver simplification
> and a couple of small maintenance changes.
>=20
> Please pull.
>=20
> Cheers,
> peda
>=20
> The following changes since commit aae4e7a8bc44722fe70d58920a36916b104319=
5e:
>=20
>   Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)
>=20
> are available in the git repository at:
>=20
>   https://github.com/peda-r/i2c-mux.git i2c-mux/for-next
>=20
> for you to fetch changes up to fabf08a0cd63ce39287646ceea10ac34781418f4:
>=20
>   i2c: mux: i2c-arb-gpio-challenge: allow compiling w/o OF support (2017-=
08-22 08:37:03 +0200)
>=20

Applied to for-next, thanks!


--dq4i2cx64xc2xdir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmiyMIACgkQFA3kzBSg
KbahPg/7B8i4/0HN0KPgUsKSC628Y2F0IaaOnQvhJM0FHQoT/hm00H3ALRhN8FmV
Ur92zQOuPbpTB4R9qaB+qLAk4syUFPo4EecfngAhQzGceXugnYUedtNCAEkd4vY3
zj7zFZ5OCk8DUG9jTLHLOBLf0Zkmj1huQygTRR+oDP7k7VXvRob/whPV+5mqDnk9
RgjNRhTUUbZw0KSU3ozWOCVDz/HURUA4CMO15+SASshIEqMoYoXTK+1ChkP4WJQ1
aMOSDGZ0SzV9L3TQwIMY+vCk48mFq1LUstMFGcleDrJiIlaZ8+bDjsOQOaRQ5jk5
VZk7ELysCcTuX6XbQYsY8VXeRZC00UYpgn1T0wfgukUq2ZdBlvQQAxVUqNJF6Xjj
8c0H20zW2tRKbMHbRw8Pqzubbidcm0N3antwg9V1Q1mUXKdaSKXvtzF50p68kSdr
rTY5yxWaqFV99aSXajkHropo89iQSNaxbvgEeebu/P6qu8oZI4PXF3gAv65YsQed
B/Qdq1zZ5JT6JxAcapOfEnyqRQCjX+YpdoB39k/YGtTKd38x8M3xMRCFv+KIkpAO
Vhg0BW/ybAY52uXXlOnwxtTOY4259iZzBmV7Sx9C7ZB1vZJ0wN02yGtsisldJHxs
FIrP6R3v2qgL9z5x14vKj4yNF2c5V1v798SY+JtWlbAhQDMtdUk=
=OozH
-----END PGP SIGNATURE-----

--dq4i2cx64xc2xdir--
