From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH linux v2 5/6] hwmon: occ: Add hwmon implementation for the
 P8 OCC
Date: Sun, 15 Jan 2017 10:34:08 -0800
Message-ID: <8c75c6b6-07e0-b7b7-7657-8928e9bf6da6@roeck-us.net>
References: <1484158237-10014-1-git-send-email-eajames.ibm@gmail.com>
 <1484158237-10014-6-git-send-email-eajames.ibm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484158237-10014-6-git-send-email-eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 01/11/2017 10:10 AM, eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
>
> Add code to tie the hwmon sysfs code and the POWER8 OCC code together, as
> well as probe the entire driver from the I2C bus. I2C is the communication
> method between the BMC and the P8 OCC.
>
> Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/hwmon/occ.txt |  13 +++
>  drivers/hwmon/occ/Kconfig                       |  14 +++
>  drivers/hwmon/occ/Makefile                      |   1 +
>  drivers/hwmon/occ/p8_occ_i2c.c                  | 123 ++++++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/occ.txt
>  create mode 100644 drivers/hwmon/occ/p8_occ_i2c.c
>
> diff --git a/Documentation/devicetree/bindings/hwmon/occ.txt b/Documentation/devicetree/bindings/hwmon/occ.txt
> new file mode 100644
> index 0000000..b0d2b36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/occ.txt
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
> index 0000000..4515c68
> --- /dev/null
> +++ b/drivers/hwmon/occ/p8_occ_i2c.c
> @@ -0,0 +1,123 @@
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
> +static int p8_occ_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct occ *occ;
> +	struct occ_sysfs *hwmon;
> +	const u32 *sensor_hwmon_configs = p8_get_sensor_hwmon_configs();
> +
> +	occ = p8_occ_start(&client->dev, client, &p8_bus_ops);
> +	if (IS_ERR(occ))
> +		return PTR_ERR(occ);
> +
> +	hwmon = occ_sysfs_start(&client->dev, occ, sensor_hwmon_configs,
> +				P8_OCC_I2C_NAME);
> +	if (IS_ERR(hwmon))
> +		return PTR_ERR(hwmon);
> +
> +	i2c_set_clientdata(client, occ);
> +
You might do the set_clientdata() call before the registration, and use
return PTR_ERR_OR_ZERO(hwmon). You'll need to drop the call to dev_set_drvdata()
in occ_sysfs_start() for that to work.

> +	return 0;
> +}
> +
> +static int p8_occ_remove(struct i2c_client *client)
> +{
> +	struct occ *occ = i2c_get_clientdata(client);
> +
> +	return p8_occ_stop(occ);

That stops occ first, then removes the hwmon driver registration. It also leaves a hole:
if occ_sysfs_start() failed, occ_stop() won't be called.

But wait ... all occ_stop does is to call devm_kfree(), which is wrong, because it
should never be necessary to call it, but even more so since the data structure
is still in use after the call to p8_occ_stop(). Just drop that function.

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
... but only if there is a detect function, and trying to detect any chip
on the common eeprom addresses is not a good idea anyway (it would be really
easy to spoof). Please drop.

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
> +MODULE_AUTHOR("Eddie James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("BMC P8 OCC hwmon driver");
> +MODULE_LICENSE("GPL");
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
