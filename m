From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
Date: Thu, 9 Jul 2015 22:09:13 +0200
Message-ID: <20150709200913.GL4744@katana>
References: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434644382-11905-1-git-send-email-anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Anurag Kumar Vulisha <anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for the submission!

> +#define CDNS_I2C_BROKEN_HOLD_BIT	0x00000001

BIT(0) maybe?

> +static const struct cdns_platform_data r1p10_i2c_def = {
> +				.quirks = CDNS_I2C_BROKEN_HOLD_BIT, };

Closing '}' should be on seperate line.

And what Mark said.

Other than that, looks okay I'd say.


--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntTpAAoJEBQN5MwUoCm2/FwP/1PfMFQP111mBlAJMjVt5zw1
8qPfXCnf+yjMV1JhSmNtoD+Iy3FvVKHoJeISRYG1oJtx/NVfcocwWOQc63uofnJN
e4WasP7C1Moww2hE6Mm9Oe/XW+EIWug4cbwTA79AtzCwZcgQEBoKpa6LlhVVJq+E
4PEJcAeXE9+exdrSZL8TlhlKbShlhRlK8vIjMIDbJBeIvy2hDlqmf345LBK3OYKk
ZjuDwBeNm0hECb3vuvipEWNGawPY6nctDpTgm58lHSRN8kq1lLcu3w6e+CFtHYmI
lE3vWxuW3j7NDk3uwxvj7sMcTs5ZmcZiK/R/BE2bLWVnsQ83eqcJaIM08rpRY3uN
RvFmacJ/ThVdBuExZy+z0JEnP3nSqHqn42ePFtvzuzFKpYlIApvjAnn+g8hMP0rM
gxxKEv+Kkg8D/aIEmclvx4LP4UAl5A+C4qOE1MK5sgQ950U59i/53Y+B94HQlRtY
8dDIId7t4aXDKEIvsudkXUQwqfNFiBWOeGeUVgV+l6kmJoFFwScmPYGENRhtvtA1
KV18UaT2LDqntdDF2La7J/9eNUXEyvRSQAFEm8oIJt+DFUrFQbkCXAn0rytn0YFI
7zM44iCVbrR9SfY326AJVzCXbaH+ReAD0HB5FYEc5w24GJTHcPMnyFmehqHeS/Q3
XZ/FM6PLzlkRla+oaYOf
=sEKs
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--
