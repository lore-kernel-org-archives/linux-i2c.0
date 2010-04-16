From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: driver for PCA954x I2C multiplexer series.
Date: Fri, 16 Apr 2010 17:38:07 +0200
Message-ID: <20100416173807.3d86e0d7@hyperion.delvare>
References: <4B5D8AFC.5060209@gmx.de>
 <4B5D95E7.1000804@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B5D95E7.1000804-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Mon, 25 Jan 2010 14:00:23 +0100, Michael Lawnick wrote:
> Sometimes you check and check and... and then sh*# happens.
> 
> Subject: [PATCH 2/2] i2c: driver for PCA954x I2C multiplexer series.
> 
> Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> Acked-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>

Review:

> ---
>  drivers/i2c/muxes/Kconfig   |    9 ++
>  drivers/i2c/muxes/Makefile  |    2 +
>  drivers/i2c/muxes/pca954x.c |  325
> +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/pca954x.h |   13 ++
>  4 files changed, 349 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/i2c/muxes/pca954x.c
>  create mode 100755 include/linux/i2c/pca954x.h
> 
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 95b9bde..72c7055 100755
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -5,4 +5,13 @@
>  menu "Multiplexer I2C Chip support"
>  	depends on I2C && I2C_MUX && EXPERIMENTAL
> 
> +config I2CMUX_PCA954x

I would prefer I2C_MUX instead of I2CMUX. 

> +	tristate "Philips PCA953x I2C Mux/switches"

Typo: PCA954x.

> +	help
> +	  If you say yes here you get support for the Philips PCA954x
> +	  I2C mux/switch devices.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called pca954x.
> +
>  endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 0416a52..2338d4c 100755
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -1,6 +1,8 @@
>  #
>  # Makefile for multiplexer I2C chip drivers.
> 
> +obj-$(CONFIG_I2CMUX_PCA954x)	+= pca954x.o
> +
>  ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)

CONFIG_I2C_DEBUG_CHIP is gone.

>  EXTRA_CFLAGS += -DDEBUG -DI2C_DEBUG_CORE
>  endif
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> new file mode 100755
> index 0000000..0440a69
> --- /dev/null
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -0,0 +1,325 @@
> +/*
> + * I2C multiplexer
> + *
> + * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> + * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
> + *
> + * This module supports the PCA954x series of I2C multiplexer/switch chips
> + * made by Philips Semiconductors.
> + * This includes the:
> + *     PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
> + *     and PCA9548.
> + *
> + * These chips are all controlled via the I2C bus itself, and all have a
> + * single 8-bit register (normally at 0x70).  The upstream "parent" bus fans

This is confusing. 0x70 is the device's I2C address, not a register
address. There is no register address for these chips, as they have a
single register. So I wouldn't mention the address at all.

> + * out to two, four, or eight downstream busses or channels; which of these
> + * are selected is determined by the chip type and register contents.  A
> + * mux can select only one sub-bus at a time; a switch can select any
> + * combination simultaneously.
> + *
> + * Based on:
> + *    pca954x.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> + * Copyright (C) 2006
> + *
> + * Based on:
> + *    pca954x.c from Ken Harrenstien
> + * Copyright (C) 2004 Google, Inc. (Ken Harrenstien)
> + *
> + * Based on:
> + *    i2c-virtual_cb.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> + * and
> + *    pca9540.c from Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, which was
> + *    based on pcf8574.c from the same project by Frodo Looijaard,
> + *    Philip Edelbrock, Dan Eaton and Aurelien Jarno.

Once again I think you go a little too deep in history. You can skip
the reference to the pcf8574.c drivers which is completely unrelated to
I2C bus multiplexing.

> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>

You don't need this one. OTOH you need <linux/slab.h> for kzalloc() and
<linux/device.h> for dev_info() etc.

> +
> +#include <linux/i2c/pca954x.h>
> +
> +#define PCA954X_MAX_NCHANS 8
> +
> +enum pca_type {
> +	pca_9540,
> +	pca_9542,
> +	pca_9543,
> +	pca_9544,
> +	pca_9545,
> +	pca_9546,
> +	pca_9547,
> +	pca_9548,
> +};
> +
> +struct pca954x {
> +	struct i2c_client *client;
> +	struct i2c_client dev;

You don't use either anywhere.

> +	unsigned int type;

Why not enum pca_type?

> +	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
> +
> +	u8 last_chan;
> +	unsigned int deselect_on_exit:1;
> +	int (*is_chan_connected)(struct i2c_adapter *adap,
> +			struct i2c_client *client, u32 chan);

What's this?

> +};
> +
> +struct chip_desc {
> +	u8 nchans;
> +	u8 enable;		/* used for muxes only */
> +	enum muxtype {
> +		pca954x_ismux = 0,
> +		pca954x_isswi
> +	} muxtype;

Why don't you simply go with a "is_switch" flag? Or you could even use
enable == 0 to differentiate between muxes and switches.

> +};
> +
> +/* Provide specs for the PCA954x types we know about */
> +static struct chip_desc chips[] = {

Could be const.

> +	[pca_9540] = {
> +		.nchans = 2,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
> +	[pca_9542] = {
> +		.nchans = 2,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
> +	[pca_9543] = {
> +		.nchans = 2,
> +		.enable = 0x0,

You don't have to explicitly mention 0 values when initializing static
structs.

> +		.muxtype = pca954x_isswi,
> +	},
> +	[pca_9544] = {
> +		.nchans = 4,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
> +	[pca_9545] = {
> +		.nchans = 4,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +	[pca_9546] = {
> +		.nchans = 4,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +	[pca_9547] = {
> +		.nchans = 8,
> +		.enable = 0x8,
> +		.muxtype = pca954x_ismux,
> +	},
> +	[pca_9548] = {
> +		.nchans = 8,
> +		.enable = 0x0,
> +		.muxtype = pca954x_isswi,
> +	},
> +};

As far as I can see, the 9540 and 9542 are handled the same, and so are
the 9545 and 9546. So you could remove 2 entries from the table above,
saving some space.

> +
> +static const struct i2c_device_id pca954x_id[] = {
> +	{ "pca9540", pca_9540 },
> +	{ "pca9542", pca_9542 },
> +	{ "pca9543", pca_9543 },
> +	{ "pca9544", pca_9544 },
> +	{ "pca9545", pca_9545 },
> +	{ "pca9546", pca_9546 },
> +	{ "pca9547", pca_9547 },
> +	{ "pca9548", pca_9548 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pca954x_id);
> +
> +static int pca954x_xfer(struct i2c_adapter *adap,
> +			struct i2c_client *client, int read_write, u8 *val)

val should be const u8 *, as you do not modify the value (but see
below).

> +{
> +	int ret = -ENODEV;
> +
> +	if (adap->algo->master_xfer) {
> +		struct i2c_msg msg;
> +		char buf[1];
> +
> +		msg.addr = client->addr;
> +		msg.flags = (read_write == I2C_SMBUS_READ ? I2C_M_RD : 0);
> +		msg.len = 1;
> +		buf[0] = *val;
> +		msg.buf = buf;

As you passed val by address, you might point msg.buf to it directly,
without an intermediate buffer. If you want to use a buffer, then you
have no reason to pass val by address.

> +		ret = adap->algo->master_xfer(adap, &msg, 1);
> +	} else if (adap->algo->smbus_xfer) {

The underlying adapter must implement either method, so a simple "else"
will do.

> +		union i2c_smbus_data data;
> +		ret = adap->algo->smbus_xfer(adap, client->addr,
> +						client->flags & I2C_M_TEN,

You don't actually need to care about this flag, as the PCA954x doesn't
use 10-bit addressing.

> +						read_write,
> +						*val, I2C_SMBUS_BYTE, &data);
> +	}

As you only use the above function for writing, you could simplify it
by hard-coding read_write to 0. This function is for your driver only,
so there's no point it making it more complex than it needs to be. Then
you might consider renaming it to pca954x_reg_write().

The above is basically a reimplementation of i2c_smbus_write_byte()
bypassing the bus locking. The idea that many mux drivers will do that
kind of thing doesn't really please me. It's digging deep into the guts
of the i2c subsystem. It is very easy to get it wrong, and any further
change to the i2c-core may have to be duplicated in all mux drivers.
There's only one for now, but I presume there will be a lot more
someday.

It might be better to implement "nolock" variants of i2c_transfer() and
i2c_smbus_xfer(), and maybe some helper functions, so that mux drivers
can just call them. I seem to recall that this is what an earlier candidate
patch for I2C multiplexing support did. We can go with your approach
for now, as I don't want to delay the inclusion of your patches. I'll
look into this in parallel. It won't be lightweight for sure, so I have
to think about it.

In the meantime, I would appreciate a comment at the top of this
function, explaining what it does and why it is needed.

> +
> +	return ret;
> +}
> +
> +static int pca954x_select_chan(struct i2c_adapter *adap,
> +				void *client, u32 chan)
> +{
> +	struct pca954x *data = i2c_get_clientdata((struct i2c_client *) client);

Cast from void * isn't needed.

> +	struct chip_desc *chip = &chips[data->type];
> +	u8 regval = 0;

Useless initialization.

> +	int ret = 0;
> +
> +	/* Callback to check for bus connection */
> +	if (data->is_chan_connected) {
> +		ret = data->is_chan_connected(adap, client, chan);
> +		if (!ret)
> +			return -EBUSY;
> +	}

I am confused. What are you doing here? Which ports are used should be
determined at initialization time.

> +
> +	/* we make switches look like muxes, not sure how to be smarter */
> +	if (chip->muxtype == pca954x_ismux)
> +		regval = chan | chip->enable;
> +	else
> +		regval = 1 << chan;

Looks good to me. If we want to be smarter, then we need to let the
user pass channel aggregation information through platform data. This
would certainly be useful in some cases, for example for some Tyan
boards. But this can be implemented later.

> +
> +	/* Only select the channel if its different from the last channel */
> +	if (data->last_chan != chan) {
> +		ret = pca954x_xfer(adap, client, I2C_SMBUS_WRITE, &regval);
> +		data->last_chan = chan;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pca954x_deselect_mux(struct i2c_adapter *adap,
> +				void *client, u32 chan)
> +{
> +	struct pca954x *data = i2c_get_clientdata((struct i2c_client *) client);

Cast not needed.

> +	struct chip_desc *chip = &chips[data->type];
> +	u8 regval = 0;

Useless initialization.

> +
> +	/* Check if we have to stay on the last channel we selected */
> +	if (!data->deselect_on_exit && (chip->muxtype == pca954x_ismux))

Test looks suspicious. I can't see why muxes and switches would handle
deselect_on_exit differently.

BTW, I think it would be better to set deselect to NULL if calling
deselect isn't desired. There's little point in calling a function
which will never do anything.

> +		return 0;
> +
> +	/* Signal we are deselecting active channel */
> +	data->last_chan = -1;

last_chan is a u8, it can't be set to -1.

> +
> +	regval = chan | ~chip->enable;

This looks wrong, basically it is setting all bits except the one in
chip->enable to 1. I doubt this is what you want. Also, this looks
valid only for mux chips, what about switches?

> +	return pca954x_xfer(adap, client, I2C_SMBUS_WRITE, &regval);
> +}
> +
> +/*
> + * I2C init/probing/exit functions
> + */
> +static int pca954x_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)

Missing __devinit.

> +{
> +	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> +	struct pca954x_platform_data *pdata = client->dev.platform_data;
> +	int i, n, f;

Please come up with better variable names. One-letter variables are a
pain to read and search for.

> +	struct pca954x *data;
> +	int ret = -ENODEV;
> +
> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
> +		goto err;
> +
> +	data = kzalloc(sizeof(struct pca954x), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +
> +	/* Read the mux register at addr.  This does two things: it verifies
> +	 * that the mux is in fact present, and fetches its current
> +	 * contents for possible use with a future deselect algorithm.
> +	 */
> +	i = i2c_smbus_read_byte(client);
> +	if (i < 0) {
> +		dev_warn(&client->dev, "probe failed\n");
> +		goto exit_free;
> +	}
> +
> +	data->type = id->driver_data;
> +	data->last_chan = -1;			/* force the first selection */

As I wrote above, -1 isn't a possible u8 value.

> +
> +	/* Now create virtual busses and adapters for them */

"busses and adapters" is redundant.

> +	for (i = 0; i < chips[data->type].nchans; i++) {
> +		f = 0;				/* dynamic adap number */
> +		if (pdata && (i < pdata->num_modes))

Looks wrong. If there are fewer "modes" provided than the device has
channels, then no adapters should be instantiated for the the remaining
channels. The loop should iterate over min(chips[data->type].nchans,
pdata->num_modes).

> +			f = pdata->modes[i].adap_id; /* force static number */
> +
> +		data->virt_adaps[i] = i2c_add_mux_adapter(adap, client, f, i,
> +						&pca954x_select_chan,
> +						&pca954x_deselect_mux);
> +		if (data->virt_adaps[i] == NULL) {
> +			ret = -ENODEV;

This certainly deserves an error message in the logs.

> +			goto virt_reg_failed;
> +		}
> +
> +		data->deselect_on_exit = pdata ?
> +				pdata->modes[i].deselect_on_exit : 1;

What was your rationale for defaulting to 1? Limiting the total
capacitance of the overall bus? As long as we only select one channel
at a time, I don't think this is likely to be an issue.

I would default to 0, for performance reasons. This is also more
consistent. Otherwise, not specifying platform data at all results in
deselect_on_exit = 1 while specifying platform data but not specifying
deselect_on_exit results in deselect_on_exit = 0. That's confusing.

> +		data->is_chan_connected = pdata ?
> +				pdata->modes[i].is_chan_connected : NULL;

This is racy. You need to set all attributes _before_ you register the
adapter.

> +	}
> +
> +	dev_info(&client->dev, "registered %d virtual busses for I2C %s %s\n",
> +			i, chips[data->type].muxtype == pca954x_ismux ?
> +					"mux" : "switch", client->name);
> +
> +	return 0;
> +
> +virt_reg_failed:
> +	for (n = 0; n < i; n++)
> +		i2c_del_mux_adapter(data->virt_adaps[n]);

You can instead decrease i from its current value down to 0. This way
you don't need to introduce another loop variable.

> +exit_free:
> +	kfree(data);
> +err:
> +	return ret;
> +}
> +
> +static int __devexit pca954x_remove(struct i2c_client *client)
> +{
> +	struct pca954x *data = i2c_get_clientdata(client);
> +	struct chip_desc *chip = &chips[data->type];
> +	int i, err;
> +
> +	for (i = 0; i < chip->nchans; ++i)
> +		if (data->virt_adaps[i]) {
> +			err = i2c_del_mux_adapter(data->virt_adaps[i]);
> +			if (err)
> +				return err;
> +			data->virt_adaps[i] = NULL;
> +		}
> +
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct i2c_driver pca954x_driver = {
> +	.driver = {
> +		.name	= "pca954x",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe	= pca954x_probe,
> +	.remove	= __devexit_p(pca954x_remove),
> +	.id_table = pca954x_id,
> +};
> +
> +static int __init pca954x_init(void)
> +{
> +	return i2c_add_driver(&pca954x_driver);
> +}
> +
> +static void __exit pca954x_exit(void)
> +{
> +	i2c_del_driver(&pca954x_driver);
> +}
> +
> +module_init(pca954x_init);
> +module_exit(pca954x_exit);
> +
> +MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>");
> +MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/i2c/pca954x.h b/include/linux/i2c/pca954x.h
> new file mode 100755
> index 0000000..18d5e79
> --- /dev/null
> +++ b/include/linux/i2c/pca954x.h
> @@ -0,0 +1,13 @@

Please add the standard copyright and license comment. Please also add
standard #ifdef/#endif to protect against multiple inclusions.

> +/* Platform data for the PCA954x I2C multiplexers */
> +
> +struct pca954x_platform_mode {
> +	int		adap_id;
> +	unsigned int	deselect_on_exit:1;
> +	int		(*is_chan_connected)(struct i2c_adapter *adap,
> +					struct i2c_client *client, u32 chan);
> +};
> +
> +struct pca954x_platform_data {
> +	struct pca954x_platform_mode *modes;
> +	int num_modes;
> +};

These structure needs full description, as it is a public interface.

As I don't have any hardware to test your code, I will try adding a
special mode to i2c-stub where it would instantiate a virtual PCA9540
chip, and present 3 adapters to the user instead of 1. That way I
should be able to preform some testing on my own.

-- 
Jean Delvare
