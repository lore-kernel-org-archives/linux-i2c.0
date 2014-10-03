From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
Date: Fri, 3 Oct 2014 18:48:52 +0200
Message-ID: <20141003164851.GA1481@katana>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
 <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
 <20141003120926.GF1349@katana>
 <542EA15B.70605@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <542EA15B.70605-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Currently Wei help do the test via I2C device interface, on a specific board
> with i2c device.
> We do the test after the board is up, also no i2c activity during probe.

Huh, so the driver has not been tested with a real i2c slave so far? Or
am I misunderstanding something?


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULtNzAAoJEBQN5MwUoCm2bK8P/01HDfp+ncaXu9XMHZfPQKC5
Rk8oLGU5bujDAXN8TGQiqj9JuQrQXobYj3CC8O2sRd6nqV+TavIRkNSKFcoXk1vP
LOh9A/KAtr3mfSfPC/PMwlmG5WJggdADm8gHSHgzeJCDsmGj2YWcG85zexaVnBXk
FMfVCQip5GH6D2yS+80DODNIzMiUX8NOBlRXVllTJg4yTAlbAvZ7A1YS/Msh5gDg
a0q5doNaqdgx8RMszvZOq+VeWxsgFR5FGbTkbl0dAjrxSOqILs1nphC4qeVhGtEp
geFHQ/JUO9eBRYhzI52xJW15U4obaP9HOAmeNZJ6sG7LaM98o5+K6AiuMUiEb6IU
6OEx0KuiFrXbXyW2UZu2LFMf332OGfqgPZedpTjDsfXWGFyhIKPAB5jjrLXYNhUS
NyHJ31Ol1HAmVniVysuY5yZrmvLnnPkHsXjXmsKQaH3+6F4Zs0jA+/URv9pZukJn
cZaw3+DYwL4zt+T3b8o+C5KpUGsm4yyffqd/prB6YiWRqUXe00NeCR0De4FcHDXu
5TUsg2q4n/0oEHsNiJ6Mj5lUSF2Y/CK4F2ryzGpQSzXD2Dg5lUtRYiZuxCTBjyyL
7Y7xCvB4VQcSvQ+uUJjAEGzTrxQU4ZumjVTumVWqR5Y45GpYiuLRBUi12RJANSFI
Q6icmb9cUS6YeIleIE9l
=hHVd
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
