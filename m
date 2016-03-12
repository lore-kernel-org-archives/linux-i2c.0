From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 05/14] i2c-octeon: Make adapter timeout tunable
Date: Sat, 12 Mar 2016 16:46:12 +0100
Message-ID: <20160312154611.GH1661@katana>
References: <cover.1457362545.git.jglauber@cavium.com>
 <00a182c50af211e409f128630ba6ba5359da6198.1457362545.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50416 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbcCLPqP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:46:15 -0500
Content-Disposition: inline
In-Reply-To: <00a182c50af211e409f128630ba6ba5359da6198.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 04:10:48PM +0100, Jan Glauber wrote:
> From: Peter Swain <pswain@cavium.com>
>=20
> Make the i2c adapter timeout a module parameter to allow upper-level
> target device drivers to retry with their own logic before their own
> timeouts abort operations.
>=20
> For example, at24 eeprom driver retries for 25ms when -EAGAIN
> indicates that an eeprom has gone unresponsive while committing
> a newly written page (5ms on typical devices).
>=20
> Signed-off-by: Peter Swain <pswain@cavium.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

i2c-dev has IOCTLs for timeout and retries. Can't you use those?


--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5DnDAAoJEBQN5MwUoCm2jtUP/3G5OMCBsOKHEZkPCClKWtvY
Mun6ArleFh5QR8nJbSTG32ejrmSQg5r/cAFArlGa/Ya85tOUgH8r8b5L903aUrHa
c5WrloD4tCT+a+o4u+BosGwQ38ugf+g9m91f8iLooIOwHVFJOuDgNXkv6noKFBRL
VZrdOKKEJ49ul6xjOHHgcwVkbDxvqdGyXW6SqnUH2dG3bHl8utN4ceI697P/L1T1
H7PYvU7RnK+ygNQbRvjCIS0QXIWM15C4F56ylHvoZrYtme/6prw2wtnZMj0uNaN/
EsDSSThtzwduAtXgXSlMwu4YFDLj4agdnUMM0SW4iNDU5iF1VJXUzhxw2fzk7Lai
60MzbyVac9+5Z5O8OBamuwLOL2wmLoVCZCQf0h8o9XqYVTGoIMmiNCwhJCm8WbSE
2CdaxYSePMQ5IbYKQkjrccVSt+p5A0j9YdV8cv65rRcrpBbNxNLaHgYpRULUkFih
EXo/KaqWP1u0qnST8NObHAB6QZ8NYz+0lW2P1ZiLxTYPuyk186dIlhZmb9Vi4sfs
+HJLbeibkYGUnDBJCi240eg9oRz2JJThgCasU+IBAqH359wYaH/9es3bUaeEKMd5
dpRFAGrTx4vHXzj6PpJ5Cv6mR2/mCm8jO7m95PYAyK4KphSN/WIuW75XcL/3i2fm
/iWtqamWTh+bIVvkiqUU
=O3dr
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
