From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/8] CI13xxx: Add i.MX233/i.MX28 binding code
Date: Fri, 18 May 2012 14:34:38 +0300
Message-ID: <20120518113436.GN29784@arwen.pp.htv.fi>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-7-git-send-email-marex@denx.de>
 <20120516083613.GG17359@arwen.pp.htv.fi>
 <201205161541.17508.marex@denx.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205161541.17508.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2012 at 03:41:17PM +0200, Marek Vasut wrote:
> Dear Felipe Balbi,
>=20
> > On Tue, May 15, 2012 at 10:23:37AM +0200, Marek Vasut wrote:
> > > This codes connects the CI13xxx driver with the core found inside of
> > > the Freescale i.MX244/i.MX28 CPU.
> > >=20
> > > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > > Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> > > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > > CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > > Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > > CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > ---
> > >=20
> > >  drivers/usb/chipidea/Makefile      |    4 +
> > >  drivers/usb/chipidea/ci13xxx_mxs.c |  201
> > >  ++++++++++++++++++++++++++++++++++++ 2 files changed, 205 insertions=
(+)
> > >  create mode 100644 drivers/usb/chipidea/ci13xxx_mxs.c
> > >=20
> > > diff --git a/drivers/usb/chipidea/Makefile
> > > b/drivers/usb/chipidea/Makefile index cc34937..266d57d 100644
> > > --- a/drivers/usb/chipidea/Makefile
> > > +++ b/drivers/usb/chipidea/Makefile
> > > @@ -12,3 +12,7 @@ endif
> > >=20
> > >  ifneq ($(CONFIG_ARCH_MSM),)
> > > =20
> > >  	obj-$(CONFIG_USB_CHIPIDEA)	+=3D ci13xxx_msm.o
> > > =20
> > >  endif
> > >=20
> > > +
> > > +ifneq ($(CONFIG_ARCH_MXS),)
> > > +	obj-$(CONFIG_USB_CHIPIDEA)	+=3D ci13xxx_mxs.o
> > > +endif
> >=20
> > NAK... let it compile everywhere.
>=20
> I just followed the pattern here, honestly I think this is quite OK so fa=
r.=20
> Further improvements can be made indeed.

why introduce something we know will change ? Just make sure your code
compiles everywhere. What's already there can be changed afterwards.

> > > +	*data->pdev->dev.dma_mask =3D DMA_BIT_MASK(32);
> > > +	data->pdev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
> >=20
> > why don't you just point to the parent's ?
>=20
> Good idea, thanks :)

no problem ;-)

--=20
balbi

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtjPMAAoJEIaOsuA1yqREVlEQAJkwM2lzQh5Zajk0aGo0zNJx
roRUnVHz3/etFBBB5EPOwkLFojcK+5NLBYQsaHEHmDBuaQzi2Vq7tIGCIKENAysT
GGuEHK3p24M3OUghwMH4/4odCyIS0MLZlhQTSTyRel/w48HEyHfGovFIm+mKwlaR
nL0smZLV0wYFYSpLzODzerSkvZjKynOFj4UUv/FmvenP3iZCdRatJ5OfEhX64uLL
NUj0kJgOGeD6DbZhZx28hnSaCjfeNFaWS0GH/3WTdXxLyZf3iHLiL9lS0ayBg4rg
KS7MdeRHLe2qMmgA5vhoWDlnhsoK/1ThRfsG9mssF/4JBDyc35RHauu0G8ghJYne
0CUTGsbIYNVlLbSz9zOWmWhYQQRoOH5pfyFibqQUMXm+haKy3NOlpEhWaPoo8LtJ
4jmUin/cNJKJD0sgE7LG21akBSpyH0nQv4iKZP+RlpX0hQ9xPdmF8Wb8PXsczEDQ
5o7zj2H3SrZtLvlJSDJUpmYUkxydOUoVDQTv4SaMEUU6rD6bgcT5QXoj21/IhTsq
0RBw123Ti7XVTSyE3GyOwk724z812plRvLbTLngZTUpe7O/DNgQYgNCu+6r74aMU
jJTWO9vrEXdqbi4jYQO4Yb+TyPO3ayYUk08ePvzGPfXl4kE3VgaUFgJlWYTvLx30
txhp3QxhyiFR6cWC8Ccs
=7/9O
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
