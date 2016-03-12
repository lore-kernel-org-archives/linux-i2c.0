From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv4] i2c: cadence: Fix the kernel-doc warnings
Date: Sat, 12 Mar 2016 16:03:44 +0100
Message-ID: <20160312150344.GB1661@katana>
References: <1457342919-12657-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50223 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbcCLPDu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:03:50 -0500
Content-Disposition: inline
In-Reply-To: <1457342919-12657-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, soren.brinkmann@xilinx.com, michal.simek@xilinx.com, Shubhrajyoti Datta <shubhraj@xilinx.com>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:58:39PM +0530, Shubhrajyoti Datta wrote:
> This fixes the below warnings
> drivers/i2c/busses/i2c-cadence.c:164: warning: No description found for p=
arameter 'dev'
> drivers/i2c/busses/i2c-cadence.c:826: warning: No description found for p=
arameter 'dev'
> drivers/i2c/busses/i2c-cadence.c:826: warning: Excess function parameter =
'_dev' description in 'cdns_i2c_runtime_suspend'
> drivers/i2c/busses/i2c-cadence.c:844: warning: No description found for p=
arameter 'dev'
> drivers/i2c/busses/i2c-cadence.c:844: warning: Excess function parameter =
'_dev' description in 'cdns_i2c_runtime_resume'
>=20
> while at it also update the cdns_i2c_clear_bus_hold
> and the runtime function update.
>=20
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

Applied to for-next, thanks!


--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5C/QAAoJEBQN5MwUoCm2aRUP/R85Er8ahRnzaHSq6TwjKLXt
bsY+iWubypcJE6kj/AbyiBy05Tl/UYLVpxwgBmYQ8PGF8c/8dOQdEqYxc1RHEOOj
481WW2/Fd1wg23kOela/whfCWRUfRD+eF3PBlUGCuVs7LfOOM8j0c9ThMmwnmSrM
WdWjkdDzDpklnF356iljUDoxcKhSnNiCH7NLP5U7HNEfoUNqSYeaHC3tHKsyLqeZ
aozY4ZC4k7+4tUQWkLPFI09TX74Ewn3ZsHCpWFQrlMWPkrPdteSY9PKORfP6Bxc6
DIiLEVLZPhfaJ6l1uuqxn/qYKsMT5QO/G53fycMrOHPwFJ051G/WrLLdvXPoH66Q
ME8tvyxW/bSFPLWg9VEW669EPd4xYIVa061ggpEriq4qQmKSEki3T8TwZtqh7aWc
kPpagKGzXP3YGzt8HToW3MOmWGsh9lmG6zU4+wu0ZK6uF3CXgV4k39y3pX249eZ3
aKYb4iouoHcFm2BMxdnBqp/8+w3b9/ok/41i4pAKl3dV7xlEoJHNsxNbWzZXqI2a
lfgLMZXuxEwrxKspIJc7VyjYwmifYQFqKD8QCDHijQm4h+aKgIPLaHgAduGoLrml
8GZ8mPUO/o26gShgQsfavdjqF+OLDSInUwW6MIaKiEy1kZvSe29K2njmKojVKlD5
nb9XtSsKb+/RxlLKear8
=COOb
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
