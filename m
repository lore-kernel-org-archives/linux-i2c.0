From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: at91: fix SMBus quick command
Date: Wed, 14 Nov 2012 10:33:58 +0100
Message-ID: <20121114093358.GC5954@pengutronix.de>
References: <1352821401-1944-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352821401-1944-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2012 at 04:43:21PM +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>=20
> The driver claims to support SMBus quick command but it was not the case.
> This patch fixes this issue.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>=20
> Hi Wolfram,
>=20
> Thanks to Jean explanation about i2cdetect and eeprom behavior, I realized
> that the first version of the patch was incorrect. This time all the i2c
> devices are detected with i2cdetect -q.
>=20
> I hope this fix could go into 3.7 since the driver claims SMBus quick
> capability but it doesn't support it. Moreover without it i2cdetect find
> imaginary devices, and with some IP versions, trying to send 0 byte can c=
ause
> issue when writing data to an EEPROM.

Updated the commit message with the latter paragraph and added to
for-current, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjZYYACgkQD27XaX1/VRsXfwCfYaoiC/ng5K6hOxeezrSApQve
Ix8AoKOET5ZbGyPTxnnSF5uSg7Rfwjg6
=sDYC
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
