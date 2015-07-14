From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v1] i2c: imx: implement bus recovery
Date: Tue, 14 Jul 2015 08:12:48 +0000
Message-ID: <CY1PR0301MB0858C32968C39EA0E60E2904CF9B0@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1436839486-11110-1-git-send-email-b54642@freescale.com>
 <20150714064832.GY1426@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150714064832.GY1426-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent=
: Tuesday, July 14, 2015 2:49 PM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an
> Fugang-B38611
> Subject: Re: [Patch v1] i2c: imx: implement bus recovery
>=20
> Hello Gao,
>=20
> On Tue, Jul 14, 2015 at 10:04:46AM +0800, Gao Pan wrote:
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
> >  Documentation/devicetree/bindings/i2c/i2c-imx.txt |   4 +
> >  drivers/i2c/busses/i2c-imx.c                      | 102
> +++++++++++++++++++++-
> >  2 files changed, 105 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > index ce4311d..0a0848f5 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > @@ -14,6 +14,8 @@ Optional properties:
> >    The absence of the propoerty indicates the default frequency 100=
 kHz.
> >  - dmas: A list of two dma specifiers, one for each entry in dma-na=
mes.
> >  - dma-names: should contain "tx" and "rx".
> > +- recover-scl: specify the gpio related to SCL pin
> > +- recover-sda: specify the gpio related to SDA pin
> I don't like the naming here. That the gpios are used for recovery is=
n't
> a hardware description. What about "scl-gpio" and "sda-gpio"?

Thanks. I will change it in the next version.=20

> >  Examples:
> >
> > @@ -37,4 +39,6 @@ i2c0: i2c@40066000 { /* i2c0 on vf610 */
> >  	dmas =3D <&edma0 0 50>,
> >  		<&edma0 0 51>;
> >  	dma-names =3D "rx","tx";
> > +	recover-scl =3D <&gpio5 26 0>;
> > +	recover-sda =3D <&gpio5 27 0>;
> >  };
> > diff --git a/drivers/i2c/busses/i2c-imx.c
> > b/drivers/i2c/busses/i2c-imx.c index 785aa67..eb4f95c 100644
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
> >  #include <linux/of_dma.h>
> >  #include <linux/platform_data/i2c-imx.h>  #include
> > <linux/platform_device.h> @@ -175,6 +177,16 @@ enum imx_i2c_type {
> >  	VF610_I2C,
> >  };
> >
> > +enum imx_i2c_vol_level {
> > +	I2C_IMX_LOW_VOL_LEVEL,
> > +	I2C_IMX_HIGH_VOL_LEVEL,
> > +};
> These are used as return value for the get_scl and get_sda callbacks
> which should return an int. I'd use plain 0 and 1 here.

Thanks. It can improve the readability to use plain 0 and 1 here.
=20
> > +struct imx_i2c_pinctrl {
> > +	unsigned int	sda_pin;
> > +	unsigned int	scl_pin;
> > +};
> > +
> >  struct imx_i2c_hwdata {
> >  	enum imx_i2c_type	devtype;
> >  	unsigned		regshift;
> > @@ -206,6 +218,7 @@ struct imx_i2c_struct {
> >  	unsigned int		ifdr; /* IMX_I2C_IFDR */
> >  	unsigned int		cur_clk;
> >  	unsigned int		bitrate;
> > +	struct imx_i2c_pinctrl	pins;
> >  	const struct imx_i2c_hwdata	*hwdata;
> >
> >  	struct imx_i2c_dma	*dma;
> > @@ -436,7 +449,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_stru=
ct
> *i2c_imx, int for_busy)
> >  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500)))
> {
> >  			dev_dbg(&i2c_imx->adapter.dev,
> >  				"<%s> I2C bus is busy\n", __func__);
> > -			return -ETIMEDOUT;
> > +			return i2c_recover_bus(&i2c_imx->adapter);
>=20
> This looks wrong. What if the bus is still busy after the call to
> i2c_recover_bus?  Also it doesn't feel right to call i2c_recover_bus =
just
> because the bus is busy.

In there, maybe i2c device sda is pulled low and bus is dead, so I add =
the bus recovery in here.
Because there wait 500ms, it is enough long.

If the bus is still busy after recovery, it return the -EBUSY, and gpio=
 also cannot recover the bus, so this transfer is failed.
What do you suggest for the position to call i2c_recover_bus() ? Thanks=
=2E

> >  		}
> >  		schedule();
> >  	}
> > @@ -450,6 +463,7 @@ static int i2c_imx_trx_complete(struct
> > imx_i2c_struct *i2c_imx)
> >
> >  	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> >  		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
> > +		i2c_recover_bus(&i2c_imx->adapter);
> >  		return -ETIMEDOUT;
> ditto.

The same as above. But it is better:
return i2c_recover_bus(&i2c_imx->adapter);

> >  	}
> >  	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__); =
@@
> > -956,6 +970,67 @@ fail0:
> >  	return (result < 0) ? result : num;
> >  }
> >
> > +static int i2c_imx_get_scl(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
> > +		return gpio_get_value(i2c_imx->pins.scl_pin);
> > +
> > +	return I2C_IMX_HIGH_VOL_LEVEL;
> > +}
> > +
> > +static int i2c_imx_get_sda(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin) {
> > +		gpio_direction_input(i2c_imx->pins.sda_pin);
> Don't you want that call in the prepare callback?

Thanks for your precise review. I will change it in the next version.
=20
> > +		return gpio_get_value(i2c_imx->pins.sda_pin);
> > +	}
> > +
> > +	return I2C_IMX_HIGH_VOL_LEVEL;
> > +}
> > +
> > +static void i2c_imx_set_scl(struct i2c_adapter *adap, int val) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
> > +		gpio_direction_output(i2c_imx->pins.scl_pin, val);
> Please move the gpio_direction_output call to the prepare callback an=
d
> only use gpio_set_value here.=20

Thank you, will change it in next version.=20

> > +}
> > +
> > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
> > +		pinctrl_pm_select_sleep_state(&adap->dev);
> So the sleep state is expected to mux the pins into their gpio functi=
on?

Yes, you are right. In here, we expect the pad is muxed to gpio functio=
n.

> > +
> spare empty line

Thanks.

>=20
> > +}
> > +
> > +static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
> > +		pinctrl_pm_select_default_state(&adap->dev);
> > +}
> > +
> > +static struct i2c_bus_recovery_info i2c_imx_bus_recovery_info =3D =
{
> > +	.get_scl                =3D i2c_imx_get_scl,
> > +	.get_sda                =3D i2c_imx_get_sda,
> > +	.set_scl                =3D i2c_imx_set_scl,
> > +	.prepare_recovery	=3D i2c_imx_prepare_recovery,
> > +	.unprepare_recovery	=3D i2c_imx_unprepare_recovery,
> > +	.recover_bus            =3D i2c_generic_scl_recovery,
> Mixed tab and spaces used for indention (if you ask me, use a single
> space before the '=3D' ...

Thanks for your carefulness, I will correct it in the next version.

> > +};
> > +
> >  static u32 i2c_imx_func(struct i2c_adapter *adapter)  {
> >  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL @@ -1009,6 +1084,7 @@
> > static int i2c_imx_probe(struct platform_device *pdev)
> >  	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> >  	i2c_imx->adapter.nr		=3D pdev->id;
> >  	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> > +	i2c_imx->adapter.bus_recovery_info	=3D &i2c_imx_bus_recovery_info=
;
> >  	i2c_imx->base			=3D base;
> ... which prevents uglyness as introduce here.)

Thanks.
=20
> >
> >  	/* Get I2C clock */
> > @@ -1037,6 +1113,30 @@ static int i2c_imx_probe(struct platform_dev=
ice
> *pdev)
> >  	/* Set up adapter data */
> >  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> >
> > +	/* Init recover pins */
> > +	i2c_imx->pins.sda_pin =3D
> > +		of_get_named_gpio(pdev->dev.of_node, "recover-sda", 0);
> > +	i2c_imx->pins.scl_pin =3D
> > +		of_get_named_gpio(pdev->dev.of_node, "recover-scl", 0);
> I'd use devm_gpiod_get_optional here.

Thanks for your good suggestion. I will change it in the next version.
