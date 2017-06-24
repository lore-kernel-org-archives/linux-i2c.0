From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [wsa:i2c/for-next 42/44] drivers/i2c/busses/i2c-zx2967.c:87:2:
 error: implicit declaration of function 'writesb'
Date: Sat, 24 Jun 2017 16:15:00 +0200
Message-ID: <20170624141500.GA1566@katana>
References: <201706240439.vcuBzSRT%fengguang.wu@intel.com>
 <20170624135754.GD23753@dragon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:43526 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdFXOPD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Jun 2017 10:15:03 -0400
Content-Disposition: inline
In-Reply-To: <20170624135754.GD23753@dragon>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Baoyou Xie <baoyou.xie@linaro.org>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jun Nie <jun.nie@linaro.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think what we should do is dropping COMPILE_TEST or adding !IA64
> dependency.  @Wolfram, what do you think?

Let's drop COMPILE_TEST for now, I'd say.

Thanks!


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllOc98ACgkQFA3kzBSg
KbZotBAAlS5+0UH28rxysKXVWSDdTAScuO0esGanWmrafV9s8A44ug9zbwb61Hxx
yueVHB09UvFYug1bGNDfG/e7G7NjCDWZYo2Iu6Ho2kGDTV1cJusU5v6R9MG1HZxb
wR0ne0CU2F6FEttwA13O1q26i+6adKBjVeONWmjtKjQNpT7WEyh5YAXhtLSXGVJd
uV4PsThiwIhCo0dngb8+Y8GWSevJnbBZ1K/SkJTHvHV/KbvfvisCu5QPY1WlO4uv
xsJJ8hGrFgdvU4Sy6LX05MRrXCqoI7nkDl/xfXiDZtMNK6KtBVoR6PljLoZPuLht
vnUKetEh74GG9i63QYe5LcEoqwjkVWXd+7jZ19YK2dsHj8ANeCMUtb7G8jPJO5DG
2Sh2FVS2p9QXaweSoRfxonzSKnxS4cI5CTtR+1G5DcCSLUNXssv1gkhlQ8j/8DFi
SV2FltwGo6pWYiLkZa4IgXG4dtznwYRvzEORiP9lbUWw6x3dMLfHwbyD0e2yyDf2
wdYlfFTJ6t3zM6MUBotmCdFW3NzdebBQI2onVhmimYUsRDnCiSnbGcgGYAJPG4NL
0H2hFro74olHbmFIe6SioDn7x40Lw13josIvRVrabLcImqhUde1/Z97l96v+XyvQ
rkmNG/0xIiQmKWZlrtlXJ6Pgq1MjyHnOB4wUBp3vD/XEwyjOvoI=
=pQ5L
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
