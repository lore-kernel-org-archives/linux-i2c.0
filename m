From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: hix5hd2: allow build with ARCH_HISI
Date: Tue, 25 Oct 2016 11:10:18 +0200
Message-ID: <20161025091018.GA1597@katana>
References: <1477298389-13462-1-git-send-email-juruqiang@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477298389-13462-1-git-send-email-juruqiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruqiang Ju <juruqiang@huawei.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, yanhaifeng@hisilicon.com
List-Id: linux-i2c@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2016 at 04:39:49PM +0800, Ruqiang Ju wrote:
> This driver should be buildable with ARCH_HISI,
> because some of other HiSilicon SoCs also use it.
>=20
> Signed-off-by: Ruqiang Ju <juruqiang@huawei.com>

Applied to for-current, thanks!


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDyF6AAoJEBQN5MwUoCm2AdgP/1mF+fDu+dhN4HPxEp1LiiZX
ck8xqNNeDzrpThWMVz1AfIJL8/zaWXP5F1UdvuMPXopBApzp7c7eSmzGsSJOP/Ub
f0B377H2Vy8IBxhUvD/iHJ/ulQ/VTudm/DBxmJVKO4jstIOOkYdMWe+4pxVCNSLW
f+/6mwwBqWnRWi3Rd64IA1GrmpRrv+bE1V50CxRCu/Vl9kVkEuW87LqAv0KW0TfG
hwQOjpYq5mYzEhVDtuVLg2PFEGNBEZ8KQu9QSgWUDtiGSLJXwXEAccFHHImPy3/c
9XcAnFcbyZyy7z5ei3n4TX0htzomyXQX6vESda1joIc6F+bHCjSBIAbX5GLN5qW0
C5iugElTM+Lm03Xi9bB5jzKGpUgpXcmL6mEL04EzOO4K6EPCGrXFfrmTmdEYfudF
CqSiaoe0oZ0f+V9lOuNb8TFctNR6IUk/ZGRhbfmox4kVeUWuo3w2RO1kdUkqM+6n
iDJi5f1+ACBOMCOhGBe4wE06Qs6TefnhE1gMdaiYEMOWwocINbpi25ZvSogA5Ij6
7VxnK/j+0iS4tlqxFQsQe74ahiHdduOa/O3uKoL8Gk8FL50PmXGUL9qWJMLGycXT
dUL5Acipuxs7gydcvEbWkluczEDwA3HYmRggJy4rbHO4gaCCkeVfRTecRrwxZmN7
CTMt6vsBpUx44rYVNcc9
=rKPJ
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
