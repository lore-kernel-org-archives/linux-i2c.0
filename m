From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Thu, 14 Nov 2013 18:00:26 +0100
Message-ID: <20131114170026.GA11022@katana>
References: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
 <1383726315-27534-2-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383726315-27534-2-git-send-email-maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stephen.gallimore-qxv4g6HH51o@public.gmane.org, stuart.menefy-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, gabriel.fernandez-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 09:25:12AM +0100, Maxime COQUELIN wrote:
> This patch adds support to SSC (Synchronous Serial Controller)
> I2C driver. This IP also supports SPI protocol, but this is not
> the aim of this driver.
>=20
> This IP is embedded in all ST SoCs for Set-top box platorms, and
> supports I2C Standard and Fast modes.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>

Applied to for-next, thanks!


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJShQGqAAoJEBQN5MwUoCm2SCMP/3HI6SSjFtrYRq1xwkMg2T1E
VObiP9YJI3LNUtfCRp/eIfZrcvRYgJ6Iju3g12ww4eU1aHwDe8UFSYv8XooeosgA
fJNPEJduVesX6gPZT5Ji5gWMxYkP20BsQG8tSKC5211oGfcMCklo2896LqGFUHjG
8rMGVoKc1/GdzNEoFQbphelQLo5D5P0haSgpRWh79sON6mb+PY1+WgKoeD6GXCOR
Rx+0iCcvtykfgxlNa0vOkVMtCfjM9vOXS4ueo5q10jSuk6Z9R7pRpy+8hjCWHcnm
KVFFs9RaR0Iz8KInsLzbDNnGs98HO+2KOqaVteyc8POox9EpB1In4OIxG6bzBOli
41MHkxtMDw+HiCH2BhlQHjJRS1nie5yh+NKR4dxCsUo4VL7M8uEJEMoMnIQEHaWK
ZRF5zCUHBa2yfpD6ltplnOFgm2MoErzszMIvGF/C4i/9md3UiVppAwaY5Z+fNSKD
M2OZexTIISJS1wJc6bHPgLuptYMWy6vXsCBW0KszZLb8E2aOc6ODdDnEJ0vdq7Ot
mHWZwjD2X8JFeUwK29J7jHe1ZwWR/c6BCLeA/o6VDYosmVIQGjaqjmB9YMy8Uwr9
1B7FO1uugAzm7CyoHN/FjddBIjFPc9CcnjE+CmYvWKmR5Rl+hfju1e4b3YTeJLdZ
xpf9EAF8HPSoF2FViZM7
=2wDJ
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
