From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Add Intel SCH I2C SMBus support (revised)
Date: Mon, 12 May 2008 22:57:18 +0200
Message-ID: <20080512225718.7440ab42@hyperion.delvare>
References: <20080428105738.06429ed2@hyperion.delvare>
	<20080429110628.66d4892b@dxy.sh.intel.com>
	<8AD95083DC3E36478732061D97524415030F8FAA@pdsmsx411.ccr.corp.intel.com>
	<20080430080351.57b8c21d@hyperion.delvare>
	<20080505141807.1aa458e1@dxy.sh.intel.com>
	<20080505110757.6454c220@hyperion.delvare>
	<20080506095036.274e91f1@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080506095036.274e91f1-PCb9FJy6fea75v1z/vFq2g@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alek,

Sorry for the late reply.

On Tue, 6 May 2008 09:50:36 +0800, Alek Du wrote:
> Since another patch SCH PCI IDs has been accepted by 2.6.26, I
> updated this patch to not include the pci_ids.h. Please review it:

Here you go:

> From e0526346fa96acfc16e558f6f47865f0a15ad79e Mon Sep 17 00:00:00 2001
> From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Wed, 30 Apr 2008 11:01:17 +0800
> Subject: [PATCH] i2c: Add Intel SCH I2C SMBus Support
> 
> This patch adds Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L) i2c bus support.
> 
> Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig    |    7 +
>  drivers/i2c/busses/Makefile   |    1 +
>  drivers/i2c/busses/i2c-isch.c |  362 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 370 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-isch.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 48438cc..39d86f7 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -247,6 +247,13 @@ config I2C_PIIX4
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-piix4.
>  
> +config I2C_SCH

I'd rather name the option I2C_ISCH to match the new driver name.

> +	tristate "Intel SCH SMBUS 1.0"

The usual spelling is "SMBus".

> +	depends on I2C && PCI

The I2C dependency is handled at menu level so you do not have to
include it here.

> +	help
> +	  If you say Y or M to this option, support will be included for the

This specific wording seems to come from the old 2.4 times. These days
we write instead "If you say yes to this option, support etc."

> +	  Intel SCH based systems. Module will be called i2c-sch.ko.

And we no longer include the extension when giving a module name.
Module name which is now i2c-isch, BTW.

> +
>  config I2C_IBM_IIC
>  	tristate "IBM PPC 4xx on-chip I2C interface"
>  	depends on 4xx
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index e8c882a..9a9ec31 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
>  obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
>  obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
> +obj-$(CONFIG_I2C_SCH)		+= i2c-isch.o

In alphabetical order please.

>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
>  obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> new file mode 100644
> index 0000000..224e4aa
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -0,0 +1,362 @@
> +/*
> +    i2c-isch.c - Linux kernel driver for Intel SCH chipset SMBus
> +    - Based on i2c-piix4.c
> +    Copyright (c) 1998 - 2002 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
> +    Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
> +    - Intel SCH support
> +    Copyright (c) 2007 - 2008 Jacob Jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License version 2 as
> +    published by the Free Software Foundation.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*/
> +
> +/*
> +   Supports:
> +	Intel SCH
> +   Note: we assume there can only be one device, with one SMBus interface.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

Your driver no longer uses module parameters, so you don't need to
include this one.

> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/stddef.h>
> +#include <linux/ioport.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +
> +
> +struct sd {
> +	const unsigned short mfr;
> +	const unsigned short dev;
> +	const unsigned char fn;
> +	const char *name;
> +};

What's the point of defining a structure which you never use?

> +/* SCH SMBus address offsets */
> +#define SMBHSTCNT	(0 + sch_smba)
> +#define SMBHSTSTS	(1 + sch_smba)
> +#define SMBHSTADD	(4 + sch_smba) /* TSA */
> +#define SMBHSTCMD	(5 + sch_smba)
> +#define SMBHSTDAT0	(6 + sch_smba)
> +#define SMBHSTDAT1	(7 + sch_smba)
> +#define SMBBLKDAT	(0x20 + sch_smba)
> +
> +/* count for request_region */
> +#define SMBIOSIZE	64
> +
> +/* PCI Address Constants */
> +#define SMBBA_SCH	0x040
> +
> +/* Other settings */
> +#define MAX_TIMEOUT	500
> +#define  ENABLE_INT9	0

Not used anywhere, please delete.

> +
> +/* I2C constants */
> +#define SCH_QUICK		0x00
> +#define SCH_BYTE		0x01
> +#define SCH_BYTE_DATA		0x02
> +#define SCH_WORD_DATA		0x03
> +#define SCH_BLOCK_DATA		0x05
> +
> +static int sch_transaction(void);

This forward declaration isn't needed.

> +static unsigned short sch_smba;
> +static struct pci_driver sch_driver;
> +static struct i2c_adapter sch_adapter;
> +
> +/*
> + * Start the i2c transaction -- the i2c_access will prepare the transaction
> + * and this function will execute it.
> + * return 0 for success and others for failure.
> + */
> +static int sch_transaction(void)
> +{
> +	int temp;
> +	int result = 0;
> +	int timeout = 0;
> +
> +	dev_dbg(&sch_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
> +		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
> +		inb(SMBHSTCMD), inb(SMBHSTADD), inb(SMBHSTDAT0),
> +		inb(SMBHSTDAT1));
> +
> +	/* Make sure the SMBus host is ready to start transmitting */
> +	temp = inb(SMBHSTSTS) & 0x0f;
> +	if (temp & 0x08) {
> +		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
> +		return -EPERM;

-EAGAIN would be more appropriate I think. If the SMBus is busy now,
the user might want to try again later. But you're already testing for
this condition in sch_access(), so why do you need to test it again
here?

> +	} else if (temp & 0x01) {
> +		dev_dbg(&sch_adapter.dev, "Completion (%02x). "
> +			"clear...\n", temp);
> +		outb(temp, SMBHSTSTS);
> +	} else if (temp & 0x06) {
> +		dev_dbg(&sch_adapter.dev, "SMBus error (%02x). "
> +			"Resetting...\n", temp);
> +		outb(temp, SMBHSTSTS);
> +	}
> +	temp =  inb(SMBHSTSTS) & 0x0f;

Doubled space.

If the first inb() didn't report any error, there's no point in doing a
second one, is there?

> +	if (temp) {
> +		dev_err(&sch_adapter.dev,
> +			"SMBus is not ready: (%02x)\n", temp);
> +		return -EPERM;
> +	} else {
> +		dev_dbg(&sch_adapter.dev, "Successful!\n");

This will print a debug message on _every_ transaction. I think that
you should rework this part of the code to only read SMBHSTSTS once if
there is no error, and only log "Successful!" if you had to reset the
controller, and succeeded.

> +	}
> +
> +	/* start the transaction by setting bit 4 */
> +	outb(inb(SMBHSTCNT) | 0x10, SMBHSTCNT);
> +
> +	do {
> +		msleep(1);
> +		temp = inb(SMBHSTSTS) & 0x0f;
> +	} while ((temp & 0x08) && (timeout++ < MAX_TIMEOUT));
> +
> +	/* If the SMBus is still busy, we give up */
> +	if (timeout >= MAX_TIMEOUT) {
> +		dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
> +		result = -EPERM;

-ETIMEDOUT

> +	}
> +	if (temp & 0x04) {
> +		result = -EPERM;

-EIO

> +		dev_dbg(&sch_adapter.dev, "Bus collision! SMBus may be "
> +			"locked until next hard reset. (sorry!)\n");
> +		/* Clock stops and slave is stuck in mid-transmission */
> +	} else if (temp & 0x02) {
> +		result = -EPERM;

Please return -ENXIO in this case (we're in the process of updating all
the other drivers to do so.)

> +		dev_dbg(&sch_adapter.dev, "Error: no response!\n");
> +	} else if (temp & 0x01) {
> +		dev_dbg(&sch_adapter.dev, "Post complete!\n");
> +		outb(temp, SMBHSTSTS);
> +		temp = inb(SMBHSTSTS) & 0x07;
> +		if (temp & 0x06) {
> +			/* Completion clear failed*/

Missing space at end of comment.

> +			dev_dbg(&sch_adapter.dev, "Failed reset at end of "
> +				"transaction (%02x), Bus error\n", temp);
> +		}
> +	} else {
> +		result = -EPERM;

-EIO

> +		dev_dbg(&sch_adapter.dev, "Transaction failed.\n");

Shouldn't this be a dev_err()? It seems serious enough to let the user
know.

> +	}
> +	dev_dbg(&sch_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
> +		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
> +		inb(SMBHSTCMD), inb(SMBHSTADD), inb(SMBHSTDAT0),
> +		inb(SMBHSTDAT1));
> +	return result;
> +}
> +
> +/*
> + * This is the main access entry for i2c-sch access
> + * adap is i2c_adapter pointer, addr is the i2c device bus address, read_write
> + * (0 for read and 1 for write), size is i2c transaction type and data is the
> + * union of transaction for data to be transfered or data read from bus.
> + *
> + * return 0 for success and  others for failure.

Doubled space.

> + */
> +static s32 sch_access(struct i2c_adapter *adap, u16 addr,
> +		 unsigned short flags, char read_write,
> +		 u8 command, int size, union i2c_smbus_data *data)
> +{
> +	int i, len, temp;
> +
> +	/* Make sure the SMBus host is not busy*/

Missing space at end of comment.

> +	temp = inb(SMBHSTSTS) & 0x0f;
> +	if (temp & 0x08) {
> +		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
> +		return -EPERM;
> +	}

That would be -EAGAIN.

> +	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
> +		(read_write)?"READ":"WRITE");
> +	switch (size) {
> +	case I2C_SMBUS_QUICK:
> +		outb(((addr & 0x7f) << 1) | (read_write & 0x01),

read_write is 0 or 1, so masking it is pointless. Likewise, addr is a
7-bit value, so masking it with 0x7f is a no-op. Same for all cases
below.

> +		       SMBHSTADD);
> +		size = SCH_QUICK;
> +		break;
> +	case I2C_SMBUS_BYTE:
> +		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +		       SMBHSTADD);
> +		if (read_write == I2C_SMBUS_WRITE)
> +			outb(command, SMBHSTCMD);
> +		size = SCH_BYTE;
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +		       SMBHSTADD);
> +		outb(command, SMBHSTCMD);
> +		if (read_write == I2C_SMBUS_WRITE)
> +			outb(data->byte, SMBHSTDAT0);
> +		size = SCH_BYTE_DATA;
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +		       SMBHSTADD);
> +		outb(command, SMBHSTCMD);
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			outb(data->word & 0xff, SMBHSTDAT0);
> +			outb((data->word & 0xff00) >> 8, SMBHSTDAT1);
> +		}
> +		size = SCH_WORD_DATA;
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +		       SMBHSTADD);
> +		outb(command, SMBHSTCMD);
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			len = data->block[0];
> +			if (len < 0)

This will never be true, as data->block[0] is as u8.

> +				len = 0;

A block length of 0 is not valid according to the SMBus specification.

> +			if (len > 32)
> +				len = 32;

Please use I2C_SMBUS_BLOCK_MAX instead of hard-coded 32.

And anyway, please do not silently force the length value to be valid.
If the request is invalid, just reject it with -EINVAL.

> +			outb(len, SMBHSTDAT0);
> +			i = inb(SMBHSTCNT);	/* Reset SMBBLKDAT */

I doubt that this is really needed. The PIIX4 needed it because
SMBBLKDAT was a single I/O port. For the SCH, SMBBLKDAT is an array of
32 I/O ports, you can access each one directly, so there's nothing to
reset.

> +			for (i = 1; i <= len; i++)
> +				outb(data->block[i], SMBBLKDAT+i-1);
> +		}
> +		size = SCH_BLOCK_DATA;
> +		break;
> +	default:
> +		dev_err(&adap->dev, "I2C transaction not supported!\n");
> +		return -EPERM;

-EOPNOTSUPP

> +	}
> +	dev_dbg(&sch_adapter.dev, "write size %d to 0x%04x\n", size, SMBHSTCNT);
> +	outb((size & 0x7), SMBHSTCNT);

This overwrites the other bits of this register... is that OK?

> +
> +	if (sch_transaction())	/* Error in transaction */
> +		return -EPERM;

Please instead return the actual error value returned by
sch_transaction().

> +
> +	if ((read_write == I2C_SMBUS_WRITE) || (size == SCH_QUICK))
> +		return 0;
> +
> +	switch (size) {
> +	case SCH_BYTE:
> +		/* Where is the result put? I assume here it is in
> +		   SMBHSTDAT0 but it might just as well be in the
> +		   SMBHSTCMD. No clue in the docs */

Please drop this old comment, it doesn't apply here. You know, just
because you copied the code from the old i2c-piix4 driver, doesn't mean
that you had to copy all the crap without thinking whether it applied
to your case or not :(

> +		data->byte = inb(SMBHSTDAT0);
> +		break;
> +	case SCH_BYTE_DATA:
> +		data->byte = inb(SMBHSTDAT0);
> +		break;

You can merge the SCH_BYTE and SCH_BYTE_DATA cases.

> +	case SCH_WORD_DATA:
> +		data->word = inb(SMBHSTDAT0) + (inb(SMBHSTDAT1) << 8);
> +		break;
> +	case SCH_BLOCK_DATA:
> +		data->block[0] = inb(SMBHSTDAT0);
> +		i = inb(SMBHSTCNT);	/* Reset SMBBLKDAT */

Again I doubt that this reset is needed.

> +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
> +			data->block[0] = I2C_SMBUS_BLOCK_MAX;

If data->block[0] > I2C_SMBUS_BLOCK_MAX this means that you received
invalid data, so just return -EPROTO. Same if data->block[0] == 0.

> +		for (i = 1; i <= data->block[0]; i++)
> +			data->block[i] = inb(SMBBLKDAT+i-1);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static u32 sch_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> +	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> +	    I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm smbus_algorithm = {
> +	.smbus_xfer	= sch_access,
> +	.functionality	= sch_func,
> +};
> +
> +static struct i2c_adapter sch_adapter = {
> +	.owner		= THIS_MODULE,
> +	.class		= I2C_CLASS_HWMON,
> +	.algo		= &smbus_algorithm,
> +};
> +
> +static struct pci_device_id sch_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SCH_LPC),
> +	  .driver_data = 0x40 },

You are not using driver_data anywhere, so what's the point? And you
really don't need it anyway. So please drop all the code related to it.

> +	{ 0, }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, sch_ids);
> +
> +static int __devinit sch_probe(struct pci_dev *dev,
> +				const struct pci_device_id *id)
> +{
> +	int retval;
> +
> +	/* driver_data might come from user-space, so check it */
> +	if (id->driver_data & 1 || id->driver_data > 0xff)
> +		return -EINVAL;
> +
> +	pci_read_config_word(dev, SMBBA_SCH, &sch_smba);
> +	sch_smba &= 0xfff0;

This doesn't match the datasheet which says that the 6 LSBs, not 4, are
unused. But anyway according to the datasheet, these LSBs are hardcoded
to 0 so I don't think that you need this mask at all.

> +	if (sch_smba == 0) {
> +		dev_err(&dev->dev, "SMB base address uninitialized\n");
> +		return -ENODEV;
> +	}
> +	if (!request_region(sch_smba, SMBIOSIZE, sch_driver.name)) {
> +		dev_err(&dev->dev, "SMB region 0x%x already in use!\n",
> +			sch_smba);
> +		return -ENODEV;

We normally return -EBUSY in this case.

> +	}

Please use "SMBus" instead of "SMB" in both error messages.

> +	dev_dbg(&dev->dev, "SMBA = 0x%X\n", sch_smba);

What about bit 31 of this register? It says whether the I/O area is
enabled or not. If it's not then you're registering the device but it
won't work, that's no good.

> +
> +	/* set up the driverfs linkage to our parent device */

There's no such thing as driverfs, you mean sysfs.

> +	sch_adapter.dev.parent = &dev->dev;
> +
> +	snprintf(sch_adapter.name, I2C_NAME_SIZE,
> +		"SMBus SCH adapter at %04x", sch_smba);

Bug. I2C_NAME_SIZE is the size of i2c client names, not i2c adapter
names. Use sizeof(sch_adapter.name) instead.

> +
> +	retval = i2c_add_adapter(&sch_adapter);
> +	if (retval) {
> +		dev_err(&dev->dev, "Couldn't register adapter!\n");
> +		release_region(sch_smba, SMBIOSIZE);
> +		sch_smba = 0;
> +	}
> +
> +	return retval;
> +}
> +
> +static void __devexit sch_remove(struct pci_dev *dev)
> +{
> +	if (sch_smba) {
> +		i2c_del_adapter(&sch_adapter);
> +		release_region(sch_smba, SMBIOSIZE);
> +		sch_smba = 0;
> +	}
> +}
> +
> +static struct pci_driver sch_driver = {
> +	.name		= "sch_smbus",

I'd name it "isch_smbus" for consistency.

> +	.id_table	= sch_ids,
> +	.probe		= sch_probe,
> +	.remove		= __devexit_p(sch_remove),
> +	.dynids.use_driver_data = 1,
> +};
> +
> +static int __init i2c_sch_init(void)
> +{
> +	return pci_register_driver(&sch_driver);
> +}
> +
> +static void __exit i2c_sch_exit(void)
> +{
> +	pci_unregister_driver(&sch_driver);
> +}
> +
> +MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Intel SCH SMBus driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(i2c_sch_init);
> +module_exit(i2c_sch_exit);

Please fix all the problems I reported and submit an updated patch.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
