From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 4/5] i2c: pca-platform: use device managed allocations
Date: Tue, 27 Jun 2017 21:55:49 +0200
Message-ID: <20170627195549.oosgrbgp7faxkgif@ninjato>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajeqzlkiegdk76ry"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54155 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752646AbdF0Tzv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 15:55:51 -0400
Content-Disposition: inline
In-Reply-To: <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: robh+dt@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ajeqzlkiegdk76ry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 12:44:33PM +1200, Chris Packham wrote:
> Switch to using the devm_ APIs and remove the now unnecessary error
> handling and most of the device removal code.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

And "reverted" the previous fix here:

-               if (IS_ERR(i2c->gpio)) {
-                       ret =3D PTR_ERR(i2c->gpio);
-                       goto e_reqirq;
-               }
+               if (IS_ERR(i2c->gpio))
+                       return PTR_ERR(i2c->gpio);

Applied to for-next, thanks!


--ajeqzlkiegdk76ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSuEUACgkQFA3kzBSg
KbbDkQ//VcExcrQ2hQCCcCKbriOJ5xIfW4BFldIanyR3uMb0cYDnd1w14mYj4yAZ
rY3WzNxQ/pb2t+jpXvqO9lY3cB+dCcN22zzhJXa8q/nvNcCMWgzcB/nDEEo1ejwo
mZli04X/80M/fW2evy6e9d5w3TYEoVaYNDFTA68QI/bGQwi45E/wr6147crx+w72
2lbFBgcSxB1VESzAMw7A7uBvUuhZVSGOy0F7MEDrxVoDDk3u9wg1oNHoAKC9RNRo
0WN5WBdXVMxLN8Ni9FdP5S+0vatepM/P62QTnvS/d8Xw9OnexFR/uwHlFpRvt4lK
tGcBkH5s93Mjfv0MVZ8PpDG/DiABNZRL3zbGaze2KLxUYkzDyweWqB5UZrQ9muo4
8tzpbNAi/PdkE6SORe1RQ88bRR1hBbIXbfbfaWoik4DY7SInmbZBdykIKliOMEYn
yApKrv+RNMC7JJtl+g2se+ODMQ6yCWudRHGbDd0Vt7hfcHrXyMpV5gNClm+luHdr
vqs61pxhAcsWitrKkwOsPC8Uks95Wae2k3amC5Zq/hp8u2Lpk1FI85zcWWwherGi
4TiqYVR/StJug0rFAnCR74OQzT1p0BilKhR2YP3kvl30lxlmS8PengeZmxOqHVTZ
Gfn3vHbG6McutR3Ff0s8ieZ1cHtKU2y3rp5V86WNbi560Iw6VIk=
=YuTl
-----END PGP SIGNATURE-----

--ajeqzlkiegdk76ry--
