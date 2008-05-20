From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] i2c: Add Intel SCH I2C SMBus support
Date: Tue, 20 May 2008 13:10:12 +0200
Message-ID: <20080520131012.5a2ac832@hyperion.delvare>
References: <20080428105738.06429ed2@hyperion.delvare>
	<20080429110628.66d4892b@dxy.sh.intel.com>
	<8AD95083DC3E36478732061D97524415030F8FAA@pdsmsx411.ccr.corp.intel.com>
	<20080430080351.57b8c21d@hyperion.delvare>
	<20080505141807.1aa458e1@dxy.sh.intel.com>
	<20080505110757.6454c220@hyperion.delvare>
	<20080506095036.274e91f1@dxy.sh.intel.com>
	<20080512225718.7440ab42@hyperion.delvare>
	<20080520135635.55238a08@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520135635.55238a08-PCb9FJy6fea75v1z/vFq2g@public.gmane.org>
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

On Tue, 20 May 2008 13:56:35 +0800, Alek Du wrote:
> Here is my patch v3, please help to review it:

Here you go. It's getting a lot better but a couple things still need
to be fixed:

> This patch adds Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L) i2c bus support.
> 
> Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig    |   10 ++
>  drivers/i2c/busses/Makefile   |    1 +
>  drivers/i2c/busses/i2c-isch.c |  335 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-isch.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 48438cc..c052b14 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -267,6 +267,16 @@ config I2C_IOP3XX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-iop3xx.
>  
> +config I2C_ISCH
> +	tristate "Intel SCH SMBus 1.0"
> +	depends on PCI
> +	help
> +	  Say Y if you want to use IIC/SMBus controller on

Please avoid the "IIC" spelling and always use "I2C". In this
particular case, it's not correct anyway: the SCH includes an SMBus 1
controller, NOT an I2C controller.

> +	  the Intel SCH based systems.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-isch.
> +
>  config I2C_IXP2000
>  	tristate "IXP2000 GPIO-Based I2C Interface (DEPRECATED)"
>  	depends on ARCH_IXP2000
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index e8c882a..bb3c3f6 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
>  obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
>  obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
>  obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
> +obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
>  obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
>  obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> new file mode 100644
> index 0000000..41540c5
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -0,0 +1,335 @@
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
> +	Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L)
> +   Note: we assume there can only be one device, with one SMBus interface.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/stddef.h>
> +#include <linux/ioport.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +
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
> +#define SMBBA_SCH	0x40
> +
> +/* Other settings */
> +#define MAX_TIMEOUT	500
> +
> +/* I2C constants */
> +#define SCH_QUICK		0x00
> +#define SCH_BYTE		0x01
> +#define SCH_BYTE_DATA		0x02
> +#define SCH_WORD_DATA		0x03
> +#define SCH_BLOCK_DATA		0x05
> +
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
> +	if (temp) {
> +		/* Can not be busy since we checked it in sch_access */
> +		if (temp & 0x01) {
> +			dev_dbg(&sch_adapter.dev, "Completion (%02x). "
> +				"clear...\n", temp);

I suggest an upper-case C to "Clear" for consistency.

> +		} else if (temp & 0x06) {

Not sure why there would be an "else" here - both cases can happen at
the same time, can't they?

> +			dev_dbg(&sch_adapter.dev, "SMBus error (%02x). "
> +				"Resetting...\n", temp);
> +		}
> +		outb(temp, SMBHSTSTS);
> +		temp = inb(SMBHSTSTS) & 0x0f;
> +		if (temp) {
> +			dev_err(&sch_adapter.dev,
> +				"SMBus is not ready: (%02x)\n", temp);
> +			return -EPERM;

-EPERM doesn't look correct. That would be -EAGAIN if there's a hope
for the problem to be solved after some time, else maybe -EBUSY or just
-EIO.

> +		}
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
> +		result = -EAGAIN;
> +	}
> +	if (temp & 0x04) {
> +		result = -EIO;
> +		dev_dbg(&sch_adapter.dev, "Bus collision! SMBus may be "
> +			"locked until next hard reset. (sorry!)\n");
> +		/* Clock stops and slave is stuck in mid-transmission */
> +	} else if (temp & 0x02) {
> +		result = -ENXIO;
> +		dev_dbg(&sch_adapter.dev, "Error: no response!\n");
> +	} else if (temp & 0x01) {
> +		dev_dbg(&sch_adapter.dev, "Post complete!\n");
> +		outb(temp, SMBHSTSTS);
> +		temp = inb(SMBHSTSTS) & 0x07;
> +		if (temp & 0x06) {
> +			/* Completion clear failed */
> +			dev_dbg(&sch_adapter.dev, "Failed reset at end of "
> +				"transaction (%02x), Bus error\n", temp);
> +		}
> +	} else {
> +		result = -EIO;
> +		/* have to use dev_dbg here, dev_err will mess up i2cdetect */
> +		dev_dbg(&sch_adapter.dev, "Transaction failed.\n");

Oh, really? i2cdetect should receive nacks when devices aren't there,
and this is supposedly covered by (temp & 0x02) above, where I had you
return -ENXIO. If this isn't the case then (temp & 0x02) should return
-EIO and print an error message, and the fallback case should return
-ENXIO. As a general rule, we want dev_dbg() and -ENXIO for the nack
case, and dev_err() for all other error cases.

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
> + * return 0 for success and others for failure.
> + */
> +static s32 sch_access(struct i2c_adapter *adap, u16 addr,
> +		 unsigned short flags, char read_write,
> +		 u8 command, int size, union i2c_smbus_data *data)
> +{
> +	int i, len, temp, rc;
> +
> +	/* Make sure the SMBus host is not busy */
> +	temp = inb(SMBHSTSTS) & 0x0f;
> +	if (temp & 0x08) {
> +		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
> +		return -EAGAIN;
> +	}
> +	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
> +		(read_write)?"READ":"WRITE");
> +	switch (size) {
> +	case I2C_SMBUS_QUICK:
> +		outb((addr << 1) | read_write, SMBHSTADD);
> +		size = SCH_QUICK;
> +		break;
> +	case I2C_SMBUS_BYTE:
> +		outb((addr << 1) | read_write, SMBHSTADD);
> +		if (read_write == I2C_SMBUS_WRITE)
> +			outb(command, SMBHSTCMD);
> +		size = SCH_BYTE;
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		outb((addr << 1) | read_write, SMBHSTADD);
> +		outb(command, SMBHSTCMD);
> +		if (read_write == I2C_SMBUS_WRITE)
> +			outb(data->byte, SMBHSTDAT0);
> +		size = SCH_BYTE_DATA;
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		outb((addr << 1) | read_write, SMBHSTADD);
> +		outb(command, SMBHSTCMD);
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			outb(data->word & 0xff, SMBHSTDAT0);
> +			outb((data->word & 0xff00) >> 8, SMBHSTDAT1);
> +		}
> +		size = SCH_WORD_DATA;
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		outb((addr << 1) | read_write, SMBHSTADD);
> +		outb(command, SMBHSTCMD);
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			len = data->block[0];
> +			if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
> +				return -EINVAL;
> +			outb(len, SMBHSTDAT0);
> +			for (i = 1; i <= len; i++)
> +				outb(data->block[i], SMBBLKDAT+i-1);
> +		}
> +		size = SCH_BLOCK_DATA;
> +		break;
> +	default:
> +		dev_err(&adap->dev, "I2C transaction not supported!\n");

The standard error message for this had become:

		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);

(See http://lists.lm-sensors.org/pipermail/i2c/2008-May/003715.html )

> +		return -EOPNOTSUPP;
> +	}
> +	dev_dbg(&sch_adapter.dev, "write size %d to 0x%04x\n", size, SMBHSTCNT);
> +	outb((inb(SMBHSTCNT) & 0xb0) | (size & 0x7), SMBHSTCNT);
> +
> +	rc = sch_transaction();
> +	if (rc)	/* Error in transaction */
> +		return rc;
> +
> +	if ((read_write == I2C_SMBUS_WRITE) || (size == SCH_QUICK))
> +		return 0;
> +
> +	switch (size) {
> +	case SCH_BYTE:
> +	case SCH_BYTE_DATA:
> +		data->byte = inb(SMBHSTDAT0);
> +		break;
> +	case SCH_WORD_DATA:
> +		data->word = inb(SMBHSTDAT0) + (inb(SMBHSTDAT1) << 8);
> +		break;
> +	case SCH_BLOCK_DATA:
> +		data->block[0] = inb(SMBHSTDAT0);
> +		if (data->block[0] == 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
> +			return -EPROTO;
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
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SCH_LPC),},

The comma before the closing parenthesis should instead be a space.

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

You no longer use driver_data so this test should go away.

> +
> +	pci_read_config_word(dev, SMBBA_SCH, &sch_smba);
> +	if (sch_smba == 0) {
> +		dev_err(&dev->dev, "SMBus base address uninitialized\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!request_region(sch_smba, SMBIOSIZE, sch_driver.name)) {
> +		dev_err(&dev->dev, "SMBus region 0x%x already in use!\n",
> +			sch_smba);
> +		return -EBUSY;
> +	}
> +	dev_dbg(&dev->dev, "SMBA = 0x%X\n", sch_smba);
> +
> +	/* set up the sysfs linkage to our parent device */
> +	sch_adapter.dev.parent = &dev->dev;
> +
> +	snprintf(sch_adapter.name, sizeof(sch_adapter.name),
> +		"SMBus SCH adapter at %04x", sch_smba);
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
> +	.name		= "isch_smbus",
> +	.id_table	= sch_ids,
> +	.probe		= sch_probe,
> +	.remove		= __devexit_p(sch_remove),
> +	.dynids.use_driver_data = 1,

No longer needed.

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

Please send a final update of this patch and I'll include it in my i2c
tree (so it goes in linux-next.)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
