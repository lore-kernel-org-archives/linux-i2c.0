From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Driver-Support of I2C_M_RECV_LEN
Date: Fri, 4 Jul 2014 09:58:50 +0200
Message-ID: <20140704075850.GA3492@katana>
References: <53A42321.5020701@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53A42321.5020701-S0/GAf8tV78@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Post <michael_post-S0/GAf8tV78@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> How i can figure out whether this mechanism will be provided of my driver?

Use i2c_get_functionality() and check for
I2C_FUNC_SMBUS_READ_BLOCK_DATA (or look at the source code).

> What is the alternative of using the function i2c_smbus_read_block_data?

That depends solely on your slave device. Check the documentation what
transfer types it supports and what alternatives are possible.

Regards,

   Wolfram

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtl66AAoJEBQN5MwUoCm2Xj4P/jqCkxZ8lyVX9XhfcZifjK6v
5hjSTGtHcksTQZx3WNjyDEr2Z8Bmuw8ScoG1QFsMYx+pU0jyoL8o9McnJzmnbBFv
13JWP04YBBHBDYvZahB0zY7VtbCr16DZ1VhRNhAIiKptTvMFtv/BhPRCVHXD7xDD
5+t8mrCJ4kxeaIXRbJ16OyyStZCKfoxuXD65pwlKi0S5RZom/60vtz8dvAtrlPJX
hdX59d3eNjIoHrO9Gy3pDraZ7xCqjTwvyYqfhRiI+px4xvrztqPZ9HGc/lCe8oJa
MKf6Ix2KaVLM0E5cw88g6JuwTenvK3UWHN4e9oLruQb+Nhj2fiwgX3cBRIeJ7+Ze
ibNFYCM4m1o9C/DNbQyDpQgLmcZRGDecqkMWrcLOk94cH8CjdQOer047jZUlWbBm
+GkyZEJppN1Th4HkoG1Y2cHdmSledFJQ8qJHhObv9Atqmfaj+cwcL7/e/8MUPxll
aUxmfWW6Dksl1BCMrCMqx26OSaYwi6YWJY47F3C2pDBKQ0KkRa+cBLFf6oIe4PZJ
/gXXgS9Ome14IaGqdhWRqnrF52UAcKBOstW+gEHD6TijzpLsyOQMheERt3mMOBsM
BV6g6+I4AGWlibeaAAvXZr19DCU7eyzGBHnEUI6eeOV8/aTB8un/sQ01FU4EbcdF
276Bji4bjzqlP6nUfGWU
=tIby
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
