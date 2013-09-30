From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 12:52:22 +0200
Message-ID: <20130930105222.GD3222@katana>
References: <1380512066-23681-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380512066-23681-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 09:04:25AM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Can you do this subsystem wide? At least mv64xxx is affected as well.


--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSVfmAAoJEBQN5MwUoCm2+ZQP/jT3QDGSNmE1FVdAD0SIucTx
vXMiRfo2/kMdBkFoqXYc3DayfmWFdLDKDuL0+wPOFg1PpXOd5sgvkute+K4+J5iR
kQxdQqp23PnCY94dPtEocRmmwVp18E5rDJq2VuHHMD70RV35eA80YQIZT5tti91K
tK4L/a2ZQ/NBpr8ImTjX7EqaTyUPFSkZDk7pOQBXeF8tTrmryi9fjjY/ehrYKnn+
CYxCMheEIQdky8/RHnvrrK5rdw6cd+P4IcWEPJbb7Jcip6xWSChyCcq5vtZ/SwMq
pJzLJPrU2/mGP4PI3T/qrnJ31Ne2OFs0GsVxzKnb3uy2mD8SoHxaS7vKiLnLu1re
10w2IOizWV99BaVUoTfmnv0fmZvvsiCwXkIL1OQB+KYd0HxyXc4dhzwx8NDni4cj
OwJY0G5dswXTPNQz/0uSGrLLFZeI9XaCItg1WdZT5HQvneE/8NGyPGrA/VLum5SG
0GIqBP7bk86ugOiG2L3noOtigWQO+l9/SiitwKCcVTVohKY5vRLqdC6rXyAmQBhM
wpxQg5VdyRxdq98P2d29QRSnS9va7voO7BM4X48UQR9CLA9XBenLVfSwcHo0Dcb1
8UnAWmfvALCYCbF5blrZuuDQyKsyDuRDNAqkWoTq6dV1cK5exLm+acSIjp/vf3xU
dcVnOyZpcFXs3ZXEyNma
=ZaRm
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
