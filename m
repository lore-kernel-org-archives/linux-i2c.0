From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: invalidate properly when
 switching fails
Date: Thu, 25 Aug 2016 18:47:49 +0200
Message-ID: <20160825164749.GJ2856@katana>
References: <20160822145221.4033-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46500 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756398AbcHYSDA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 14:03:00 -0400
Content-Disposition: inline
In-Reply-To: <20160822145221.4033-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 04:52:21PM +0200, Wolfram Sang wrote:
> Make sure the index to the active channel is invalidated when switching
> fails.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvyE1AAoJEBQN5MwUoCm2WU8QAKp8+cB8yC4/X/P8P7eiB8xU
0vjcv24h/sZBb2fseQePPkaZDcne6MsyFeYtU20j7sGVB+T4LH0uhKzBFuTF2ble
lE2utVSdjV2iweT2mQQSnmd8mMGmGrloYmw3wD0xdjCQlRRtE1mo1orhc1q4MlP+
v88l0lOP5i4Ejo4yvubWHGAhxF/p381qG88zdgtN3XAiSHlJ33A7pzhs1J0O0+MZ
3NbdARQxKrYRF5wXyWvU+ADhvx/JHNbSe7PINtKGnJN3hDlxgyrG4M3HcgqGx1+v
6EndwQlnH4L7mYlVrpq4o8vYthlMDDhZj7W7Rh+8AT9NZ3RWr7mBtD5CORK6upyF
UuYkd7b0V3U/P9YhACxdvMey719PlKNYhWLoRuHbG6RXeCwP4C+llft4n6L9ThS3
ZOfjk4mmLdvvi5qUP7nY2nEVSH918ovXSHWDpNzPf23vgZJHPjgguDTWZ90P3ry7
kwd18SUmBqv4e2fprFdiEvcirBnb00D9I7NelUMD/dWH6burGaJ/txvm4hMWnIe+
TtQIelfH1dZULFwYnXLGLIKObzdDCxrd0NlzVmGwMmzeltU4PUm2Cd3gnlYeGwUJ
K+S6s8Qy6Xk9FlZIUz83+zATiYUILH1rZ1AAbyVLAtj60maNyF1cHS+0fWM7qwRV
SqNxEx52jc7mKS6cyZMz
=ZdcD
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
