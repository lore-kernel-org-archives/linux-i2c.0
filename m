From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [04/11] i2c: mpc: use of_property_read_bool
Date: Fri, 27 Oct 2017 22:15:08 +0200
Message-ID: <20171027201508.2jtjou6jpx5nt5ta@ninjato>
References: <1470387411-15879-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y5nr4xtarz375zrl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470387411-15879-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--y5nr4xtarz375zrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2016 at 10:56:44AM +0200, Julia Lawall wrote:
> Use of_property_read_bool to check for the existence of a property.
>=20
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@
> expression e1,e2;
> statement S2,S1;
> @@
> -       if (of_get_property(e1,e2,NULL))
> +       if (of_property_read_bool(e1,e2))
>         S1 else S2
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Shortened commit message and applied to for-next, thanks!


--y5nr4xtarz375zrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzk8sACgkQFA3kzBSg
KbYceQ/+JUaFSM8fJ28983lSevVKeQkThavq3mFhrkzs9o1DL2EzCbO1iCWV2e1c
sRVBwa3HTwIrLOFLVeEAPNelFNVQ8Mzdo67xXAunza9C8+hm3dlIQmHRld4FMRns
xXmQPlkKh3x6/Ehqb9uT9yvdWFCIVXV1ShJFiO/ewWKreUOXa4QKbvXy6GfgZlCz
MDmITbRYavf74W/l1yp5rTdMpNsCnXn68rQNKvwOBWTx4UPd6S6k6+gAhxADm6lQ
CyK0/fhG6urC5U6Wp/mBz/lcBp6nKJ9G5V+Bxk/rNVvFi0Ie/HXT8KRay8SBMwL4
3lxfIkisckDvjBRmsl1LHBDAl+N9jv+eZNwelixiJQ2k2YsNgE7zA2EsagnrjuKm
luFEpRoiR+dTuSZMkZP7iLqND3z5COhcVdpevsJfCdlj9U5QYUc2jovmUPVofR3j
2+fuQAYcBopDtc+ZkM3bjFt8NhXS+jrweEs78HH4jelUq7pbwQZrH2oJDWUaYtjo
mYMHCxz5ffdMuDhRwFGvaLYgH/En+2kz2COOtcWi06T9rjDLVdLlIoDVr6xK7C1/
r7CaBhDHRyx7kAGJLqklC+OEebDTjDyCfdk+rxyvqJ3qF5YWzbFusThFzDFcjzpv
jTO/me1RKtCaW+mEKHPNnxA6z6eYb1MvfRJOoggoHVHbyans67g=
=T+QM
-----END PGP SIGNATURE-----

--y5nr4xtarz375zrl--
