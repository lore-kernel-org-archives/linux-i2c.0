From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Sat, 21 Jul 2012 14:44:06 +0200
Message-ID: <20120721124406.GA9946@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
 <20120715081715.GA2429@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120715081715.GA2429-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2012 at 04:17:16PM +0800, Shawn Guo wrote:
> On Fri, Jul 13, 2012 at 10:22:49AM +0200, Wolfram Sang wrote:
> > > +	/*
> > > +	 * TODO: This is a temporary solution and should be changed
> > > +	 * to use generic DMA binding later when the helpers get in.
> > > +	 */
> >=20
> > @Shawn: Any idea when this is going to happen? And why do we need this?
>=20
> See thread [1] for current statues.  I'm not sure when it's going to
> happen though.

Phew, [1] is a bit too much too read. I will just assume there are still
issues.

> > AFAICT it will be always channel 6/7 on mx28?
> >=20
> Yes, but it might be a different channel on mx23.  Just like we define
> IO region and interrupt number in device tree, dma channel is just
> another resource of hardware block that we choose to define in device
> tree.

What makes me wonder now that I come to think of it (not necessarily a
question for Shawn but to all):

If I have an I2C slave with an interrupt line tied to something, GPIO or
external IRQ from the SoC, it makes perfect sense to define that in the
devicetree.

Yet, if I know the compatible property for the mxs I2C driver, and also
know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
information, including DMA channel. That is fix. Why encode it?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAKpBUACgkQD27XaX1/VRvtAwCgt3WQkUBdzIuYvXShLYYKfzr9
/y8An2sFWUFGs5e+1+J8/ZUdrY/POUEl
=Z0WR
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
