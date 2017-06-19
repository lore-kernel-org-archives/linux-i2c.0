From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: at91: Handle return value of clk_prepare_enable
Date: Mon, 19 Jun 2017 16:28:18 +0200
Message-ID: <20170619142818.s2a754damyru4gzg@ninjato>
References: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vi6k3nxzpqu6r7ib"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53482 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdFSO2U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:28:20 -0400
Content-Disposition: inline
In-Reply-To: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ludovic.desroches@microchip.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--vi6k3nxzpqu6r7ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 12:27:44PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

I update the commit message to mention the clk_unprepare addition.
Applied to for-next, thanks!


--vi6k3nxzpqu6r7ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH34IACgkQFA3kzBSg
Kba2ixAAmfw41m31Q/vfpFY0Ua0xUijLaOxt3YkbGGIvLlBrKrTT9M+xfEmLtyEv
7uBpkZ3s35Jlo6ape+ooUCi2KJ2WP+i1Yh4WBu0kr+ZBhUYiphDza7qynxJ1rZig
HVGC5EP5Vr8pFvIbW1jbx40/3vCLutKnLVTRLZU9gMRONO5NVz/Goj5uE+kHNyZQ
43YtoEq4UfBZpBVdwosKqHWLzwULsCBntvZ6g2hWo4uAXUMGgEIcgccKpVDtflLa
FnCG7Im2DEJR1YkgCVSp++kLmVnDTo9yK9M6mPzezQj/73t7koYzQenHSizf86vM
iH6Htd+zvdOYBRZGogxCPCMjbE4eJRRvJv3YrOP8oYTBQP9DPIblTRxmlVNNeJkB
w9NiDxd1s6+SkY+gtKTys9OBK5DiwNMpFR3q/zDVThfdieEcnFxhgcXar17izsen
yPr0soFkHzfpwFETJ+PY7MAHg2UCGCQm7cFdHpUJpnuV/vocHbAWdfM8nTnGlcwa
LsL0HGENr1hpw91kU2uccp8j/uDjveWZBUsW338vlmPGd8kiVhejKXsRaEXOSCye
Iy71clrmKBnh6zAmpJSnnE2B+peWLmVbWLpByGEcPQtIUnnRkG7N9Ag3ixjA/Tk1
kjl5FMpR++iS1UqpXCtFvhx9uw+4mOuUrmAB77X2h9KimYuXU0Q=
=+Deq
-----END PGP SIGNATURE-----

--vi6k3nxzpqu6r7ib--
