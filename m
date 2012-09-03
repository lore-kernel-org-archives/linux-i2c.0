From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
Date: Mon, 3 Sep 2012 10:50:08 +0100
Message-ID: <20120903095001.GB5782@gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120903094448.GB11780-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 03, 2012 at 11:44:48AM +0200, Wolfram Sang wrote:
> On Mon, Sep 03, 2012 at 11:22:28AM +0200, Linus Walleij wrote:
> > On Fri, Aug 31, 2012 at 2:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> w=
rote:
> >=20
> > (...)
> > >  static int nmk_i2c_probe(struct amba_device *adev, const struct =
amba_id *id)
> > >  {
> > >         int ret =3D 0;
> > >         struct nmk_i2c_controller *pdata =3D adev->dev.platform_d=
ata;
> > > +       struct device_node *np =3D adev->dev.of_node;
> > >         struct nmk_i2c_dev      *dev;
> > >         struct i2c_adapter *adap;
> > >
> > > +       if (np) {
> > > +               if (!pdata) {
> >=20
> > So, if no pdata is provided, we go on to allocate some ...
> >=20
> > > +                       pdata =3D devm_kzalloc(&adev->dev, sizeof=
(*pdata), GFP_KERNEL);
> > > +                       if (!pdata) {
> > > +                               ret =3D -ENOMEM;
> > > +                               goto err_no_mem;
> > > +                       }
> > > +               }
> > > +               /* Provide the default configuration as a base. *=
/
> > > +               pdata =3D &u8500_i2c;
> >=20
> > Then you just override that pointer with a pointer to the local con=
fig.
> >=20
> > > +               nmk_i2c_of_probe(np, pdata);
> > > +       }
> > > +
> > >         if (!pdata)
> > >                 /* No i2c configuration found, using the default.=
 */
> > >                 pdata =3D &u8500_i2c;
> >=20
> > This in it's entirety does not look sound. I *think* this is what y=
ou
> > want to do,
> > replace all of the above codde (including the last if (!pdata) clau=
se) with:
> >=20
> > if (!pdata) {
> >     /* If no platform data passed in, use the default configuration=
 as
> > a base. */
> >     pdata =3D &u8500_i2c;
> >     if (np)
> >         /* Further, if we have a DT node, override the default with=
 this */
> >         nmk_i2c_of_probe(np, pdata);
> > }
> >=20
> > This makes any passed pdata take precedence, else default pdata
> > complemented with DT info. Which is what we want.
>=20
> No. of_probe modifies pdata which in this case the default config whi=
ch
> might already be in use. So, you will get problems if you have two
> instances with different configuration. So, we need to allocate memor=
y
> but copy the content of the default data. The patch above just copies
> the pointer which is bogus.

Agreed. I'll fixup.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
