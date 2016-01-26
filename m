From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 1/1] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date: Tue, 26 Jan 2016 07:01:59 +0100
Message-ID: <20160126060159.GE1533@katana>
References: <1452888132-134446-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51278 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbcAZGCD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 01:02:03 -0500
Content-Disposition: inline
In-Reply-To: <1452888132-134446-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2016 at 10:02:12PM +0200, Andy Shevchenko wrote:
> This is effectively reapplies the commit b0898fdaffb2 (i2c: designware-pc=
i: use
> IRQF_COND_SUSPEND flag) after the commit d80d134182ba (i2c: designware: M=
ove
> common probe code into i2c_dw_probe()). Original message as follows.
>=20
> The mentioned flag fixes a warning on Intel Edison board since one of the=
 I2C
> controller shares IRQ line with watchdog timer.
>=20
> Fixes: d80d134182ba (i2c: designware: Move common probe code into i2c_dw_=
probe())
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fixed this checkpatch error:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> =
("<title line>")' - ie: 'commit d80d134182ba ("i2c: designware: Move common=
 probe code into i2c_dw_probe()")'

and applied to for-current, thanks!


--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpwvXAAoJEBQN5MwUoCm20IMQAK/N4kilKzdabNxgigEDHkir
CHGs3ToCFWTNpPyWOLo56/zAPuZaY5HT6KdpqjnTepZ/bQ+ZlC+oiziYRGcN5yae
jY2Tf5w2WRHn9cm8KgN2RYJ5DttWxtDWCEs8/9WyObzT77JFHFu4WEayu8w9fMog
HNsSz5WVBdXVpt+7SsovB8GnKTNXEwO847eyJOk764hyXg2niyMcymT8NW+GzNb5
IbBnDPt48rfJKJIG7jzR10GQk+O7Dr6cG8u1SbBQEQWRbuXGp15QXWbm02+CkrAm
tYr2An9X8jNClkHccj76V2kHm1Jsj4VxaNthAUAE+C7AJ8Ib1bp/hCchIeZkYzx6
styDfllAOQYxUjFyaql34ed0sB0+NuFYDm9K6XJCu0McxUuy3P6UXZWp/mOB8fOH
Vq75/Aa82RnpqgKJ0W1f+tPfYksrF/4u1/7EPHJh2OGS4ZkvCQpQl7YzjItxRg8p
B+ZEyNpJxKADzhoLTkqit6dT33EAjD1GSaZyg8ODEh6FLliL3dJ0SpMz+6ZxYScP
m4lWT2eVeMKXgfyygVTwEIh5FAXhWuLjmLOAbJMvtJYewI+3UY1Lpq3GrEZUsW1W
RiAB2uRPE1I2jkzD2SQepZWpf01J+AD9h9tv4c2jkJbj7efkL0rWfgq9sL05b4HV
RXsXPz6C++DDkHCXD8dy
=fyGQ
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
