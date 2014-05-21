From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: i2c: removal of s6000 driver
Date: Wed, 21 May 2014 13:30:29 +0200
Message-ID: <20140521113029.GT2708@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N7HXVILz59yg1nI8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--N7HXVILz59yg1nI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I recently discovered that the I2C core of the S6000 is basically a
Designware IP core. For the latter we have a frequently used and updated
i2c driver while the S6000 driver seems to bitrot. My wish is to remove
the s6000 driver in favor of the DesignWare one. My question is if there
is someone who could test such a change on real hardware?
Grepping through sources, it looks to me like the only candidate in
mainline is the s6105, yet its defconfig doesn't even have I2C
activated? Can we remove this driver right away? Am I missing something?

Kind regards,

   Wolfram


--N7HXVILz59yg1nI8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfI5UAAoJEBQN5MwUoCm2UkgP/3UeIgbWf0ALTRqZAcdQ/6wH
zeDxQp+n3lQxc4tCNxWpk6ffKGSpzPrUg+7sH2kNxkc+QXuRxtbnhK5scK/seFHj
kdpJ9aBuVFeUzpVTQk8oh7wCmhYbHiyjNmmLf9dKjogKwRPHjkLhXk2lzs/kPWv7
xQqmjP24f71gVPNiYPsbooPAuMsiSiJpX7Ol3/ncyEdRnu1e/KDzexeyietOQxmX
XfdHIw+bhcf+Z8l96gUuPFRjEBJjj/V3SjAhXNunpmsfFx8PmMHhfsacbiYwllf0
sCyWdg3gW/2z9QkIr2tmFsOhmDVbUrMbpXtaixJaXitjtozXU8Ml0LZrtK9qq2Bp
KEWfbk0UeWu3x5xERIMjvkAGc6b8X0oiE1Jd49FSqij+XNvNvzAhf2I2zwnr0z0F
KvMl/yn0vF1z1EhauNliXY8wchKJ+Tf+nVdiu+XI5ehyowrpZzeiMDhelAcA/G73
n/1yfIjP6/8ExSUCJNpgJEOh/CzGwOqnMsYTK2Glv7WCNjJ1iDPfS36iRxLvtkJ5
52DRF8QMnd3RBKg2apFaHIKPbrM/RbmSpG7UL2AiH8B7bc8kjqGvAS9tDi21jFbQ
+D8tAxKepDgsdUMrbMzLxpse/s+dT2HlmNQzn94Pkmd6wmTHvp+dlQJcs6ZUHSEl
QEBZVsybrUWmxgIyT6Sy
=gWdF
-----END PGP SIGNATURE-----

--N7HXVILz59yg1nI8--
