From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/4] i2c: designware: detect when dynamic tar update
 is possible
Date: Thu, 25 Aug 2016 22:03:24 +0200
Message-ID: <20160825200324.GE1614@katana>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
 <1471990736-30190-4-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47007 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbcHYUEY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 16:04:24 -0400
Content-Disposition: inline
In-Reply-To: <1471990736-30190-4-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-i2c@vger.kernel.org, Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org, =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +		u32 ic_con = dw_readl(dev, DW_IC_CON);
> +		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)

Checkpatch warned:

WARNING: Missing a blank line after declarations
#49: FILE: drivers/i2c/busses/i2c-designware-core.c:452:

I fixed it for you this time.


--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXv08MAAoJEBQN5MwUoCm2+D0QAJdMoEgF8bHeNS7hNJmEneZE
VEBSbRY/ZfYgGa6hZpdkPbApws2T0J9W88PAVWQH54gNMw2W3xUK893/8uHxoxYY
e+uKrbuO6fGUJYl8Jv9BjHUY/twc1grz3a+C2XAlCMuRvRXYkI5f3jMZOyyt+yoz
sQ6tf+adQT9bNZrptx9NRplrxZaU7bQolGPdWpq93cduB9DTkelD7CLSfM1eYZrY
Ak9qaJIw5jDLvXgQYjz86dFgYLd+rtGhdLSq4BUZiFhCg0mbfsZl51972qJZ94/S
RHyGpzsIxIqlsBQ/Pw5eRYtXx+wglQzy275kYACpqJHPQpeSSr8tfbaCrpBfXMoq
h5yIlRUaRBnJvyw4eEzwnnDkBy5sGS/UBdyBVuISMPbV8IMNtpIJOSg4yXr/vVM8
5RbbHp10iWXtxQi6QXeu44766CQy8wPUY6GKYlF2jK0Wq9e+AwRKvuglSM6Lqm1u
du2DPSLPyGNlZ3rw5eWH4kiDEus3UbLZh6w093/gnO1zOHNjpYYU7Fe33o8JVyb5
Nr6AAVtrpEa+9PhgtZ9ZX0MFDMGbZkgcexTBtjX953SzbyElOG+8zKV3xj3/EaUh
3e43WVnqh9lmiAU/lQ/TUVTvmi12egiC5mFmgRYPLggCu9TL9exycCR+4+o15qJj
L9iB3n2g9SzOmcYgEVzS
=MAWM
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
