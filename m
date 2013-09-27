From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: define i2c_dw_pci_runtime_idle only with
 runtime pm
Date: Fri, 27 Sep 2013 11:22:59 +0300
Message-ID: <20130927082259.GC28875@intel.com>
References: <1380234243-23787-1-git-send-email-vincent.stehle@laposte.net>
 <20130927024313.GB3159@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130927024313.GB3159@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 27, 2013 at 04:43:13AM +0200, Wolfram Sang wrote:
> On Fri, Sep 27, 2013 at 12:24:03AM +0200, Vincent Stehl=C3=A9 wrote:
> > Make sure i2c_dw_pci_runtime_idle() is defined only when actually u=
sed, when
> > CONFIG_PM_RUNTIME is defined.
> >=20
> > This fixes the following compilation warning:
> >=20
> >  drivers/i2c/busses/i2c-designware-pcidrv.c:188:12: warning: =E2=80=
=98i2c_dw_pci_runtime_idle=E2=80=99 defined but not used [-Wunused-func=
tion]
> >=20
> > Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>=20
> I wonder if this fix is complete? Mika?
>=20
> > ---
> >  drivers/i2c/busses/i2c-designware-pcidrv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i=
2c/busses/i2c-designware-pcidrv.c
> > index f6ed06c..2b5d3a6 100644
> > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > @@ -185,6 +185,7 @@ static int i2c_dw_pci_resume(struct device *dev=
)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_PM_RUNTIME
> >  static int i2c_dw_pci_runtime_idle(struct device *dev)
> >  {
> >  	int err =3D pm_schedule_suspend(dev, 500);
> > @@ -194,6 +195,7 @@ static int i2c_dw_pci_runtime_idle(struct devic=
e *dev)
> >  		return 0;
> >  	return -EBUSY;
> >  }
> > +#endif
> > =20
> >  static const struct dev_pm_ops i2c_dw_pm_ops =3D {
>=20
> Shouldn't this be using UNIVERSAL_DEV_PM_OPS with the suspend and res=
ume
> function #ifdeffed by CONFIG_PM_SLEEP?

Yes, I think that would be better.

>=20
> >  	.resume         =3D i2c_dw_pci_resume,
> > --=20
> > 1.8.4.rc3
> >=20
