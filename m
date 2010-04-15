From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Thu, 15 Apr 2010 14:49:06 +0200
Message-ID: <20100415144906.2a20588d@hyperion.delvare>
References: <4B5D8AFC.5060209@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B5D8AFC.5060209-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

Sorry for the long delay. Here finally comes a review of your code.

On Mon, 25 Jan 2010 13:13:48 +0100, Michael Lawnick wrote:
> Subject: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
>=20
> Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> ---
>  drivers/i2c/Kconfig        |   10 +++
>  drivers/i2c/Makefile       |    3 +-
>  drivers/i2c/i2c-core.c     |   73 +++++++++++++++++--
>  drivers/i2c/i2c-dev.c      |   32 ++++++++-
>  drivers/i2c/i2c-mux.c      |  167
> ++++++++++++++++++++++++++++++++++++++++++++

Your e-mail client wraps long lines, this caused your patch to not
apply. I had to edit it manually before I was able to apply it. Please
fix your setup so that I don't have to do it again next time.

Please also make sure to run your patch through scripts/checkpatch.pl.
I found many trailing whitespace, and even after removing them, the
script still finds 9 style errors which should be fixed.

>  drivers/i2c/muxes/Kconfig  |    8 ++
>  drivers/i2c/muxes/Makefile |    6 ++
>  include/linux/i2c.h        |   14 ++++
>  8 files changed, 303 insertions(+), 10 deletions(-)
>  create mode 100755 drivers/i2c/i2c-mux.c
>  create mode 100755 drivers/i2c/muxes/Kconfig
>  create mode 100755 drivers/i2c/muxes/Makefile
>=20
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index d7ece13..0c2f86a 100755
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -35,6 +35,16 @@ config I2C_COMPAT
>  	  other user-space package which expects i2c adapters to be class
>  	  devices. If you don't know, say Y.
>=20
> +config I2C_MUX
> +	tristate "I2C bus multiplexing support"
> +	depends on I2C
> +	help
> +	  Say Y here if you want the I2C core to support the ability to
> +	  handle multiplexed I2C bus topologies, by presenting each
> +	  multiplexed segment as a I2C adapter.
> +
> +source drivers/i2c/muxes/Kconfig
> +
>  config I2C_CHARDEV
>  	tristate "I2C device interface"
>  	help
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index ba26e6c..281e2a7 100755
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -4,8 +4,9 @@
>=20
>  obj-$(CONFIG_I2C_BOARDINFO)	+=3D i2c-boardinfo.o
>  obj-$(CONFIG_I2C)		+=3D i2c-core.o
> +obj-$(CONFIG_I2C_MUX)		+=3D i2c-mux.o
>  obj-$(CONFIG_I2C_CHARDEV)	+=3D i2c-dev.o
> -obj-y				+=3D busses/ chips/ algos/
> +obj-y				+=3D busses/ chips/ muxes/ algos/

This doesn't work. You can't ask the build system to operate on an
empty directory. You'll have to move the inclusion of this directory to
the patch adding the first mux driver. I know it's not nice, but
there's no other way I know of.

>=20
>  ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
>  EXTRA_CFLAGS +=3D -DDEBUG
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2965043..83119ae 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -20,7 +20,9 @@
>  /* With some changes from Ky=C3=83=C2=B6sti M=C3=83=C2=A4lkki <kmalk=
ki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>.
>     All SMBus-related things are written by Frodo Looijaard <frodol@d=
ds.nl>
>     SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> and
> -   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> */
> +      Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> +   Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
> +      Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>*/

Missing space before end of comment.

>=20
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> @@ -937,9 +939,66 @@ static int __i2c_check_addr(struct device *dev,
> void *addrp)
>  	return 0;
>  }
>=20
> +static int i2c_check_clients(struct i2c_adapter *adapter, int addr)
> +{
> +	int result =3D 0;

Useless initialization.

> +
> +	result =3D device_for_each_child(&adapter->dev, &addr, __i2c_check_=
addr);
> +
> +	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))

All devices don't have a parent, so you should first check that
adapter->dev.parent isn't NULL. Try your code with i2c-stub for
example, it would crash.

> +		result =3D i2c_check_clients(to_i2c_adapter(adapter->dev.parent), =
addr);
> +=09
> +	return result;
> +}

> +
>  static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
>  {
> -	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr=
);
> +	int result =3D 0;

Useless initialization. There are many other cases below, I won't
comment on each but please fix them all.

> +
> +	result =3D i2c_check_clients(adapter, addr);
> +=09
> +	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))

Here again, you have no guarantee that the adapter device has a parent.
There are many other occurrences of this below. Maybe you want a small
helper function.

> +	{
> +		struct i2c_client dummy;
> +		char buff;
> +

You must zero all the struct i2c_client fields before you use it.

> +		dummy.adapter =3D to_i2c_adapter(adapter->dev.parent);
> +		dummy.addr =3D addr;
> +		dummy.flags =3D 0;
> +
> +		result =3D i2c_master_recv(&dummy, &buff, 1) =3D=3D 1;
> +	}

I don't understand this part, please explain, and add a comment before
the code if the above is really needed. I would think that the
recursive address business check would be sufficient, is it not?

We should avoid as much as possible to run arbitrary transactions on
the I2C bus. We are already using such arbitrary transactions for
device detections, but we are trying to move away from this now. Let's
not add more such cases. Some devices may hang on transactions they
don't expect!

If the above is really needed, it will have to be implemented
differently anyway, as you have no guarantee that the adapter supports
raw I2C transactions. Most SMBus controllers don't.

> +	=09
> +	return result;
> +}
> +
> +static void i2c_mux_tree_lock(struct i2c_adapter *adap)
> +{
> +	mutex_lock_nested(&adap->bus_lock, SINGLE_DEPTH_NESTING);

i2c-core moved to rt_mutex, so your code will need to be updated
accordingly.

> +	if(adap->dev.parent->bus =3D=3D &i2c_bus_type)
> +		i2c_mux_tree_lock(to_i2c_adapter(adap->dev.parent));
> +}

In the end, each time one wants access to a segment of the tree, they
will have to lock the root segment to succeed. So do we really need to
lock each segment in turn? Can't we just look for the root and lock
only it? This would be faster.

> +
> +static int i2c_mux_tree_trylock(struct i2c_adapter *adap)
> +{
> +	int ret;
> +=09
> +	ret =3D mutex_trylock(&adap->bus_lock);
> +
> +	if(ret && (adap->dev.parent->bus =3D=3D &i2c_bus_type)) {
> +		ret =3D i2c_mux_tree_trylock(to_i2c_adapter(adap->dev.parent));
> +		if (!ret)
> +			mutex_unlock(&adap->bus_lock);
> +	}
> +
> +	return ret;
> +}
> +
> +static void i2c_mux_tree_unlock(struct i2c_adapter *adap)
> +{
> +	if(adap->dev.parent->bus =3D=3D &i2c_bus_type)
> +		i2c_mux_tree_unlock(to_i2c_adapter(adap->dev.parent));
> +	mutex_unlock(&adap->bus_lock);
>  }
>=20
>  /**
> @@ -1092,12 +1151,12 @@ int i2c_transfer(struct i2c_adapter *adap,
> struct i2c_msg *msgs, int num)
>  #endif
>=20
>  		if (in_atomic() || irqs_disabled()) {
> -			ret =3D mutex_trylock(&adap->bus_lock);
> +			ret =3D i2c_mux_tree_trylock(adap);
>  			if (!ret)
>  				/* I2C activity is ongoing. */
>  				return -EAGAIN;
>  		} else {
> -			mutex_lock_nested(&adap->bus_lock, adap->level);
> +			i2c_mux_tree_lock(adap);
>  		}
>=20
>  		/* Retry automatically on arbitration loss */
> @@ -1109,7 +1168,7 @@ int i2c_transfer(struct i2c_adapter *adap, stru=
ct
> i2c_msg *msgs, int num)
>  			if (time_after(jiffies, orig_jiffies + adap->timeout))
>  				break;
>  		}
> -		mutex_unlock(&adap->bus_lock);
> +		i2c_mux_tree_unlock(adap);
>=20
>  		return ret;
>  	} else {
> @@ -1913,7 +1972,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter,
> u16 addr, unsigned short flags,
>  	flags &=3D I2C_M_TEN | I2C_CLIENT_PEC;
>=20
>  	if (adapter->algo->smbus_xfer) {
> -		mutex_lock(&adapter->bus_lock);
> +		i2c_mux_tree_lock(adapter);
>=20
>  		/* Retry automatically on arbitration loss */
>  		orig_jiffies =3D jiffies;
> @@ -1927,7 +1986,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter,
> u16 addr, unsigned short flags,
>  				       orig_jiffies + adapter->timeout))
>  				break;
>  		}
> -		mutex_unlock(&adapter->bus_lock);
> +		i2c_mux_tree_unlock(adapter);
>  	} else
>  		res =3D i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
>  					      command, protocol, data);
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 7e13d2d..ce2f1a1 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -190,16 +190,44 @@ static int i2cdev_check(struct device *dev, voi=
d
> *addrp)
>=20
>  	if (!client || client->addr !=3D *(unsigned int *)addrp)
>  		return 0;
> -
> +=09

Please don't include whitespace changes in your patch.

>  	return dev->driver ? -EBUSY : 0;
>  }
>=20
> +static int i2cdev_check_clients(struct i2c_adapter *adapter, int add=
r)
> +{
> +	int result =3D 0;
> +
> +	result =3D device_for_each_child(&adapter->dev, &addr, i2cdev_check=
);
> +
> +	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))
> +		result =3D i2cdev_check_clients(to_i2c_adapter(adapter->dev.parent=
), addr);
> +=09
> +	return result;
> +}
> +
>  /* This address checking function differs from the one in i2c-core
>     in that it considers an address with a registered device, but no
>     driver bound to it, as NOT busy. */
>  static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned i=
nt
> addr)
>  {
> -	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
> +	int result =3D 0;
> +
> +	result =3D i2cdev_check_clients(adapter, addr);
> +=09
> +	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))
> +	{
> +		struct i2c_client dummy;
> +		char buff;
> +
> +		dummy.adapter =3D to_i2c_adapter(adapter->dev.parent);
> +		dummy.addr =3D addr;
> +		dummy.flags =3D 0;
> +
> +		result =3D i2c_master_recv(&dummy, &buff, 1) =3D=3D 1;
> +	}
> +	=09
> +	return result;
>  }

This duplicated code in i2c-dev starts being a problem, but I guess it
can't be avoided as long as i2c-dev doesn't properly integrate with the
standard device driver binding model :(

>=20
>  static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> new file mode 100755
> index 0000000..014d488
> --- /dev/null
> +++ b/drivers/i2c/i2c-mux.c
> @@ -0,0 +1,167 @@
> +/*
> + * Multiplexed I2C bus driver.
> + *
> + * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> + * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
> + *
> + * Simplifies access to complex multiplexed I2C bus topologies, by
> presenting
> + * each multiplexed bus segment as a virtual I2C adapter.  Supports

I would prefer the term "separate I2C adapter" rather than "virtual I2C
adapter". There's nothing virtual about these bus segments. i2c-stub is
a virtual I2C adapter.

> multi-level
> + * mux'ing (mux behind a mux).
> + *
> + * Based on:
> + *    i2c-virt.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> + *    i2c-virtual.c from Copyright (c) 2004 Google, Inc. (Ken Harren=
stien)

"from Copyright" looks bad.

> + *    i2c-virtual.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> + * which was:
> + *    Adapted from i2c-adap-ibm_ocp.c
> + *    Original file Copyright 2000-2002 MontaVista Software Inc.

There's probably no point in going that far in history. I doubt
i2c-adap-ibm_ocp.c was a bus multiplexer driver.

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

You don't need this one.

> +
> +struct i2c_mux_priv {

Would be good to document what this structure represents conceptually.

> +	struct i2c_adapter adap;
> +	struct i2c_algorithm algo;
> +
> +	struct i2c_adapter *parent_adap;

Why not just "parent"?

> +	void *client;			/* The mux chip/device */

"client" is a confusing term, because it is heavily used in the i2c
subsystem and drivers to refer to I2C devices. As the mux chip does not
have to be an I2C device, I'd rather use a more generic term, such as
"mux" or "mux_dev".

> +	u32 id;				/* the mux id */

Comment looks wrong, I think this is a channel ID for the given mux
device and not a mux device ID?

> +
> +	int (*select)(struct i2c_adapter *, void *, u32);
> +	int (*deselect)(struct i2c_adapter *, void *, u32);

Please name the arguments, otherwise it's difficult to figure out what
each argument represents. Not sure why you don't simply pass a struct
i2c_mux_priv, BTW. It contains all the information you need.

I'm unsure why deselect would take what I presume is a mux id argument?
I'm not even sure what this function would do... Not all chips can
deselect all their channels. Some very simple I2C multiplexers are
controlled by a single GPIO pin, and must always have exactly one
channel selected. So the deselect callback should certainly be optional=
=2E

> +};
> +
> +#define VIRT_TIMEOUT		(HZ/2)
> +#define VIRT_RETRIES		3
> +
> +static int i2c_mux_master_xfer(struct i2c_adapter *adap,
> +				struct i2c_msg msgs[], int num)
> +{
> +	struct i2c_mux_priv *priv =3D adap->algo_data;
> +	struct i2c_adapter *parent =3D priv->parent_adap;
> +	int ret;
> +
> +	/* Select the right mux port and perform the transfer. */=09
> +
> +	ret =3D priv->select(parent, priv->client, priv->id);
> +	if (ret >=3D 0)

Should be "ret =3D=3D 0" for consistency with the next function.

> +		ret =3D parent->algo->master_xfer(parent, msgs, num);
> +	priv->deselect(parent, priv->client, priv->id);

As discussed earlier, I don't think that we want to always deselect the
multiplexer channels after a transfer, for performance reasons.
Probably the implementation of deselect() should be optional, and
reserved to the few cases where it is really desirable (for example
tuner chips behind gates to reduce electrical noise on TV adapters.)

> +
> +	return ret;
> +}
> +
> +static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
> +				u16 addr, unsigned short flags,
> +				char read_write, u8 command,
> +				int size, union i2c_smbus_data *data)
> +{
> +	struct i2c_mux_priv *priv =3D adap->algo_data;
> +	struct i2c_adapter *parent =3D priv->parent_adap;
> +	int ret;
> +
> +	/* Select the right mux port and perform the transfer. */=09
> +
> +	ret =3D priv->select(parent, priv->client, priv->id);
> +	if (ret =3D=3D 0)
> +		ret =3D parent->algo->smbus_xfer(parent, addr, flags,
> +					   read_write, command, size, data);
> +	priv->deselect(parent, priv->client, priv->id);
> +
> +	return ret;
> +}
> +
> +/* Return the parent's functionality for the virtual adapter */
> +static u32 i2c_mux_functionality(struct i2c_adapter *adap)
> +{
> +	struct i2c_mux_priv *priv =3D adap->algo_data;
> +	struct i2c_adapter *parent =3D priv->parent_adap;
> +
> +	return parent->algo->functionality(parent);
> +}
> +
> +struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
> +				void *client, u32 force_nr, u32 mux_val,
> +				int (*select_cb) (struct i2c_adapter *,
> +						void *, u32),
> +				int (*deselect_cb) (struct i2c_adapter *,
> +						void *, u32))

Please drop the trailing _cb, it's already pretty clear that these are
callback functions.

> +{
> +	struct i2c_mux_priv *priv;
> +	int ret;
> +
> +	priv =3D kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);

You must include <linux/slab.h> for this.

> +	if (!priv)
> +		return NULL;
> +
> +	/* Set up private adapter data */
> +	priv->parent_adap =3D parent;
> +	priv->client =3D client;
> +	priv->id =3D mux_val;
> +	priv->select =3D select_cb;
> +	priv->deselect =3D deselect_cb;
> +
> +	/* Need to do algo dynamically because we don't know ahead
> +	 * of time what sort of physical adapter we'll be dealing with.
> +	 */
> +	if (parent->algo->master_xfer)
> +		priv->algo.master_xfer =3D i2c_mux_master_xfer;
> +	if (parent->algo->smbus_xfer)
> +		priv->algo.smbus_xfer =3D i2c_mux_smbus_xfer;
> +	priv->algo.functionality =3D i2c_mux_functionality;
> +
> +	/* Now fill out new adapter structure */
> +	snprintf(priv->adap.name, sizeof(priv->adap.name),
> +			"i2c-%d-mux (mux %02x)",

I don't get the use of hexadecimal to represent a channel number/id.
Decimal would be more readable. I would also use the term "channel" or
"port" before that ID, rather than "mux".

> +			i2c_adapter_id(parent), mux_val);
> +	priv->adap.owner =3D THIS_MODULE;
> +	priv->adap.id =3D i2c_adapter_id(parent);

No, this is incorrect. I know the name i2c_adapter_id is very
confusing, but it's returning a bus number, not a bus ID. If you need
the parent's ID, you must copy it manually, there's no helper function
for that.

> +	priv->adap.algo =3D &priv->algo;
> +	priv->adap.algo_data =3D priv;
> +	priv->adap.timeout =3D VIRT_TIMEOUT;
> +	priv->adap.retries =3D VIRT_RETRIES;

I don't think these make sense. The actual transaction will happen at
the root level, that's where the relevant timeout and retries settings
are. The values above will never be used, so I'd rather not set them.

> +	priv->adap.dev.parent =3D &parent->dev;
> +=09
> +	if (force_nr) {
> +		priv->adap.nr =3D force_nr;
> +		ret =3D i2c_add_numbered_adapter(&priv->adap);
> +	} else {
> +		ret =3D i2c_add_adapter(&priv->adap);
> +	}
> +	if (ret < 0) {

Might be worth an error message?

> +		kfree(priv);
> +		return NULL;
> +	}
> +
> +	dev_info(&parent->dev, "i2c-mux-%d: Virtual I2C bus - "
> +		"physical bus i2c-%d, client %02x, port %d\n",
> +		i2c_adapter_id(&priv->adap), i2c_adapter_id(parent), ((struct
> i2c_client*)priv->client)->addr, mux_val);

This is wrong and will crash for non-I2C mux chips. You just can't
assume that it is safe to cast priv->client to an i2c_client.

> +
> +	return &priv->adap;
> +}
> +EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
> +
> +int i2c_del_mux_adapter(struct i2c_adapter *adap)
> +{
> +	struct i2c_mux_priv *priv =3D adap->algo_data;
> +	int ret;
> +
> +	ret =3D i2c_del_adapter(adap);
> +	if (ret < 0)
> +		return ret;
> +	kfree(priv);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_del_mux_adapter);
> +
> +MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>");
> +MODULE_DESCRIPTION("Virtual I2C driver for multiplexed I2C busses");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> new file mode 100755
> index 0000000..95b9bde
> --- /dev/null
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -0,0 +1,8 @@
> +#
> +# Multiplexer I2C chip drivers configuration
> +#
> +
> +menu "Multiplexer I2C Chip support"
> +	depends on I2C && I2C_MUX && EXPERIMENTAL

I2C_MUX itself already depends in I2C, so I guess it's enough to depend
on I2C_MUX.

> +
> +endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> new file mode 100755
> index 0000000..0416a52
> --- /dev/null
> +++ b/drivers/i2c/muxes/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for multiplexer I2C chip drivers.
> +
> +ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)

CONFIG_I2C_DEBUG_CHIP is gone. I suggest you introduce a new option,
CONFIG_I2C_DEBUG_MUX.

> +EXTRA_CFLAGS +=3D -DDEBUG -DI2C_DEBUG_CORE

-DDEBUG should be enough.

> +endif
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 7b40cda..24ff2e5 100755
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -580,6 +580,20 @@ union i2c_smbus_data {
>  #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
>  #define I2C_SMBUS_I2C_BLOCK_DATA    8
>=20
> +/*
> + * Called to create a 'virtual' i2c bus which represents a multiplex=
ed bus
> + * segment.  The client and mux_val are passed to the select and des=
elect
> + * callback functions to perform hardware-specific mux control.
> + */
> +struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
> +				void *client, u32 force_nr, u32 mux_val,
> +				int (*select_cb) (struct i2c_adapter *,
> +						void *, u32),
> +				int (*deselect_cb) (struct i2c_adapter *,
> +						void *, u32));
> +
> +int i2c_del_mux_adapter(struct i2c_adapter *adap);
> +

These functions are not available if mux support wasn't selected, so
their declarations shouldn't be there in that case. In fact, I would
suggest that you move these to a separate header, <linux/i2c-mux.h>,
which only multiplexer drivers (and i2c-mux.c) would include. This
keeps things nicely separated.

>=20
>  #ifdef __KERNEL__
>=20

I'll go on with reviewing the PCA954x mux driver.

--=20
Jean Delvare
