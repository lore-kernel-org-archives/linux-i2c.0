From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [V1, 1/2] i2c: brcmstb: Adding support for CM and DSL SoCs
Date: Sun, 3 Jan 2016 19:51:46 +0100
Message-ID: <20160103185146.GH1522@katana>
References: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56491 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcACSvv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:51:51 -0500
Content-Disposition: inline
In-Reply-To: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: linux-i2c@vger.kernel.org, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 03:49:09PM -0500, Kamal Dasu wrote:
> Broadcoms DSL, CM (cable modem)and STB I2C core implementation have
> 8 data in/out registers that can transfer 8 bytes or 32 bytes max.
> Cable and DSL "Peripheral" i2c cores use single byte per data
> register and the STB can use 4 byte per data register transfer.
> Adding support to take care of this difference. Accordingly added
> the compatible string for SoCs using the "Peripheral" I2C block.
>=20
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Squashed both patches and applied to for-next, thanks!


--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiW3CAAoJEBQN5MwUoCm202wP/3ljYnRP95evw7zEbV1QRUbu
c+2L6OSpZOhTIOy3hDX2GMz7jEuszLC3AiCmv9rvTBUBIjsndQCAa5R3oBodolXX
vFdm068nTkd+WRCkwgLjz5n58KXCKs5HFf327TjFRUesK/iZR1+cIfRhDfJnkTfa
hZvssNisGka3BlNWuL6JCTFN31MAgUMOHCcOvdhiGk1NK8xKHdByH0Pn/Bi72IzC
LJAY+duhyNlqKV+1kCqn/aCrbDTh0Mo2tF5Z2un9SJMsbG8VyRoicIjYhzInarkf
bQavPulbvEruNvmGYl3sP7/+KWkd/7hORKtTX1P2XGpkpheQ3Uv5P+QiShfHWPxa
fxj+S9M+by8Pg2f+3RlrvwH9ohBsFXY5zibOtk4TQldYij8VJO3NLGixOIqW4AkD
8XA2vM/27Omh+s7yZZYJM6/nXVaGQjHZWdlWBPSauF8g3ugDRW1mEj5y/BRsospO
LBxwRNekuIrXMT5DiLO6BDgNpv3jHticnkvlE3FiO0rvLiD3cU2fu4ZL3EHJ+Qf2
GyB2XrtrWd+mmCqHEtGdjweDx5H2prvYv8QOEXrVAtDMq7N87GkV+xfWaQTIn2I/
TnUiTXXs6XFLACbIsl+QkNCmcN5M18n8G/gOCzIUloy+8yzei38vQCdxjvYZiNBg
KCqYePICYmCiSR0ZbzIH
=aCu1
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
