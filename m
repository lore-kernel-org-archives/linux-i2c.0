From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND, 1/4] i2c: mpc: get MPC8xxx I2C clock prescaler before
 using it in calculations
Date: Sat, 30 Dec 2017 19:18:14 +0100
Message-ID: <20171230181814.4ppgyqg6mcfahkdh@ninjato>
References: <20171207102003.23496-2-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3bpxdavwubgsb6j4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60242 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdL3SSQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 30 Dec 2017 13:18:16 -0500
Content-Disposition: inline
In-Reply-To: <20171207102003.23496-2-asolokha@kb.kras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>


--3bpxdavwubgsb6j4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 05:20:00PM +0700, Arseny Solokha wrote:
> Obtaining the actual I2C clock prescaler value in mpc_i2c_setup_8xxx() on=
ly
> happens when the clock parameter is set to something other than
> MPC_I2C_CLOCK_LEGACY. When the clock parameter is exactly
> MPC_I2C_CLOCK_LEGACY, the prescaler parameter is used in arithmetic
> division as provided by the caller, resulting in a division by zero
> for the majority of processors supported by the module.
>=20
> Avoid division by zero by obtaining the actual I2C clock prescaler
> in mpc_i2c_setup_8xxx() unconditionally regardless of the passed clock
> value.
>=20
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>

Applied to for-current, thanks!


--3bpxdavwubgsb6j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpH2GYACgkQFA3kzBSg
Kba9KQ/7BKmTw8PPcpwWgQnAg+0RbPYprfxcoSGj5/mLhKpHXWWYNOrTXKSLd9GZ
tCoWyDXu2DZpTNZ2CZoHkDaSLINJ9CVUeB+1d/DCoPtk5/EqarGhW8YPz0zrjCkn
3x8FLmJhsY7WZsVaKGJnw5YXTdjdN7P990S4HU7anRoXLlqEkys3hjsDCBLv/I2l
jBRCebWijqvcSBbP6re0ituviXaQD99G5V9Ek3mmYDHkdS27UKCrx+o2upPurRBu
w/TOPe7tG7ZvIfkCWlfIRBMTWNkrZcgZadgRX9KNZZOIYoSsLdCrl4TZ/yO/3KND
zLiD12XMWaUVhGiqpIqdapTtE/RGCq41N8JGHdZhd1hHvhIQVvDw96ZxDS/WDsP9
yDPuhoJP4lW1fUAs0llRP/frc283wIaqb3///D49TfLcY2RXcaWwUi5ujmH63Pk7
qeM3KQflJvIfxDjFlmwHqwfIK+bplIJiniJsxztH4m+tqeh6uDo427ay9jZPpt+N
iQLIpn2pvlPgE44ttS073kKRyS05f5xLHdKHZlwCrCz3PDr1hZyIS1axzWH46znK
GyfOIIZpgBlCsf30sH8kGJ/amxfCVVLCIUQawG8iyB8nVVRdeNAnFGLW9qC4yeNu
jeu/oGVmRE1sE9+EmEaPgluf65DAiYftdNo5cLqVQ2aqrPbLiss=
=obif
-----END PGP SIGNATURE-----

--3bpxdavwubgsb6j4--
