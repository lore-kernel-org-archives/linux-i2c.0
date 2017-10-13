From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: fix misleading bus recovery debug message
Date: Fri, 13 Oct 2017 20:39:43 +0200
Message-ID: <20171013183942.vmgpiptmvvw3dojz@ninjato>
References: <20171009192614.31226-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="famfcb6emcoyyenm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41520 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbdJMSjo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 14:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20171009192614.31226-1-clemens.gruber@pqgruber.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--famfcb6emcoyyenm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:26:14PM +0200, Clemens Gruber wrote:
> The arguments for SDA and SCL were swapped. Fix it.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Applied to for-current, thanks!


--famfcb6emcoyyenm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhCG4ACgkQFA3kzBSg
Kbb0Bw/8C5lHdgVNoAV0L+RXcBjH8LwpYTA0lNexEetFu2BS/2g1wwuPt4ZIuGBK
tQLS67/CTHZUkfaA86OwlnEkBbqzCPNfrbB400JgoQEQUQasVy3lLu5mv0MVyVIB
wEqmyvV5rFEehhG5YCC94VACybEIIyPhry/myrU3XBRk0qAa+P8egoTFOgXOKkzo
vgP3eMK7+X65joRsf8RhKnBpRxpXo4cO055C+oCDbVVARv2JJnE4msuUKunIRDQk
0TRLHcON8u/nqrwGVv/3jynGgSPGsp36LRxnKXNYC1t295l6gXe36RezPO5vURaS
zT7O/KyUu6I82wsWjOw3wWF32FehGLVQjY+8Xmg/fI4BSMHTIAg6uyGf9ZaJZdz0
jyH3F3SlAF6PyIgJW0IXLEPqFHSXV21Gs3MdGBCyaHQGc1rh7t9WCdaDh60eYA9Y
hzAk/H+mslyfohkG9EMfSarOuiufuwrQISIhoGEHS532YQzlrrwBIBYl1YB2GoEj
438XnryifGtOX/lPLMq0i2QWDKo+EhHKobDrGND6ae50e3RdP0Cpy6XDJkVDmWDP
lYvIvmcWb44Cqo5MLxb4Le5NavTcCFaSDTmpyGR1DJCV7QcLHT+zRKok80EH68QN
G3rQfZBFWcMsd0gNLSHt+SUB9l0q5CWiyiQBIbbz8s/OI1kZVck=
=egIi
-----END PGP SIGNATURE-----

--famfcb6emcoyyenm--
