From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: hix5hd2: add i2c controller driver
Date: Mon, 6 Oct 2014 19:56:12 +0200
Message-ID: <20141006175611.GB2000@katana>
References: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
 <1412350549-2607-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412350549-2607-3-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2014 at 11:35:48PM +0800, Zhangfei Gao wrote:
> From: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>=20
> I2C drivers for hix5hd2 soc series, including following chipset
> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>=20
> Signed-off-by: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Sorry, one more thing, then we are ready to go:

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Here you say "GPL v2 or later"...

> +MODULE_LICENSE("GPL v2");

=2E.. here "GPL v2 only". That should be consistent!

Thanks,

   Wolfram


--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMte7AAoJEBQN5MwUoCm2Z+EP/1jFwDoEmG77BYiMREm8W6D7
hAU99mUvbiomce2X4FnBHMI0thBmF3bqSYNOVgSc9yVrRNKXCeSKSM6DEwdE1hhe
kAaOOqtpgGc1MTZXEjr4cCHsamfT5qoOZ71PfI/Swxowy/PlUh9aJ4Mzk86DnX5B
EsOV2qx4Tv0jCYBfl3+otyeRTrC4fQjg9rAjlMb9Qv7cUXrrXS9/oIhStfUIeCgN
BXHoBbkevnve4t6AAhXtKA/LMiTH+0FCGMNYaVL1kS/y8DLQwQ20gFwrLLcKHTCi
2q8FemHlujnPZP010PuU/Sm4FsFvoIeiQUQifejRi6HO29I9o74IZKX4UkHZppOR
swlqbzGc8uHZIxsnOQMAaJFu7kwmpEpgK3faR5Wys/grgHrbbEqWwokpnojbi+8a
Cg/yoOp31M2hndHCxBRWCvrkTeKnyinUs2xZsixbsCN8ymDFu6tPeVR419WIJYgf
tnQqWWYZl3j0yU6bG5nT78x5Q+RpXnzH2NAlTI7ftj/zNhS0630I2qsBJtSLIpfX
KMENtC/2j8NHOBA+OBl/T7P2VN4PbSmY499onmA0vyBzJyIjnEoU6Wvjd4YhwzEv
6T2BnKkoeoKmlgrTXfZVa/PzhBxzd3pzXADtovJEbVDrQzCL5bf7znD92iimjTn1
mvbF6Sw0FoR28NRxlTEz
=Ee7j
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
