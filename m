From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: exynos5: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Thu, 13 Mar 2014 22:20:56 +0100
Message-ID: <20140313212056.GD2696@katana>
References: <000501cf3cc8$4b7f8d90$e27ea8b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000501cf3cc8$4b7f8d90$e27ea8b0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Naveen Krishna Ch' <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Taekgyun Ko' <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 10:21:57AM +0900, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
>=20
>   warning: 'exynos5_i2c_suspend_noirq' defined but not used [-Wunused-fun=
ction]
>   warning: 'exynos5_i2c_resume_noirq' defined but not used [-Wunused-func=
tion]
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIiE4AAoJEBQN5MwUoCm2+4oQAIZbWt7cXH7T9Qzuc6hXpelB
rMcj8EHc+kabgNI9HtGjtQSLi0B3+b/wv2fzM7Zznc/hOlOdMARldOF9ykrxJa7U
H3wN7MG9Fg4b0EHydxtBKj9kFVeQ1v1NbmhRa+LiBO8MFE3PPSf2CGv3JY9tUZRv
AYgjpGE1SmfdkCmWYA2tZhOrh6saPKqGTmjfF/GsasDgrkPvHmoaDcVmsGwK8oDF
X7TSLN/lzg8G10JtS1Ac80BoXJEPy0hqt4jFQJZdEERLr6IP+s8TvkJog5RTWVw5
ZIylV94/GMk8XnmMoilkHE98lCqRIwpBhvsywltLeCboXI9nnKir/h4x+b38Th1+
MviG0xl/AnNRjimu0PXgGy5cg0laww3iIz5oME1poFVV8sB+6bMZPsTyGJpWNSAQ
v8/3il/HJFquWYMpOgkVrIbfsnvnZpUcnsJSOg+XV1HMmBZmKTCsXF1FrzmMuHyX
AYgVE0mgl2GNnvlkVPitQ/P2BRO0nxy0D9ODN+q3u6E+/xV/rySJN33xzOOn0G/B
5LD4jKw3o1SUUxuVGzrZ+j3701hqrgn68/gxD/XomfssP5Z5MKgSrchR6X+t8BBN
J+QlJgoD8JA3zJtlkbCwBdCm00zADPE/EtzxF9+IiZJQlzbnrDOQ9UXG8siM79GC
SoiNx81gCmVphm9+1ZpR
=EVMp
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
