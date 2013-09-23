From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Tue, 24 Sep 2013 00:09:22 +0200
Message-ID: <20130923220921.GA3244@katana>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com>
 <20130923071012.GD3051@katana>
 <5240B626.9050904@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5240B626.9050904-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Please, no unnecessary #ifdefs in code. We have 'struct mpc_i2c_data'
> > already.
> >=20
>=20
> I am not pround of this change. Please elaborate how to use mpc_i2c_data
> to separate the mpc85xx from the rest.

Search for 'match->data' and see how the custom setup function and
custom prescaler value is used.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQLwRAAoJEBQN5MwUoCm2NDIP/1hrUSpG3iME0uV5km6ErMDk
jez7TJPy8R8VKTzSz6+gYzffJYFkcYIPy919cG4sd3zqFLrI60lkL+jZ1e3Ox7zq
Og1aMHS8MYskjxCjjPeBK5As6EenUVz+lSY523jO2I1OqtheVR8ZYIB4AC8V2gpG
NULjh6giFUHlcjsZU761HsN2DsEPdEes2mpiCRCqqyVw+HnproeTeuRRyZ+ziLP4
DWFUEWsrvvYwWQY3dO6fipJ+oe+TAte5bwhmhzSxmpSrJfimKYIbEOsq0Eef6tUu
Rv86b45li9pH8UjLlVcKG9p3x/NjMtno6H59CjUV95Kr00+HHXQ6lwwoNCz92JK9
2N4jC3btAUD0uQSDb22n5xAjOg5dQDHQN8SeO+6BrwTIEK1de5jbfW8vHqBP3RBv
LcE2F4MeKKU01aTWFjkV4O7vD/1vmfGGBstjBd7QA+qj0TpXgoa8GKdwTV1TE0Cy
Eduv64Ncu6SGZ9gurxAJL5auaEurt9m2HTxSY/Gv8gJkPE93BDMoC1epmAgIx4A1
ppMWKGqC7bbZlTtpMLNlkQFbZf8gQFpVCkOlrqwJNL9KcSftIiifW42gNVKKAWor
fjgKXQIPUUg8tW2PT/I5qi2PCl8TuMehAZ2+PnEEt+n/OR1koxt/yYC8lZv1FqNj
ZyY1uI1/Qv4sGm503SYZ
=85rb
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
