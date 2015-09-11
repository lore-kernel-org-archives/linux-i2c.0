From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v4] i2c: imx: implement bus recovery
Date: Fri, 11 Sep 2015 02:10:43 +0000
Message-ID: <CY1PR0301MB0858AC48C32C8224ECFE0002CF500@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1439977931-5104-1-git-send-email-b54642@freescale.com>
 <20150907212712.GJ14598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150907212712.GJ14598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent=
: Tuesday, September 08, 2015 5:27 AM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an
> Fugang-B38611; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
> Subject: Re: [Patch v4] i2c: imx: implement bus recovery
>=20
> Hello,
>=20
> On Wed, Aug 19, 2015 at 05:52:11PM +0800, Gao Pan wrote:
> > @@ -963,6 +973,59 @@ out:
> >  	return (result < 0) ? result : num;
> >  }
> >
> > +static int i2c_imx_get_scl(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +
> > +	return gpiod_get_value(i2c_imx->pins.scl);
> > +}
> > +
> > +static int i2c_imx_get_sda(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +
> > +	return gpiod_get_value(i2c_imx->pins.sda);
> > +}
> > +
> > +static void i2c_imx_set_scl(struct i2c_adapter *adap, int val) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	gpiod_set_value(i2c_imx->pins.scl, val); }
>=20
> <nitpick>
> These three functions are very similar (i.e. 1 line respectively for
> variable declaration, driver data assignment and gpio operation), but=
 the
> last has an empty line less.
> </nitpick>
=20
Thanks.

> > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	pinctrl_pm_select_sleep_state(&adap->dev);
>=20
> I still think this is not nice, the v2 thread is still active with Li=
nus
> W. being involved.
=20
Thank you very much, will change it as Linus's suggestion in next versi=
on.

> > +	gpiod_direction_input(i2c_imx->pins.sda);
> > +	gpiod_direction_output(i2c_imx->pins.scl, 1); }
> > [...]
> > @@ -1011,12 +1074,13 @@ static int i2c_imx_probe(struct
> > platform_device *pdev)
> >
> >  	/* Setup i2c_imx driver structure */
> >  	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx-
> >adapter.name));
> > -	i2c_imx->adapter.owner		=3D THIS_MODULE;
> > -	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
> > -	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> > -	i2c_imx->adapter.nr		=3D pdev->id;
> > -	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> > -	i2c_imx->base			=3D base;
> > +	i2c_imx->adapter.owner =3D THIS_MODULE;
> > +	i2c_imx->adapter.algo =3D &i2c_imx_algo;
> > +	i2c_imx->adapter.dev.parent =3D &pdev->dev;
> > +	i2c_imx->adapter.nr =3D pdev->id;
> > +	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
> > +	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info=
;
> In a former review round I suggested to only do this assignment after=
 the
> two gpios were aquired successfully. Then the above checks could be
>=20
> 	if (i2c_imx->adapter.bus_recovery_info)
>=20
> instead of
>=20
> 	if (i2c_imx->pins.sda && i2c_imx->pins.scl)
>=20
> which IMHO looks nicer and more robust.
=20
Thanks, will correct it in next version.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/
