From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v10 0/8] add i2c driver supported for rk3399
Date: Fri, 17 Jun 2016 13:56:11 +0200
Message-ID: <20160617115611.GC6876@tetsubishi>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2016 at 09:57:35PM +0800, David Wu wrote:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399
>=20
> David Wu (8):
>   i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
>   i2c: rk3x: use struct "rk3x_i2c_calced_timings"
>   i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
>   i2c: rk3x: Change SoC data to not use array
>   i2c: rk3x: Move spec timing data to "static const" structs
>   dt-bindings: i2c: rk3x: add support for rk3399
>   i2c: rk3x: add i2c support for rk3399 soc
>   i2c: rk3x: support fast-mode plus for rk3399
>=20
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-

Applied whole series to for-next, thanks! This was nicely refactored and
easy to review, thanks. Also thanks to all reviewers who helped this
series. I fixed one checkpatch issue for you, though:

WARNING: Statements should start on a tabstop
#278: FILE: drivers/i2c/busses/i2c-rk3x.c:789:
+	 if (min_div_for_hold >=3D min_total_div) {


--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXY+VaAAoJEBQN5MwUoCm2LQAP/1h+DdiXM1Mu0YLLdpULOQ9S
7iROR4TB4tOKx210fq/ixbJ4wRTZEA8cywxnmu7UBJBPIk+xf2PcazuzffxaioWu
++DoAlxJsgmgzpVeUvRCbB4FwHiqc5iHnZJHpXo3k75dXKE6vKgUW8lPKsYnUIeP
4wsk0zEy9oabAh0gr1HfWTd5AoqYUXTF8+Unv37ZNdW0l73rTocPlFQ8JlKLxf1t
T/rGLXLvW39xpK8FM4ZH1ysmZVecJSRCN8KnGdtCK8pFB0AdqVJZ1kKC0Jr5siyW
NlaxXzbXGpSYYTEEloIoyGCODMkmK3ot/eZl93PDr/66qj4R9enJt/u3EU3I332Q
3Gr20mwiBP6mHY0rni6F9uukta91XDmYo4dRJ3xzRNgfBhn152IWs52hBxe3EaIF
t2qZWrigPOHGANFZzJLkX/PvI+BVhylnldPIY8uCR9TPb2ezb9mnVU5l5HzJAUno
xVPHNRaLuCqQP3xDPYMSlrXNaw386HXP3c6bxuk64Q4PggpAsTRTg6nbOMCHBT37
VNjtjOlzMYL5IWGWip8UOUZOAFUy9Z5j3B0xwFIDZAuMeHksO25BWfW6zGf5G2sD
9+6xHeI+M/L9G2/RCrO2Q4YPf0BnMB0U6etnb0yBuvTQnNdDbnLm/xXhUdWtCoFj
m9Ju5LjC60aRjfvGedwP
=AkVo
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
