From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: make bitrate unsigned int
Date: Mon, 9 Jul 2012 11:37:12 +0200
Message-ID: <20120709093712.GA1296@pengutronix.de>
References: <1341746687-1448-1-git-send-email-wolfram@the-dreams.de>
 <20120709062428.GD26888@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120709062428.GD26888-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2012 at 02:24:29PM +0800, Richard Zhao wrote:
> On Sun, Jul 08, 2012 at 01:24:47PM +0200, Wolfram Sang wrote:
> > sparse found this assignment of u32 to an int. Fix it:
> >=20
> > drivers/i2c/busses/i2c-imx.c:540:56: warning: incorrect type in argumen=
t 3 (different signedness)
> Could you change imxi2c_platform_data.bitrate to unsigned int too?

Good point, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/6pkgACgkQD27XaX1/VRvRDACeNLsAV80RRHMmvrhU3OiiPCa8
PlYAoIsvL/5jeES4ZWfIIFpe1xS84pm1
=oQld
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
