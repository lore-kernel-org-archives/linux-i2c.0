From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
Date: Tue, 13 Nov 2012 08:58:13 +0100
Message-ID: <20121113075813.GA23119@pengutronix.de>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <20121112172651.GC15159@pengutronix.de>
 <27240C0AC20F114CBF8149A2696CBE4A1C3952@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A1C3952@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thanks your pointing out. I just manually reviewed the code when found
> this point. Would like to try some auto-script but failed:)

I can suggest 'coccinelle' for that kind of job.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCh/ZUACgkQD27XaX1/VRtfbwCgpxhJREFgmTFc6liGgO4gW6Pn
OSQAoMQm7VZQHd45eDDe6yj1lYHdJdvl
=Hbkr
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
