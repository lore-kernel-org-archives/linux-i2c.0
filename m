From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-imx: Adapt the clock name to the new clock
 framework
Date: Mon, 9 Jul 2012 14:50:46 +0200
Message-ID: <20120709125046.GJ1296@pengutronix.de>
References: <1341599492-18212-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341599492-18212-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2012 at 03:31:32PM -0300, Fabio Estevam wrote:
> With the new i.mx clock framework the i2c clock is registered as:
>=20
> clk_register_clkdev(clk[i2c1_ipg_gate], NULL, "imx-i2c.0")
>=20
> So we do not need to pass "i2c_clk" string and can use NULL instead.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to next after fixing it up because we now use devm.

Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/606YACgkQD27XaX1/VRsxKACdGBiB0FNPMuOfRRSldI6K4ISP
htUAoIKw9ZKza4CSXGTDNyfrT2tLPN1w
=Sylq
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
