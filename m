From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v2 2/2] i2c: brcmstb: Remove superfluous size check
Date: Fri, 15 Jul 2016 15:03:25 +0900
Message-ID: <20160715060324.GC1629@tetsubishi>
References: <20160715034509.58148-1-jaedon.shin@gmail.com>
 <20160715034509.58148-3-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36851 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcGOGDi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 02:03:38 -0400
Content-Disposition: inline
In-Reply-To: <20160715034509.58148-3-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2016 at 12:45:09PM +0900, Jaedon Shin wrote:
> The driver transfer to a message with NOACK always in any size.
> If client (eg. EDID segment point message) needs NOACK condition, it can
> use I2C_M_IGNORE_NAK flag.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Applied to for-next, thanks!


--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiHysAAoJEBQN5MwUoCm2phYQAJCC9ADAA86EJSA3xPhc4xM+
m/xfWZOnw0apjN9nX9iX0RzONqNOzZf2MBx1i+bQQdKBEFmIFwYIFwqwyv8C+4cF
4qq+MnXCeAjQTUAyx4vuj6J0DOmDSChJIUxpVzceRCLNIAaYVdUdlrX2qu0p9CNl
zUwi2pqvRMiDkXHJdXKNg7viU8ucckGJnPU+ay+0KZTAv7KvobEN4UrI3FQPaX96
jnN5OeNBKYgkPDptIgUAWQ7QQzRRuQTBxLrYmnKNfKxI9j224nGRFTII/0A+W/+v
ZDCVn8GoSXO+7+stCFCZcsXLdSIJgfgV4OkHwnn+Oyz0fLUENKLkgio0QdscpDEq
FWQPG6kF2hUK1fYDHLYQLMsmnJDS4hd8qKF2YGtX76zDnNNouxMSJ4WXKGTG86yw
ZkQ4jR8EzLI5NZvdUPOqXfhqm89ANoW7vRKR2ET3/Q0U0kWnNoX8sMXRCfWRcIYl
RTxMrRFusCwhE9l5yihspDJsL53CwDV+C+FjfY/H/EwB3tyGonupUpL+3hYf2k7f
kQ4YMkmCAoF0puKGpp8/xf+SNzacpVc55GfR91RSgsjHSt0LGt8Sb3w0sEYneg+t
/mopE9gBqPiLjo9gd/0/ikaRV/LtZIQtOz/j4LZ11BirrbrTzeTvdxIW+YWbCH99
kkEuR0XWBIyIDd4mmMF4
=Ps1u
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
