From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 1/4] i2c: pca-platform: add devicetree awareness
Date: Tue, 13 Jun 2017 04:38:19 +0000
Message-ID: <beffb088e82c40ae86cb05eebda33a66@svr-chch-ex1.atlnz.lc>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
 <20170613015641.29373-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34820 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbdFMEiZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Jun 2017 00:38:25 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 13/06/17 13:56, Chris Packham wrote:=0A=
> Allow devices that use this driver to be registered via a=0A=
> devicetree.=0A=
> =0A=
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> ---=0A=
>   .../devicetree/bindings/i2c/i2c-pca-platform.txt    | 18 ++++++++++++++=
++++=0A=
>   drivers/i2c/busses/i2c-pca-platform.c               | 21 ++++++++++++++=
+++++++=0A=
>   2 files changed, 39 insertions(+)=0A=
>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platfo=
rm.txt=0A=
> =0A=
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt b=
/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt=0A=
> new file mode 100644=0A=
> index 000000000000..47410bda3f37=0A=
> --- /dev/null=0A=
> +++ b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt=0A=
> @@ -0,0 +1,18 @@=0A=
> +* NXP PCA PCA9564/PCA9665 I2C controller=0A=
> +=0A=
> +The PCA9564/PCA9665 serves as an interface between most standard=0A=
> +parallel-bus microcontrollers/microprocessors and the serial I2C-bus=0A=
> +and allows the parallel bus system to communicate bi-directionally=0A=
> +with the I2C-bus.=0A=
> +=0A=
> +Required properties :=0A=
> +=0A=
> + - reg : Offset and length of the register set for the device=0A=
> + - compatible : one of "nxp,pca9564" or "nxp,pca9665"=0A=
> +=0A=
> +Optional properties=0A=
> + - interrupts : the interrupt number=0A=
> + - interrupt-parent : the phandle for the interrupt controller.=0A=
> +   If an interrupt is not specified polling will be used.=0A=
> + - gpios : gpio phandle to control device reset.=0A=
> + - clock-frequency : I2C bus frequency.=0A=
> \ No newline at end of file=0A=
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i=
2c-pca-platform.c=0A=
> index 3bd2e7d06e4b..ca63fee400cb 100644=0A=
> --- a/drivers/i2c/busses/i2c-pca-platform.c=0A=
> +++ b/drivers/i2c/busses/i2c-pca-platform.c=0A=
> @@ -23,6 +23,9 @@=0A=
>   #include <linux/i2c-pca-platform.h>=0A=
>   #include <linux/gpio.h>=0A=
>   #include <linux/io.h>=0A=
> +#include <linux/of.h>=0A=
> +#include <linux/of_device.h>=0A=
> +#include <linux/of_gpio.h>=0A=
>   =0A=
>   #include <asm/irq.h>=0A=
>   =0A=
> @@ -136,12 +139,15 @@ static int i2c_pca_pf_probe(struct platform_device =
*pdev)=0A=
>   	struct resource *res;=0A=
>   	struct i2c_pca9564_pf_platform_data *platform_data =3D=0A=
>   				dev_get_platdata(&pdev->dev);=0A=
> +	struct device_node *np =3D pdev->dev.of_node;=0A=
>   	int ret =3D 0;=0A=
>   	int irq;=0A=
>   =0A=
>   	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);=0A=
>   	irq =3D platform_get_irq(pdev, 0);=0A=
>   	/* If irq is 0, we do polling. */=0A=
> +	if (irq < 0)=0A=
> +		irq =3D 0;=0A=
>   =0A=
>   	if (res =3D=3D NULL) {=0A=
>   		ret =3D -ENODEV;=0A=
> @@ -182,6 +188,11 @@ static int i2c_pca_pf_probe(struct platform_device *=
pdev)=0A=
=0A=
=0A=
I should be setting i2c->adap.dev.of_node somewhere around here so that =0A=
the child nodes get automatically probed.=0A=
=0A=
>   		i2c->adap.timeout =3D platform_data->timeout;=0A=
>   		i2c->algo_data.i2c_clock =3D platform_data->i2c_clock_speed;=0A=
>   		i2c->gpio =3D platform_data->gpio;=0A=
> +	} else if (np) {=0A=
> +		i2c->adap.timeout =3D HZ;=0A=
> +		i2c->gpio =3D of_get_gpio(np, 0);=0A=
> +		of_property_read_u32_index(np, "clock-frequency", 0,=0A=
> +					   &i2c->algo_data.i2c_clock);=0A=
>   	} else {=0A=
>   		i2c->adap.timeout =3D HZ;=0A=
>   		i2c->algo_data.i2c_clock =3D 59000;=0A=
> @@ -275,11 +286,21 @@ static int i2c_pca_pf_remove(struct platform_device=
 *pdev)=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> +#ifdef CONFIG_OF=0A=
> +static const struct of_device_id i2c_pca_of_match_table[] =3D {=0A=
> +	{ .compatible =3D "nxp,pca9564" },=0A=
> +	{ .compatible =3D "nxp,pca9665" },=0A=
> +	{},=0A=
> +};=0A=
> +MODULE_DEVICE_TABLE(of, i2c_pca_of_match_table);=0A=
> +#endif=0A=
> +=0A=
>   static struct platform_driver i2c_pca_pf_driver =3D {=0A=
>   	.probe =3D i2c_pca_pf_probe,=0A=
>   	.remove =3D i2c_pca_pf_remove,=0A=
>   	.driver =3D {=0A=
>   		.name =3D "i2c-pca-platform",=0A=
> +		.of_match_table =3D of_match_ptr(i2c_pca_of_match_table),=0A=
>   	},=0A=
>   };=0A=
>   =0A=
> =0A=
=0A=
