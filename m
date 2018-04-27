From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is
 called
Date: Fri, 27 Apr 2018 14:14:17 +0200
Message-ID: <20180427121417.auv4ppryegkprv32@ninjato>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rtsyducdkarauc4p"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: broonie@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rtsyducdkarauc4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 02:40:54PM +0800, Baolin Wang wrote:
> Add one flag to indicate if the i2c controller has been in suspend state,
> which can prevent i2c accesses after i2c controller is suspended following
> system suspend.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied to for-current, thanks!

We should maybe handle this in the core somewhen, though. Or?


--rtsyducdkarauc4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrjFBkACgkQFA3kzBSg
Kbbbfg//eftzZ8oQPqQkuSuYU3D5qas3i3n4qAycJQmpSVaYjDOBcqiRzPV6gaQQ
6hYvc4EIpIfv4ZLa9Nwa9ds9lN25gLKZOUIt9KzFXtwRTzxHAxD/jDR5xXEijJ0a
bPoeuuUjBnAq7G/hp2j/KjCf1s7nuvkAnk9jyGeSGNfyOO8B/coEYzZ4b0Nw4pQJ
A+ahJ48f/AsxuVqAXgMc1GUpZrzvpgX0F2DPbZG84bcN2b4k+DdNC/qCL4AlkB4C
4pA5ciBa5VDAaz7ppfWGrDnRNl479TWQlhpL/rJ58e6NZ+8Cc305+L9Z2K693UKJ
J9IUkcHmhFISYRLtNhMe4FYCWoTMsK3npIP4MBu6/lQTNBL3wN6iAaWLHcyFiGLj
Vg478nR9I3Bu39+2udXk9YgjBZELo1KMD6gh9g7S9LczlQkYS7eoiy/ijR6priE9
fA07DTWExGQMzogchxmQJ7VakvTu1AG8gYVwu3UHhOVhBaADP0C+dDBOsUS/d7QH
/Uxeo2ztdvPt3zX8QQBMAyd9UmNAH49Wy8Zosxzh4gHsemv49ZoZb+zx06rFEe0q
tkHHMfw4Q4VwONL0293hO3sx9nGNDny1lsaFzcQqxXoebS+LWLxddUxyxX8fj2E8
thA2SI5I5tNeVuGF6rHqdoEUrDUgJwpsf0pkS470jMqvuv1EwPY=
=LiUL
-----END PGP SIGNATURE-----

--rtsyducdkarauc4p--
