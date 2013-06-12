From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c:i2c-bfin-twi: Read and write the FIFO in loop.
Date: Wed, 12 Jun 2013 20:13:41 +0200
Message-ID: <20130612181341.GB3018@katana>
References: <1369737669-14226-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369737669-14226-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, buildroot-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 06:41:09PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> Reported-by: Bob Maris <mail-qjpqXGGzJR7sq35pWSNszA@public.gmane.org>
>=20
> TWI transfer interrupts may be lost when system is heavily handling other
> interrupts, while current transfer handler depends on each accurate inter=
rupt
> and misses some data in this case. Because there are 2 2-byte FIFOs in bl=
ackfin
> TWI controller, the occurrence of the data loss can be reduced by reading=
 till
> the RX FIFO is empty and writing till the TX FIFO is full.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuLpVAAoJEBQN5MwUoCm2hpoQAJYNWg5SPtGgJLF0qufcW3me
Ih4tF7rAsEvbBGNerLPvnxDIGfgFENak42LVaoANzWQlOVEg6omvgC+7sUDnJNA/
2gqhFK/trps1/2YMl2/Uv+fpPH+3KKgxL/uOlIaTfXJclyoc5Xw1NbNB+50zy3PB
QjoAjufvdLxmrMFQqViQXsW5Meq4dyqCi3b/r2ILMEEHjmi03urWI/s7kNhuoeA7
LLuj/6nwVKaUBdT8O8HAjU3x9Qa4EeeJH0ja3kE+AbZJ123ngzrgYcjpe0aDLBVQ
bfyTEQ1dWns2bVuoULnU02ganYzPkjm9mwozL3k0ur9lhLGy+rgIH9FFK6pUK5sr
KI9ru6kQ7cSMwPVi26hSFWEU3kn+Hi33R5JPrXTxc15ezP2Vfw/qZ6AWjvaRALE/
5aZLAL6QQWb72EDQ8Kdqc4JgLBX3BRpTUeYAd/4YV88TNAD015+UU9Om+mHq+MNN
R6K4/eobTo4ocKNoFNfDICDOMiDYlzDqmc0en34DEdrPIZtUGVYNDHaZGXLabNBh
aHCG6K+XkAduNAUC+g1sP4940x1f3qG0q+10h1F8tGnfZwRi1PM6MRr4Z7WFOdkH
1dkzEFKkg3Y5DeBuZ3hW4Kvup+95hPxMqbWhq+t86ej9FSrjeBuyktSfF3SaAZk8
mp2cjXOQCU61IA26B2Dl
=A6e6
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
