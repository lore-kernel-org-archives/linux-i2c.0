From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: xiic: Remove casting the return value which is
 a void pointer
Date: Fri, 27 Sep 2013 18:56:24 +0200
Message-ID: <20130927165624.GD3094@katana>
References: <005001cead1d$d68d3bc0$83a7b340$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <005001cead1d$d68d3bc0$83a7b340$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 02:31:29PM +0900, Jingoo Han wrote:
> Casting the return value which is a void pointer is redundant.
> The conversion from void pointer to any other pointer type is
> guaranteed by the C programming language.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSRbi4AAoJEBQN5MwUoCm2QHwP/2Kh9aA7qzagXno7TuDGW73l
kl6efqIkfBrBCbYfocEnYmkOFnkg2nvOjIN+wrP0vqau/eq2L87HPlucxqiZNmiR
p0PjtDlxU6gH3VmMDUxYseJS8zA0g5GCSsxcAf6sjRrakgVIyzI9Q6cu9FA5lcYd
su8GuLblzWEweHRF4m7dZ0AGeAt5aX0S4lf9WtiDtSHm2otb1f/cILMuFZj3Xdfe
jVP1YkC1ISlXetdf7XdIUk7LZFTqT7Hhj7gUtGIVRLzUqyEFHHBL+D4oL4OSwf2f
Hko2nPg2RA8ClsAi1tAp31/CpXE+OwO8pdfWXoWg+5ltSOh5/LpNLcTN/bhpcr8i
EL0aU7mCJc8V20LnhdK42eYNOIh2xPaOwnVnVE2yt5fweo4uAIaBOOYnSmRDLfki
7lQf0NqTfGBZh498GTt9W/hIRvv2XRmKF1Tb5pn9R7Ig6mHeS5RdBFs1Jnf9Cve2
JKqNKg8MEEDigZl4+5zdnlrOpPgWVUQTwuBv+QAuQTDrFP9raAyTsCvE4hl85YCY
/9b5nM+2X4mraBqiKN/3c/wxhgmb5hoJX3Aoc0LZEHki9uf7rifNMz1YRq3GW9Ud
4OARU7tnNXUPa4bs/qVbgmlujdxnpWS2ZHg4M8wv171s72JpcVyepX4rNz/u0YA9
tyP7sCNqLCfRPl6uS7nz
=2vRC
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
