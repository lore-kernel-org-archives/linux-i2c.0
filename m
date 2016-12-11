From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 i2c/for-next] i2c: rcar: Add per-Generation fallback
 bindings
Date: Sun, 11 Dec 2016 22:49:23 +0100
Message-ID: <20161211214923.GB2552@katana>
References: <1481040088-22596-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481040088-22596-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 05:01:28PM +0100, Simon Horman wrote:
> In the case of Renesas R-Car hardware we know that there are generations =
of
> SoCs, e.g. Gen 2 and Gen 3. But beyond that it's not clear what the
> relationship between IP blocks might be. For example, I believe that
> r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
> descendant of the former or vice versa.
>=20
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appea=
rs
> to be compatible with the IP blocks on SoCs within a given generation.
>=20
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme is being adopted for
> drivers for Renesas SoCs.
>=20
> Also:
> * Deprecate renesas,i2c-rcar. It seems poorly named as it is only
>   compatible with R-Car Gen 1. It also appears unused in mainline.
> * Add some text to describe per-SoC bindings
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Changed '//' comment to '/*' comment and applied to for-next, thanks!


--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTcnjAAoJEBQN5MwUoCm2UsgP/0U+x/DXYdIxTcDu+7RVYT4r
xLwC0PbR1x7I2jRY4hvCtzhLooHmotciIra+ovZSpyjhzohsbyvNgCCplfh7QeQd
W4IzkEYamOsvU/vYLWeUvkf6xrWVxwoKGMJ4BZmdk0u3SU49WNW0PHlUrEijXuip
01MUV0BRIrUn4HVdZD82hG96lPJasy60Bhw/yvYhyfja3HBK57XG/uVbE6VtIsqc
Scm7dHAX0Dd4N6lmVZCQC9mnn+/+8hddl4eeGB9unPCUwDjY47FuvO106/nHqTa7
AbjWKkAr0SYQibvWDsNMMCxX0vsGZgaX+31LxekAgLTRqsUW6HPIItcMBaa4eVVL
YnEnwZ1rZBWiGxyZwtz3/IM/9IXPFeXTrQ/ZUFJDcpnZ19Ktlo5dCodGN1EKXrYH
Vl5kvHJ81dxpUov4PCrnuaopcRknZ/aZmLDFRs6wf0wVZ/mEDzhHXXMHeS0R/ksT
soA8nS2KsxF8Pp1CiFgRjxKoR1tCJT3EDEe0Yeyl/PXyWtjviKHP8uv9pGu5J3GT
lAfruM3nr/nTEhGPYbuFqXS//rBvNdIOK8lNpF6lkPYO2/IwjbvVYc0qDSD5rbKT
4iMqRG6xduvs8+h6lSVEsa8MrTyIek5eIcvHcrFj4zdWTGpGJEkeMw+SO5mCPf6F
r8S19vZdRf8PetsvumUZ
=GNQb
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
