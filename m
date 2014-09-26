From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH resend 2/2] i2c: hix5hd2: add i2c controller driver
Date: Fri, 26 Sep 2014 08:55:44 +0200
Message-ID: <20140926065544.GA1284@katana>
References: <1409030722-30709-1-git-send-email-zhangfei.gao@linaro.org>
 <1409030722-30709-3-git-send-email-zhangfei.gao@linaro.org>
 <20140919171829.GB2874@katana>
 <5424DDD5.1020706@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5424DDD5.1020706-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> >>+#include <linux/clk.h>
> >>+#include <linux/delay.h>
> >>+#include <linux/i2c.h>
> >>+#include <linux/io.h>
> >>+#include <linux/interrupt.h>
> >>+#include <linux/module.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/pm_runtime.h>
> >
> >I think there should be at least of.h, too.
> The of.h is already in i2c.h
> include/linux/i2c.h:33:#include <linux/of.h>

Please add it nonetheless, because you use e.g. of_property_read_u32()
directly. That makes you independet of changes to i2c.h.

> >>+	rate = i2c->s_clock;
> >>+	sysclock = clk_get_rate(i2c->clk);
> >>+	sclh = (sysclock / (rate * 2)) / 2 - 1;
> >>+	writel_relaxed(sclh, i2c->regs + HIX5I2C_SCL_H);
> >>+	scll = (sysclock / (rate * 2)) / 2 - 1;
> >
> >scll and sclh use the same formula? Have you measured the setup
> >frequency with a scope?
> Yes, it is confusing, will use the same vector scl instead.
> The value is same means sclk high voltage and low voltage keep same time.

OK.


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJQ3wAAoJEBQN5MwUoCm2YNwQAIinkNKuFDpxWw8k3s1yBHs0
PcaS8RpHRmtzuYr90lU0KXIwLsMzjmwH46uzwB3mgB+iI5BXqqrQfSw4H046m1dz
biIph7JK/aCkttarBj+GGTepfjKWchwxburAFbzWq+RAW6zxPx/feOxeC5UCc4Ns
mbGE59npZzvgWD+ijb0//mg9lwfhMW1/QdRtN85/K9TBrOfEyCnW1mO9ZH4a/nht
X1cltEailZrGc5M328KkZijNsTYB7Yw7mcB08GTOmdcK/VNnSnSfHxa3fJKoJ7xq
7DYxBCa0NV1r3brGt5kHLGTLohib6m6KFdJUKBUBbyIxEKNJVyGFSCHRDUKegROs
NVV4r18DeBzXvKmrqBsZQQjv+4d6Of+KhruOO2pWhpS/IYvHM/8BapKaXvLa/Swf
OfhhbIJIaQ6x2AWWWWLZjIhYIUL6iI228xD4FOVoHaKCfIm+8Ahntqblzr7SKBQk
IFugRFV7XBFA8+NsVwGs89QRJJT6YUwjuYLALIL8fIjsGUyBSb/2AwnPf0cJP6Au
X2U+Y4kJ8/7kDbWh7PJa1D8MhPkI8jfhW7g7oSQUKrXmYIY+4r2QBWt5mG/XC8jt
IUFqKde+o2uefg19ypB8d4QwUQC49aXqRgs2eZOjujmwpSByTEgDOGAGHAMi42+y
cG/7pZMWVgAe60bVaWP9
=SRH1
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
