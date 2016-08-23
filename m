From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 4/8] i2c: thunderx: Add SMBUS alert support
Date: Tue, 23 Aug 2016 22:57:25 +0200
Message-ID: <20160823205724.GD20872@katana>
References: <cover.1465997603.git.jglauber@cavium.com>
 <4ba9512e145ee8d303393874a0033ed83ae33a8f.1465997604.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ba9512e145ee8d303393874a0033ed83ae33a8f.1465997604.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 03:51:30PM +0200, Jan Glauber wrote:
> Add SMBUS alert interrupt support. For now only device tree is
> supported for specifying the alert. In case of ACPI an error
> is returned.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

What about 'select I2C_SMBUS' in Kconfig and skip all the ifdeffery?


--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvLi0AAoJEBQN5MwUoCm2JwgP/j+eEmcAcvB8M5/fWE3HK3Z5
K7RHmf+cjy8LhqO9wdPcQq1H/Eq3DRhivIbdCNaqE1fMVldfIWbJDsHQ3ZnTlRxg
ProAHySVfjGWDEIpnwjynsIQx7CxuWnM6Wa4S+dk/c0L1jVQuJjqpEzNbXhlB870
R0VAH86K2S0caxHnC9ZsCuAkEECrQv9+qOtvdrwKgoKYUtkHR1O5vBsGGnI44OnY
LCVAOWNSyVOhyR8t64vPOVxTqJJ5QxRKEhoswZ51dgeb3R2lYVeRgNK1+lmgTJRZ
zyESKyJArolmjmj8WR1Dm9ckkWT/1idaFdpXJAX/O/2ViNbCL/fK5J6+LXDFbO4W
RlotQYTZckJ6ukKabKbOu799jre8OxJyRwC1vWhrL4YunxCs0obfJRefUDsxP1SD
/1KK++UXbt65Q85WGSSmR3W97PnKruHRntstBrBIJ5zngynYNMgmVH/Ikkawqobi
B7OPfhwYFzlWZm1KtjCiXvw/Wdy09FSdrBgBnwh+yX8zEi+h9Nb4GLtX8HISDzo/
FTa8HjD2l9x6VVKn0uAKucB2bU/9Um3tcVyRmoq8R1RnSjVtUi2J65pzoqGLO1DS
Z34Sx15FH6yTYTi4MllSIMQcA9dDasCeETW7rHRQoNVl9i7TJpqXxqUvm9wu0jyN
Sn2judFIhv4UENHGoCGx
=GBlF
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
