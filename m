From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: core: Export bus recovery functions
Date: Wed, 15 Apr 2015 21:03:47 +0200
Message-ID: <20150415190347.GC1125@katana>
References: <1429121919-1448-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429121919-1448-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 07:18:39PM +0100, Mark Brown wrote:
> Current -next fails to link an ARM allmodconfig because drivers that use
> the core recovery functions can be built as modules but those functions
> are not exported:
>=20
> ERROR: "i2c_generic_gpio_recovery" [drivers/i2c/busses/i2c-davinci.ko] un=
defined!
> ERROR: "i2c_generic_scl_recovery" [drivers/i2c/busses/i2c-davinci.ko] und=
efined!
> ERROR: "i2c_recover_bus" [drivers/i2c/busses/i2c-davinci.ko] undefined!
>=20
> Add exports to fix this.
>=20
> Fixes: 5f9296ba21b3c (i2c: Add bus recovery infrastructure)
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks, I was just about to implement the same.

Applied to for-next, thanks!


--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLrYTAAoJEBQN5MwUoCm2y0kQAJpUCmXzb33uPgkYCLHl8b0s
DNX76iOKlp6X1ftShAqRLfo7w03KPUd0pEr6DmwcKVNsOY3fIXT5qljhDC3Vxd6Q
IbR6IMcCD84Mv525MIg7VELpH/ouR0+dSi1no7u2vwBDFQ4WHKfsCKG6hN//512D
jZC2p1FuzKCzSpS+gG9WRIS0kInEPjAj+g3xoxAI8pWK2vM6oItMb/dnf8LUWeaL
8omEjzobZJIFjN3BTBcNna67Y9bc6Z7Gm7EXCRGPG+bQ/3uz04PowUQB2rYfb/UY
DKWXsjsmWLD15LMWL+hBcd/VKSFt3mQsNMCoPntIqTvMsuOR7QoyIRF8qvqajHlp
BG30HOrNW6TSx7vyk+KDjQ/oIcpFpJAIO1NWVDROQ+uxcewotBFP2RHPDmt6v/Ob
vJcYUql9JkrDtrKDjsM63lHnv35tSNj0UTVVn9KdQWN2/InPwEouum/vpDnoSWC7
iiMfj5/0UOqQXkCFvqFnK1Xk8Zv4EbzSj+Hym9CDLF/EhEOXvAufXS/lWzckMgN1
NDZeL6sj5ykN9KqK5xI4uT4lLNv7RANMXadkrCL2CSCRtbknYsSZUX6dqivVcbKX
8kt7hgu2nVTTeo0z1uOGBElY1HgfplUsgCo/Hs0TcNhZCrZuWMfePygSKDnVCl1I
XVfsN545/6iQls+YtWTv
=cyj9
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
