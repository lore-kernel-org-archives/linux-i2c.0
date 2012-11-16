From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
Date: Fri, 16 Nov 2012 15:09:43 +0100
Message-ID: <20121116140943.GE7313@pengutronix.de>
References: <1351182234-22971-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351182234-22971-3-git-send-email-maxime.ripard@free-electrons.com>
 <20121116083218.GE8464@pengutronix.de>
 <20121116142530.GH2941@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121116142530.GH2941-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2012 at 10:25:32PM +0800, Shawn Guo wrote:
> On Fri, Nov 16, 2012 at 09:32:18AM +0100, Wolfram Sang wrote:
> > On Thu, Oct 25, 2012 at 06:23:54PM +0200, Maxime Ripard wrote:
> > > This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
> > > GPIO expander eventually.
> > >=20
> > > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >=20
> > Shawn, I pushed the needed code to my for-next now. So you could apply
> > this patch for 3.8 or give an ack in case you want me to pick it via
> > i2c.
> >=20
> I have already sent mxs 3.8 stuff to arm-soc, so please have it go via
> i2c tree.  Thanks.
>=20
> Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

OK. Applied to my for-next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmSScACgkQD27XaX1/VRtH+ACgpU6m6v2DxbVSgs0vAiIFCyC3
S18An29AbBvgp427tnZFFJNH/lrYWr3J
=Xx0H
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
