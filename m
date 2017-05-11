From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-mpc: Correct I2C reset procedure
Date: Thu, 11 May 2017 13:28:28 +0200
Message-ID: <20170511112828.nwdmd7kqx3zciyaa@ninjato>
References: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d4j3shulhktwgpfw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40278 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdEKL2b (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 May 2017 07:28:31 -0400
Content-Disposition: inline
In-Reply-To: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: linux-i2c@vger.kernel.org, Scott Wood <scottwood@freescale.com>


--d4j3shulhktwgpfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 02:03:51PM +0200, Joakim Tjernlund wrote:
> Current I2C reset procedure is broken in two ways:
> 1) It only generate 1 START instead of 9 STARTs and STOP.
> 2) It leaves the bus Busy so every I2C xfer after the first
>    fixup calls the reset routine again, for every xfer there after.
>=20
> This fixes both errors. Add an iobarrier_rw() when writing the
> I2C control register as well to make sure the register reaches the
> controller in time.
>=20
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>

BTW can this driver be converted to make use of the bus_recovery
infrastructure?


--d4j3shulhktwgpfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkUStgACgkQFA3kzBSg
KbYyVw//VeK7I2P3PW4CRb/tivA4njsO5HR8gzZEfSnOEgxKXz9eSKaUW/cyjpR3
aPRXfkA2tx6dBan4mqBsXHZbA0Hjv5ccv2sOQ9LSpKPK9kF4B7Fvj7o5pnLHsa95
siJR4cUUcn2Fj3UJ8niSSvjiraiwcRnj5bXiomzbAg3S+VjhEMXmheDlP/nihJwQ
9bsqAbLVJY0m4d2lWfTyh4HSWGbQiN6JxzKziNP8pJ9sN66HM/m5u8eAWAj5o5Jx
cUjMexfetpiJXJtBpV1+xImxMlFEuAdVusyUgdqMqiE7rhMuOF2wxFHgbOCSf9gI
6n5y8zpr4EKA2jpekM6zehKivsFQclu1IvdzyekrKk25pvqwSh6coiobP8I5pCub
QfFyCFOjZ8nJdKkFNtE3cFC6bkPYxsMHhtXwVjRHqMd6Ov3S53Me/cDGQpOSy943
vUBmJZUV6XlYwbsztrX6bQHj1mZiiSarhqh9SjrxOISf9q+CQ+zSZ2KDEuDT0t6r
vLOybpIsOvZf3brbrsj+1cIYI6Uf8DNOGTbm18kIyeUWT/9ELOvZHWnMmcOGjng7
oDBijfOvBclYEAJTEb73ogP+TeY+s3WWQzwEw3rLoKv5SNAaqeepSwLs9ifEgAez
PLZxFOTNqulZrcZQ47XCY15ET9LTuTijrD3N4RKS9sdAfpu0RKA=
=Q4hP
-----END PGP SIGNATURE-----

--d4j3shulhktwgpfw--
