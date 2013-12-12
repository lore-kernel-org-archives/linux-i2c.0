From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-imx: Check the return value from
 clk_prepare_enable()
Date: Thu, 12 Dec 2013 22:50:57 +0100
Message-ID: <20131212215057.GG19381@katana>
References: <1386195697-4417-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386195697-4417-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 08:21:37PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> clk_prepare_enable() may fail, so let's check its return value and propag=
ate it
> in the case of error.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-current, thanks!


--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqi/BAAoJEBQN5MwUoCm2qZIQAIrlJzQMXsGL1OZwM1zytYkL
P6VfD57ssPw+fCaiegD3pRRxgTKlaOWZWLV55tmoUOql2vfUVUY/R0rFokP/jXkH
g1S7X4JcJ9VVLc6bryWcUa6giCu+7ISGHnpvJW+dKYsrcUMIVPdjLCH9MZOMNGTH
zdtyJYksinbkc/b27Uql5CUw/JAfmfY62JRCiTZz6Y0ncPzxJdd15OrRiVBQ6Ls6
1A+Vn9fzNUUZTO1B5wmWdn+O+NeUI5WEqtgCXz2zSgFHNeW0jGx+FqFdMCXA+XyW
ZbMqgPZt9kJX5dfXhT35VI7C461/5+OjcRXhrGEjcQEzwSu67KJJ5eqUYUilpidy
zxQukLKwrkvYoew2gD0r8OxZw68agQYtARJqjZOZPXsxFnGn4//pNtRZ4IlsrrwR
6jAMXo+MY8qYpYL9zHYbCulSP8p318frTdAyQgHctVfs5Z3AAR7oOJNZ0SH7MA+F
2jQsP17Ywl+E2gXiregg80wZ/iFG/Vdb/0xv9XDYGlOWErBdre7eFfDU7aFDIgV9
ftiR7znEOYsCoFSLAb+U6tlznFge1KA2G+QHYzpQver8kQr5gRrae9pjkk+LSd/u
gGi61HD8GsfrLCF5aeG1ZF9fdOSC5mbEQ8a5O9MZ0eEmi1L6sxYAwsR0MJmbiiuB
oFs0tBEDgHhdrmOCBoPk
=wgWn
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
