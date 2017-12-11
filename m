From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Mon, 11 Dec 2017 20:14:45 +0100
Message-ID: <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:43200
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752512AbdLKTOw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 11 Dec 2017 14:14:52 -0500
In-Reply-To: <20171211165811.5806-1-adrian.fiergolski@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
Cc: giometti@enneenne.com, giometti@linux.it

On 2017-12-11 17:58, Adrian Fiergolski wrote:
> This patch exetends the current i2c-mux-pca954x driver and adds suuport for

support

> a newer PCA984x family of the I2C switches and multiplexers from NXP.
> In probe function, the patch supports device ID function, introduced in the
> new family, and checks it against configuration provided by the
> devicetree. Moreover, it also performs software reset which is now
> available for the new devices.
> The reset of the code remains common with the legacy PCA954x devices.
> 
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
> ---
> Apply Peter's and Rodolfo's comments.
> Add missing part in pca984x_family_probe which checks deviceID.
> 
> Peter addressing your main comments:
> 
>  Quoting the PCA9848 manual: "The Software Reset Call allows all the devices in
>  the I2C-bus to be reset to the power-up state value through a specific formatted
>  I2C-bus command. To be performed correctly, it implies that the I2C-bus is
>  functional and that there is no device hanging the bus."
>  This call should reset the multiplexer and all devices which are below it in the
>  I2C address space tree to the default state.

Yes, I read all that in the datasheet, but why do *you* need it? Because
it is wrong to do it in this driver. It is doubly wrong to do it
unconditionally. I was asking so that I could help you find a solution
for your problem, because it is simply not acceptable to add a bus-wide
reset to a random driver.

> 
>  The manufacturer ID and device ID checks in pca984x_family_probe ensures that
>  we actually communicate with a device we intended to (according to the
>  devicetree) and that communication with this device works properly (this device
>  ID and manufacturer ID can be seen as a fixed pattern).

Yes yes yes, but do you actually need it? Because it complicates the driver
for little gain (in my opinion).

>  .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |   5 +-
>  drivers/i2c/muxes/Kconfig                          |   2 +-
>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 157 +++++++++++++++++++--
>  3 files changed, 153 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index aa097045a10e..b428bc0d81b1 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -1,10 +1,13 @@
>  * NXP PCA954x I2C bus switch
>  
> +The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
> +
>  Required Properties:
>  
>    - compatible: Must contain one of the following.
>      "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"
>  
>    - reg: The I2C address of the device.
>  
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 0f5c8fc36625..5da2e04585a9 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -68,7 +68,7 @@ config I2C_MUX_PCA954x
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  If you say yes here you get support for the Philips PCA954x
> -	  I2C mux/switch devices.
> +	  and PCA984x I2C mux/switch devices.

lets update Philips to NXP while at it.

>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mux-pca954x.
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 2ca068d8b92d..6205ae52aa4d 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -1,14 +1,15 @@
>  /*
>   * I2C multiplexer
>   *
> + * Copyright (c) 2017 Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
>   * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
>   * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
>   *
> - * This module supports the PCA954x series of I2C multiplexer/switch chips
> - * made by Philips Semiconductors.
> + * This module supports the PCA954x and PCA954x series of I2C multiplexer/switch
> + * chips made by Philips Semiconductors.

NXP.

>   * This includes the:
> - *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
> - *	 and PCA9548.
> + *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547,
> + *	 PCA9548, PCA9846, PCA9847, PCA9848 and PCA9849
>   *
>   * These chips are all controlled via the I2C bus itself, and all have a
>   * single 8-bit register. The upstream "parent" bus fans out to two,
> @@ -54,6 +55,12 @@
>  
>  #define PCA954X_IRQ_OFFSET 4
>  
> +/* PCA984x family I2C other addresses */
> +#define GENERAL_CALL  0x00
> +#define SOFTWARE_RESET 0x06
> +#define DEVICE_ID_ADDRESS 0x7C
> +#define NXP_ID 0x00
> +
>  enum pca_type {
>  	pca_9540,
>  	pca_9542,
> @@ -63,6 +70,10 @@ enum pca_type {
>  	pca_9546,
>  	pca_9547,
>  	pca_9548,
> +	pca_9846,
> +	pca_9847,
> +	pca_9848,
> +	pca_9849,
>  };
>  
>  struct chip_desc {
> @@ -73,6 +84,7 @@ struct chip_desc {
>  		pca954x_ismux = 0,
>  		pca954x_isswi
>  	} muxtype;
> +	u16 deviceID; /* used by PCA984x family only */

Please name it device_id, if you insist on keeping it.

>  };
>  
>  struct pca954x {
> @@ -129,6 +141,29 @@ static const struct chip_desc chips[] = {
>  		.nchans = 8,
>  		.muxtype = pca954x_isswi,
>  	},
> +	[pca_9846] = {
> +		.nchans = 4,
> +		.muxtype = pca954x_isswi,
> +		.deviceID = 0x10B,
> +	},
> +

As requested for v2, please drop these empty lines, the blocks above the
hunk don't have them. Let's keep things consistent.

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
>  };
>  
>  static const struct i2c_device_id pca954x_id[] = {
> @@ -140,6 +175,10 @@ static const struct i2c_device_id pca954x_id[] = {
>  	{ "pca9546", pca_9546 },
>  	{ "pca9547", pca_9547 },
>  	{ "pca9548", pca_9548 },
> +	{ "pca9846", pca_9846 },
> +	{ "pca9847", pca_9847 },
> +	{ "pca9848", pca_9848 },
> +	{ "pca9849", pca_9849 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, pca954x_id);
> @@ -154,6 +193,10 @@ static const struct of_device_id pca954x_of_match[] = {
>  	{ .compatible = "nxp,pca9546", .data = &chips[pca_9546] },
>  	{ .compatible = "nxp,pca9547", .data = &chips[pca_9547] },
>  	{ .compatible = "nxp,pca9548", .data = &chips[pca_9548] },
> +	{ .compatible = "nxp,pca9846", .data = &chips[pca_9846] },
> +	{ .compatible = "nxp,pca9847", .data = &chips[pca_9847] },
> +	{ .compatible = "nxp,pca9848", .data = &chips[pca_9848] },
> +	{ .compatible = "nxp,pca9849", .data = &chips[pca_9849] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, pca954x_of_match);
> @@ -304,6 +347,83 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
>  	i2c_mux_del_adapters(muxc);
>  }
>  
> +/*
> + * Part of probe function specific for pca954x family
> + */
> +static int pca954x_family_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +

Drop the blank line.

> +	/* Write the mux register at addr to verify
> +	 * that the mux is in fact present. This also
> +	 * initializes the mux to disconnected state.
> +	 */

/*
 * Use this comment style for all multiline comments that you write
 * in the kernel source.
 */

I realize that you just copied this one, but let's clean it up while
at it.

> +	if (i2c_smbus_write_byte(client, 0) < 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Part of probe function specific for pca984x family
> + */
> +static int pca984x_family_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)

Ok, you seem determined to keep the device/manufacturer check. In
that case, it is odd to have functions that does not follow the
driver prefix rule.

So, please rename this one to e.g. pca954x_pca984x_probe and the
one above to pca954x_default_probe. Or something such.

> +{
> +	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> +	union i2c_smbus_data device_id_raw;
> +	u16 manufacturer_id; /* 12 bits */
> +	u16 device_id;       /* 9 bits */
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
> +	/* Software reset */
> +	if (i2c_smbus_xfer(client->adapter, GENERAL_CALL, client->flags,
> +			   I2C_SMBUS_WRITE, SOFTWARE_RESET, I2C_SMBUS_BYTE, NULL)  < 0) {
> +		dev_warn(&client->dev, "PCA9846 family: Sofrware reset failed\n");
> +		return -ENODEV;
> +	}

As stated above, this just has to go.

> +
> +	/* Get device ID */
> +	device_id_raw.block[0] = 3;  /* read 3 bytes */
> +	if (i2c_smbus_xfer(client->adapter, DEVICE_ID_ADDRESS, client->flags,
> +			   I2C_SMBUS_READ,  client->addr << 1,
> +			   I2C_SMBUS_I2C_BLOCK_DATA, &device_id_raw)) {

Whooa, I managed to miss this last time... Why are you not using the
i2c_smbus_read_i2c_block_data helper? (and even if you have some good
reason to open-code this, you seem to have some seriously confused
arguments, so if those are indeed correct you need to document what
the hell is going on)

> +		dev_warn(&client->dev, "PCA9846 family: Get device ID failed\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Device ID contains only 3 bytes */
> +	if (device_id_raw.block[0] != 3) {
> +		dev_warn(&client->dev, "PCA9846 family: Get device ID failed\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Check manufacturer ID (12 bits) */
> +	manufacturer_id = ((u16) device_id_raw.block[1] << 4) | (device_id_raw.block[2] >> 4);

This assignment is still broken...

> +	if (manufacturer_id != NXP_ID) {
> +		dev_warn(&client->dev, "PCA9846 family: Manufacturer ID does not match NXP\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Check device ID (9 bits) */
> +	device_id = ((u16) device_id_raw.block[2] << 5) | (device_id_raw.block[3] >> 3);

...and this is also broken.

> +	if (device_id != chips[id->driver_data].deviceID) {
> +		dev_warn(&client->dev, "PCA9846 family: Device ID does not match %s\n", id->name);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * I2C init/probing/exit functions
>   */
> @@ -339,11 +459,29 @@ static int pca954x_probe(struct i2c_client *client,
>  	if (IS_ERR(gpio))
>  		return PTR_ERR(gpio);
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

Please drop these and do the 954x probe in default.

> +		ret = pca954x_family_probe(client, id);
> +		break;
> +	case pca_9846:
> +	case pca_9847:
> +	case pca_9848:
> +	case pca_9849:
> +		ret = pca984x_family_probe(client, id);
> +		break;
> +	default: /* unknown device */
> +		ret = -ENODEV;
> +		break;
> +	}
> +
> +	if (ret < 0) {
>  		dev_warn(&client->dev, "probe failed\n");
>  		return -ENODEV;

return ret;

Cheers,
Peter

>  	}
> @@ -443,6 +581,7 @@ static struct i2c_driver pca954x_driver = {
>  
>  module_i2c_driver(pca954x_driver);
>  
> +MODULE_AUTHOR("Adrian Fiergolski <Adrian.Fiergolski@cern.ch>");
>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>  MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
>  MODULE_LICENSE("GPL v2");
> 
