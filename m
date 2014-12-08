From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: Driver to expose PowerNV platform i2c busses
Date: Mon, 8 Dec 2014 21:55:20 +0100
Message-ID: <20141208205520.GA12715@katana>
References: <20141208063039.14356.34770.stgit@localhost.localdomain>
 <1418069595.4827.43.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418069595.4827.43.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2014 at 07:13:15AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-12-08 at 12:06 +0530, Neelesh Gupta wrote:
> > The patch exposes the available i2c busses on the PowerNV platform
> > to the kernel and implements the bus driver to support i2c and
> > smbus commands.
> > The driver uses the platform device infrastructure to probe the busses
> > on the platform and registers them with the i2c driver framework.
>=20
> Wolfram, what are you remaining objections here ? We need that in
> distros ASAP ...

Oh, I thought we agreed that you take it via powerpc. I still think this
is the best solution.

> I still maintain that it's not reasonable to hold driver for the
> additions of multi-byte smbus offsets. This is a new feature that will
> require changes to a number of existing bus and device drivers, so a
> very pervasive change, and which will be visible to user space, which
> means that drivers will need to continue supporting the "old" way at
> least for a while anyway...

Yeah, I agree on that. I am still unsure about the port-name binding,
but well, if it is needed to fit your PowerNV scheme...

> > Signed-off-by: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> > Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> > ---
> >=20
> > v2 -> v3:
> > - Added the device tree binding documentation for the driver.
> > - Sorted the ordering of this new driver added in Makefile.
> > - Removed populating the superfluous .owner field in 'struct driver'.

Thanks for the updates!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhhA4AAoJEBQN5MwUoCm2EY0P/1iLRsSLPPyFV+mjyWVdGO9z
D8V5RTzThia+Fvg/y77Ksssps/so+74OTa8ygDtChuOhMWsM5UJtdxOROJ3rYXzN
Z0FizogQZLFQHidb+w6P6Cj3b0PhjCNQ2QE+ePX8NLuYjb88IkthadJjkRiVf7+/
tsR4rJnXuDrywkZeTsQEdvkijKTYTuBwtlYnOOGPO8jUij/diUv9BaP0fVTCV63T
pKNdOIGnwIzLVmj280V0jlrZ3FqF2K4g5ZFTpzFbcnV8GDVdRZhFgcQViWy7TgwS
uvVq6Pqkpq+nH1fQO74mJOuCSv+zyPB6TRJbwPVd0cT2Du3H7+9aqOa1Kn6K3Ju7
hnOUEfUruo652Jt0MAoaHSxmgLnSyziucMrN9+FQQpiKFcagOl85kMrGyRXK7xk7
riqRMHWoK9ghHtUdgIynbLyToSkABSAHtQRdUb++rZ69DO168n7GuBDc1D0i69Rt
6Hq1xEubUscjDFNwhGMOgpfQso6AJAiBsuUZ/UEz7f9peTvPqqNWOYZGCY5SMvY4
YqIaYdZUs3fYLs8Ig8dNswKALjJgrmIH7yWR0s3jxQZwFvo9DSCDbTxGN5qUXNEW
Cl5M/2OOpqlvOCxDxTs3xB1Zuk/t/TkeUP0zeIR+spoFhItI2NKjk6RlP0Hj/3/5
bhvwA2UDID6U51gkop7R
=lKq2
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
