From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v3] driver/i2c/mux: Add register-based mux i2c-mux-reg
Date: Tue, 11 Aug 2015 18:16:10 +0200
Message-ID: <20150811161610.GA1523@katana>
References: <1434657458-16553-1-git-send-email-yorksun@freescale.com>
 <20150811153916.GD1525@katana>
 <55CA1ADF.200@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55CA1ADF.200-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> +	if (of_find_property(np, "little-endian", NULL)) {
> >=20
> > You should check for a "big-endian" property as well, no?
>=20
> I use the little-endian as an option to indicate the nature of litten-end=
ian
> register. It is default to big-endian if this property doesn't exist. I p=
refer
> this way unless you strongly suggest to add both and throw out an error if
> neither exists.

I'd think that "little-endian" or "big-endian" force a setting. If none
is present, we shall take the CPU endianess. Or am I overlooking
something?

Oh, and I forgot the biggest issue: I get build errors, because
__LITTLE_ENDIAN__ should be __LITTLE_ENDIAN. Is this a recent change or
why did it work for you?

Thanks for the quick response,

   Wolfram


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyh/KAAoJEBQN5MwUoCm2qSwQAJsW6hioc2JzPuWOM6sQcMyh
tAi8D8vqgm3fuchhmwZv0ktgYUE6b/duPEt9+PnGowEBx75knlKp0n/Jf40YiGtO
/YwpWb5MCU3p80QIi5PJWyHbMJRY2eEy0PgmEuGWxaB7+jprXcHtXWXvuPdZngjZ
2LBg1yWkXPgMR1kx2mSAtuEFusskRhJ/D9uEZIHGFd3dR2IycHXNd+T5bT4khfPD
LTQlPe9uDB2uJZTfEDO8NOh1OAovaAC5X8W+E0Vy0DtjthQibLKtooZXE8RNtGXI
94HCNzc+yGqWb6HqFY9JcXfp0JrQ/c3ouv6l65eMPy3MpZIz4sjeHKJDc3p4i6ge
rkRrrXqXagUcpG8IGEXE1nuWY/cs5s5yViAHhHYG3+tcRpC8dGteJrKG03P/paQS
drt5xLrClpZnm7oqIEg/nUw2qYVmjOqwgtEvfbWWapvskZOaOVpQvnWJo4jEks8t
fOg9QzjnHJ7YZfQlKPUOyrwkGt7H4+5FF8eo2Q5SV35spYe+UuoxVtBgXspuHOK3
sAHv40va59pweoLq59csvfAPqj+Mah7oxRbG1+UEMeYkcWuajXsBPhjKamfNt6bt
62Gaf7fYkpAzyisHxVZygSXbEHMbSFQjPkblyFvv0s9AyQgooTZxVdqbgDuyV/fc
coNIu7Nh0utpC0PgcciV
=3SEN
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
