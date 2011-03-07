From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: set controller to pio queue mode after reset
Date: Mon, 7 Mar 2011 10:06:51 +0100
Message-ID: <20110307090651.GA3425@pengutronix.de>
References: <1298656491-30686-1-git-send-email-w.sang@pengutronix.de>
 <20110307004736.GC15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110307004736.GC15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2011 at 12:47:36AM +0000, Ben Dooks wrote:
> On Fri, Feb 25, 2011 at 06:54:51PM +0100, Wolfram Sang wrote:
> > From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >=20
> > mxs_reset_block() clears the PIO_QUEUE_MODE bit. So we have
> > to set it again after a controller reset.
>=20
> -rc candidate?

The driver is only in your next branch. I guess you could even squash
it into the driver if rebasing does not hurt there.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk10oCoACgkQD27XaX1/VRszsQCfT3Ipbx7+Jh44VTV6Kop8MC4l
ZYgAnidd+sDKU69KcoO2Rdt/kBM96HkW
=gTyl
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
