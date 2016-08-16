From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Tue, 16 Aug 2016 14:12:05 +0200
Message-ID: <20160816121205.GA2846@tetsubishi>
References: <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
 <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
 <20160728083914.GC2693@katana>
 <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
 <20160728091514.GA17499@katana>
 <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
 <b2070d79-ab76-a2f5-658f-d24ad0229b04@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49968 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140AbcHPMMZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 16 Aug 2016 08:12:25 -0400
Content-Disposition: inline
In-Reply-To: <b2070d79-ab76-a2f5-658f-d24ad0229b04@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

> If you really have a separate device on the bus with the same address
> that you want to add slave support for, then there really is a conflict,
> and the kernel knows it.

We still have a disagreement about "the kernel knows it". The kernel
knows it only in one case, i.e. when you are able to describe all
devices on the bus.

What about this compromise: We keep the current scheme, but print a
warning when the kernel notices a slave device has the same address
which is already claimed by a client driver. This will let most users
know about the conflict but it will not hurt the debugging-via-loopback
case, since people know what they are doing and will happily ignore it.

If you can agree to that, I'll cook up a patch later this week.

Thanks,

   Wolfram


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXswMVAAoJEBQN5MwUoCm2IwYP/17mvqf1iHhf+4FLmfe/MJIi
TcqNOW0fztVxVVJ5XyZ3HBqwBRDfRV6EF8BOagUUfaVZp/nA9piVp2uOvbwpO06o
DG1oe0J+2vOGLeF5xOfqvXnl3Zd4oNTNkcDP06vcjlDmuiaoqNU8NYGCZ9M8dzRB
JO3A0Mf6vUkcxw84l4Vapckrro/LquV5vrme7CqWhqIeakVrbizEcryLtLwaKyzl
ZfAkcIzbuAoTIs0P7ZiWFdJH9Xe4MJwWDZgWx4HSPTu/P4tfaoODX/1pvsadezSS
IgqoRzE1kc+GKipKUFSspMhgG1Vkt2s4R7dSTDm5DPsO3zP5x+Ar2lYWYWU7s7Im
jFHwX1DiJm3C1lLrfLAnHli8GMB4rF/mUUjfzH/77KEgV9HPCiCXC4A1y9jB1SOA
m5bjMK+YU3+yo6tDBwMFmgJXPHGrSJehP3fKslhLYhEqiaCwmCCJf48OzEcly2Rj
+8mAlYrW3nvjSJaJNaU/FYR0ss+pLp1NZxdJMTMJnSVqtla6VTNw9sWXGG0cnpCD
JtTi4hr2wzKJfJXcj3GPIcso/wu3rHkhABeyEJdAITsOEPM433wdlYZUJEC4KqEX
pWznXfNpRkhma+SJMAtFB8PcsnHRHJ4/9mG/dh+b7LMDIaGvZynSvxARXrtNCSPN
XMjoEdJs3z7Ra3EdteIR
=7QW9
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
