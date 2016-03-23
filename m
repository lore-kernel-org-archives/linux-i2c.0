From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 01/14] i2c-octeon: Cleanup i2c-octeon driver
Date: Wed, 23 Mar 2016 20:51:58 +0100
Message-ID: <20160323195158.GB19849@katana>
References: <cover.1458289385.git.jglauber@cavium.com>
 <0c8d2f5e22f6bb73d056d790c65da9f7cf248561.1458289385.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48046 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbcCWTwD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 15:52:03 -0400
Content-Disposition: inline
In-Reply-To: <0c8d2f5e22f6bb73d056d790c65da9f7cf248561.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 09:46:26AM +0100, Jan Glauber wrote:
> Cleanup only without functional change.
>=20
> - removed DRV_VERSION
> - defines: use defines instead of plain values,
>   use BIT_ULL macro, add comments
> - rename waitqueue return value to time_left
> - sort local variables by length
> - fix indentation and whitespace errors
> - make function return void if the result is not used
>   (octeon_i2c_stop, octeon_i2c_set_clock)
> - remove debug code from octeon_i2c_stop
> - renamed some functions for readability
> - update copyright
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Forgot to say: This is already upsteam. Since it is "just" cleanup, I
didn't want to wait another cycle and merged it for v4.6 merge window
already, so we can continue with reviewing the next patches.


--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8vPeAAoJEBQN5MwUoCm2O9wP/2o+ikGt5e0hEfy1HsU6sLrd
hqkimg6x+kDuoVMmGk6ABxEJuYiRgqNs+3WJEPq35ZsQznlgkFAM27ndf7GS90DE
Zic/5YoBCCrKPZVcExt7SWDlrIB5FlIJwHnMYupIDtoGHvd/9T9fFGQNlXhaTGUj
ByT78l7pgQf/r7+yDxPmoM6Q0yKv+pSSOOQcCWbZ5HEKFo/4XOS8N14/DqkUA9eK
u1UaNPwj0wNt+1NM4nQ91al0fDJLTWDTyv3xYpG9X2n5RvB/+fMlDozfYreAu0lR
D75a/JyuUHBRUPfHLCR/HISfUI5mJIP9L4mAjhNCewewRZ/hhpaT8KVK1V+0fwqq
g14dvCIwFNKpD4vBwZQlaa/XzGD0F55qhR7MkHfYGevAqoj/aubJ0SQPvldyiZAn
6c43KE4rqIwXOPbFVV2hAsud0B3fQZiYugQHKzxESuJak8fiLdARIBUaPQgCEYDV
YvmN8I3pIWuqqak5WJwy0pcRbXprv4kRJP5TUYHD+ARythRLyDSMo5t1FYaUKcsT
nRp5lTJUZ2wKtmLvv7U93VgdT2nmHeA5LkkH3g1+Ycpc8CcBD2wm30MsjoN/mOZv
2rgvVVNxYeV3HS2dRPQ9c+wKWi/L35ks8lv/2TxbrnNp5QNUGqyGw5JHeq0x/RzZ
TyJDxmEAWujw/99K1eAS
=XjFN
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
