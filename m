From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] macintosh: convert to i2c_new_scanned_device
Date: Tue, 31 Mar 2020 17:33:23 +0200
Message-ID: <20200331153323.GA5709@ninjato>
References: <20200326113819.7761-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42418 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCaPd3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Mar 2020 11:33:29 -0400
Content-Disposition: inline
In-Reply-To: <20200326113819.7761-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:38:19PM +0100, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). No functional change for this driver because
> it doesn't check the return code anyhow.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to for-next, thanks!


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6DYr8ACgkQFA3kzBSg
KbaRrQ/+NkT1leu18nmq9wUmVuXHs4jwgNIrw3w+V7G7J7jdi1G5SLFdwNgCoQSW
qRuK6Oq9+8nKYBFfnLS/XsU9jzpsRTyVKUaEr0OeomaR/LiL8ouAUYWsR0pnMstR
qLRBI2MUa0w638fXxOf08/hHWb9h4d5CNjuo3clkaW1JhdFhWngAYgrIBg7HQn0U
NVaN5fn/d4rxtUsIdoLgI8OPZEnFf7ZJ03Oidrm4bV8q4MZ0XNC5wAnf4+aHlo5T
pu5Krq+8nAHFZUITeqjQcE1Rw0PUuMxfUXT7eix9W/xo7cVgRLEYHwOlyLi4l5It
ABX9JPDpod6Jgw6PKY7HN35O+xgwAsSw9LS/pFJzmihWSb7lUYEiVYSbgnq08x3Y
YnE/pNYluRzBt8Xp6XoUQQNNxig0gKZXC/54r0AmIno/TAmRpMest1OqUJpVDqDU
G+F9dXgaakTAfIXm43C+N2ltZU/nbKF2XrX/cGFZZNjqxJZH2k7WF0gpyxzCHOQX
JSEqzgzyTDsAgfvPiDfy+y5VUSyky+my2eBFDHxt8+T6S+EWZsV3aTTrPyG7YycZ
n9cHNEfc4Hhl7gxvYgJXQR6QgoX3U7feJ9nqPqROsilPyrTUkkJa6i8VTSN9DCAN
5JCYLbkJRsWxQ0iQK3NDkRSHObqxaqywdMWIysZ2TUhnLhnG8Gs=
=96EW
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
