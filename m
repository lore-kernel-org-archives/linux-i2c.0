From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/3] i2c: uniphier: updates for v4.9
Date: Thu, 8 Sep 2016 22:41:29 +0200
Message-ID: <20160908204129.GF3166@katana>
References: <1472730390-8907-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472730390-8907-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2016 at 08:46:27PM +0900, Masahiro Yamada wrote:
>=20
>=20
>=20
> Masahiro Yamada (3):
>   i2c: uniphier: avoid WARN_ON() of clk_disable() in failure path
>   i2c: uniphier-f: avoid WARN_ON() of clk_disable() in failure path
>   i2c: uniphier-f: set the adapter to master mode when probing
>=20

Applied to for-next, thanks!


--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0cz5AAoJEBQN5MwUoCm2iGkP/1OVgN5jKtKsdJdxKM2A0iox
xQhISQlglnM0LgjIVmqVODHpSJ91HlEvyf7SzHt8ZtgNUF1gA9410j0q8Jfua+hh
EJ5LwKN9Rvu+GrCkOuBbrD7O/0ScEomXcD+sM2Qpmw6rmGWc3+/XZsjwDk1jvIxY
LjpISG2X/NRHC71qhAtiCZAdUCdESob5R2nAR+MZOQNgfMrvjtvGGWTPmhpuQ/Re
wvNYvGvXVZuIVbGDq+SpPERIiTrsn3i+fK4G+9Eu8h4YsLaksObtCb9IZct2mYj4
J86CmEqSFrJxnpQmQxcZ5rS5sFpNt0mbS7dJVTU14PaWDQsCuumaCsne1h7YWR0o
etJK87uZfwvtoLR9UsF9bMg8twKKry0j6pdrlr0Uvi1v/ZMicPBuSWAd//Mam/Qq
4g/Xmzsooz2AuJNXyHjdlbx5k0I38rXcz0KWs/2N6hBtVgspOPazezkYzRXnDt4Y
yZw2pVWtO1WAIIPKe8Za09MK3PH2XGSzlCJ/p6GOhWnuBrEdfPc9YdqQRnvJ9iYe
5lg9TIpK/+08X2h/xPAesFXbK8GIv5tkvxZyFzH+6PM9VmdchFzzgH8vbhibwkvh
kiI1A1Ao13aWXFRcx4ws6Z34w0ayU/fR+SXfIYcj/rxSIGWO1y3EjQaCRlFfIKS+
0d9j8tOzkgCfwjqhAgEU
=h/Ow
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
