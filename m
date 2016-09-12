From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v3] i2c: mux: mellanox: add driver
Date: Mon, 12 Sep 2016 18:05:08 +0200
Message-ID: <7ed194ad-43ba-5d3c-bbb6-7e67fe1ee5bf@axentia.se>
References: <1473438676-64981-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0097.outbound.protection.outlook.com ([104.47.2.97]:60271
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750839AbcILQif (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Sep 2016 12:38:35 -0400
In-Reply-To: <1473438676-64981-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

First off, sorry for not catching all issues at once, I'm not an experienced
reviewer...

On 2016-09-09 18:31, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
> 
> This driver allows I2C routing controlled through CPLD select registers on
> wide range of Mellanox systems (CPLD Lattice device).
> MUX selection is provided by digital and analog HW. Analog part is not
> under SW control.
> Digital part is under CPLD control (channel selection/de-selection).
> 
> Connectivity schema.
> i2c-mlxcpld                                 Digital               Analog
> driver
> *--------*                                 * -> mux1 (virt bus2) -> mux ->|
> | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux ->|
> | bridge | bus 1                 *---------*                              |
> | logic  |---------------------> * mux reg *                              |
> | in CPLD|                       *---------*                              |
> *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux ->|
>     |        driver                   |                                   |
>     |        *---------------*        |                             Devices
>     |        * CPLD (i2c bus)* select |
>     |        * registers for *--------*
>     |        * mux selection * deselect
>     |        *---------------*
>     |                 |
> <-------->     <----------->
> i2c cntrl      Board cntrl reg
> reg space      space (mux select,
>                IO, LED, WD, info)
> 
> i2c-mux-mlxpcld does not necessarily require i2c-mlxcpld. It can be use
> along with another bus driver, and still control i2c routing through CPLD
> mux selection, in case the system is equipped with CPLD capable of mux
> selection control.
> 
> The Kconfig currently controlling compilation of this code is:
> drivers/i2c/muxes/Kconfig:config I2C_MUX_MLXCPLD
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> ---
> v2->v3
>  Fixes issues pointed out by Peter:
>   - Fix several comments;
>   - In MAINTAINERS file use linux-i2c instead of linux-kernel;
>   - Place include files in alphabetic order;
>   - When channel select fail, set last_chan to zero for cleaning last value;
>   - Return with error from probe if there is no platform data;
>   - Use i2c_mux_reg driver for the lpc_access cases:
>     it fit well for Mellanox system with LPC access - has been tested and it
> 	works good.
>   - Limit this driver to i2c_access only one device (mlxcpld_mux_module).
> v1->v2
>  Fixes issues pointed out by Peter:
>   - changes in commit cover massage;
>   - change leg to channel in comments;
>   - missed return err;
>   - use platform data mux array rather the offset from 1st channel in probe
>     routine;
>   - remove owner field from driver structure;
>   - use module_i2c_driver macros, instead if __init and __exit;
>   - remove deselect on exit flag;
>   - add record to MAINTAINER file;
> ---
>  MAINTAINERS                         |   8 ++
>  drivers/i2c/muxes/Kconfig           |  11 ++
>  drivers/i2c/muxes/Makefile          |   1 +
>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 257 ++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/mlxcpld.h         |  57 ++++++++
>  5 files changed, 334 insertions(+)
>  create mode 100644 drivers/i2c/muxes/i2c-mux-mlxcpld.c
>  create mode 100644 include/linux/i2c/mlxcpld.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bbe4b1..be83d69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7655,6 +7655,14 @@ W:	http://www.mellanox.com
>  Q:	http://patchwork.ozlabs.org/project/netdev/list/
>  F:	drivers/net/ethernet/mellanox/mlxsw/
>  
> +MELLANOX MLXCPLD I2C MUX DRIVER
> +M:	Vadim Pasternak <vadimp@mellanox.com>
> +M:	Michael Shych <michaelsh@mellanox.com>
> +L:	linux-i2c@vger.kernel.org
> +S:	Supported
> +W:	http://www.mellanox.com
> +F:	drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +
>  SOFT-ROCE DRIVER (rxe)
>  M:	Moni Shoua <monis@mellanox.com>
>  L:	linux-rdma@vger.kernel.org
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index e280c8e..b7ab144 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -81,4 +81,15 @@ config I2C_DEMUX_PINCTRL
>  	  demultiplexer that uses the pinctrl subsystem. This is useful if you
>  	  want to change the I2C master at run-time depending on features.
>  
> +config I2C_MUX_MLXCPLD
> +        tristate "Mellanox CPLD based I2C multiplexer"
> +        help
> +          If you say yes to this option, support will be included for a
> +          CPLD based I2C multiplexer. This driver provides access to
> +          I2C busses connected through a MUX, which is controlled
> +          by a CPLD registers.
> +
> +          This driver can also be built as a module.  If so, the module
> +          will be called i2c-mux-mlxcpld.
> +
>  endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 7c267c2..e5c990e 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -10,5 +10,6 @@ obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
>  obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
>  obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
> +obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
>  
>  ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> new file mode 100644
> index 0000000..0ca3d55
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> @@ -0,0 +1,257 @@
> +/*
> + * drivers/i2c/muxes/i2c-mux-mlxcpld.c
> + * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2016 Michael Shych <michaels@mellanox.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the names of the copyright holders nor the names of its
> + *    contributors may be used to endorse or promote products derived from
> + *    this software without specific prior written permission.
> + *
> + * Alternatively, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") version 2 as published by the Free
> + * Software Foundation.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/version.h>
> +#include <linux/i2c/mlxcpld.h>
> +
> +#define CPLD_MUX_MAX_NCHANS	8
> +
> +/*
> + * mlxcpld_mux types - kind of mux supported by driver:
> + * @mlxcpld_mux_module - I2C access; 8 channels/legs.
> + */
> +enum mlxcpld_mux_type {
> +	mlxcpld_mux_module,
> +};

This enum is now pointless.

> +
> +/* mlxcpld_mux - mux control structure:
> + * @type - mux type
> + * @last_chan - last register value
> + * @client - I2C device client
> + */
> +struct mlxcpld_mux {
> +	enum mlxcpld_mux_type type;

This member is now pointless.

> +	u8 last_chan;
> +	struct i2c_client *client;
> +};
> +
> +/* mlxcpld_mux_desc - mux descriptor structure:
> + * @nchans - number of channels
> + */
> +struct mlxcpld_mux_desc {
> +	u8 nchans;
> +};
> +
> +/* MUX logic description.
> + * Driver can support different mux control logic, according to CPLD
> + * implementation.
> + *
> + * Connectivity schema.
> + *
> + * i2c-mlxcpld                                 Digital               Analog
> + * driver
> + * *--------*                                 * -> mux1 (virt bus2) -> mux -> |
> + * | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux -> |
> + * | bridge | bus 1                 *---------*                               |
> + * | logic  |---------------------> * mux reg *                               |
> + * | in CPLD|                       *---------*                               |
> + * *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux -> |
> + *     |        driver                   |                                    |
> + *     |        *---------------*        |                              Devices
> + *     |        * CPLD (i2c bus)* select |
> + *     |        * registers for *--------*
> + *     |        * mux selection * deselect
> + *     |        *---------------*
> + *     |                 |
> + * <-------->     <----------->
> + * i2c cntrl      Board cntrl reg
> + * reg space      space (mux select,
> + *                IO, LED, WD, info)
> + *
> + */
> +static const struct mlxcpld_mux_desc muxes[] = {
> +	[mlxcpld_mux_module] = {
> +		.nchans = CPLD_MUX_MAX_NCHANS,
> +	},
> +};

This variable is now pointless.

> +
> +static const struct i2c_device_id mlxcpld_mux_id[] = {
> +	{ "mlxcpld_mux_module", mlxcpld_mux_module },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mlxcpld_mux_id);
> +
> +/* Write to mux register. Don't use i2c_transfer() and
> + * i2c_smbus_xfer() for this as they will try to lock adapter a second time
> + */
> +static int mlxcpld_mux_reg_write(struct i2c_adapter *adap,
> +				 struct i2c_client *client, u8 val)
> +{
> +	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
> +
> +	if (adap->algo->master_xfer) {
> +		struct i2c_msg msg;
> +		u8 msgbuf[] = {pdata->sel_reg_addr, val};
> +
> +		msg.addr = pdata->addr;

Maybe use client->addr here?

> +		msg.flags = 0;
> +		msg.len = 2;
> +		msg.buf = msgbuf;
> +		return __i2c_transfer(adap, &msg, 1);
> +	}
> +	dev_err(&client->dev, "SMBus isn't supported on this adapter\n");

This error message is misleading, since you are not checking for the
smbus_xfer operation so you can't really say that it's not supported.

Maybe add an else branch instead of the dev_err like so (completely untested):

	} else {
		union i2c_smbus_data data;
		data.byte = val;
		ret = adap->algo->smbus_xfer(adap, client->addr,
					     client->flags, I2C_SMBUS_WRITE,
					     pdata->sel_reg_addr,
					     I2C_SMBUS_BYTE_DATA, &data);
	}

> +
> +	return -ENODEV;
> +}
> +
> +static int mlxcpld_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct mlxcpld_mux *data = i2c_mux_priv(muxc);
> +	struct i2c_client *client = data->client;
> +	u8 regval;
> +	int err = 0;
> +
> +	if (data->type == mlxcpld_mux_module)

This comparison is now pointless.

> +		regval = chan + 1;
> +	else
> +		return -ENXIO;
> +
> +	/* Only select the channel if its different from the last channel */
> +	if (data->last_chan != regval) {
> +		err = mlxcpld_mux_reg_write(muxc->parent, client, regval);
> +		if (err)
> +			data->last_chan = 0;
> +		else
> +			data->last_chan = regval;
> +	}
> +
> +	return err;
> +}
> +
> +static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct mlxcpld_mux *data = i2c_mux_priv(muxc);
> +	struct i2c_client *client = data->client;
> +
> +	/* Deselect active channel */
> +	data->last_chan = 0;
> +
> +	return mlxcpld_mux_reg_write(muxc->parent, client, data->last_chan);
> +}
> +
> +/* I2C init/probing/exit functions */
> +static int mlxcpld_mux_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> +	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
> +	struct i2c_mux_core *muxc;
> +	int num, force;
> +	u8 nchans;
> +	struct mlxcpld_mux *data;
> +	int err;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
> +		return -ENODEV;

This is not what you actually end up using, I think. You use a register
number and a value, and you always write so I2C_FUNC_SMBUS_WRITE_BYTE_DATA
seems like a better fit. That is what you should check for.

> +
> +	switch (id->driver_data) {
> +	case mlxcpld_mux_module:
> +		nchans = muxes[id->driver_data].nchans;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This switch statement is now pointless. nchans always ends up 8.

> +
> +	muxc = i2c_mux_alloc(adap, &client->dev, nchans, sizeof(*data), 0,
> +			     mlxcpld_mux_select_chan, mlxcpld_mux_deselect);
> +	if (!muxc)
> +		return -ENOMEM;
> +
> +	data = i2c_mux_priv(muxc);
> +	i2c_set_clientdata(client, muxc);
> +	data->client = client;
> +	data->type = id->driver_data;
> +	data->last_chan = 0; /* force the first selection */
> +
> +	/* Only in mlxcpld_mux_tor first_channel can be different.
> +	 * In other mlxcpld_mux types channel numbering begin from 1
> +	 * Now create an adapter for each channel
> +	 */

The comment needs an update.

> +	for (num = 0; num < muxes[data->type].nchans; num++) {
> +		force = 0; /* dynamic adap number */

This assignment is pointless.

> +		if (num < pdata->num_adaps)
> +			force = pdata->adap_ids[num];
> +		else
> +			/* discard unconfigured channels */
> +			break;
> +

I would write:
		if (num >= pdata->num_adaps)
			/* discard unconfigured channels */
			break;

		force = pdata->adap_ids[num];

> +		err = i2c_mux_add_adapter(muxc, force, num, 0);
> +		if (err) {
> +			dev_err(&client->dev, "failed to register multiplexed adapter %d as bus %d\n",
> +				num, force);
> +			goto virt_reg_failed;
> +		}
> +	}
> +
> +	return 0;
> +
> +virt_reg_failed:
> +	i2c_mux_del_adapters(muxc);
> +	return err;
> +}
> +
> +static int mlxcpld_mux_remove(struct i2c_client *client)
> +{
> +	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> +
> +	i2c_mux_del_adapters(muxc);
> +	return 0;
> +}
> +
> +static struct i2c_driver mlxcpld_mux_driver = {
> +	.driver		= {
> +		.name	= "mlxcpld-mux",
> +	},
> +	.probe		= mlxcpld_mux_probe,
> +	.remove		= mlxcpld_mux_remove,
> +	.id_table	= mlxcpld_mux_id,
> +};
> +
> +module_i2c_driver(mlxcpld_mux_driver);
> +
> +MODULE_AUTHOR("Michael Shych (michaels@mellanox.com)");
> +MODULE_DESCRIPTION("Mellanox I2C-CPLD-MUX driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:i2c-mux-mlxcpld");
> diff --git a/include/linux/i2c/mlxcpld.h b/include/linux/i2c/mlxcpld.h
> new file mode 100644
> index 0000000..1b46e5e
> --- /dev/null
> +++ b/include/linux/i2c/mlxcpld.h
> @@ -0,0 +1,57 @@
> +/*
> + * mlxcpld.h - Mellanox I2C multiplexer support in CPLD
> + *
> + * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2016 Michael Shych <michaels@mellanox.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the names of the copyright holders nor the names of its
> + *    contributors may be used to endorse or promote products derived from
> + *    this software without specific prior written permission.
> + *
> + * Alternatively, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") version 2 as published by the Free
> + * Software Foundation.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef _LINUX_I2C_MLXCPLD_H
> +#define _LINUX_I2C_MLXCPLD_H
> +
> +/* Platform data for the CPLD I2C multiplexers */
> +
> +/* mlxcpld_mux_plat_data - per mux data, used with i2c_register_board_info
> + * @adap_ids - adapter array
> + * @num_adaps - number of adapters
> + * @sel_reg_addr - mux select register offset in CPLD space
> + * @first_channel - first channel to start virtual busses vector
> + * @addr - address of mux device - set to mux select register offset on LPC
> + *	   connected CPLDs or to I2C address on I2C conncted CPLDs
> + */
> +struct mlxcpld_mux_plat_data {
> +	int *adap_ids;
> +	int num_adaps;
> +	int sel_reg_addr;

sel_reg_addr may be static information?

> +	int first_channel;

This member is now pointless.

> +	int addr;

This member is pointless if you can use client->addr in mlxcpld_mux_reg_write().

> +};
> +
> +#endif /* _LINUX_I2C_MLXCPLD_H */
> 
