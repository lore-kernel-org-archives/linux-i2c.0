From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-tools] i2c-dev.h: copy over typo fix from kernel
 include
Date: Fri, 19 Jan 2018 10:21:58 +0100
Message-ID: <20180119092158.o6x7wy4epnzddv5y@katana>
References: <20180115204030.26400-1-wsa@the-dreams.de>
 <20180119093753.71e9457f@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vxz3y7orgjwr4zj3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35444 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeASJWA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Jan 2018 04:22:00 -0500
Content-Disposition: inline
In-Reply-To: <20180119093753.71e9457f@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org


--vxz3y7orgjwr4zj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> 652619121974 ("i2c-dev.h: Minimize differences with kernel flavor".) At
> this point i2c-tools' i2c-dev.h and the kernel's i2c-dev.h are exactly
> the same file, modulo the difference you just pointed out.

Exactly. I wanted to follow up in minimizing the differences. But I was
unaware of the master plan...

> So the right thing to do is to delete include/linux/i2c-dev.h from
> i2c-tools altogether. We no longer use it and we no longer install it,
> so it should be a straightforward change. I simply forgot to do it
> after the library conversion.

... which I super like very much!

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--vxz3y7orgjwr4zj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlphuLYACgkQFA3kzBSg
KbbZgw/+LDs65Pj0UiM8rfnJPpYRJemZwAAb5hc4ZTal28YQvN49/pcPsrLa59G/
upI9ayTk4EP+xXktttUJ5OQkdodU/YI37XiU+TFC3W6kRZ8N7PCbvTglQrl9bA0k
sDYjWXtPMZgCb0PqWOMg2GyxDeedSXV004MjDUNq8To7xNtfr+VKk1GaFPns0Noy
AknawdYUcyuxLCmCsBuv3kLldjStj9jXaZO4KMHqRyzpi67CpEdc2m+2aI0W0tux
J5Q/HJmT/Fc72ZfLdmPqcz557Tuj++ND+IlRKdtAh7Vx3UbrmEpZkkKxn03TK1TQ
tAs/Z8e4E2K6k2T7IBOgeUJuCcv5swtQ8coBvK6IEUpOW6Z3FAI55BFrGfrrKHZG
8xJ9FdNuesqdidnIfMQNDYobmpTVav9A5oRYATbA2fEVlCJejjlNgqPZgMhSPxqw
jo+NHTz3T6vkwnsk8vwnLxhDAZDn6qn/TTuKEjwJzYJIW9iy8mCizYPGrxB2KCvv
FspzgSwOqeWM83P1JVOi2mvzTi752dOpOwlbYMiEr2d4jRnDgA7dI48tzh7ffCCu
VRIyx3iqHYgpoHfWiPSkth961fs0AiTyBLf/HwIGrQqnmYji0BU8Or+ChRna0Qh2
CMaSZFBQZqqNflfYLKCo9F3zhNvLoUpDj7OcWQraRVU9IrPBJSo=
=g9IT
-----END PGP SIGNATURE-----

--vxz3y7orgjwr4zj3--
