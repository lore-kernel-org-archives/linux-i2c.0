From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: s3c2410: Trivial cleanup in header file
Date: Mon, 10 Mar 2014 17:33:03 +0100
Message-ID: <20140310163303.GG11592@katana>
References: <1392359490-9834-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392359490-9834-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2014 at 12:01:30PM +0530, Sachin Kamat wrote:
> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> moved the files to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHek/AAoJEBQN5MwUoCm2cg8P/0RfslEocRxyfUwMxoyUqfXh
KvZFo7Av51qrWerKvouUJK9z1HA3JZcc9R51L18tAeqPPEcPDfNha/ghw7EWlvPl
Z7z9I2l4lndluRTHC/qTAtVe6r3Gh+Qg4WbjFDsoVZm/p1yGZE/n31cuTnuMqiTC
vTZFax9enLfEj++HHEMdrJoO2n9VBGT8xzuHKL4qHab6gN/6HzQIFmsFh0tLvyTl
oVv9/cXC9Tls8sFi2x7RZnknvjShBi+j5dQDhpAidrE5L7DsCyedEGpoxbBXSLQg
n1jpINOHKYTpNeskclvyOucoO8xFcpA3GZAGsrJMcjTIyzNV47+f86McG0Oknru5
/8czrp6H6+WRn7NqCLOVnl/WWYlRqZRrsRQmHq9wNoLflkxUnNEOJqQCoPQJzUZC
ivdUS8J03RQxL3rZ5glba0Pk5s8Bm3ZAT9MfQytk6DL51fGn/lyIo77fDf1PuQIE
LbSOUokDNFlqS4q7QKMh1f3cTiNzeSdtTI/ClpgiVT9DS4P3RqtDQpI0vUTLpUXd
1komD2UozEfy15FCOcz40luUClYzB+D4yHt9C2MaAQ5P7G/zu2g7+ZBDXw5I21Hj
XlZmj+ZE6PYLVAkoJ7DANirSqN97NzcygQWrzkXOrV1JA6USVCvFkj1OYcw+fGs6
cL8xZTyJuZSL9OSZ1sRy
=13rH
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
