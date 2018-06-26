From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Tue, 26 Jun 2018 17:46:07 +0400
Message-ID: <20180626134606.h4ciolw23t6qnrjb@ninjato>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
 <20180626023757.l54suaryim2fieq3@ninjato>
 <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hauj3d2ynysbmlnz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--hauj3d2ynysbmlnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't think it's that easy as I just thought about another problem
> with lifting the locking from the emulation function. It calls
> kzalloc(..., GFP_KERNEL), at least in some cases, and that's not a
> very good idea from atomic/irq context...

Right. However, we could simply bail out early when we are in atomic
context. Simply no DMA then...


--hauj3d2ynysbmlnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsyQ54ACgkQFA3kzBSg
KbbisxAAgJ1Hqsg7KSWJ8Nhdf/n/x4KMtajyVDYr6gcblvLd6vm4JNmmBscMtJve
LfHaU1qFRJMMmEUQOzjNcLdC7q5ZnFWEz6YgX2yuoRp4VMw9RAFVmlM16zoZyMOA
0jKNfJ8nTudVonSBB/4nfGYUqGbKEqJqklaGhqu4Ga7SnF1JWgrWyAbXGEHiQSez
Xzpm76VeDCyp2/WYP8V1Lw46zC5j5Zkh3PH7sStw2BMCIDOYK8ipXzU3rl8akdbi
DM0FuB9CzY2MnTfhvhIM6RsNBeJo1KDMlzYG9WY2yTI4kQ/GcNO2lqFsSUTxsrKT
sJ8vRiVhgY0KmBKBB3hsGCVvYt6meof1TaLHb2iUK2IYjc1XAlC26JM9hLSEg+X4
6qi3gr/xi8vU53Fgmjs3KkA6rUr+ivaXU4pkIy0WFTWwRpJQ4pBLzEzdQEQ7VE0J
MPWQ1WWVMcI8FkCL+krUsaPdR1yhVZH7DNAj6xxfGu9QDdBGNLz/c8pd2ghk4CuP
2kIIjC1v4oIOx5kxFXoBe3NhtAWhYY7MrTJnUDKIUnVtj2Z+FZiQIcJisu8e7Zob
5LdQdcFa1qhBw8jRkgUlQhAsil4sycWQcwSoaV/CCxquP2Yc0LYCJ9nzThn24p2H
V66XHFValUM+jOqxQkFg5SA7wXu9U+Omm6gZTObiJEza0LzFhpY=
=cn0W
-----END PGP SIGNATURE-----

--hauj3d2ynysbmlnz--
