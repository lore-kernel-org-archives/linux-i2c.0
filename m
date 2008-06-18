From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: virtual i2c adapter support.
Date: Wed, 18 Jun 2008 20:00:08 +0100
Message-ID: <20080618190008.GK10351@trinity.fluff.org>
References: <1213794365-8089-1-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1213794365-8089-1-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 18, 2008 at 03:06:03PM +0200, Rodolfo Giometti wrote:
> Simplifies access to complex multiplexed I2C bus topologies, by
> presenting each multiplexed bus segment as a virtual I2C adapter. In
> this manner I2C devices "after" the multiplexer can ba managed as
> usual.
> 
> Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> ---
>  drivers/i2c/Kconfig    |    9 +++
>  drivers/i2c/Makefile   |    1 +
>  drivers/i2c/i2c-virt.c |  188 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-id.h |    3 +
>  include/linux/i2c.h    |   17 +++++
>  5 files changed, 218 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/i2c-virt.c
> 
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 9686734..053fe2f 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -27,6 +27,15 @@ config I2C_BOARDINFO
>  	boolean
>  	default y
>  
> +config I2C_VIRT
> +	tristate "I2C virtual adapter support"
> +	depends on I2C
> +	help
> +	  Say Y here if you want the I2C core to support the ability to have
> +	  virtual adapters. Virtual adapters are useful to handle multiplexed
> +	  I2C bus topologies, by presenting each multiplexed segment as a
> +	  I2C adapter.
> +
>  config I2C_CHARDEV
>  	tristate "I2C device interface"
>  	help
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index ba26e6c..db72ed9 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
>  obj-$(CONFIG_I2C)		+= i2c-core.o
> +obj-$(CONFIG_I2C_VIRT)		+= i2c-virt.o
>  obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
>  obj-y				+= busses/ chips/ algos/
>  
> diff --git a/drivers/i2c/i2c-virt.c b/drivers/i2c/i2c-virt.c
> new file mode 100644
> index 0000000..ed58f64
> --- /dev/null
> +++ b/drivers/i2c/i2c-virt.c
> @@ -0,0 +1,188 @@
> +/*
> + * i2c-virt.c - Virtual I2C bus driver.
> + *
> + * Copyright (c) 2008 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> + * Copyright (c) 2008 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
> + *
> + * Simplifies access to complex multiplexed I2C bus topologies, by presenting
> + * each multiplexed bus segment as a virtual I2C adapter.  Supports multi-level
> + * mux'ing (mux behind a mux).
> + *
> + * Based on:
> + *    i2c-virt.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> + *    i2c-virtual.c from Copyright (c) 2004 Google, Inc. (Ken Harrenstien)
> + *    i2c-virtual.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> + * which was:
> + *    Adapted from i2c-adap-ibm_ocp.c
> + *    Original file Copyright 2000-2002 MontaVista Software Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-id.h>
> +
> +struct i2c_virt_priv {
> +	struct i2c_adapter *parent_adap;
> +	struct i2c_client *client;	/* The mux chip/device */
> +
> +	u32 id;				/* the mux id */
> +
> +	int (*select)(struct i2c_adapter *, struct i2c_client *, u32);
> +					/* Enable the mux */
> +	int (*deselect)(struct i2c_adapter *, struct i2c_client *, u32);
> +					/* Disable the mux */
> +};
> +
> +#define VIRT_TIMEOUT		(HZ/2)
> +#define VIRT_RETRIES		3
> +
> +static int i2c_virt_master_xfer(struct i2c_adapter *adap,
> +				struct i2c_msg msgs[], int num)
> +{
> +	struct i2c_virt_priv *priv = adap->algo_data;
> +	struct i2c_adapter *parent = priv->parent_adap;
> +	int ret;
> +
> +	/* Grab the lock for the parent adapter. We already hold the lock for
> +	 * the virtual adapter. Then select the right mux port and perform
> +	 * the transfer.
> +	 */
> +
> +	mutex_lock(&parent->bus_lock);
> +
> +	ret = priv->select(parent, priv->client, priv->id);
> +	if (ret >= 0)
> +		ret = parent->algo->master_xfer(parent, msgs, num);
> +	priv->deselect(parent, priv->client, priv->id);
> +
> +	mutex_unlock(&parent->bus_lock);
> +
> +	return ret;
> +}

Out of interest, is it going to be better to hide the parent
away completely from the system? I suppose if clients have
already bound to it then we're probably going to just have to
live with it being available.

> +static int i2c_virt_smbus_xfer(struct i2c_adapter *adap,
> +				u16 addr, unsigned short flags,
> +				char read_write, u8 command,
> +				int size, union i2c_smbus_data *data)
> +{
> +	struct i2c_virt_priv *priv = adap->algo_data;
> +	struct i2c_adapter *parent = priv->parent_adap;
> +	int ret;
> +
> +	/* Grab the lock for the parent adapter.  We already hold the lock for
> +	 * the virtual adapter.  Then select the right mux port and perform
> +	 * the transfer.
> +	 */
> +
> +	mutex_lock(&parent->bus_lock);
> +
> +	ret = priv->select(parent, priv->client, priv->id);
> +	if (ret == 0)
> +		ret = parent->algo->smbus_xfer(parent, addr, flags,
> +					   read_write, command, size, data);
> +	priv->deselect(parent, priv->client, priv->id);
> +
> +	mutex_unlock(&parent->bus_lock);
> +
> +	return ret;
> +}
> +
> +/* Return the parent's functionality for the virtual adapter */
> +static u32 i2c_virt_functionality(struct i2c_adapter *adap)
> +{
> +	struct i2c_virt_priv *priv = adap->algo_data;
> +	struct i2c_adapter *parent = priv->parent_adap;
> +
> +	return parent->algo->functionality(parent);
> +}
> +
> +struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *parent,
> +				struct i2c_client *client,
> +				u32 force_nr, u32 mux_val,
> +				int (*select_cb) (struct i2c_adapter *,
> +						struct i2c_client *, u32),
> +				int (*deselect_cb) (struct i2c_adapter *,
> +						struct i2c_client *, u32))
> +{
> +	struct i2c_adapter *adap;
> +	struct i2c_virt_priv *priv;
> +	struct i2c_algorithm *algo;
> +	int ret;
> +
> +	adap = kzalloc(sizeof(struct i2c_adapter)
> +			+ sizeof(struct i2c_virt_priv)
> +			+ sizeof(struct i2c_algorithm), GFP_KERNEL);
> +	if (!adap)
> +		return NULL;
> +
> +	priv = (struct i2c_virt_priv *)(adap + 1);
> +	algo = (struct i2c_algorithm *)(priv + 1);

you shouldn't need force-typecast here.

you could always make your i2c_virt_priv data contain the i2c_adapter
and i2c_algorithm structure so you can easily go between them.

> +	/* Set up private adapter data */
> +	priv->parent_adap = parent;
> +	priv->client = client;
> +	priv->id = mux_val;
> +	priv->select = select_cb;
> +	priv->deselect = deselect_cb;
> +
> +	/* Need to do algo dynamically because we don't know ahead
> +	 * of time what sort of physical adapter we'll be dealing with.
> +	 */
> +	algo->master_xfer = (parent->algo->master_xfer
> +					? i2c_virt_master_xfer : NULL);
> +	algo->smbus_xfer = (parent->algo->smbus_xfer
> +					? i2c_virt_smbus_xfer : NULL);
> +	algo->functionality = i2c_virt_functionality;

you're using kzalloc, so this boils down to the neater:

	if (parent->algo->master_xfer)
		algo->master_xfer = i2c_virt_master_xfer;
etc.

> +	/* Now fill out new adapter structure */
> +	snprintf(adap->name, sizeof(adap->name),
> +			"i2c-%d-virt (mux %02x:%02x)",
> +			i2c_adapter_id(parent), client->addr, mux_val);
> +	adap->id = I2C_HW_VIRT | i2c_adapter_id(parent);
> +	adap->algo = algo;
> +	adap->algo_data = priv;
> +	adap->timeout = VIRT_TIMEOUT;
> +	adap->retries = VIRT_RETRIES;
> +	adap->dev.parent = &parent->dev;

How about creating a struct with the callbacks in, and the data
for timeout, retries and any other data that would be needed?

> +	if (force_nr) {
> +		adap->nr = force_nr;
> +		ret = i2c_add_numbered_adapter(adap);
> +	} else
> +		ret = i2c_add_adapter(adap);
> +	if (ret < 0) {
> +		kfree(adap);
> +		return NULL;
> +	}
> +
> +	dev_info(&parent->dev, "i2c-virt-%d: Virtual I2C bus - "
> +		"physical bus i2c-%d, multiplexer 0x%02x port %d\n",
> +		i2c_adapter_id(adap), i2c_adapter_id(parent),
> +		client->addr, mux_val);
> +
> +	return adap;
> +}
> +EXPORT_SYMBOL_GPL(i2c_add_virt_adapter);
> +
> +int i2c_del_virt_adapter(struct i2c_adapter *adap)
> +{
> +	int ret;
> +
> +	ret = i2c_del_adapter(adap);
> +	if (ret < 0)
> +		return ret;
> +	kfree(adap);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_del_virt_adapter);
> +
> +MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org, " \
> +		"Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>");
> +MODULE_DESCRIPTION("Virtual I2C driver for multiplexed I2C busses");
> +MODULE_LICENSE("GPL");

"GPL v2" is the definition you probably want here.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
