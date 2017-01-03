From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH linux 5/6] hwmon: occ: Add hwmon implementation for the
 P8 OCC
Date: Tue, 3 Jan 2017 16:45:16 -0600
Message-ID: <20170103224516.fqknlnicrwae7e6c@rob-hp-laptop>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
 <1483120568-21082-6-git-send-email-eajames.ibm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32899 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757877AbdACWpT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 17:45:19 -0500
Content-Disposition: inline
In-Reply-To: <1483120568-21082-6-git-send-email-eajames.ibm@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: eajames.ibm@gmail.com
Cc: linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net, mark.rutland@arm.com, wsa@the-dreams.de, andrew@aj.id.au, joel@jms.id.au, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Edward A. James" <eajames@us.ibm.com>

On Fri, Dec 30, 2016 at 11:56:07AM -0600, eajames.ibm@gmail.com wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
> 
> Add code to tie the hwmon sysfs code and the POWER8 OCC code together, as
> well as probe the entire driver from the I2C bus. I2C is the communication
> method between the BMC and the P8 OCC.
> 
> Signed-off-by: Edward A. James <eajames@us.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../devicetree/bindings/i2c/i2c-ibm-occ.txt        |  13 ++

bindings/i2c/ is generally for host controllers. bindings/hwmon perhaps.

>  drivers/hwmon/occ/Kconfig                          |  14 ++
>  drivers/hwmon/occ/Makefile                         |   1 +
>  drivers/hwmon/occ/p8_occ_i2c.c                     | 141 +++++++++++++++++++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-ibm-occ.txt
>  create mode 100644 drivers/hwmon/occ/p8_occ_i2c.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-ibm-occ.txt b/Documentation/devicetree/bindings/i2c/i2c-ibm-occ.txt
> new file mode 100644
> index 0000000..b0d2b36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-ibm-occ.txt
> @@ -0,0 +1,13 @@
> +HWMON I2C driver for IBM POWER CPU OCC (On Chip Controller)
> +
> +Required properties:
> + - compatible: must be "ibm,p8-occ-i2c"
> + - reg: physical address
> +
> +Example:
> +i2c3: i2c-bus@100 {
> +	occ@50 {
> +		compatible = "ibm,p8-occ-i2c";
> +		reg = <0x50>;
> +	};
> +};
> diff --git a/drivers/hwmon/occ/Kconfig b/drivers/hwmon/occ/Kconfig
> index cdb64a7..3a5188f 100644
> --- a/drivers/hwmon/occ/Kconfig
> +++ b/drivers/hwmon/occ/Kconfig
> @@ -13,3 +13,17 @@ menuconfig SENSORS_PPC_OCC
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called occ.
> +
> +if SENSORS_PPC_OCC
> +
> +config SENSORS_PPC_OCC_P8_I2C
> +	tristate "POWER8 OCC hwmon support"
> +	depends on I2C
> +	help
> +	 Provide a hwmon sysfs interface for the POWER8 On-Chip Controller,
> +	 exposing temperature, frequency and power measurements.
> +
> +	 This driver can also be built as a module. If so, the module will be
> +	 called p8-occ-i2c.
> +
> +endif
> diff --git a/drivers/hwmon/occ/Makefile b/drivers/hwmon/occ/Makefile
> index a6881f9..9294b58 100644
> --- a/drivers/hwmon/occ/Makefile
> +++ b/drivers/hwmon/occ/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_SENSORS_PPC_OCC) += occ.o occ_sysfs.o
> +obj-$(CONFIG_SENSORS_PPC_OCC_P8_I2C) += occ_scom_i2c.o occ_p8.o p8_occ_i2c.o
> diff --git a/drivers/hwmon/occ/p8_occ_i2c.c b/drivers/hwmon/occ/p8_occ_i2c.c
> new file mode 100644
> index 0000000..0c65894
> --- /dev/null
> +++ b/drivers/hwmon/occ/p8_occ_i2c.c
> @@ -0,0 +1,141 @@
> +/*
> + * p8_occ_i2c.c - hwmon OCC driver
> + *
> + * This file contains the i2c layer for accessing the P8 OCC over i2c bus.
> + *
> + * Copyright 2016 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +
> +#include "scom.h"
> +#include "occ_scom_i2c.h"
> +#include "occ_p8.h"
> +#include "occ_sysfs.h"
> +
> +#define P8_OCC_I2C_NAME	"p8-occ-i2c"
> +
> +static char *caps_sensor_names[] = {
> +	"curr_powercap",
> +	"curr_powerreading",
> +	"norm_powercap",
> +	"max_powercap",
> +	"min_powercap",
> +	"user_powerlimit"
> +};
> +
> +int p8_i2c_getscom(void *bus, u32 address, u64 *data)
> +{
> +	/* P8 i2c slave requires address to be shifted by 1 */
> +	address = address << 1;
> +
> +	return occ_i2c_getscom(bus, address, data);
> +}
> +
> +int p8_i2c_putscom(void *bus, u32 address, u32 data0, u32 data1)
> +{
> +	/* P8 i2c slave requires address to be shifted by 1 */
> +	address = address << 1;
> +
> +	return occ_i2c_putscom(bus, address, data0, data1);
> +}
> +
> +static struct occ_bus_ops p8_bus_ops = {
> +	.getscom = p8_i2c_getscom,
> +	.putscom = p8_i2c_putscom,
> +};
> +
> +static struct occ_sysfs_config p8_sysfs_config = {
> +	.num_caps_fields = ARRAY_SIZE(caps_sensor_names),
> +	.caps_names = caps_sensor_names,
> +};
> +
> +static int p8_occ_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct occ *occ;
> +	struct occ_sysfs *hwmon;
> +
> +	occ = p8_occ_start(&client->dev, client, &p8_bus_ops);
> +	if (IS_ERR(occ))
> +		return PTR_ERR(occ);
> +
> +	hwmon = occ_sysfs_start(&client->dev, occ, &p8_sysfs_config);
> +	if (IS_ERR(hwmon))
> +		return PTR_ERR(hwmon);
> +
> +	i2c_set_clientdata(client, hwmon);
> +
> +	return 0;
> +}
> +
> +static int p8_occ_remove(struct i2c_client *client)
> +{
> +	int rc;
> +	struct occ_sysfs *hwmon = i2c_get_clientdata(client);
> +	struct occ *occ = hwmon->occ;
> +
> +	rc = occ_sysfs_stop(&client->dev, hwmon);
> +
> +	rc = rc || p8_occ_stop(occ);
> +
> +	return rc;
> +}
> +
> +/* used by old-style board info. */
> +static const struct i2c_device_id occ_ids[] = {
> +	{ P8_OCC_I2C_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, occ_ids);
> +
> +/* used by device table */
> +static const struct of_device_id occ_of_match[] = {
> +	{ .compatible = "ibm,p8-occ-i2c" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, occ_of_match);
> +
> +/*
> + * i2c-core uses i2c-detect() to detect device in below address list.
> + * If exists, address will be assigned to client.
> + * It is also possible to read address from device table.
> + */
> +static const unsigned short normal_i2c[] = {0x50, 0x51, I2C_CLIENT_END };
> +
> +static struct i2c_driver p8_occ_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = P8_OCC_I2C_NAME,
> +		.pm = NULL,
> +		.of_match_table = occ_of_match,
> +	},
> +	.probe = p8_occ_probe,
> +	.remove = p8_occ_remove,
> +	.id_table = occ_ids,
> +	.address_list = normal_i2c,
> +};
> +
> +module_i2c_driver(p8_occ_driver);
> +
> +MODULE_AUTHOR("Eddie James <eajames@us.ibm.com>");
> +MODULE_DESCRIPTION("BMC P8 OCC hwmon driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 
