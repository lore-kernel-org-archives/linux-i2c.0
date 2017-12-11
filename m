From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH] i2c: Add support for NXP PCA984x family.
Date: Mon, 11 Dec 2017 12:25:27 +0100
Message-ID: <dd092e72-dc8a-7847-ae4d-aaa65fe6b3d7@enneenne.com>
References: <20171211111022.30333-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpcmd0873.aruba.it ([62.149.156.73]:58302 "EHLO
        smtpcmd0873.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLKLci (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Dec 2017 06:32:38 -0500
In-Reply-To: <20171211111022.30333-1-adrian.fiergolski@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
Cc: peda@axentia.se, giometti@linux.it

On 11/12/17 12:10, Adrian Fiergolski wrote:
> This patch exetends the current i2c-mux-pca954x driver and adds suuport for
> a newer PCA984x family of the I2C switches and multiplexers from NXP.
> In probe function, the patch supports device ID function, introduced in the
> new family, and checks it against configuration provided by the
> devicetree. Moreover, it also performs software reset which is now
> available for the new devices.
> The reset of the code remains common with the legacy PCA954x devices.
> 
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
> ---
>   .../{i2c-mux-pca954x.txt => i2c-mux-pca9x4x.txt}   |   5 +-
>   arch/arm/configs/aspeed_g4_defconfig               |   2 +-
>   arch/arm/configs/aspeed_g5_defconfig               |   2 +-
>   arch/arm/configs/multi_v7_defconfig                |   2 +-
>   arch/arm/configs/pxa_defconfig                     |   2 +-
>   arch/arm/configs/tegra_defconfig                   |   2 +-
>   arch/arm64/configs/defconfig                       |   2 +-
>   arch/powerpc/configs/85xx-hw.config                |   2 +-
>   drivers/i2c/muxes/Kconfig                          |   6 +-
>   drivers/i2c/muxes/Makefile                         |   2 +-
>   drivers/i2c/muxes/i2c-mux-pca9541.c                |   4 +-
>   .../muxes/{i2c-mux-pca954x.c => i2c-mux-pca9x4x.c} | 295 ++++++++++++++++-----
>   .../linux/platform_data/{pca954x.h => pca9x4x.h}   |  15 +-
>   13 files changed, 246 insertions(+), 95 deletions(-)
>   rename Documentation/devicetree/bindings/i2c/{i2c-mux-pca954x.txt => i2c-mux-pca9x4x.txt} (91%)
>   rename drivers/i2c/muxes/{i2c-mux-pca954x.c => i2c-mux-pca9x4x.c} (56%)
>   rename include/linux/platform_data/{pca954x.h => pca9x4x.h} (80%)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
> similarity index 91%
> rename from Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> rename to Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
> index aa097045a10e..cf9a075ca1dd 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
> @@ -1,10 +1,11 @@
> -* NXP PCA954x I2C bus switch
> +* NXP PCA9x4x I2C bus switch
>   
>   Required Properties:
>   
>     - compatible: Must contain one of the following.
>       "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"
>   
>     - reg: The I2C address of the device.
>   
> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
> index d23b9d56a88b..a461ad3cf63d 100644
> --- a/arch/arm/configs/aspeed_g4_defconfig
> +++ b/arch/arm/configs/aspeed_g4_defconfig
> @@ -116,7 +116,7 @@ CONFIG_I2C=y
>   CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_MUX=y
>   CONFIG_I2C_MUX_PCA9541=y
> -CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_MUX_PCA9x4x=y

Nak.

I'm not sure you should break backward compatibility. You should keep the 
CONFIG_I2C_MUX_PCA954x configuration setting and the current name convention.

>   CONFIG_I2C_ASPEED=y
>   CONFIG_GPIOLIB=y
>   CONFIG_GPIO_SYSFS=y
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index c0ad7b82086b..5e71e889aeb1 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -118,7 +118,7 @@ CONFIG_I2C=y
>   CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_MUX=y
>   CONFIG_I2C_MUX_PCA9541=y
> -CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_MUX_PCA9x4x=y
>   CONFIG_I2C_ASPEED=y
>   CONFIG_GPIOLIB=y
>   CONFIG_GPIO_SYSFS=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 61509c4b769f..0a9b3ec54e2f 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -352,7 +352,7 @@ CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_DAVINCI=y
>   CONFIG_I2C_MUX=y
>   CONFIG_I2C_ARB_GPIO_CHALLENGE=m
> -CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_MUX_PCA9x4x=y
>   CONFIG_I2C_MUX_PINCTRL=y
>   CONFIG_I2C_DEMUX_PINCTRL=y
>   CONFIG_I2C_AT91=m
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index 830e817a028a..7b181af815d9 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -350,7 +350,7 @@ CONFIG_SERIAL_PXA=y
>   CONFIG_SERIAL_PXA_CONSOLE=y
>   CONFIG_HW_RANDOM=y
>   CONFIG_I2C_CHARDEV=m
> -CONFIG_I2C_MUX_PCA954x=m
> +CONFIG_I2C_MUX_PCA9x4x=m
>   CONFIG_I2C_MUX_PINCTRL=m
>   CONFIG_I2C_DESIGNWARE_PLATFORM=m
>   CONFIG_I2C_PXA_SLAVE=y
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index 6678f2929356..4c6efffe5659 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -128,7 +128,7 @@ CONFIG_SERIAL_TEGRA=y
>   # CONFIG_HW_RANDOM is not set
>   # CONFIG_I2C_COMPAT is not set
>   CONFIG_I2C_CHARDEV=y
> -CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_MUX_PCA9x4x=y
>   CONFIG_I2C_MUX_PINCTRL=y
>   CONFIG_I2C_TEGRA=y
>   CONFIG_SPI=y
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6356c6da34ea..9685367bd073 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -268,7 +268,7 @@ CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
>   CONFIG_VIRTIO_CONSOLE=y
>   CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_MUX=y
> -CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_MUX_PCA9x4x=y
>   CONFIG_I2C_BCM2835=m
>   CONFIG_I2C_DESIGNWARE_PLATFORM=y
>   CONFIG_I2C_IMX=y
> diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
> index c03d0fb16665..0772c249a287 100644
> --- a/arch/powerpc/configs/85xx-hw.config
> +++ b/arch/powerpc/configs/85xx-hw.config
> @@ -48,7 +48,7 @@ CONFIG_HID_SUNPLUS=y
>   CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_CPM=m
>   CONFIG_I2C_MPC=y
> -CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_MUX_PCA9x4x=y
>   CONFIG_I2C_MUX=y
>   CONFIG_I2C=y
>   CONFIG_IGB=y
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 0f5c8fc36625..0a35869020ea 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -63,11 +63,11 @@ config I2C_MUX_PCA9541
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called i2c-mux-pca9541.
>   
> -config I2C_MUX_PCA954x
> -	tristate "Philips PCA954x I2C Mux/switches"
> +config I2C_MUX_PCA9x4x
> +	tristate "Philips PCA9x4x I2C Mux/switches"
>   	depends on GPIOLIB || COMPILE_TEST
>   	help
> -	  If you say yes here you get support for the Philips PCA954x
> +	  If you say yes here you get support for the Philips PCA9x4x
>   	  I2C mux/switch devices.

Even here you should point out that the driver supports both PCA954x and PCA984x 
families... maybe you can write as follow:

If you say yes here you get support for the Philips PCA954x and  PCA984x I2C 
mux/switch devices.

>   	  This driver can also be built as a module.  If so, the module
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 6d9d865e8518..a87c9adc5671 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_I2C_MUX_GPMUX)	+= i2c-mux-gpmux.o
>   obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
>   obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
>   obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
> -obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
> +obj-$(CONFIG_I2C_MUX_PCA9x4x)	+= i2c-mux-pca9x4x.o
>   obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
>   obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
>   
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 6a39adaf433f..0eb84deef566 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -22,7 +22,7 @@
>   #include <linux/i2c-mux.h>
>   #include <linux/jiffies.h>
>   #include <linux/module.h>
> -#include <linux/platform_data/pca954x.h>
> +#include <linux/platform_data/pca9x4x.h>
>   #include <linux/slab.h>
>   
>   /*
> @@ -334,7 +334,7 @@ static int pca9541_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
>   	struct i2c_adapter *adap = client->adapter;
> -	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct pca9x4x_platform_data *pdata = dev_get_platdata(&client->dev);
>   	struct i2c_mux_core *muxc;
>   	struct pca9541 *data;
>   	int force;
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca9x4x.c
> similarity index 56%
> rename from drivers/i2c/muxes/i2c-mux-pca954x.c
> rename to drivers/i2c/muxes/i2c-mux-pca9x4x.c
> index 2ca068d8b92d..14ef7cfca751 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9x4x.c
> @@ -1,14 +1,16 @@
>   /*
>    * I2C multiplexer
>    *
> + * Copyright (c) 2017 Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
>    * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
>    * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
>    *
> - * This module supports the PCA954x series of I2C multiplexer/switch chips
> + * This module supports the Pca9x4x series of I2C multiplexer/switch chips
>    * made by Philips Semiconductors.
>    * This includes the:
>    *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
>    *	 and PCA9548.
> + *       PCA9846, PCA9847, PCA9848 and PCA9849
>    *
>    * These chips are all controlled via the I2C bus itself, and all have a
>    * single 8-bit register. The upstream "parent" bus fans out to two,
> @@ -45,14 +47,20 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/of_irq.h>
> -#include <linux/platform_data/pca954x.h>
> +#include <linux/platform_data/pca9x4x.h>
>   #include <linux/pm.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   
> -#define PCA954X_MAX_NCHANS 8
> +#define PCA9X4X_MAX_NCHANS 8
>   
> -#define PCA954X_IRQ_OFFSET 4
> +#define PCA9X4X_IRQ_OFFSET 4
> +
> +//PCA984x family I2C other addresses
> +#define GENERAL_CALL  0x00
> +#define SOFTWARE_RESET 0x06
> +#define DEVICE_ID_ADDRESS 0x7C
> +#define NXP_ID 0x00
>   
>   enum pca_type {
>   	pca_9540,
> @@ -63,6 +71,12 @@ enum pca_type {
>   	pca_9546,
>   	pca_9547,
>   	pca_9548,
> +

Why is a blank line here?

> +	pca_9846,
> +	pca_9847,
> +	pca_9848,
> +	pca_9849,
> +
>   };
>   
>   struct chip_desc {
> @@ -70,12 +84,13 @@ struct chip_desc {
>   	u8 enable;	/* used for muxes only */
>   	u8 has_irq;
>   	enum muxtype {
> -		pca954x_ismux = 0,
> -		pca954x_isswi
> +		pca9x4x_ismux = 0,
> +		pca9x4x_isswi
>   	} muxtype;
> +	u16 deviceID; //used by PCA984x family only
>   };
>   
> -struct pca954x {
> +struct pca9x4x {
>   	const struct chip_desc *chip;
>   
>   	u8 last_chan;		/* last register value */
> @@ -87,51 +102,79 @@ struct pca954x {
>   	raw_spinlock_t lock;
>   };
>   
> -/* Provide specs for the PCA954x types we know about */
> +/* Provide specs for the PCA9x4x types we know about */
>   static const struct chip_desc chips[] = {
> +	//954x family
>   	[pca_9540] = {
>   		.nchans = 2,
>   		.enable = 0x4,
> -		.muxtype = pca954x_ismux,
> +		.muxtype = pca9x4x_ismux,
>   	},
>   	[pca_9542] = {
>   		.nchans = 2,
>   		.enable = 0x4,
>   		.has_irq = 1,
> -		.muxtype = pca954x_ismux,
> +		.muxtype = pca9x4x_ismux,
>   	},
>   	[pca_9543] = {
>   		.nchans = 2,
>   		.has_irq = 1,
> -		.muxtype = pca954x_isswi,
> +		.muxtype = pca9x4x_isswi,
>   	},
>   	[pca_9544] = {
>   		.nchans = 4,
>   		.enable = 0x4,
>   		.has_irq = 1,
> -		.muxtype = pca954x_ismux,
> +		.muxtype = pca9x4x_ismux,
>   	},
>   	[pca_9545] = {
>   		.nchans = 4,
>   		.has_irq = 1,
> -		.muxtype = pca954x_isswi,
> +		.muxtype = pca9x4x_isswi,
>   	},
>   	[pca_9546] = {
>   		.nchans = 4,
> -		.muxtype = pca954x_isswi,
> +		.muxtype = pca9x4x_isswi,
>   	},
>   	[pca_9547] = {
>   		.nchans = 8,
>   		.enable = 0x8,
> -		.muxtype = pca954x_ismux,
> +		.muxtype = pca9x4x_ismux,
>   	},
>   	[pca_9548] = {
>   		.nchans = 8,
> -		.muxtype = pca954x_isswi,
> +		.muxtype = pca9x4x_isswi,
> +	},
> +
> +	//984x family
> +	[pca_9846] = {
> +		.nchans = 4,
> +		.muxtype = pca9x4x_isswi,
> +		.deviceID = 0x10B,
> +	},
> +
> +	[pca_9847] = {
> +		.nchans = 8,
> +		.muxtype = pca9x4x_ismux,
> +		.deviceID = 0x108,
>   	},
> +
> +	[pca_9848] = {
> +		.nchans = 8,
> +		.muxtype = pca9x4x_isswi,
> +		.deviceID = 0x10A,
> +	},
> +
> +	[pca_9849] = {
> +		.nchans = 4,
> +		.muxtype = pca9x4x_ismux,
> +		.deviceID = 0x109,
> +	},
> +
>   };
>   
> -static const struct i2c_device_id pca954x_id[] = {
> +static const struct i2c_device_id pca9x4x_id[] = {
> +	//954x family
>   	{ "pca9540", pca_9540 },
>   	{ "pca9542", pca_9542 },
>   	{ "pca9543", pca_9543 },
> @@ -140,12 +183,20 @@ static const struct i2c_device_id pca954x_id[] = {
>   	{ "pca9546", pca_9546 },
>   	{ "pca9547", pca_9547 },
>   	{ "pca9548", pca_9548 },
> +
> +	//984x family
> +	{ "pca9846", pca_9846 },
> +	{ "pca9847", pca_9847 },
> +	{ "pca9848", pca_9848 },
> +	{ "pca9849", pca_9849 },
> +
>   	{ }
>   };
> -MODULE_DEVICE_TABLE(i2c, pca954x_id);
> +MODULE_DEVICE_TABLE(i2c, pca9x4x_id);
>   
>   #ifdef CONFIG_OF
> -static const struct of_device_id pca954x_of_match[] = {
> +static const struct of_device_id pca9x4x_of_match[] = {
> +	//954x family
>   	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
>   	{ .compatible = "nxp,pca9542", .data = &chips[pca_9542] },
>   	{ .compatible = "nxp,pca9543", .data = &chips[pca_9543] },
> @@ -154,14 +205,22 @@ static const struct of_device_id pca954x_of_match[] = {
>   	{ .compatible = "nxp,pca9546", .data = &chips[pca_9546] },
>   	{ .compatible = "nxp,pca9547", .data = &chips[pca_9547] },
>   	{ .compatible = "nxp,pca9548", .data = &chips[pca_9548] },
> +
> +
> +	//984x family
> +	{ .compatible = "nxp,pca9846", .data = &chips[pca_9846] },
> +	{ .compatible = "nxp,pca9847", .data = &chips[pca_9847] },
> +	{ .compatible = "nxp,pca9848", .data = &chips[pca_9848] },
> +	{ .compatible = "nxp,pca9849", .data = &chips[pca_9849] },
> +
>   	{}
>   };
> -MODULE_DEVICE_TABLE(of, pca954x_of_match);
> +MODULE_DEVICE_TABLE(of, pca9x4x_of_match);
>   #endif
>   
>   /* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
>      for this as they will try to lock adapter a second time */
> -static int pca954x_reg_write(struct i2c_adapter *adap,
> +static int pca9x4x_reg_write(struct i2c_adapter *adap,
>   			     struct i2c_client *client, u8 val)
>   {
>   	int ret = -ENODEV;
> @@ -190,32 +249,32 @@ static int pca954x_reg_write(struct i2c_adapter *adap,
>   	return ret;
>   }
>   
> -static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
> +static int pca9x4x_select_chan(struct i2c_mux_core *muxc, u32 chan)
>   {
> -	struct pca954x *data = i2c_mux_priv(muxc);
> +	struct pca9x4x *data = i2c_mux_priv(muxc);
>   	struct i2c_client *client = data->client;
>   	const struct chip_desc *chip = data->chip;
>   	u8 regval;
>   	int ret = 0;
>   
>   	/* we make switches look like muxes, not sure how to be smarter */
> -	if (chip->muxtype == pca954x_ismux)
> +	if (chip->muxtype == pca9x4x_ismux)
>   		regval = chan | chip->enable;
>   	else
>   		regval = 1 << chan;
>   
>   	/* Only select the channel if its different from the last channel */
>   	if (data->last_chan != regval) {
> -		ret = pca954x_reg_write(muxc->parent, client, regval);
> +		ret = pca9x4x_reg_write(muxc->parent, client, regval);
>   		data->last_chan = ret < 0 ? 0 : regval;
>   	}
>   
>   	return ret;
>   }
>   
> -static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
> +static int pca9x4x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
>   {
> -	struct pca954x *data = i2c_mux_priv(muxc);
> +	struct pca9x4x *data = i2c_mux_priv(muxc);
>   	struct i2c_client *client = data->client;
>   
>   	if (!(data->deselect & (1 << chan)))
> @@ -223,12 +282,12 @@ static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
>   
>   	/* Deselect active channel */
>   	data->last_chan = 0;
> -	return pca954x_reg_write(muxc->parent, client, data->last_chan);
> +	return pca9x4x_reg_write(muxc->parent, client, data->last_chan);
>   }
>   
> -static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
> +static irqreturn_t pca9x4x_irq_handler(int irq, void *dev_id)
>   {
> -	struct pca954x *data = dev_id;
> +	struct pca9x4x *data = dev_id;
>   	unsigned int child_irq;
>   	int ret, i, handled = 0;
>   
> @@ -237,7 +296,7 @@ static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
>   		return IRQ_NONE;
>   
>   	for (i = 0; i < data->chip->nchans; i++) {
> -		if (ret & BIT(PCA954X_IRQ_OFFSET + i)) {
> +		if (ret & BIT(PCA9X4X_IRQ_OFFSET + i)) {
>   			child_irq = irq_linear_revmap(data->irq, i);
>   			handle_nested_irq(child_irq);
>   			handled++;
> @@ -246,21 +305,21 @@ static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
>   	return handled ? IRQ_HANDLED : IRQ_NONE;
>   }
>   
> -static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
> +static int pca9x4x_irq_set_type(struct irq_data *idata, unsigned int type)
>   {
>   	if ((type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_LOW)
>   		return -EINVAL;
>   	return 0;
>   }
>   
> -static struct irq_chip pca954x_irq_chip = {
> -	.name = "i2c-mux-pca954x",
> -	.irq_set_type = pca954x_irq_set_type,
> +static struct irq_chip pca9x4x_irq_chip = {
> +	.name = "i2c-mux-pca9x4x",
> +	.irq_set_type = pca9x4x_irq_set_type,
>   };
>   
> -static int pca954x_irq_setup(struct i2c_mux_core *muxc)
> +static int pca9x4x_irq_setup(struct i2c_mux_core *muxc)
>   {
> -	struct pca954x *data = i2c_mux_priv(muxc);
> +	struct pca9x4x *data = i2c_mux_priv(muxc);
>   	struct i2c_client *client = data->client;
>   	int c, irq;
>   
> @@ -282,16 +341,16 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>   			return -EINVAL;
>   		}
>   		irq_set_chip_data(irq, data);
> -		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
> -			handle_simple_irq);
> +		irq_set_chip_and_handler(irq, &pca9x4x_irq_chip,
> +					 handle_simple_irq);
>   	}
>   
>   	return 0;
>   }
>   
> -static void pca954x_cleanup(struct i2c_mux_core *muxc)
> +static void pca9x4x_cleanup(struct i2c_mux_core *muxc)
>   {
> -	struct pca954x *data = i2c_mux_priv(muxc);
> +	struct pca9x4x *data = i2c_mux_priv(muxc);
>   	int c, irq;
>   
>   	if (data->irq) {
> @@ -304,20 +363,92 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
>   	i2c_mux_del_adapters(muxc);
>   }
>   
> +/*
> + * Part of probe function specific for pca954x family
> + */
> +inline int pca954x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id){
> +
> +	/* Write the mux register at addr to verify
> +	 * that the mux is in fact present. This also
> +	 * initializes the mux to disconnected state.
> +	 */
> +	if (i2c_smbus_write_byte(client, 0) < 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Part of probe function specific for pca984x family
> + */
> +inline int pca984x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id){
> +
> +	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> +	union i2c_smbus_data device_id_raw;
> +	u16 manufacturer_id; //12 bits
> +
> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
> +		dev_warn(&client->dev, "PCA9846 family: I2c adapter doesn't support I2C_FUNC_SMBUS_WRITE_BYTE_DATA");
> +		return -ENODEV;
> +	}
> +
> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		dev_warn(&client->dev, "PCA9846 family: I2c adapter doesn't support I2C_FUNC_SMBUS_READ_I2C_BLOCK");
> +		return -ENODEV;
> +	}
> +
> +	//
> +	//Software reset
> +	//

I'm not sure you can use "//" for comments...

> +	if (i2c_smbus_xfer(client->adapter, GENERAL_CALL, client->flags,
> +			   I2C_SMBUS_WRITE, SOFTWARE_RESET, I2C_SMBUS_BYTE, NULL)  < 0) {
> +		dev_warn(&client->dev, "PCA9846 family: Sofrware reset failed\n");
> +		return -ENODEV;
> +	}
> +
> +	//
> +	//Get device ID
> +	//
> +	device_id_raw.block[0] = 3;  //read 3 bytes
> +	if (i2c_smbus_xfer(client->adapter, DEVICE_ID_ADDRESS, client->flags,
> +			   I2C_SMBUS_READ,  client->addr << 1,
> +			   I2C_SMBUS_I2C_BLOCK_DATA, &device_id_raw)) {
> +		dev_warn(&client->dev, "PCA9846 family: Get device ID failed\n");
> +		return -ENODEV;
> +	}
> +
> +	//Device ID contains only 3 bytes
> +	if (device_id_raw.block[0] != 3) {
> +		dev_warn(&client->dev, "PCA9846 family: Get device ID failed\n");
> +		return -ENODEV;
> +	}
> +
> +	//Check manufacturer ID (12 bits)
> +	manufacturer_id = ((u16) device_id_raw.block[1] << 4) | (device_id_raw.block[2] >> 4);
> +	if (manufacturer_id != NXP_ID) {
> +		dev_warn(&client->dev, "PCA9846 family: Manufacturer ID does not match NXP\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * I2C init/probing/exit functions
>    */
> -static int pca954x_probe(struct i2c_client *client,
> +static int pca9x4x_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
>   	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> -	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct pca9x4x_platform_data *pdata = dev_get_platdata(&client->dev);
>   	struct device_node *of_node = client->dev.of_node;
>   	bool idle_disconnect_dt;
>   	struct gpio_desc *gpio;
>   	int num, force, class;
>   	struct i2c_mux_core *muxc;
> -	struct pca954x *data;
> +	struct pca9x4x *data;
>   	const struct of_device_id *match;
>   	int ret;
>   
> @@ -325,8 +456,8 @@ static int pca954x_probe(struct i2c_client *client,
>   		return -ENODEV;
>   
>   	muxc = i2c_mux_alloc(adap, &client->dev,
> -			     PCA954X_MAX_NCHANS, sizeof(*data), 0,
> -			     pca954x_select_chan, pca954x_deselect_mux);
> +			     PCA9X4X_MAX_NCHANS, sizeof(*data), 0,
> +			     pca9x4x_select_chan, pca9x4x_deselect_mux);
>   	if (!muxc)
>   		return -ENOMEM;
>   	data = i2c_mux_priv(muxc);
> @@ -339,16 +470,34 @@ static int pca954x_probe(struct i2c_client *client,
>   	if (IS_ERR(gpio))
>   		return PTR_ERR(gpio);
>   
> -	/* Write the mux register at addr to verify
> -	 * that the mux is in fact present. This also
> -	 * initializes the mux to disconnected state.
> -	 */
> -	if (i2c_smbus_write_byte(client, 0) < 0) {
> +	switch (id->driver_data) {
> +	case pca_9540:
> +	case pca_9542:
> +	case pca_9543:
> +	case pca_9544:
> +	case pca_9545:
> +	case pca_9546:
> +	case pca_9547:
> +	case pca_9548:
> +		ret = pca954x_probe(client, id);
> +		break;
> +	case pca_9846:
> +	case pca_9847:
> +	case pca_9848:
> +	case pca_9849:
> +		ret = pca984x_probe(client, id);
> +		break;
> +	default: //unknown device
> +		ret = -ENODEV;
> +		break;
> +	}
> +
> +	if (ret < 0) {
>   		dev_warn(&client->dev, "probe failed\n");
>   		return -ENODEV;
>   	}
>   
> -	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
> +	match = of_match_device(of_match_ptr(pca9x4x_of_match), &client->dev);
>   	if (match)
>   		data->chip = of_device_get_match_data(&client->dev);
>   	else
> @@ -359,7 +508,7 @@ static int pca954x_probe(struct i2c_client *client,
>   	idle_disconnect_dt = of_node &&
>   		of_property_read_bool(of_node, "i2c-mux-idle-disconnect");
>   
> -	ret = pca954x_irq_setup(muxc);
> +	ret = pca9x4x_irq_setup(muxc);
>   	if (ret)
>   		goto fail_cleanup;
>   
> @@ -389,60 +538,60 @@ static int pca954x_probe(struct i2c_client *client,
>   
>   	if (data->irq) {
>   		ret = devm_request_threaded_irq(&client->dev, data->client->irq,
> -						NULL, pca954x_irq_handler,
> +						NULL, pca9x4x_irq_handler,
>   						IRQF_ONESHOT | IRQF_SHARED,
> -						"pca954x", data);
> +						"pca9x4x", data);
>   		if (ret)
>   			goto fail_cleanup;
>   	}
>   
>   	dev_info(&client->dev,
>   		 "registered %d multiplexed busses for I2C %s %s\n",
> -		 num, data->chip->muxtype == pca954x_ismux
> -				? "mux" : "switch", client->name);
> +		 num, data->chip->muxtype == pca9x4x_ismux
> +		 ? "mux" : "switch", client->name);
>   
>   	return 0;
>   
>   fail_cleanup:
> -	pca954x_cleanup(muxc);
> +	pca9x4x_cleanup(muxc);
>   	return ret;
>   }
>   
> -static int pca954x_remove(struct i2c_client *client)
> +static int pca9x4x_remove(struct i2c_client *client)
>   {
>   	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>   
> -	pca954x_cleanup(muxc);
> +	pca9x4x_cleanup(muxc);
>   	return 0;
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> -static int pca954x_resume(struct device *dev)
> +static int pca9x4x_resume(struct device *dev)
>   {
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> -	struct pca954x *data = i2c_mux_priv(muxc);
> +	struct pca9x4x *data = i2c_mux_priv(muxc);
>   
>   	data->last_chan = 0;
>   	return i2c_smbus_write_byte(client, 0);
>   }
>   #endif
>   
> -static SIMPLE_DEV_PM_OPS(pca954x_pm, NULL, pca954x_resume);
> +static SIMPLE_DEV_PM_OPS(pca9x4x_pm, NULL, pca9x4x_resume);
>   
> -static struct i2c_driver pca954x_driver = {
> +static struct i2c_driver pca9x4x_driver = {
>   	.driver		= {
> -		.name	= "pca954x",
> -		.pm	= &pca954x_pm,
> -		.of_match_table = of_match_ptr(pca954x_of_match),
> +		.name	= "pca9x4x",
> +		.pm	= &pca9x4x_pm,
> +		.of_match_table = of_match_ptr(pca9x4x_of_match),
>   	},
> -	.probe		= pca954x_probe,
> -	.remove		= pca954x_remove,
> -	.id_table	= pca954x_id,
> +	.probe		= pca9x4x_probe,
> +	.remove		= pca9x4x_remove,
> +	.id_table	= pca9x4x_id,
>   };
>   
> -module_i2c_driver(pca954x_driver);
> +module_i2c_driver(pca9x4x_driver);
>   
> -MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
> -MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
> +MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>, Adrian Fiergolski <Adrian.Fiergolski@cern.ch>");
> +MODULE_DESCRIPTION("PCA9x4x I2C mux/switch driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/pca954x.h b/include/linux/platform_data/pca9x4x.h
> similarity index 80%
> rename from include/linux/platform_data/pca954x.h
> rename to include/linux/platform_data/pca9x4x.h
> index 1712677d5904..a33c5afbfd7f 100644
> --- a/include/linux/platform_data/pca954x.h
> +++ b/include/linux/platform_data/pca9x4x.h
> @@ -2,6 +2,7 @@
>    *
>    * pca954x.h - I2C multiplexer/switch support
>    *
> + * Copyright (c) 2017 Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
>    * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
>    * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
>    * Michael Lawnick <michael.lawnick.ext@nsn.com>
> @@ -22,10 +23,10 @@
>    */
>   
>   
> -#ifndef _LINUX_I2C_PCA954X_H
> -#define _LINUX_I2C_PCA954X_H
> +#ifndef _LINUX_I2C_PCA9X4X_H
> +#define _LINUX_I2C_PCA9X4X_H
>   
> -/* Platform data for the PCA954x I2C multiplexers */
> +/* Platform data for the PCA9x4x I2C multiplexers */
>   
>   /* Per channel initialisation data:
>    * @adap_id: bus number for the adapter. 0 = don't care
> @@ -33,16 +34,16 @@
>    *                    of this channel after transaction.
>    *
>    */
> -struct pca954x_platform_mode {
> +struct pca9x4x_platform_mode {
>   	int		adap_id;
>   	unsigned int	deselect_on_exit:1;
>   	unsigned int	class;
>   };
>   
>   /* Per mux/switch data, used with i2c_register_board_info */
> -struct pca954x_platform_data {
> -	struct pca954x_platform_mode *modes;
> +struct pca9x4x_platform_data {
> +	struct pca9x4x_platform_mode *modes;
>   	int num_modes;
>   };
>   
> -#endif /* _LINUX_I2C_PCA954X_H */
> +#endif /* _LINUX_I2C_PCA9X4X_H */
> 


-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
