From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: i2cget with 16-bit address, 16-bit data
Date: Thu, 23 May 2013 10:24:10 -0500
Message-ID: <20130523152410.GC6406@sirena.org.uk>
References: <DB8F1B3EEF94C3439BFFE674EB05E3CC23FFBCB5@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC23FFBCB5-Y7gaLC3AO2b/4/2YxPzWhkKZ0KZ9iFohnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Craig McQueen <craig.mcqueen-5IW6GhIdNBM/ppqrhe30yRZCeNDtXRbv@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 04:27:20AM +0000, Craig McQueen wrote:
> I'm trying to read data from a SGTL5000 audio CODEC, which has 16-bit addresses and 16-bit wide data registers.

> Unless I'm missing something, it looks impossible to read these registers using i2cget, because it only supports 8-bit addresses. Is there any other similar tool, or should I patch i2cget to support 16-bit addresses?

If you're running Linux why are you trying to use i2cget to interact
with the register map?  There's a driver for the device using regmap...

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnjSXAAoJELSic+t+oim9O/kP/0S3p/Na+aLQhO1CyBIN/5c0
lgWPlMv6gBoZOXD5tmabehUuHpjhpNiOzV6ItP66RXHe9odFUcK0Kt4oEyNkKov0
wLCmjZSytjAwGWXmR/Ak94F88RpcWypczDRc8wAgUUFVAiPpz/F3BnTGNxyqyMfa
TyRftnpbIJ0ZpOG2SFhFzQ2AxAWHdmjTVfRJg9ssjzn5ImPpz1Kk67iABMl0/zBY
5f85ZyppIa3braBSdEHPoV9hjEjJq6gSgdu1hsExuexHpTgy7/Gl1qXmrBMyqx8M
Tbq3j8l1Yl+Tx3DpbNGuV0lOxZWA3IvXFVR2+kZKtzZzNyLjpMVX3SQxoDuQ4384
2UfydviUgGV94mEOfuGZX2MEJep2how8QYrXFmEIIINCeVU/GRYID2BoyOFPuslG
vYZoWZjLGe+QBSY7Vp0ZI1hYwOEd9wpLbr2SLvw4DAHhbtGVlt15kDxzZpM08lFD
yrX1WgNuHZpCdviD4oiCQbl1uT0cPam/lXwci7ly6DcSCOISfwhx3VRSh9Tqjf8G
0mYTvhcPT8GOR91vs75IF+wiiwDlae5sAXk+EhEF1joHsQdqcCC4OU4LOdUXi2eK
8qOcBTJlOSIEGajG0n7TUxjgLe1oimhDUytg4ccWT8WrA3HJaw/I8aHjAPWHcGRE
WyZbX7V/MnMCVUUPB3ro
=zZG2
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
