From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio for
 bus recovery
Date: Wed, 01 Apr 2015 16:38:11 +0200
Message-ID: <551C02D3.4080107@nokia.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com> <1417448047-15236-6-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417448047-15236-6-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Grygorii,

On 01/12/14 16:34, Grygorii Strashko wrote:
> Having a board where the I2C bus locks up occasionally made it clear
> that the bus recovery in the i2c-davinci driver will only work on
> some boards, because on regular boards, this will only toggle GPIO
> lines that aren't muxed to the actual pins.
>=20
> The I2C controller on SoCs like da850 (and da830), Keystone 2 has the
> built-in capability to bit-bang its lines by using the ICPFUNC regist=
ers
> of the i2c controller.
> Implement the suggested procedure by toggling SCL and checking SDA us=
ing
> the ICPFUNC registers of the I2C controller when present. Allow platf=
orms
> to indicate the presence of the ICPFUNC registers with a has_pfunc pl=
atform
> data flag and add optional DT property "ti,has-pfunc" to indicate
> the same in DT.
>=20
> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> CC: Mike Looijmans <info-KQxf8TFvCoAi8rCdYzckzA@public.gmane.org>
> CC: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
> Signed-off-by: Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> [grygorii.strashko-l0cyMroinI0@public.gmane.org: combined patches from Ben Gardiner and
> Mike Looijmans and reimplemented ICPFUNC bus recovery using I2C
> bus recovery infrastructure]
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

We have tested it on a custom Keystone2-based board, recovery seems to =
work
when SDA is held low externally.

Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Tested-by: Michael Lawnick <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

> ---
>  .../devicetree/bindings/i2c/i2c-davinci.txt        |   3 +
>  drivers/i2c/busses/i2c-davinci.c                   | 102 +++++++++++=
+++++++++-
>  include/linux/platform_data/i2c-davinci.h          |   1 +
>  3 files changed, 105 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt b/=
Documentation/devicetree/bindings/i2c/i2c-davinci.txt
> index 2dc935b..a4e1cbc 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
> @@ -10,6 +10,9 @@ Required properties:
>  Recommended properties :
>  - interrupts : standard interrupt property.
>  - clock-frequency : desired I2C bus clock frequency in Hz.
> +- ti,has-pfunc: boolean; if defined, it indicates that SoC supports =
PFUNC
> +	registers. PFUNC registers allow to switch I2C pins to function as
> +	GPIOs, so they can by toggled manually.
> =20
>  Example (enbw_cmc board):
>  	i2c@1c22000 {
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2=
c-davinci.c
> index 00aed63..a1bb587 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -64,6 +64,12 @@
>  #define DAVINCI_I2C_IVR_REG	0x28
>  #define DAVINCI_I2C_EMDR_REG	0x2c
>  #define DAVINCI_I2C_PSC_REG	0x30
> +#define DAVINCI_I2C_FUNC_REG	0x48
> +#define DAVINCI_I2C_DIR_REG	0x4c
> +#define DAVINCI_I2C_DIN_REG	0x50
> +#define DAVINCI_I2C_DOUT_REG	0x54
> +#define DAVINCI_I2C_DSET_REG	0x58
> +#define DAVINCI_I2C_DCLR_REG	0x5c
> =20
>  #define DAVINCI_I2C_IVR_AAS	0x07
>  #define DAVINCI_I2C_IVR_SCD	0x06
> @@ -97,6 +103,29 @@
>  #define DAVINCI_I2C_IMR_NACK	BIT(1)
>  #define DAVINCI_I2C_IMR_AL	BIT(0)
> =20
> +/* set SDA and SCL as GPIO */
> +#define DAVINCI_I2C_FUNC_PFUNC0	BIT(0)
> +
> +/* set SCL as output when used as GPIO*/
> +#define DAVINCI_I2C_DIR_PDIR0	BIT(0)
> +/* set SDA as output when used as GPIO*/
> +#define DAVINCI_I2C_DIR_PDIR1	BIT(1)
> +
> +/* read SCL GPIO level */
> +#define DAVINCI_I2C_DIN_PDIN0 BIT(0)
> +/* read SDA GPIO level */
> +#define DAVINCI_I2C_DIN_PDIN1 BIT(1)
> +
> +/*set the SCL GPIO high */
> +#define DAVINCI_I2C_DSET_PDSET0	BIT(0)
> +/*set the SDA GPIO high */
> +#define DAVINCI_I2C_DSET_PDSET1	BIT(1)
> +
> +/* set the SCL GPIO low */
> +#define DAVINCI_I2C_DCLR_PDCLR0	BIT(0)
> +/* set the SDA GPIO low */
> +#define DAVINCI_I2C_DCLR_PDCLR1	BIT(1)
> +
>  struct davinci_i2c_dev {
>  	struct device           *dev;
>  	void __iomem		*base;
> @@ -257,6 +286,71 @@ static struct i2c_bus_recovery_info davinci_i2c_=
gpio_recovery_info =3D {
>  	.unprepare_recovery =3D davinci_i2c_unprepare_recovery,
>  };
> =20
> +static void davinci_i2c_set_scl(struct i2c_adapter *adap, int val)
> +{
> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
> +
> +	if (val)
> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_DSET_REG,
> +				      DAVINCI_I2C_DSET_PDSET0);
> +	else
> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_DCLR_REG,
> +				      DAVINCI_I2C_DCLR_PDCLR0);
> +}
> +
> +static int davinci_i2c_get_scl(struct i2c_adapter *adap)
> +{
> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
> +	int val;
> +
> +	/* read the state of SCL */
> +	val =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_DIN_REG);
> +	return val & DAVINCI_I2C_DIN_PDIN0;
> +}
> +
> +static int davinci_i2c_get_sda(struct i2c_adapter *adap)
> +{
> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
> +	int val;
> +
> +	/* read the state of SDA */
> +	val =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_DIN_REG);
> +	return val & DAVINCI_I2C_DIN_PDIN1;
> +}
> +
> +static void davinci_i2c_scl_prepare_recovery(struct i2c_adapter *ada=
p)
> +{
> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
> +
> +	davinci_i2c_prepare_recovery(adap);
> +
> +	/* SCL output, SDA input */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_DIR_REG, DAVINCI_I2C_DIR_PDI=
R0);
> +
> +	/* change to GPIO mode */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_FUNC_REG,
> +			      DAVINCI_I2C_FUNC_PFUNC0);
> +}
> +
> +static void davinci_i2c_scl_unprepare_recovery(struct i2c_adapter *a=
dap)
> +{
> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
> +
> +	/* change back to I2C mode */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_FUNC_REG, 0);
> +
> +	davinci_i2c_unprepare_recovery(adap);
> +}
> +
> +static struct i2c_bus_recovery_info davinci_i2c_scl_recovery_info =3D=
 {
> +	.recover_bus =3D i2c_generic_scl_recovery,
> +	.set_scl =3D davinci_i2c_set_scl,
> +	.get_scl =3D davinci_i2c_get_scl,
> +	.get_sda =3D davinci_i2c_get_sda,
> +	.prepare_recovery =3D davinci_i2c_scl_prepare_recovery,
> +	.unprepare_recovery =3D davinci_i2c_scl_unprepare_recovery,
> +};
> +
>  /*
>   * Waiting for bus not busy
>   */
> @@ -669,6 +763,10 @@ static int davinci_i2c_probe(struct platform_dev=
ice *pdev)
>  		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>  			&prop))
>  			dev->pdata->bus_freq =3D prop / 1000;
> +
> +		dev->pdata->has_pfunc =3D
> +			of_property_read_bool(pdev->dev.of_node,
> +					      "ti,has-pfunc");
>  	} else if (!dev->pdata) {
>  		dev->pdata =3D &davinci_i2c_platform_data_default;
>  	}
> @@ -710,7 +808,9 @@ static int davinci_i2c_probe(struct platform_devi=
ce *pdev)
>  	adap->timeout =3D DAVINCI_I2C_TIMEOUT;
>  	adap->dev.of_node =3D pdev->dev.of_node;
> =20
> -	if (dev->pdata->scl_pin) {
> +	if (dev->pdata->has_pfunc)
> +		adap->bus_recovery_info =3D &davinci_i2c_scl_recovery_info;
> +	else if (dev->pdata->scl_pin) {
>  		adap->bus_recovery_info =3D &davinci_i2c_gpio_recovery_info;
>  		adap->bus_recovery_info->scl_gpio =3D dev->pdata->scl_pin;
>  		adap->bus_recovery_info->sda_gpio =3D dev->pdata->sda_pin;
> diff --git a/include/linux/platform_data/i2c-davinci.h b/include/linu=
x/platform_data/i2c-davinci.h
> index 2312d19..89fd347 100644
> --- a/include/linux/platform_data/i2c-davinci.h
> +++ b/include/linux/platform_data/i2c-davinci.h
> @@ -18,6 +18,7 @@ struct davinci_i2c_platform_data {
>  	unsigned int	bus_delay;	/* post-transaction delay (usec) */
>  	unsigned int    sda_pin;        /* GPIO pin ID to use for SDA */
>  	unsigned int    scl_pin;        /* GPIO pin ID to use for SCL */
> +	bool		has_pfunc;	/*chip has a ICPFUNC register */
>  };
> =20
>  /* for board setup code */

--=20
Best regards,
Alexander Sverdlin.
