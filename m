From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V4 2/2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Fri, 23 Jan 2015 15:18:53 +0100
Message-ID: <20150123141853.GA9592@katana>
References: <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1421313137-1613-3-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421313137-1613-3-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Mostly good, except one thing:

> +config I2C_DESIGNWARE_BAYTRAIL
> +	bool "Intel Baytrail I2C semaphore support"
> +	depends on I2C_DESIGNWARE_PLATFORM
> +	select IOSF_MBI

This needs some dependency on something Baytrail specific. Otherwise, it
causes lots of build errors:

With ARM allnoconfig, I can select this option but there are no headers
for iosf.

With x86_64_defconfig and disabled ACPI, I can select this option but it
fails over "implicit declaration of function =E2=80=98acpi_evaluate_integer=
=E2=80=99".

An incremental patch will do for me, the rest looks good.


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwlhNAAoJEBQN5MwUoCm2rkUP/iYlfnu/9Kxz6dGnXV+BJCXC
DTs/nJfuL07/Tpw7Dtgk0QWfEVrdqZFazDt2rCMpXNKTj+BI8DxrXmKRvf1Jk2NT
oQoexr8Ua32pbjEk3ab0Mzt0tOiny4ePhVJRHGXneOUsj4hPLiNQjzd7cJQn0iRu
dwZZjtB3a3da0e1P77cWIkSPn7F794bgALFShhg8BodPNatLkTtYMMEEDQEaO4Lo
aClDzF1VTii+Y9TkDiRMb3Cn3zgA+QszGOvpRO4A8dd5RtAKbYnMM7fuDJPCJ1wn
a7kvt6coE5n1nTNzspaIcRAVz48uvpG8nMwmn2Ul64trj4hU6BnCoOYtMavaHx0O
J7yPk6S8HjV2c+uwiO6ciGGi8HbYsZxTgJFquQmZhzi0itWGsFhD155vxFJwtgc8
QpsffIgVhTO3yfCTP958pJVZPjJvO06LtieAyf3KVSsaKk/tOfL0jUa4zJ1sv5rq
e9IrRdn+TgsMeC/hzPC8QzJpQebRtOiozeukSLfAUPsQNkgk/MZ7lIdZi9I4l/65
4M3UUSowGNoLCUhaSmMzQ0MbHMwXcm3LrOrgJTUX5mLqSNlOdtZ+W9I1psMsE422
jIx0CyFFJLn0S3o6IcwEsrcU04zHTP21tQdINNESJfcGn8I9URAKzQvZVcZFuzQF
Gys86cNje2tf0RBHgEhR
=hydN
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
