From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [kbuild-all] [wsa:i2c/for-4.13 15/51] warning: __mcount_loc
 already exists: drivers/i2c/algos/i2c-algo-bit.o
Date: Tue, 11 Jul 2017 10:46:19 +0200
Message-ID: <20170711084619.GD2342@katana>
References: <201707111232.THY3DhFS%fengguang.wu@intel.com>
 <20170711065431.GA2342@katana>
 <20170711075555.e5ktanutreueotu7@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:49864 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754126AbdGKIqW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Jul 2017 04:46:22 -0400
Content-Disposition: inline
In-Reply-To: <20170711075555.e5ktanutreueotu7@wfg-t540p.sh.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, kbuild-all@01.org, Philip Li <philip.li@intel.com>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>All warnings (new ones prefixed by >>):
> >>
> >>>> warning: __mcount_loc already exists: drivers/i2c/algos/i2c-algo-bit=
=2Eo
> >>--
> >>>> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-emev2.o
> >>--
> >>>> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-xlp9xx.o
> >>--
> >>>> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-rcar.o
> >
> >False positive? How can a commit that only touches the DEBUG define in
> >i2c-algo-bit have effects on the latter three drivers?
>=20
> You are right, I just confirmed that it's a false positive.
>=20
> The bisect didn't run distclean, which may explain the warnings on
> duplicate __mcount_loc.

Cool. Thanks for the heads up!


--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllkkFsACgkQFA3kzBSg
KbZ7Ew//e45v7dUpq9yPVFiUIOWrihGLQ0AqiWVL680Ab4sX5lxLfA/4UiC2IdFY
uWregCJM8Db8Zv+iUuOCh44Us0n1cuTlrHVaMNFryKp/JMmzAOit9QybhWn4eKac
qfDwkMmwJtJ2a36n/y0A77y9d7yTaURLjUjiCkkvtQYpYkhVuUhPdkXOuNDrxhPd
WwGt9l+acyulitSoj7FC8Wch3B+qGyri0WQeyOVLFWGRvWIeok4L/6M70JoTT2WN
sX+a1z4j+JNeSJFkM+c6s3uySxn9B2faYC7CjtoCHVrr9coH4P4SEMCMwPYgUjZn
uvqTC3s+RLf2cNhPcnYQUr01uLfCN7wNUdV126wMpxV1Rs6Mdhrbie7AttwT78e2
ZP3ovlgTX6iNrNzv0cCaXIv0YuRWiXlyzbQ8d5dQoX1hYPie5DjEBFtBf5iIE3bm
N5oiaIY1agiNVvAojBlsAag3iMArmZugaahN2nX8UAHpNtNNXi+2BQxsv8kRuS4V
p6eQ+NOYWveyIfU3fYzcdfzokNO3uJW3qJiY+KVge2YUZiATRtSbW/8oN0fcBPY4
lKCbol/E7IrwZW1+zN66xLW8iithyiyG36COyB4xOR8A066vgxjJ81zFV5xM1Gvf
HXRZvmWG2PSZG9x3JT1ZHmBfUFe7s6XuXkDloSHSFVh7YGFzgV4=
=bv8k
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
