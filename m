From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c/busses: Diolan U2C-12 USB/I2C adapter driver
Date: Wed, 19 Jan 2011 21:14:03 +0000
Message-ID: <20110119211403.GM5432@trinity.fluff.org>
References: <1295472398-705-1-git-send-email-guenter.roeck@ericsson.com> <1295472398-705-2-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1295472398-705-2-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Wed, Jan 19, 2011 at 01:26:37PM -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig          |   10 +
>  drivers/i2c/busses/Makefile         |    1 +
>  drivers/i2c/busses/i2c-diolan-u2c.c |  529 +++++++++++++++++++++++++++++++++++
>  3 files changed, 540 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-diolan-u2c.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 113505a..30f8dbd 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -648,6 +648,16 @@ config I2C_EG20T
>  
>  comment "External I2C/SMBus adapter drivers"
>  
> +config I2C_DIOLAN_U2C
> +	tristate "Diolan U2C-12 USB adapter"
> +	depends on USB
> +	help
> +	  If you say yes to this option, support will be included for Diolan
> +	  U2C-12, a USB to I2C interface.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-diolan-u2c.
> +
>  config I2C_PARPORT
>  	tristate "Parallel port adapter"
>  	depends on PARPORT
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 9d2d0ec..3c630b7 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>  obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
>  
>  # External I2C/SMBus adapter drivers
> +obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
>  obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
>  obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
>  obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
> diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
> new file mode 100644
> index 0000000..44905ce
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
> @@ -0,0 +1,529 @@
> +/*
> + * Driver for the Diolan u2c-12 USB-I2C adapter
> + *
> + * Copyright (c) 2010-2011 Ericsson AB
> + *
> + * Derived from:
> + *  i2c-tiny-usb.c
> + *  Copyright (C) 2006-2007 Till Harbaum (Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/i2c.h>
> +
> +#define DRIVER_NAME		"i2c-diolan-u2c"
> +
> +#define USB_VENDOR_ID_DIOLAN		0x0abf
> +#define USB_DEVICE_ID_DIOLAN_U2C	0x3370
> +

might be worth type-defing the commands and responses, but not especially
importnant.

> +#define U2C_I2C_SPEED_FAST	0	/* 400 kHz */
> +#define U2C_I2C_SPEED_STD	1	/* 100 kHz */
> +#define U2C_I2C_SPEED_2KHZ	242	/* 2 kHz, minimum speed */
> +#define U2C_I2C_SPEED(f)	((DIV_ROUND_CLOSEST(1000000, (f)) - 10) / 2 + 1)

how about rounding down? surely the speed requested is the maximum?

> +/* Structure to hold all of our device specific stuff */
> +struct i2c_diolan_u2c {
> +	struct usb_device *usb_dev;	/* the usb device for this device */
> +	struct usb_interface *interface;/* the interface for this device */
> +	struct i2c_adapter adapter;	/* i2c related things */
> +	int olen;			/* Output buffer length */
> +	int ocount;			/* Number of enqueued messages */
> +	u8 obuffer[DIOLAN_OUTBUF_LEN];	/* output buffer */
> +	u8 ibuffer[DIOLAN_INBUF_LEN];	/* input buffer */

you should cache-line align the buffers to avoid any problems with
dma-vs-cache, etc.

> +/* Send command to device, and get response. */
> +static int diolan_usb_transfer(struct i2c_diolan_u2c *dev)
> +{
> +	int ret = 0;
> +	int actual;
> +	int i;
> +
> +	if (!dev->olen || !dev->ocount)
> +		return -EINVAL;
> +
> +	ret = usb_bulk_msg(dev->usb_dev,
> +			   usb_sndbulkpipe(dev->usb_dev, DIOLAN_OUT_EP),
> +			   dev->obuffer, dev->olen, &actual,
> +			   DIOLAN_USB_TIMEOUT);
> +	if (!ret) {
> +		for (i = 0; i < dev->ocount; i++) {
> +			int tmpret;
> +
> +			tmpret = usb_bulk_msg(dev->usb_dev,
> +					      usb_rcvbulkpipe(dev->usb_dev,
> +							      DIOLAN_IN_EP),
> +					      dev->ibuffer,
> +					      sizeof(dev->ibuffer), &actual,
> +					      DIOLAN_USB_TIMEOUT);
> +			if (tmpret < 0 && ret == 0)
> +				ret = tmpret;
> +			else if (ret >= 0 && tmpret == 0 && actual > 0) {
> +				switch (dev->ibuffer[actual - 1]) {
> +				case RESP_NACK:
> +					ret = -ENXIO;
> +					break;
> +				case RESP_TIMEOUT:
> +					ret = -ETIMEDOUT;
> +					break;
> +				case RESP_OK:
> +					/* strip off return code */
> +					ret = actual - 1;
> +					break;
> +				default:
> +					ret = -EIO;
> +					break;
> +				}
> +			}
> +		}
> +	}

this looks a little complicated with ret and tmpret.

> +	dev->olen = 0;
> +	dev->ocount = 0;
> +	return ret;
> +}
> +

> +static int diolan_usb_cmd_data2(struct i2c_diolan_u2c *dev, u8 command, u8 d1,
> +				u8 d2, bool flush)
> +{
> +	int ret = 0;
> +
> +	dev->obuffer[dev->olen++] = command;
> +	dev->obuffer[dev->olen++] = d1;
> +	dev->obuffer[dev->olen++] = d2;
> +	dev->ocount++;
> +	if (flush || dev->olen >= DIOLAN_FLUSH_LEN)
> +		ret = diolan_usb_transfer(dev);
> +	return ret;
> +}

how about wrapping the check for usb_transfer into one call?
say diolan_written_cmd(dev, flush) and then just use that as a
return and remove any need for 'int ret = 0' as well.

> +/*
> + * Flush input queue.
> + * If we don't do this at startup and the controller has queued up
> + * messages which were not retrieved, it will stop responding
> + * at some point.
> + */
> +static void diolan_flush_input(struct i2c_diolan_u2c *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < 10; i++) {
> +		int actual = 0;
> +		int ret;
> +
> +		ret = usb_bulk_msg(dev->usb_dev,
> +				   usb_rcvbulkpipe(dev->usb_dev, DIOLAN_IN_EP),
> +				   dev->ibuffer, sizeof(dev->ibuffer), &actual,
> +				   DIOLAN_USB_TIMEOUT);
> +		if (ret < 0 || actual == 0)
> +			break;
> +	}
> +	if (i == 10)
> +		dev_err(&dev->interface->dev, "Failed to flush input buffer\n");

[snip]


> +		 "Diolan U2C at USB bus %03d address %03d speed %d Hz\n",
> +		 dev->usb_dev->bus->busnum, dev->usb_dev->devnum, frequency);
> +
> +	diolan_flush_input(dev);
> +	diolan_fw_version(dev);

why bother returning ret from some of these when they're not checked?

> +	ret = diolan_i2c_start(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < num; i++) {
> +		pmsg = &msgs[i];
> +		if (i) {
> +			ret = diolan_i2c_repeated_start(dev);
> +			if (ret < 0)
> +				goto abort;
> +		}

i think this is ok.

> +	int ret;
> +
> +	/* allocate memory for our device state and initialize it */
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (dev == NULL) {
> +		dev_err(&interface->dev, "Out of memory\n");

how about "no memory for device state"

> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
> +	dev->interface = interface;
> +
> +	/* save our data pointer in this interface device */
> +	usb_set_intfdata(interface, dev);
> +
> +	/* setup i2c adapter description */
> +	dev->adapter.owner = THIS_MODULE;
> +	dev->adapter.class = I2C_CLASS_HWMON;
> +	dev->adapter.algo = &diolan_usb_algorithm;
> +	i2c_set_adapdata(&dev->adapter, dev);
> +	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
> +		 DRIVER_NAME " at bus %03d device %03d",
> +		 dev->usb_dev->bus->busnum, dev->usb_dev->devnum);
> +
> +	dev->adapter.dev.parent = &dev->interface->dev;
> +
> +	/* initialize diolan i2c interface */
> +	ret = diolan_init(dev);
> +	if (ret < 0)
> +		goto error_free;

do all return paths of diolan_init() print error?

> +
> +	/* and finally attach to i2c layer */
> +	ret = i2c_add_adapter(&dev->adapter);
> +	if (ret < 0) {
> +		dev_err(&interface->dev, "failed to add I2C adapter\n");
> +		goto error_free;
> +	}
> +
> +	dev_dbg(&interface->dev, "connected " DRIVER_NAME "\n");
> +
> +	return 0;
> +
> +error_free:
> +	usb_set_intfdata(interface, NULL);
> +	diolan_u2c_free(dev);
> +error:
> +	return ret;
> +}
> +

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
