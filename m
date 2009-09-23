From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Add support for Xilinx XPS IIC Bus Interface
Date: Wed, 23 Sep 2009 01:41:58 +0100
Message-ID: <20090923004158.GD24720@trinity.fluff.org>
References: <4AB785FB.4020806@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4AB785FB.4020806-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 21, 2009 at 03:56:11PM +0200, Richard R=F6jfors wrote:
> This patch adds support for the Xilinx XPS IIC Bus Interface.
>=20
> The driver uses the dynamic mode, supporting to put several
> I2C messages in the FIFO to reduce the number of interrupts.
>=20
> It has the same feature as ocores, it can be passed a list
> of devices that will be added when the bus is probed.
>=20
> Signed-off-by: Richard R=F6jfors <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
> ---
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8206442..6b291e8 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -433,6 +433,16 @@ config I2C_OCORES
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-ocores.
>=20
> +config I2C_XILINX
> +	tristate "Xilinx I2C Controller"
> +	depends on EXPERIMENTAL && HAS_IOMEM
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Xilinx I2C controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called xilinx_i2c.
> +
>  config I2C_OMAP
>  	tristate "OMAP I2C adapter"
>  	depends on ARCH_OMAP
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index e654263..a2ce5b8 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_IXP2000)	+=3D i2c-ixp2000.o
>  obj-$(CONFIG_I2C_MPC)		+=3D i2c-mpc.o
>  obj-$(CONFIG_I2C_MV64XXX)	+=3D i2c-mv64xxx.o
>  obj-$(CONFIG_I2C_OCORES)	+=3D i2c-ocores.o
> +obj-$(CONFIG_I2C_XILINX)	+=3D i2c-xiic.o
>  obj-$(CONFIG_I2C_OMAP)		+=3D i2c-omap.o
>  obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi.o
>  obj-$(CONFIG_I2C_PNX)		+=3D i2c-pnx.o
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-x=
iic.c
> new file mode 100644
> index 0000000..7b1e618
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -0,0 +1,800 @@
> +/*
> + * i2c-xiic.c
> + * Copyright (c) 2009 Intel Corporation

is this the right copyirhgt entity?

> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/* Supports:
> + * Xilinx IIC
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/wait.h>
> +#include <linux/i2c-xiic.h>
> +#include <linux/io.h>
> +
> +#define DRIVER_NAME "xiic-i2c"
> +
> +struct xiic_i2c {
> +	void __iomem *base;
> +	wait_queue_head_t wait;
> +	struct i2c_adapter adap;
> +	struct i2c_msg *tx_msg;
> +	spinlock_t	lock; /* mutual exclusion */
> +	unsigned int tx_pos;
> +	unsigned int nmsgs;
> +	int state; /* see STATE_ */
> +
> +	struct i2c_msg *rx_msg; /* current RX message */
> +	int		rx_pos;
> +};

It would be nice (but not esential) to see some documentation
on this structure.

> +#define STATE_DONE   0x00
> +#define STATE_ERROR  0x01
> +#define STATE_START  0x02

it would be great to see these as an enum (say, enum xilinx_i2c_state)
to represent the state.

> +#define xiic_irq_dis(i2c, mask)				\
> +	xiic_setreg32(i2c, XIIC_IIER_OFFSET,		\
> +	xiic_getreg32(i2c, XIIC_IIER_OFFSET) & ~(mask))

These should be 'static inline' functions, that would avoid the
whole \ continuation business.

> +static irqreturn_t xiic_isr(int irq, void *dev_id)
> +{
> +	struct xiic_i2c *i2c =3D dev_id;

blank sould be here.

> +static int __devinit xiic_i2c_probe(struct platform_device *pdev)
> +{
> +	struct xiic_i2c *i2c;
> +	struct xiic_i2c_platform_data *pdata;
> +	struct resource *res;
> +	int ret, irq;
> +	u8 i;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;

-ENODEV is not a good error here, you won't get any report from the
driver core binding if you return this or (iirc, -EIO). Personally
I like returning -ENOENT, but this can be objectionable to others as
it is an file-system error.


> +	pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platform_data=
;
> +	if (!pdata)
> +		return -ENODEV;

how about -EINVAL here.

> +	i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;
> +
> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)=
) {
> +		dev_err(&pdev->dev, "Memory region busy\n");
> +		ret =3D -EBUSY;
> +		goto request_mem_failed;
> +	}
> +
> +	i2c->base =3D ioremap(res->start, resource_size(res));
> +	if (!i2c->base) {
> +		dev_err(&pdev->dev, "Unable to map registers\n");
> +		ret =3D -EIO;
> +		goto map_failed;
> +	}
> +
> +	/* hook up driver to tree */
> +	platform_set_drvdata(pdev, i2c);
> +	i2c->adap =3D xiic_adapter;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +	i2c->adap.dev.parent =3D &pdev->dev;
> +
> +	xiic_reinit(i2c);
> +
> +	spin_lock_init(&i2c->lock);
> +	init_waitqueue_head(&i2c->wait);
> +	ret =3D request_irq(irq, xiic_isr, 0, pdev->name, i2c);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot claim IRQ\n");
> +		goto request_irq_failed;
> +	}

Prints here but not for missing resources? at least you could
make a generic 'resource missing' error to tell users.

> +	/* add i2c adapter to i2c tree */
> +	ret =3D i2c_add_adapter(&i2c->adap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add adapter\n");
> +		goto add_adapter_failed;
> +	}
> +
> +	/* add in known devices to the bus */
> +	for (i =3D 0; i < pdata->num_devices; i++)
> +		i2c_new_device(&i2c->adap, pdata->devices + i);
> +
> +	return 0;
> +
> +add_adapter_failed:
> +	free_irq(irq, i2c);
> +request_irq_failed:
> +	xiic_deinit(i2c);
> +	iounmap(i2c->base);
> +map_failed:
> +	release_mem_region(res->start, resource_size(res));
> +request_mem_failed:
> +	kfree(i2c);
> +
> +	return ret;
> +}

> +++ b/include/linux/i2c-xiic.h
> @@ -0,0 +1,31 @@
> +/*
> + * i2c-xiic.h
> + * Copyright (c) 2009 Intel Corporation

is this the right copyright?

> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/* Supports:
> + * Xilinx IIC
> + */
> +
> +#ifndef _LINUX_I2C_XIIC_H
> +#define _LINUX_I2C_XIIC_H
> +
> +struct xiic_i2c_platform_data {
> +	u8 num_devices; /* number of devices in the devices list */
> +	struct i2c_board_info const *devices; /* devices connected to the b=
us */
> +};

kernel style documentation here people

> +#endif /* _LINUX_I2C_XIIC_H */

--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
