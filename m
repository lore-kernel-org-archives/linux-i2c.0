From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/9] i2c: designware: use to_pci_dev()
Date: Sun, 3 Jan 2016 19:54:36 +0100
Message-ID: <20160103185436.GI1522@katana>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
 <7e2bbe0841ba35dbcfb9f6cf08c9ac81ab540663.1451211133.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVyHzDF4yf4A8jkR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56556 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbcACSyn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:54:43 -0500
Content-Disposition: inline
In-Reply-To: <7e2bbe0841ba35dbcfb9f6cf08c9ac81ab540663.1451211133.git.geliangtang@163.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--qVyHzDF4yf4A8jkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2015 at 06:45:59PM +0800, Geliang Tang wrote:
> Use to_pci_dev() instead of open-coding it.
>=20
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied to for-next, thanks!


--qVyHzDF4yf4A8jkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiW5sAAoJEBQN5MwUoCm2r7QQAJhlobGUAaerT/ZjGZEnTh7I
NW52Mdmu2MiFNNqj40ZKjx0rGg6i8psdrRFpesxLrBIHM9pXxf/uGO9mo/u0WHyZ
rrVqFBCSXqf08caod15P7Z60/jZKcOe5WBSghUb6K0YZizburiBk/s/pSBxfPTZs
hx/QUljR5yyqCrdqOAoX2JzvQv/znbZmQD2kdQl/SP+nAa342meODucGF1ykNvxg
jzCs5ncdecGLKPWW2zhBqOgyuS56xDkXTu2Eh+Co4YE7FZuNIKAy2U85YCTLoGnF
W2GXaDgAfq+HqNyDOOGeF8vM/VvYoUSTitwvwEAl2CwxbeYBNeIh0eFRXpsieWOG
5TLwvvCtxhdv7fAo1jnJV2JD4CqxVxEx8AIjAmCODJOD3fNfRcpLYdLmwTRxWIwv
hnMVLESFPlsvdPLQn2JNM2PL9bXTIB8Mm/EiRN2otDIw/hChC6em/XFwUiPImB5H
+y5ilz6jkeBoSCmr5OX4TksmBgtwC1yru6kpqBJqSjJe2DF11ElRvVi2E+8EYqVS
0ztBzh5pD9HwNngvLHp/H/to+C1Sarb1z7hSY7aMvdWkT/li+eonRJhmbclw7/91
mdO9vyjWoM/pSS4X/vne9aPjnshZgNQEaoRC5dr6Sg6glz6chCaYdrHG7iJN4sTN
AvCSkvV5zCccVmABEaRr
=YMEG
-----END PGP SIGNATURE-----

--qVyHzDF4yf4A8jkR--
