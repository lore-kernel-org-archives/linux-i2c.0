From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 07/13] i2c: pnx: Use devm_*() functions
Date: Thu, 9 Jan 2014 22:24:22 +0100
Message-ID: <20140109212422.GB3866@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002b01cefaf4$fa737d40$ef5a77c0$%han@samsung.com>
 <008b01cf0a88$85df55f0$919e01d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <008b01cf0a88$85df55f0$919e01d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Roland Stigge' <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 11:39:29AM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes since V1:
> - Use devm_ioremap_resource() to make the code simpler, per Wolfram Sang.

Yes, you used this function but you did not remove all the stuff which
can go now since you use this function.


--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzxOGAAoJEBQN5MwUoCm2t4gP/iOgTu8N6G+eg4yV6HKOuhVc
eswdQcdQVl57YnKpEDyiLDBjlMFYg9IcV4gTvHK4aoi+po4tSWOgW6XqTg4vVplw
76R6Xpjdm/Q4HhoGE2LjSSC7oCeTAZwqO0+oqQlgUA3pFTTnPAeS2igvo7V0SmfW
RbLtCr7miQLn+dRsOX9dg2/Fh2AW4XhuksZPhfrWLfTtMuj1lQE0PamLAoZHLXPb
bWsm6JOGz9317N//6hESUy2iJEQ5Ogv+xB+LAaW5Vg0Y6ADBPYCzBM3WVnPPM1ZA
WehxOpUd8qQFdr0u3/zx/cHMdAYo/7bce0BEENtyEMkvXjD40iL7bhWb4Y5v5JMR
Y1ftaJhYd2/ij9i1gnN3uOWPDy1OPSkvE/p0SDYuKAVDVBHzgtrT1cxh31sE5gfK
FaF7vASCeM4rwZb4sZ8OPxciHd68DPBh0O9fxnECsMx7DtJQf2qRrTZWyJ91SwsU
QO2rfEu/DyWZkkXH5ZC4xp8esduw2PJ/EAlY5uZiepvaFzGdtd2srjClhEATcNiD
iViZGW9w7JLeHvamLwXjYXink7TO4/bhHP9dtBl0L78Bp/Pebtno7IoCWGT8IXWe
XiXL+RKuOS7AN4HqLLSgxMcNuDODh+eeXA2aLte1QXRC08r7JAQiGCdHpXPg+ZfJ
Uf1y5rXBG3vf6J/1muGM
=gxxL
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
