From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: make busses/i2c-pxa-pci.c explicitly non-modular
Date: Fri, 4 Nov 2016 20:47:49 +0100
Message-ID: <20161104194748.GB1478@katana>
References: <20161031175947.10531-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38746 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbcKDTry (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 4 Nov 2016 15:47:54 -0400
Content-Disposition: inline
In-Reply-To: <20161031175947.10531-1-paul.gortmaker@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-i2c@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2016 at 01:59:47PM -0400, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> drivers/i2c/busses/Kconfig:config I2C_PXA_PCI
> drivers/i2c/busses/Kconfig:     def_bool I2C_PXA && X86_32 && PCI && OF
>=20
> ...meaning that it currently is not being built as a module by anyone.
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>=20
> Since module_pci_driver() uses the same init level priority as
> builtin_pci_driver() the init ordering remains unchanged with
> this commit.
>=20
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Looks OK to me, still I'd like an ack from Sebastian for this patch.


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYHOXkAAoJEBQN5MwUoCm2Bf8P/1Q0uGtp71hIFCNFjbEIQXex
rPsOJG6CZzKTURjHtHrEP4spJLlFpN7u1vXrEI/ZlMqx6uBZnOM6vdyULsY/QexI
o6g0WHJNgLoWhp3/cbTFOWKN6ece0ik2Jdr/PIR8tejXrpYn/5TspH3tot7EXwNT
OFybBEgpHm1G9BVW+6/tFdNF2l3xm9VIXmYdLl2YASoAE6PWh3eygZXgRNf2n0Pa
zwsDUpUdwyF5/SgKI1j795VY96jZ+vKZyb9jk0lYJ7Ez2dTe2+xfvCe/oxz3u2P0
MMj3L+FjLYmVxy5Hhb9x0qp85QAs+uRRBPe5+VSrZw5wWY581zXDx9uu2qKHZn77
/CCNAWOp/2nmvzk+1XOm0T+p0QIvTmxLhjXtEmfklPXumrYCfJrXImwb2PgDo2Gx
oQQsJxoRz3VtLJ5bZ6wrHoR+s+fHMYjYqggyVMte3ORHJ8BblUHFyV/9e7RVhc6Y
KIfGEtNXghVi53xU1eg3dSH4sT8O6B3+S1FecRU8E7AlKKGlbeh/YqmOD32bcqzD
H8FNByRi1B4vqZ9rJySLoS4Pn7u63sWehjqcVgFdskwlxrBBTLrb7btfzPpPIthQ
Op5gnyNzubkErmi/ggIHx8UnJdpNJp/8HtxqlQ5BYqDFF0H7M3ObntxvgY+ZUYqf
tUryIv38vcRB9ELwAEnN
=3mZn
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
