From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c-mpc: add support for the Freescale MPC512x and
	other fixes
Date: Mon, 25 Jan 2010 13:02:09 +0100
Message-ID: <20100125120209.GC5257@pengutronix.de>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1264408029-5290-1-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2010 at 09:27:06AM +0100, Wolfgang Grandegger wrote:

> This patch series adds support for the MPC512x from Freescale to the
> i2c-mpc driver. At that occasion, issues with  __devinit[data] have
> been fixed and the doc of the FSL I2C dts bindings updated. It has
> been tested on a MPC5121ADS, TQM5200 and TQM8560 board

Nice :) BTW, is there a git-tree meanwhile for your or Anatolij's
MPC5121-development?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktdiEEACgkQD27XaX1/VRswCACeIagD9gPY5IAZqq6EwELDc8Ic
7GMAn2RkpFStIydd9uKhiitbHx7xeT7r
=62Gf
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
