From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-imx: Disable the clock on probe failure
Date: Mon, 6 Oct 2014 20:00:10 +0200
Message-ID: <20141006180010.GD2000@katana>
References: <1412425047-9323-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412425047-9323-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2014 at 09:17:27AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> In the case of errors during probe, we should disable i2c_imx->clk.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!


--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMtiqAAoJEBQN5MwUoCm2APkP/R09EUyJ+JgsqF8K+nzkMhme
O3x9QnmOOQESgXKlF/HYNC1hOv4CbWGWlKaoRPgFjWLbMlHcm/0crvCJKdWZZTV9
SZ6Hp8J7QLfB6uEUvPQ39l2HBdV+VSiDlRl8x1izORAZEFIP2O/OAe8B1NYLJGGC
YZZkMmgMii2p9KqNXyMLwsMDoySN2eTM4TLAb7o1s86DZK9geugjFINW3oHOGmc2
1iH6FsKH4Iz24YiA7MMSfY6JCaYFdSUo2R+LosCa9bJm4zXDvzHOXPPUEvvYk8QO
CkfcP3vjfzbzJQwtnUuSN4hJ4HjZaOlxkoMSlD8GXOarOIuBCmzQzpGUzfUD7y9y
2yuTyQySmz93B9cTWyFPTri8o46GJCuZAywO0StYBeUpweblRwKiPGTstl4HVjlG
YV/b1IofWcfS1HKUZ/P1cfmNsjaPtOcHUtmGNFDFw8m0ERcGpR573UEBkHq1DGVe
Y0TrEyku8JcgIVchy+8UcTYhCnN8N2sqV9cOKLtJANN07x7cWtPjqpM0xADATK6F
XhMH7jeUx51E/zUmaaX49yHAxASAERmG7L6KCmTv4mtwjadHRDdh1N+FRMZga7SW
iSbCtg2XZtzAcwjSFEB7IvDcys5NCzkGEPYLxX7UP+ZnSmII0qxwA2ObTJvBbIZ/
pPEc4t0yKsR1DF0UmufC
=C+2F
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
