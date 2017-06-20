From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
Date: Tue, 20 Jun 2017 09:41:26 +0200
Message-ID: <20170620074126.GA1541@katana>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39264 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdFTHl3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 20 Jun 2017 03:41:29 -0400
Content-Disposition: inline
In-Reply-To: <20170620025815.GA4818@x250>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Baoyou Xie <baoyou.xie@linaro.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> Oh, yes, I should have mentioned it in the cover-letter.  Instead of
> changing MAINTAINERS file in different subsystem patch series, which may
> introduce merge conflicts, we plan to update it with a separate patch
> adding all driver entries that lands on mainline, and get it in through
> arm-soc tree.  Are you okay with that?

Yup, totally fine! Good approach.

> > Is this the error handling (NACK, etc)? Then, it got lost now since we
> > don't reset the hardware anymore after timeouts. But that would have
> > meant that errors are only detected after the timeout was reached
> > instead of instantly? If so, no good design. But maybe I misunderstand.
>=20
> Hmm, this doesn't make too much sense now, since this reset function is
> only being called at probe time to ensure the device is in a sane
> initial state.  There is no data transfer happening at this point at
> all.  I will drop these error bits checking from here, and add the error
> handling in irq handler.

Great, thanks!

> > How was this driver tested BTW?
>=20
> The driver is being used to access an Audio codec on the I2C bus.

Nice. Can you also run 'i2cdetect' on the bus to see if we have proper
NAK handling? AFAICS this should be broken now. And very slow with
previous versions of the driver.

Thanks,

   Wolfram


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllI0aEACgkQFA3kzBSg
KbaCVw//QD4x82/rT6ZgUcBGy1P7EIl0eRP4PpR3+aVkAJCffpOPWxQoapjllgzR
V4uSyi9fjYPEg+aaU+DlXNSGjQvT9W8AUoCk4jGslIpiJIH55qNN/mJH/+1RECJF
Gg/Jq+r/+YU+dwOx/nfOjwKD6ONHpSvxdtUV0vsOFGSE+VJfCqI4yT6+6AeGnHcG
lx49gNb/r24JmTd0sAfuw8nXqo2ykq1W+Q40znadgli51AvR4NjUT9AKCOxjrdz3
C9JWLs1+M8NAUa6NQSqpz2XmA24RoMGsag4oEt+TwU1Gztz8cgEhbmLYbYs7IM44
tRDighUSMR8/68mBilc7wh7C732X6XeVsUwyZVy++WZfeJYA6+zGtVRrHExmWjl/
VJDF1v5ShL69xGWqls1RxP8OiddNqUbe3pi3ddhAsrGU9V6QhW7j0NSpuz69KBVB
ImC84nFXgXaVv+IIQYzYPpKY5Q8s1V29SJFpL6gg/ZzKv1Dc/to+IQFKs1ItuDCt
6s1hz/Lch4pD/QhzuJIeo9p7bLWALbNuMiHJGRUhB29uNivvDaD/ZQzCmV5jKdVn
6BT7Ih7jQrAMiFls3OQ16V4L4MQN3aI0N0uufCHGqq96WiKSwamiaD7xhSf7kC3v
TD99jNGvq6sqhiYfaktA54EU7JOQXRICWHON398o23WvBpaAxC8=
=MmDy
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
