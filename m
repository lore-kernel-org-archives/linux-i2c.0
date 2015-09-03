From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: reg: simplify register size checking
Date: Thu, 3 Sep 2015 11:56:10 +0200
Message-ID: <20150903095609.GA720@katana>
References: <1440106846-4484-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440106846-4484-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 11:40:46PM +0200, Wolfram Sang wrote:
> Checking was done at three different locations, just do it once and
> properly at probing time.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6Bk5AAoJEBQN5MwUoCm2mmoQAIdqkIm0n0g/UerTjSigqcoK
r4T/eNSjmOe8kUrzDGliZAzXJyFWJBLBIA20BorAHegJ9fP+B3ZK3oui2v05MDQU
gfucFYpX3eU6+zuDL9lJrkyPsb9v/VZeLzuAQAgk492PF2/U2QA8c7OdkHZL3Sqh
TvDxC9c71iALoCkTsmb6PKhy0lorpFt/tLnWzjSWiuKFTA6djeDmuxb8LOeMm9dM
BajbGoJbCooUSNtQ8SubWR2S/Jaxw9adt3RnvqsN12sKrnXouMHXStUjp9tBisCZ
4Otjcte8KT1d+DgqucJ4cWTkbSTdnWTguMc47NlqPl0VQ4Xd0NNV1GDqzvmda7R9
46vsRq6N9wQeqotnD0eh/kkbIvZJDP94zTHTV+4X3/sSlZSbSaU5FsE7zjqzL2FY
YddZb/UG8d+Cpbs2Syh5L9azkRduDETiIq4bME1f/pd4cgAzjBS3bCBRU/Y0ftHM
SnNRiJzQ7D8oIVOLrIBJMmO3yWReybFuX+ddYpqfCRBEmxU92q3d7VgZEuhewb9B
RHrnWSFMHCf+GW2zBDuEt1td9gT+hIDBRQgFVwts9mz1xF3LpRDX6wnrpft4408U
2GzpCRKbLqSc5/DPQjZQvxm1U6y00lQLZcvTiOndtwUsH2VEzBmvpRhjgWMp8isf
2Pd7kChf+oRKG8gezU/k
=Amu8
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
