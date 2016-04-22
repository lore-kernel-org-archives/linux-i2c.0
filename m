From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: cpm: Fix build break due to incompatible pointer
 types
Date: Fri, 22 Apr 2016 15:16:33 +0200
Message-ID: <20160422131633.GB1538@katana>
References: <1460519954-9365-1-git-send-email-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460519954-9365-1-git-send-email-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, jochen@scram.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, scottwood@freescale.com
List-Id: linux-i2c@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 01:59:14PM +1000, Michael Ellerman wrote:
> Since commit ea8daa7b9784 ("kbuild: Add option to turn incompatible
> pointer check into error"), assignments from an incompatible pointer
> types have become a hard error, eg:
>=20
>   drivers/i2c/busses/i2c-cpm.c:545:91: error: passing argument 3 of
>   'dma_alloc_coherent' from incompatible pointer type
>=20
> Fix the build break by converting txdma & rxdma to dma_addr_t.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to for-current, thanks!


--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGiQxAAoJEBQN5MwUoCm2bW8QALDkA2/ri7/6zjUGJwBOozih
QpKinPKBpVeUqrjpsnRCVdMDc4VHMrYFvV3aDBNKVwiHTWwKxnJTzRD3CnvzG6RA
P9d0NL0sHj8gf5temjRzDJpjrnQeE5/oWg6DuBXDMdfi6nIF5iQ4rBxpGafAVhyT
ZvzaTrePxIEJYzfwFoJq9EVPWr73EaR5IWgjLNKsFKsRHfNVkvfBV8qmP/wasWv1
JIS62fqNQmjhlanVNQtjQy6vnvjcrbnsF7Y2ZcxDc6kbS1Yw780BIPVH+A9hIVID
DocI2vkNHEEt63F3b+v+X5d5W2AbxA/QBie6N5s2gByV1gAR2YRUhF1SrvMIpPaJ
kWmzpGSHVrrXCiCbi51ouQ0FKAJBrle9ZsT7RoLhf2ijPmZXHWOtXsvOJc4E01KM
e4nOEg42ae6fKobu5sGTmw9ImussAXsEzYunznNslSmYQ76HbkxFEY+FnEi4xf/y
S4h3Mz2Ee7NmXyMKqqtlxSx23X5gusKzvsTa2hZxnX2/CdBXrfW2YeGCGZP9W8u8
N0gDPhMIs7So1pyCjZwJrWGfTbGa9N6j1cxLIanOP59Hes5d4EQFlCcmktMMheOX
LRMtlGTDN02Y2OP7b4Xvs3UfPU6LnqdR48DN7tFL4WNORExQdaF5uF/nlpBvuh3P
MPrDwVNfS2ufT3QWLkpI
=AZsd
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
