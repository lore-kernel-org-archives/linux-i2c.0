From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH v2] i2c: Add support for NXP PCA984x family.
Date: Mon, 11 Dec 2017 16:07:34 +0100
Message-ID: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
References: <f2bd4153-871f-0f71-2825-6225f0ec19d5@enneenne.com>
 <20171211142716.30340-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpweb130.aruba.it ([62.149.158.130]:41905 "EHLO
        smtpweb130.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdLKPHh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Dec 2017 10:07:37 -0500
In-Reply-To: <20171211142716.30340-1-adrian.fiergolski@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
Cc: peda@axentia.se, giometti@linux.it

On 11/12/17 15:27, Adrian Fiergolski wrote:
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
>   .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |   5 +-
>   drivers/i2c/muxes/Kconfig                          |   2 +-
>   drivers/i2c/muxes/i2c-mux-pca954x.c                | 164 ++++++++++++++++++++-
>   3 files changed, 161 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index aa097045a10e..b428bc0d81b1 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -1,10 +1,13 @@
>   * NXP PCA954x I2C bus switch
>   
> +The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
> +
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
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 0f5c8fc36625..5da2e04585a9 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -68,7 +68,7 @@ config I2C_MUX_PCA954x
>   	depends on GPIOLIB || COMPILE_TEST
>   	help
>   	  If you say yes here you get support for the Philips PCA954x
> -	  I2C mux/switch devices.
> +	  and PCA984x I2C mux/switch devices.
>   
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called i2c-mux-pca954x.
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 2ca068d8b92d..88de57ae5b7a 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -1,14 +1,16 @@
>   /*
>    * I2C multiplexer
>    *
> + * Copyright (c) 2017 Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
>    * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
>    * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
>    *
> - * This module supports the PCA954x series of I2C multiplexer/switch chips
> - * made by Philips Semiconductors.
> + * This module supports the PCA954x and PCA954x series of I2C multiplexer/switch
> + * chips made by Philips Semiconductors.
>    * This includes the:
>    *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
>    *	 and PCA9548.
> + *       PCA9846, PCA9847, PCA9848 and PCA9849
>    *
>    * These chips are all controlled via the I2C bus itself, and all have a
>    * single 8-bit register. The upstream "parent" bus fans out to two,
> @@ -54,6 +56,12 @@
>   
>   #define PCA954X_IRQ_OFFSET 4
>   
> +//PCA984x family I2C other addresses

Use /* and */ for comments.

> +#define GENERAL_CALL  0x00
> +#define SOFTWARE_RESET 0x06
> +#define DEVICE_ID_ADDRESS 0x7C
> +#define NXP_ID 0x00
> +
>   enum pca_type {
>   	pca_9540,
>   	pca_9542,
> @@ -63,6 +71,11 @@ enum pca_type {
>   	pca_9546,
>   	pca_9547,
>   	pca_9548,
> +	pca_9846,
> +	pca_9847,
> +	pca_9848,
> +	pca_9849,
> +
>   };
>   
>   struct chip_desc {
> @@ -73,6 +86,7 @@ struct chip_desc {
>   		pca954x_ismux = 0,
>   		pca954x_isswi
>   	} muxtype;
> +	u16 deviceID; //used by PCA984x family only
>   };
>   
>   struct pca954x {
> @@ -89,6 +103,7 @@ struct pca954x {
>   
>   /* Provide specs for the PCA954x types we know about */
>   static const struct chip_desc chips[] = {
> +	//954x family
>   	[pca_9540] = {
>   		.nchans = 2,
>   		.enable = 0x4,
> @@ -129,9 +144,36 @@ static const struct chip_desc chips[] = {
>   		.nchans = 8,
>   		.muxtype = pca954x_isswi,
>   	},
> +
> +	//984x family
> +	[pca_9846] = {
> +		.nchans = 4,
> +		.muxtype = pca954x_isswi,
> +		.deviceID = 0x10B,
> +	},
> +
> +	[pca_9847] = {
> +		.nchans = 8,
> +		.muxtype = pca954x_ismux,
> +		.deviceID = 0x108,
> +	},
> +
> +	[pca_9848] = {
> +		.nchans = 8,
> +		.muxtype = pca954x_isswi,
> +		.deviceID = 0x10A,
> +	},
> +
> +	[pca_9849] = {
> +		.nchans = 4,
> +		.muxtype = pca954x_ismux,
> +		.deviceID = 0x109,
> +	},
> +
>   };
>   
>   static const struct i2c_device_id pca954x_id[] = {
> +	//954x family
>   	{ "pca9540", pca_9540 },
>   	{ "pca9542", pca_9542 },
>   	{ "pca9543", pca_9543 },
> @@ -140,12 +182,20 @@ static const struct i2c_device_id pca954x_id[] = {
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
>   MODULE_DEVICE_TABLE(i2c, pca954x_id);
>   
>   #ifdef CONFIG_OF
>   static const struct of_device_id pca954x_of_match[] = {
> +	//954x family
>   	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
>   	{ .compatible = "nxp,pca9542", .data = &chips[pca_9542] },
>   	{ .compatible = "nxp,pca9543", .data = &chips[pca_9543] },
> @@ -154,6 +204,14 @@ static const struct of_device_id pca954x_of_match[] = {
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
>   MODULE_DEVICE_TABLE(of, pca954x_of_match);
> @@ -304,6 +362,78 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
>   	i2c_mux_del_adapters(muxc);
>   }
>   
> +/*
> + * Part of probe function specific for pca954x family
> + */
> +inline int _pca954x_probe(struct i2c_client *client,
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
> +inline int _pca984x_probe(struct i2c_client *client,
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
> +	/*
> +	 * Software reset
> +	 */
> +	if (i2c_smbus_xfer(client->adapter, GENERAL_CALL, client->flags,
> +			   I2C_SMBUS_WRITE, SOFTWARE_RESET, I2C_SMBUS_BYTE, NULL)  < 0) {
> +		dev_warn(&client->dev, "PCA9846 family: Sofrware reset failed\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Get device ID
> +	 */
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
> @@ -339,11 +469,29 @@ static int pca954x_probe(struct i2c_client *client,
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
> +		ret = _pca954x_probe(client, id);
> +		break;
> +	case pca_9846:
> +	case pca_9847:
> +	case pca_9848:
> +	case pca_9849:
> +		ret = _pca984x_probe(client, id);
> +		break;
> +	default: //unknown device
> +		ret = -ENODEV;
> +		break;
> +	}

I dislike names starting with "_"... maybe you can use pca954x_family_probe() 
and pca984x_family_probe()? :-)

> +
> +	if (ret < 0) {
>   		dev_warn(&client->dev, "probe failed\n");
>   		return -ENODEV;
>   	}
> @@ -443,6 +591,6 @@ static struct i2c_driver pca954x_driver = {
>   
>   module_i2c_driver(pca954x_driver);
>   
> -MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
> +MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>, Adrian Fiergolski <Adrian.Fiergolski@cern.ch>");

Use multiple MODULE_AUTHOR() lines.

>   MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
>   MODULE_LICENSE("GPL v2");

Ciao,

Rodolfo

-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
