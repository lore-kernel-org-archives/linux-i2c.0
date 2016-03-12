From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 03/14] i2c-octeon: Cleanup resource allocation code
Date: Sat, 12 Mar 2016 16:37:15 +0100
Message-ID: <20160312153715.GF1661@katana>
References: <cover.1457362545.git.jglauber@cavium.com>
 <f33c059a7df4d76768c4b9345c341bdeea2b6484.1457362545.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50353 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbcCLPhS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:37:18 -0500
Content-Disposition: inline
In-Reply-To: <f33c059a7df4d76768c4b9345c341bdeea2b6484.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 04:10:46PM +0100, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> Use resource start and size directly.
>=20
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

What about converting to devm_ioremap_resource()?


--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5DerAAoJEBQN5MwUoCm2LgYP+QH56BxVniKCTxnSqZS8yVAg
MT9v26dHML1GB/ZgXcPj+ku1NMvCeJ9iW+99DMX3a77fXe+Pw5unZT0ZQQNEVyrk
P0Zxd0NThLLBq85MLLBLLxj5rSJX530JkHC1E8+t3HqH0RXZns1+wjDmwj0QL/n0
7kKOgWwXBMiaH+Gtds1mC9SCkEP40tgKWkZUWCPb/irvagH7IJYz2fMkuMBE9VsO
KePqXSnW3S3WtBRlNyhK9jHNn/JgOAKahZTFvVBA92pReyc+NvlfSPbyAWgOfOMd
fQLoiiw8xs67ydNfXSc9fdeXj6JL7NJ/KBE+df3QEpkDvDueDWUA/P0sqakP7mJx
WgXEgNvze7Q/lKrkbnx/84J2qC3OTkm8WIbHR5t53uDaatKBDLZMKNUfxzSNkfzf
THCVJxZsmiZgbLt6sc/Z/yUD9nPWFcCmU78ssgs+ddZVkMUloWxmhtmXXCms2jxj
3jL2OUkLwdDrKItZeWHhoI/zEJrMHZLWrvtqHpSpA7YHPNld9rnB7ECqGPd6HVCr
b5jI0W2s7SGo0Fj5qV8rSA3NWZUm0AfU5OLG6//MDhrpgYgX5fQ92+aCw+Y+Gxnm
EoFwtHBnqkK7IhY+Sfh9eOAQenpRx4m0Jn8PGWDfKNSpwljyxTGRu6Hoy7sNGciX
hNrjMHnSihkp8DgF9ffh
=Q9h7
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
