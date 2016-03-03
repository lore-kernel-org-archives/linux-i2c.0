From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] drivers/i2c/i2c-imx.c: improve i2c bus error recovery
Date: Thu, 3 Mar 2016 22:37:13 +0100
Message-ID: <20160303213713.GG1501@katana>
References: <1453884283-33414-1-git-send-email-ying.zhang22455@nxp.com>
 <1453884283-33414-2-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46146 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757734AbcCCVhQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 16:37:16 -0500
Content-Disposition: inline
In-Reply-To: <1453884283-33414-2-git-send-email-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ying.zhang22455@nxp.com
Cc: linux-i2c@vger.kernel.org, xiaobo.xie@nxp.com, york.sun@nxp.com, Ying Zhang <b40530@freescale.com>


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 04:44:43PM +0800, ying.zhang22455@nxp.com wrote:
> From: Ying Zhang <b40530@freescale.com>
>=20
> When a system reset does not cause all I2C devices to be reset, slave can
> hold bus low to cause bus hang.
> It is necessary to force the I2C module to become the I2C bus master out
> of reset and drive SCL.
>=20
> The patch fixup the bus if a hang has been detected.
>=20
> Signed-off-by: Ying Zhang <b40530@freescale.com>

Can't you make use of the generic recovery infrastructure using struct
i2c_bus_recovery_info?


--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2K6JAAoJEBQN5MwUoCm22A4P/0B7ny7h82Mi4AbGVngRYaGi
PXkLe9Cw6C/E2nHozwVwt72pyc6K3xj87mHY+brPJFlkXUqb2z7nGyKQcRBECG/9
U0DyD+NBtRCSLxtPy17oFrcciSGDbENPcHDYY0yYI+6vO7RpdO6tOsgH1tgrNz+Y
YkSb+TnLOYc1/EzszN8G304uAvJhrj2NyoLMTp6l1XZJnyLKb3OIwJ4cRrcgCvUi
d+AvTLm3tQcL2/G7poq8FT8HDZVqoyg9WpUwIjm4BUcfkYoqRquMDl2mhcmSQw++
SrlVbzoEkkA/7GrSDhzTvMKVA84HTl6PyLdrKIeNutqJm3VC1XDlR77K9P6fyVrd
u+9wOXblwYV0MsehyIbS6cSU23aCpwcjEZs4nxEToDd5riTgb7+09xNBzn/nxtI/
0aTUEA9CvhgWeyLNo7PQ4U9uX4u2RN6my9VTI2LcYAIDrIlX+fW1vge5n5ea2LDF
KzOJleOqFfltucZHFiGTWvK6gNCJuV98cRKRUA4hDg1i4qLjeXEIj3LtjzA3ugJO
70WgYxvhzfDeLS27OpU6SysUDD5nZITsFFo8P5k3wi+nz+nIy/6hmCZmg0AOT2z3
YkYbfe7JEE2CAzZuCv2mIS3acoPz2dhb8yGUHrjdw8MjL3aYank/p4D8CqVq6s4y
tEiXVxLiVXAmbqI9vwU9
=v+Dq
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
