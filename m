From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] i2c: at91: add dt support to i2c-at91
Date: Tue, 21 Aug 2012 18:08:02 +0200
Message-ID: <5033B262.2020900@atmel.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com> <1345559345-13988-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345559345-13988-3-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/21/2012 04:29 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/atmel-i2c.txt          | 29 ++++++++++++=
+
>  drivers/i2c/busses/i2c-at91.c                      | 49 ++++++++++++=
+++++-----
>  2 files changed, 68 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/atmel-i2c.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/atmel-i2c.txt b/Do=
cumentation/devicetree/bindings/i2c/atmel-i2c.txt
> new file mode 100644
> index 0000000..9e46289
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/atmel-i2c.txt
> @@ -0,0 +1,29 @@
> +I2C for Atmel platforms
> +
> +Required properties :
> +- compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2=
c" or
> +     "atmel,at91sam9g20-i2c"
> +- reg: physical base address of the controller and length of memory =
mapped
> +     region.
> +- interrupts: interrupt number to the cpu.
> +- #address-cells =3D <1>;
> +- #size-cells =3D <0>;
> +
> +Optional properties:
> +- Child nodes conforming to i2c bus binding
> +
> +Examples :
> +
> +i2c0: i2c@fff84000 {
> +	compatible =3D "atmel,at91sam9g20-i2c";
> +	reg =3D <0xfff84000 0x100>;
> +	interrupts =3D <12 4>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	24c512@50 {
> +		compatible =3D "24c512";
> +		reg =3D <0x50>;
> +		pagesize =3D <128>;
> +	}
> +}
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-a=
t91.c
> index 4599522..1c86b24 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -24,6 +24,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_i2c.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20
> @@ -112,17 +115,27 @@ static void at91_init_twi_bus(struct at91_twi_d=
ev *dev)
>   */
>  static void __devinit at91_calc_twi_clock(struct at91_twi_dev *dev, =
int twi_clk)
>  {
> -	int offset, div, max_ckdiv, ckdiv, cdiv;
> -
> -	if (cpu_is_at91rm9200()) {
> -		offset =3D 3;
> -		max_ckdiv =3D 5;
> -	} else if (cpu_is_at91sam9261()) {
> -		offset =3D 4;
> -		max_ckdiv =3D 5;
> +	int offset =3D 4, max_ckdiv =3D 7;
> +	int div, ckdiv, cdiv;
> +
> +	if (dev->dev->of_node) {
> +		if (of_device_is_compatible(dev->dev->of_node,
> +					    "atmel,at91rm9200-i2c")) {
> +			offset =3D 3;
> +			max_ckdiv =3D 5;
> +		} else if (of_device_is_compatible(dev->dev->of_node,
> +						   "atmel,at91sam9261-i2c")) {
> +			offset =3D 4;
> +			max_ckdiv =3D 5;
> +		}
>  	} else {
> -		offset =3D 4;
> -		max_ckdiv =3D 7;
> +		if (cpu_is_at91rm9200()) {
> +			offset =3D 3;
> +			max_ckdiv =3D 5;
> +		} else if (cpu_is_at91sam9261()) {

H=E9h=E9 ;-) here also, you will have to review this part...

> +			offset =3D 4;
> +			max_ckdiv =3D 5;
> +		}
>  	}
> =20
>  	div =3D max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
> @@ -379,6 +392,7 @@ static int __devinit at91_twi_probe(struct platfo=
rm_device *pdev)
>  	dev->adapter.dev.parent =3D dev->dev;
>  	dev->adapter.nr =3D pdev->id;
>  	dev->adapter.timeout =3D AT91_I2C_TIMEOUT;
> +	dev->adapter.dev.of_node =3D pdev->dev.of_node;
> =20
>  	rc =3D i2c_add_numbered_adapter(&dev->adapter);
>  	if (rc) {
> @@ -387,6 +401,8 @@ static int __devinit at91_twi_probe(struct platfo=
rm_device *pdev)
>  		goto err_free_irq;
>  	}
> =20
> +	of_i2c_register_devices(&dev->adapter);
> +
>  	dev_info(dev->dev, "AT91 i2c bus driver.\n");
>  	return 0;
> =20
> @@ -454,12 +470,25 @@ static const struct dev_pm_ops at91_twi_pm =3D =
{
>  #define at91_twi_pm_ops NULL
>  #endif
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id at91_twi_dt_ids[] =3D {
> +	{ .compatible =3D "atmel,at91rm9200-i2c", },
> +	{ .compatible =3D "atmel,at91sam9260-i2c", },
> +	{ .compatible =3D "atmel,at91sam9261-i2c", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_twi_dt_ids);
> +#else
> +#define at91_twi_dt_ids NULL
> +#endif
> +
>  static struct platform_driver at91_twi_driver =3D {
>  	.probe		=3D at91_twi_probe,
>  	.remove		=3D __devexit_p(at91_twi_remove),
>  	.driver		=3D {
>  		.name	=3D "at91_i2c",
>  		.owner	=3D THIS_MODULE,
> +		.of_match_table =3D at91_twi_dt_ids,
>  		.pm	=3D at91_twi_pm_ops,
>  	},
>  };
>=20


--=20
Nicolas Ferre
