From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v3] i2c: imx: implement bus recovery
Date: Wed, 19 Aug 2015 08:36:33 +0000
Message-ID: <CY1PR0301MB0858B7F521C3DE171103DAF0CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1439967841-15885-1-git-send-email-b54642@freescale.com>
 <20150819071427.GF9999@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150819071427.GF9999-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <mailto:linux-i2c-owner-u79uwXL29TY@public.gmane.org=
nel.org>  Sent: Wednesday, August 19, 2015 3:14 PM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an
> Fugang-B38611; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
> Subject: Re: [Patch v3] i2c: imx: implement bus recovery
>=20
> Hello,
>=20
> On Wed, Aug 19, 2015 at 03:04:01PM +0800, Gao Pan wrote:
> > Implement bus recovery methods for i2c-imx so we can recover from
> > situations where SCL/SDA are stuck low.
> >
> > Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> > pinctrl to gpio mode by calling pinctrl sleep set function, and the=
n
> > use GPIO to emulate the i2c protocol to send nine dummy clock to
> > recover i2c device. After recovery, set i2c pinctrl to default grou=
p
> setting.
> >
> > Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> > V2:
> > As Uwe Kleine-K=F6nig's suggestion, the version do below changes:
> >  -replace of_get_named_gpio() with devm_gpiod_get_optional()  -move
> > gpio_direction_input() and gpio_direction_output() call to the
> >   prepare callback
> >  -use 0 and 1 as return value for the get_scl and get_sda callbacks
> >
> > V3:
> >  -replace "...-gpio" with "...-gpios" in i2c binding doc  -document
> > the requirement of using sleep state to configure the pins
> >   as gpio in i2c binding doc
> >  -remove i2c_recover_bus() in i2c_imx_trx_complete()  -use
> > GPIOD_OUT_HIGH as the parameter of devm_gpiod_get_optional to confi=
g
> >   the gpios as output high
> >  -add error disposal as devm_gpiod_get_optional meets error.
> >
> >  Documentation/devicetree/bindings/i2c/i2c-imx.txt |   8 ++
> >  drivers/i2c/busses/i2c-imx.c                      | 100
> ++++++++++++++++++++--
> >  2 files changed, 101 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > index ce4311d..f778db0 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > @@ -14,6 +14,12 @@ Optional properties:
> >    The absence of the propoerty indicates the default frequency 100=
 kHz.
> >  - dmas: A list of two dma specifiers, one for each entry in dma-na=
mes.
> >  - dma-names: should contain "tx" and "rx".
> > +- scl-gpios: specify the gpio related to SCL pin
> > +- sda-gpios: specify the gpio related to SDA pin
> > +
> > +I2C bus recovery implementation note:
> > +- If "scl-gpios" and "sda-gpios" property are present, pinctrl sle=
ep
> > +state
> > +  is used to configure the pins as gpio.
> >
> >  Examples:
> >
> > @@ -37,4 +43,6 @@ i2c0: i2c@40066000 { /* i2c0 on vf610 */
> >  	dmas =3D <&edma0 0 50>,
> >  		<&edma0 0 51>;
> >  	dma-names =3D "rx","tx";
> > +	scl-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH>;
> > +	sda-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;
> >  };
> > diff --git a/drivers/i2c/busses/i2c-imx.c
> > b/drivers/i2c/busses/i2c-imx.c index 4960fc1..59a6ffd 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/dmapool.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/gpio.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > @@ -48,6 +49,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> This is not necessary any more, now, is it?

Yes, you are right. Thanks.
=20
> >  #include <linux/of_dma.h>
> >  #include <linux/platform_data/i2c-imx.h>  #include
> > <linux/platform_device.h> @@ -178,6 +180,11 @@ enum imx_i2c_type {
> >  	VF610_I2C,
> >  };
> >
> > +struct imx_i2c_pinctrl {
> > +	struct gpio_desc *sda;
> > +	struct gpio_desc *scl;
> > +};
> > +
> >  struct imx_i2c_hwdata {
> >  	enum imx_i2c_type	devtype;
> >  	unsigned		regshift;
> > @@ -209,6 +216,7 @@ struct imx_i2c_struct {
> >  	unsigned int		ifdr; /* IMX_I2C_IFDR */
> >  	unsigned int		cur_clk;
> >  	unsigned int		bitrate;
> > +	struct imx_i2c_pinctrl	pins;
> >  	const struct imx_i2c_hwdata	*hwdata;
> >
> >  	struct imx_i2c_dma	*dma;
> > @@ -439,7 +447,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_stru=
ct
> *i2c_imx, int for_busy)
> >  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500)))
> {
> >  			dev_dbg(&i2c_imx->adapter.dev,
> >  				"<%s> I2C bus is busy\n", __func__);
> > -			return -ETIMEDOUT;
> > +			return i2c_recover_bus(&i2c_imx->adapter);
> You dropped the other call to i2c_recover_bus, did you keep this one =
on
> purpose?

Yes, if the bus is still unavailable after specific time. It can be con=
cluded that i2c bus is stuck.
The i2c_recover_bus is carried out under the condition of "i2c_imx->pin=
s.sda && i2c_imx->pins.scl".

> >  		}
> >  		schedule();
> >  	}
> > @@ -963,6 +971,67 @@ out:
> >  	return (result < 0) ? result : num;
> >  }
> >
> > +static int i2c_imx_get_scl(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.scl)
> > +		return gpiod_get_value(i2c_imx->pins.scl);
>=20
> If you implement my suggested change below you can drop the check and
> call return gpiod_get_value(i2c_imx->pins.scl) unconditionally here.

Thanks, you are right, will change it in next version.

> > +	return 1;
> > +}
> > +
> > +static int i2c_imx_get_sda(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda)
> > +		return gpiod_get_value(i2c_imx->pins.sda);
>=20
> ditto

Thanks.

> > +
> > +	return 1;
> > +}
> > +
> > +static void i2c_imx_set_scl(struct i2c_adapter *adap, int val) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.scl)
> > +		gpiod_set_value(i2c_imx->pins.scl, val);
>=20
> and also here

Thanks.
=20
> > +}
> > +
> > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
> > +		pinctrl_pm_select_sleep_state(&adap->dev);
>=20
> You wanted to document this. But maybe Linus Walleij want to say
> something here.

Thanks.=20

>=20
> > +		gpiod_direction_input(i2c_imx->pins.sda);
> > +		gpiod_direction_output(i2c_imx->pins.scl, 1);
> > +	}
> > +}
> > +
> > +static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda && i2c_imx->pins.scl)
> > +		pinctrl_pm_select_default_state(&adap->dev);
> > +}
> > +
> > +static struct i2c_bus_recovery_info i2c_imx_bus_recovery_info =3D =
{
> > +	.get_scl =3D i2c_imx_get_scl,
> > +	.get_sda =3D i2c_imx_get_sda,
> > +	.set_scl =3D i2c_imx_set_scl,
> > +	.prepare_recovery =3D i2c_imx_prepare_recovery,
> > +	.unprepare_recovery =3D i2c_imx_unprepare_recovery,
> > +	.recover_bus =3D i2c_generic_scl_recovery, };
> > +
> >  static u32 i2c_imx_func(struct i2c_adapter *adapter)  {
> >  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL @@ -1011,12 +1080,13 @@
> > static int i2c_imx_probe(struct platform_device *pdev)
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
> > +	i2c_imx->base =3D base;
>=20
> Maybe:
>=20
> -	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;
> +	if (i2c_imx->pins.sda && i2c_imx->pins.scl)
> +		i2c_imx->adapter.bus_recovery_info =3D
> &i2c_imx_bus_recovery_info;
>=20
> (This check obviously needs to be done further down when sda and scl =
are
> setup.)

Thanks. If i2c_recover_bus() is called under the condition of "i2c_imx-=
>pins.sda && i2c_imx->pins.scl",
the check here can be removed. How do you think?
=20

> >  	/* Get I2C clock */
> >  	i2c_imx->clk =3D devm_clk_get(&pdev->dev, NULL); @@ -1052,6 +1122=
,22
> > @@ static int i2c_imx_probe(struct platform_device *pdev)
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
> >  	pm_runtime_use_autosuspend(&pdev->dev);
> >
> > +	/* Init recover pins */
> > +	i2c_imx->pins.sda =3D
> > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpio",
> GPIOD_OUT_HIGH);
> > +	i2c_imx->pins.scl =3D
> > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpio",
> GPIOD_OUT_HIGH);
> As already noticed in the v2 thread: I think GPIOD_OUT_HIGH is wrong.

Thanks.
