From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v1] i2c: imx: add runtime pm support to improve the
 performance
Date: Thu, 18 Jun 2015 02:37:48 +0000
Message-ID: <CY1PR0301MB0858E745717A1A7317909A2FCFA50@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1433987404-28957-1-git-send-email-b54642@freescale.com>
 <20150617214839.GG20984@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617214839.GG20984-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent: Thurs=
day, June 18, 2015 5:49 AM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an
> Fugang-B38611
> Subject: Re: [Patch v1] i2c: imx: add runtime pm support to improve t=
he
> performance
>=20
> Hello,
>=20
> On Thu, Jun 11, 2015 at 09:50:04AM +0800, Gao Pan wrote:
> > In our former i2c driver, i2c clk is enabled and disabled in xfer
> > function, which contributes to power saving. However, the clk enabl=
e
> > process brings a busy wait delay until the core is stable. As a
> > result, the performance is sacrificed.
> Which platform are you referring here? Looking at i.MX21 I cannot fin=
d a
> delay for the i2c clock.
I tested platforms are i.MX6q/i.MX7d that both use i.MX21 i2c IP.

There just need one delay before disable i2c controller:

static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
{
        ...

        if (is_imx1_i2c(i2c_imx)) {
                /*
                 * This delay caused by an i.MXL hardware bug.
                 * If no (or too short) delay, no "STOP" bit will be ge=
nerated.
                 */
                udelay(i2c_imx->disable_delay);
        }

	  ...

        /* Disable I2C controller */
        temp =3D i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
        imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
}=20

>=20
> > To weigh the power consuption and i2c bus performance, runtime
> consumption

Thanks for your detail review, will change it in next version.

> > pm is the good solution for it. The clk is enabled when a i2c trans=
fer
> > starts, and disabled afer a specifically defined delay.
> after

Thanks.

> > [...]
> > diff --git a/drivers/i2c/busses/i2c-imx.c
> > b/drivers/i2c/busses/i2c-imx.c index 785aa67..cc4b5d6 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > [...]
> > @@ -520,9 +523,6 @@ static int i2c_imx_start(struct imx_i2c_struct
> > *i2c_imx)
> >
> >  	i2c_imx_set_clk(i2c_imx);
> >
> > -	result =3D clk_prepare_enable(i2c_imx->clk);
> > -	if (result)
> > -		return result;
> you remove clk_prepare_enable enable and instead rely on
> clk_prepare_enable in i2c_imx_runtime_resume, right?
>=20
Yes, you are right.

> If I understand correctly this results in never enabling the clock if
> CONFIG_PM is disabled?!
>=20
Yes, you are right, I will change it in next version.


> > [...]
> > @@ -583,6 +582,9 @@ static irqreturn_t i2c_imx_isr(int irq, void
> *dev_id)
> >  	struct imx_i2c_struct *i2c_imx =3D dev_id;
> >  	unsigned int temp;
> >
> > +	if (pm_runtime_suspended(i2c_imx->adapter.dev.parent))
> > +		return IRQ_NONE;
> > +
> I don't claim to understand the runtime pm stuff, but I agree to the
> previous reviewer that this smells fishy. If this is required it need=
s a
> comment why.
>=20
In fact, I agree you two reviewers' consideration. As I said, this is j=
ust to avoid system hang in worse case.
Of course, I still don't catch the worse case. So I will remove this pm=
 stuff.

> >  	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >  	if (temp & I2SR_IIF) {
> >  		/* save status register */
> > @@ -894,6 +896,10 @@ static int i2c_imx_xfer(struct i2c_adapter
> > *adapter,
> >
> >  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > +	result =3D pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> > +	if (IS_ERR_VALUE(result))
> Is this better than
> +	if (result < 0)
> ?

Yes, thanks.=20
=20

>=20
> > +		goto out;
> > [...]
> > @@ -1018,11 +1028,6 @@ static int i2c_imx_probe(struct platform_dev=
ice
> *pdev)
> >  		return PTR_ERR(i2c_imx->clk);
> >  	}
> >
> > -	ret =3D clk_prepare_enable(i2c_imx->clk);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "can't enable I2C clock\n");
> > -		return ret;
> > -	}
> Is there a reason the clock was enabled *here* before. With the way y=
ou
> rearranged the code the irq handler might be entered before the clock=
 is
> on. But if I'm not mistaken (which might very well be the case) there=
 is
> a problem also without the patch if the bootloader jumps to linux wit=
h a
> pending i2c transfer that fires when the clk_disable is done below. I=
MHO
> "Set up chip registers to defaults" should be done before "Request IR=
Q"?!
>=20
Agree with your opinion.  I will fix it in the next version.

> > [...]
> > @@ -1093,14 +1110,51 @@ static int i2c_imx_remove(struct
> > platform_device *pdev) [...]
> > +#ifdef CONFIG_PM
> > +static int i2c_imx_runtime_suspend(struct device *dev) {
> > +	struct imx_i2c_struct *i2c_imx  =3D dev_get_drvdata(dev);
> s/  / /
> > [...]
> > +static int i2c_imx_runtime_resume(struct device *dev) {
> > +	struct imx_i2c_struct *i2c_imx  =3D dev_get_drvdata(dev);
> s/  / /
> > +	int ret;
> > +
> > +	ret =3D clk_prepare_enable(i2c_imx->clk);
> > +	if (ret) {
> > +		dev_err(dev, "can't enable I2C clock\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> this is equivalent to:
>=20
> 	if (ret)
> 		dev_err(dev, "can't enable I2C clock\n");
>=20
> 	return ret;
>=20
> Probably a matter of taste. Also I'd suggest to add the value of ret =
to
> the message to make the report more useful.
>=20
Yes, thanks.

> > +}
> > +
> > +static const struct dev_pm_ops i2c_imx_pm_ops =3D {
> > +	SET_RUNTIME_PM_OPS(i2c_imx_runtime_suspend,
> > +			   i2c_imx_runtime_resume, NULL)
> > +};
> > +#define I2C_IMX_PM_OPS (&i2c_imx_pm_ops) #else #define I2C_IMX_PM_=
OPS
> > +NULL #endif /* CONFIG_PM */
> > +
> >  static struct platform_driver i2c_imx_driver =3D {
> >  	.probe =3D i2c_imx_probe,
> >  	.remove =3D i2c_imx_remove,
> >  	.driver	=3D {
> >  		.name	=3D DRIVER_NAME,
> > +		.pm     =3D I2C_IMX_PM_OPS,
> >  		.of_match_table =3D i2c_imx_dt_ids,
> This increases the number of styles to place the =3D to three. .name =
uses a
> tab, .of_match_table a space and you add .pm with >1 spaces.
>=20
Yes, thanks.

> >  	},
> >  	.id_table	=3D imx_i2c_devtype,
> unrelated to this patch: The =3D in the line above is not aligned
> consistently compared to the other members at the same level like .pr=
obe.
>=20
Yes, thanks.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/
 |
