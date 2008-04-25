From: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Subject: Re: [PATCH] i2c: Add Intel SCH I2C SMBus support
Date: Fri, 25 Apr 2008 23:00:35 +0200
Message-ID: <48124673.8020808@assembler.cz>
References: <20080424100510.09cc2d4b@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080424100510.09cc2d4b-PCb9FJy6fea75v1z/vFq2g@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Alek,

Please check the review bellow. It took me hour and half which was quite
unexpected when I started. Jean would you please take a look too?

Thanks,
Rudolf

> +/*
> +    i2c-sch.c - Part of lm_sensors, Linux kernel modules for hardware
> +    monitoring
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
> +       Intel SCH
> +
> +   Function i2c_sch_init and i2c_sch_exit are module init/exit entries, and
> +   sch_probe will be called for device initialization, In probe, SCH i2c
> +   adapter will be setup by sch_setup and added by i2c_add_adapter. sch_access
> +   is the main entry for the i2c-sch bus.
> +   Note: we assume there can only be one device, with one SMBus interface.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/stddef.h>
> +#include <linux/sched.h>
> +#include <linux/ioport.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/apm_bios.h>
> +#include <linux/io.h>
> +
> +
> +struct sd {
> +       const unsigned short mfr;
> +       const unsigned short dev;
> +       const unsigned char fn;
> +       const char *name;
> +};
> +/* SCH SMBus address offsets */
> +#define SMBHSTCNT      (0 + sch_smba)
> +#define SMBHSTSTS      (1 + sch_smba)
> +#define SMBHSTADD      (4 + sch_smba) /* TSA */
> +#define SMBHSTCMD      (5 + sch_smba)
> +#define SMBHSTDAT0     (6 + sch_smba)
> +#define SMBHSTDAT1     (7 + sch_smba)
> +#define SMBBLKDAT      (0x20 + sch_smba)
> +
> +
> +/* count for request_region */
> +#define SMBIOSIZE      8

No it is 64 bytes

> +
> +/* PCI Address Constants */
> +#define SMBBA_SCH      0x040
> +
> +/* Other settings */
> +#define MAX_TIMEOUT    500
> +#define  ENABLE_INT9   0
> +
> +/* I2C constants */
> +#define SCH_QUICK              0x00
> +#define SCH_BYTE               0x01
> +#define SCH_BYTE_DATA          0x02
> +#define SCH_WORD_DATA          0x03
> +#define SCH_BLOCK_DATA 0x05

Maybe your mailer did something to the tabs. You can run:

indent -kr -i8 i2ci-sch.c

It will fix all coding style issues. (I think except that it put labels
indented, you may revert that). We take here also text attachments, which are
fine through thunderbird. You seem to use clawmail so I cant help much.

> +
> +/* insmod parameters */
> +
> +/* If force is set to anything different from 0, we forcibly enable the
> +   SCH. DANGEROUS! */
> +static int force;
> +module_param(force, int, 0);
> +MODULE_PARM_DESC(force, "Forcibly enable the I2C. DANGEROUS!");

Hmm not sure if it is good now. The newer BIOSes are much more saner than the
old - but here it is some left_over - check bellow.

> +
> +
> +static int sch_transaction(void);
> +
> +static unsigned short sch_smba;
> +static struct pci_driver sch_driver;
> +static struct i2c_adapter sch_adapter;
> +
> +/*
> + * sch_probe will call this function to get SMBus base address
> + * sch_dev and id are the arguments from probe functions
> + * return 0 for success and -ENODEV for failure
> + */
> +static int __devinit sch_setup(struct pci_dev *sch_dev,
> +                               const struct pci_device_id *id)
> +{
> +       unsigned short smbase;
> +       if (sch_dev->device != PCI_DEVICE_ID_INTEL_SCH_LPC) {
> +               /* match up the function */
> +               if (PCI_FUNC(sch_dev->devfn) != id->driver_data)
> +                       return -ENODEV;
> +               dev_info(&sch_dev->dev, "Found %s device\n", pci_name(sch_dev));
> +       } else {
> +               dev_info(&sch_dev->dev, "Found SCH SMBUS %s device\n",
> +                       pci_name(sch_dev));
> +               /* find SMBUS base address */
> +               pci_read_config_word(sch_dev, 0x40, &smbase);
> +               dev_info(&sch_dev->dev, "SCH SM base = 0x%04x\n", smbase);
> +       }
> +
> +
> +       /* Determine the address of the SMBus areas */
> +       if (sch_dev->device == PCI_DEVICE_ID_INTEL_SCH_LPC)
> +               pci_read_config_word(sch_dev, SMBBA_SCH, &sch_smba);
> +       else
> +               sch_smba = 0;
> +       sch_smba &= 0xfff0;
> +       if (sch_smba == 0) {
> +               dev_err(&sch_dev->dev, "SMB base address "
> +                       "uninitialized - upgrade BIOS or use "
> +                       "force_addr=0xaddr\n");
> +               return -ENODEV;
> +       }
> +
> +       if (!request_region(sch_smba, SMBIOSIZE, sch_driver.name)) {
> +               dev_err(&sch_dev->dev, "SMB region 0x%x already in use!\n",
> +                       sch_smba);
> +               return -ENODEV;
> +       }
> +


Hmm its difficult for me to understand what are you trying to do with this
function? It seems you are trying to handle the case when the PCI_ID came from
user space? Also it seems force_addr parameter is gone.

Maybe we can do that like it is done now in i2c-viapro.c. But with the exception
that there seems to be no SMBUs enable bit except the bit32 in the BAR. To make
it compatible with some future versions where the BAR 0x40 wont be 0x40 please
use the driver_data to hold the register register value for the BAR and guard it
with:

        /* driver_data might come from user-space, so check it */
        if (id->driver_data & 3 || id->driver_data > 0xff)
                return -EINVAL;

and then allow the force_addr like this:

/* Determine the address of the SMBus areas */
	if (force_addr) {
		sch_smba = force_addr & 0xffc0;
		pci_write_config_dword(sch_dev, id->driver_data,
					sch_smba | 0x80000000);

	}


If  force or force_addr was used I think we should put back registers after
sleep (resume). Maybe we should save/load the BAR0x40 because the BIOS might forgot?

	pci_read_config_byte(sch_dev, id->driver_data, &tmp);

	/* and check if user wants to just enable the controller without forcing any
address */
	if (force) {
		tmp |= 0x80;
		pci_write_config_byte(sch_dev, id->driver_data, tmp);
	}

	if (!(tmp & 0x80))
		dev_err(&sch_dev->dev, "SMBus controller not enabled */
		return -ENODEV (or use goto style maybe better)
	}

> +       dev_dbg(&sch_dev->dev, "SMBA = 0x%X\n", sch_smba);
> +
> +       return 0;
> +}
> +
> +/*
> + * Start the i2c transaction -- the i2c_access will prepare the transaction
> + * and this function will execute it.
> + * return 0 for success and others for failure.
> + */
> +static int sch_transaction(void)
> +{
> +       int temp;
> +       int result = 0;
> +       int timeout = 0;
> +
> +       dev_dbg(&sch_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
> +               "ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
> +               inb(SMBHSTCMD), inb(SMBHSTADD), inb(SMBHSTDAT0),
> +               inb(SMBHSTDAT1));
> +
> +       /* Make sure the SMBus host is ready to start transmitting */
> +       temp = inb(SMBHSTSTS);
> +       if (temp) {
> +               if (temp == 1) {

not sure if undocumented bit should be masked out

> +                       dev_dbg(&sch_adapter.dev, "Completion (%02x). "
> +                               "clear...\n", temp);
> +                       outb(temp, SMBHSTSTS);
> +               } else if (temp & 0xe) {
> +                       dev_dbg(&sch_adapter.dev, "SMBus error (%02x). "
> +                               "Resetting...\n", temp);

You cant access the controller when the BUSY is set, nor you can try to clear
it. The error logic before transaction start must be fixed. check also the
access function for the BUSY bit.

> +                       outb(temp, SMBHSTSTS);
> +               }
> +               temp =  inb(SMBHSTSTS);
> +               if (temp) {

and here too (reserved regs usage)

> +                       dev_err(&sch_adapter.dev,
> +                               "SMBus is not ready: (%02x)\n", temp);
> +                       return -EPERM;
> +               } else {
> +                       dev_dbg(&sch_adapter.dev, "Successfull!\n");

spelling mistake

> +               }
> +       }
> +
> +       /* start the transaction by setting bit 4 */
> +       outb(inb(SMBHSTCNT) | 0x10, SMBHSTCNT);
> +
> +       do {
> +               msleep(1);
> +               temp = inb(SMBHSTSTS);
> +       } while ((temp & 0x08) && (timeout++ < MAX_TIMEOUT));
> +
> +       /* If the SMBus is still busy, we give up */
> +       if (timeout >= MAX_TIMEOUT) {
> +               dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
> +               result = -EPERM;
> +       }
> +
> +       if (temp & 0x10) {
> +               result = -EPERM;
> +               dev_err(&sch_adapter.dev, "Error: Failed bus transaction\n");
> +       }

bit 0x10 is reserved. Maybe 0x4?

> +
> +       if (temp & 0x08) {
> +               result = -EPERM;
> +               dev_dbg(&sch_adapter.dev, "Bus collision! SMBus may be "
> +                       "locked until next hard reset. (sorry!)\n");
> +               /* Clock stops and slave is stuck in mid-transmission */
> +       }

I think if we are still busy we wont get here because we escape through the timeout.

> +
> +       if (temp & 0x04) {
> +               result = -EPERM;
> +               dev_dbg(&sch_adapter.dev, "Error: no response!\n");
> +       }

I think this should be 0x2 - device error.

> +       temp = inb(SMBHSTSTS);
> +       if (temp) {
> +               if (temp == 0x1) {
> +                       dev_dbg(&sch_adapter.dev, "post complete!\n");

again here reserved registers are assumed to be zero.

> +                       outb(temp, SMBHSTSTS);
> +               } else if (temp & 0xe) {
> +                       dev_dbg(&sch_adapter.dev, "Error: bus, etc!\n");
> +                       outb(inb(SMBHSTSTS), SMBHSTSTS);
> +               }
> +       }
> +       msleep(1);

why?

> +       temp = inb(SMBHSTSTS);
> +       if (temp & 0xe) {
> +               /* BSY, device or bus error */
> +               dev_err(&sch_adapter.dev, "Failed reset at end of "
> +                       "transaction (%02x), Bus error\n", temp);

Maybe write that transaction did not complete. Also quite a lot device error
would be when probing the bus with i2cdetect command. The unclaimed device
cycles should be marked as debug so we dont waste log when probing for the
device. Also maybe we can mark it as real error only if the quick write was not
used? Jean, what do you think?

> +       }
> +       dev_dbg(&sch_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
> +               "ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
> +               inb(SMBHSTCMD), inb(SMBHSTADD), inb(SMBHSTDAT0),
> +               inb(SMBHSTDAT1));
> +       return result;
> +}
> +
> +/*
> + * This is the main access entry for i2c-sch access
> + * adap is i2c_adapter pointer, addr is the i2c device bus address, read_write
> + * (0 for read and 1 for write), size is i2c transaction type and data is the
> + * union of transaction for data to be transfered or data read from bus.
> + *
> + * return 0 for success and  others for failure.
> + */
> +static s32 sch_access(struct i2c_adapter *adap, u16 addr,
> +                unsigned short flags, char read_write,
> +                u8 command, int size, union i2c_smbus_data *data)
> +{
> +       int i, len;
> +       dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
> +               (read_write)?"READ":"WRITE");

You _cant_ access the controller if busy is set. Maybe some check here? with
timeout?

> +       switch (size) {
> +       case I2C_SMBUS_PROC_CALL:
> +               dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
> +               return -EPERM;

I think this should not happen.

> +       case I2C_SMBUS_QUICK:
> +               outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +                      SMBHSTADD);
> +               size = SCH_QUICK;
> +               break;
> +       case I2C_SMBUS_BYTE:
> +               outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +                      SMBHSTADD);
> +               if (read_write == I2C_SMBUS_WRITE)
> +                       outb(command, SMBHSTCMD);
> +               size = SCH_BYTE;
> +               break;
> +       case I2C_SMBUS_BYTE_DATA:
> +               outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +                      SMBHSTADD);
> +               outb(command, SMBHSTCMD);
> +               if (read_write == I2C_SMBUS_WRITE)
> +                       outb(data->byte, SMBHSTDAT0);
> +               size = SCH_BYTE_DATA;
> +               break;
> +       case I2C_SMBUS_WORD_DATA:
> +               outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +                      SMBHSTADD);
> +               outb(command, SMBHSTCMD);
> +               if (read_write == I2C_SMBUS_WRITE) {
> +                       outb(data->word & 0xff, SMBHSTDAT0);
> +                       outb((data->word & 0xff00) >> 8, SMBHSTDAT1);
> +               }
> +               size = SCH_WORD_DATA;
> +               break;
> +       case I2C_SMBUS_BLOCK_DATA:
> +               outb(((addr & 0x7f) << 1) | (read_write & 0x01),
> +                      SMBHSTADD);
> +               outb(command, SMBHSTCMD);
> +               if (read_write == I2C_SMBUS_WRITE) {
> +                       len = data->block[0];
> +                       if (len < 0)
> +                               len = 0;
> +                       if (len > 32)
> +                               len = 32;
> +                       outb(len, SMBHSTDAT0);
> +                       i = inb(SMBHSTCNT);     /* Reset SMBBLKDAT */

Note that this is not documented in datasheet. And I think it works different
way. Not as FIFO but as registers.

> +                       for (i = 1; i <= len; i++)
> +                               outb(data->block[i], SMBBLKDAT);

No never would work. You did not tested that didn't you?

MAybe you can test the driver with following commands. Assuming that you have
SPD eeprom on 0x50.

modprobe i2c-dev
modprobe i2c-sch

i2cdump -l
will list the busses, assuming it is 0 please try following:

i2cdetect 0

It should detect all devices, maybe on 0x50 or 0x51 SPD eeprom. Use this device
for other tests:

i2cdump  0 0x50 b
i2cdump  0 0x50 c
i2cdump  0 0x50 W
i2cdump  0 0x50 s

This commands should produce same results.

i2cdump  0 0x50 w

You should see above in daisy chained mode. If the byte mode was:
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?

Now you should see:

00: 0880 0708 0d07 0a0d 020a 4002 0040 0400
08: 5004 6050 0060 8200 0882 0008 0100 0e01 (e1 is from offset 0x10)

CHeck log aftewards if there is nothing unusual.


> +               }
> +               size = SCH_BLOCK_DATA;
> +               break;
> +       }
> +       dev_dbg(&sch_adapter.dev, "write size %d to 0x%04x\n", size, SMBHSTCNT);
> +       outb((size & 0x7), SMBHSTCNT);

You are overwriting here one reserved bit.

> +
> +       if (sch_transaction())  /* Error in transaction */
> +               return -EPERM;
> +
> +       if ((read_write == I2C_SMBUS_WRITE) || (size == SCH_QUICK))
> +               return 0;

Well maybe the write quick success/error handling is here.

> +
> +
> +       switch (size) {
> +       case SCH_BYTE:
> +               /* Where is the result put? I assume here it is in
> +                  SMBHSTDAT0 but it might just as well be in the
> +                  SMBHSTCMD. No clue in the docs */

Well check with my test ;)

> +               data->byte = inb(SMBHSTDAT0);
> +               break;
> +       case SCH_BYTE_DATA:
> +               data->byte = inb(SMBHSTDAT0);
> +               break;
> +       case SCH_WORD_DATA:
> +               data->word = inb(SMBHSTDAT0) + (inb(SMBHSTDAT1) << 8);
> +               break;
> +       case SCH_BLOCK_DATA:
> +               data->block[0] = inb(SMBHSTDAT0);
> +               i = inb(SMBHSTCNT);     /* Reset SMBBLKDAT */
> +               for (i = 1; i <= data->block[0]; i++)
> +                       data->block[i] = inb(SMBBLKDAT);
> +               break;

No way. It is different now. Fix it please.

> +       }
> +       return 0;
> +}
> +
> +static u32 sch_func(struct i2c_adapter *adapter)
> +{
> +       return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> +           I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> +           I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm smbus_algorithm = {
> +       .smbus_xfer     = sch_access,
> +       .functionality  = sch_func,
> +};
> +
> +static struct i2c_adapter sch_adapter = {
> +       .owner          = THIS_MODULE,
> +       .class          = I2C_CLASS_HWMON,
> +       .algo           = &smbus_algorithm,
> +};
> +
> +static struct pci_device_id sch_ids[] = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SCH_LPC),
> +         .driver_data = 0xf8 },

Please set it to 0x40 as suggested above.

> +       { 0, }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, sch_ids);
> +
> +static int __devinit sch_probe(struct pci_dev *dev,
> +                               const struct pci_device_id *id)
> +{
> +       int retval;
> +       retval = sch_setup(dev, id);
> +       if (retval)
> +               return retval;
> +

Maybe you can merge it with function above.

> +       /* set up the driverfs linkage to our parent device */
> +       sch_adapter.dev.parent = &dev->dev;
> +
> +       snprintf(sch_adapter.name, I2C_NAME_SIZE,
> +               "SMBus SCH adapter at %04x", sch_smba);
> +
> +       retval = i2c_add_adapter(&sch_adapter);
> +       if (retval) {
> +               dev_err(&dev->dev, "Couldn't register adapter!\n");
> +               release_region(sch_smba, SMBIOSIZE);
> +               sch_smba = 0;
> +       }
> +
> +       return retval;
> +}
> +
> +static void __devexit sch_remove(struct pci_dev *dev)
> +{
> +       if (sch_smba) {
> +               i2c_del_adapter(&sch_adapter);
> +               release_region(sch_smba, SMBIOSIZE);
> +               sch_smba = 0;
> +       }
> +}
> +
> +static struct pci_driver sch_driver = {
> +       .name           = "sch_smbus",
> +       .id_table       = sch_ids,
> +       .probe          = sch_probe,
> +       .remove         = __devexit_p(sch_remove),

.dynids.use_driver_data = 1,

and this.


> +};
> +
> +static int __init i2c_sch_init(void)
> +{
> +       return pci_register_driver(&sch_driver);
> +}
> +
> +static void __exit i2c_sch_exit(void)
> +{
> +       pci_unregister_driver(&sch_driver);
> +}
> +
> +MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
> +               "Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org> and "
> +               "Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> ");
> +MODULE_DESCRIPTION("Intel SCH SMBus driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(i2c_sch_init);
> +module_exit(i2c_sch_exit);
> --
> 1.5.2.5
> --
> 
> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEkZh3J9wPJqZRNURAm7YAKC3xmN59rlFm2Qxxpk4U4HEkA6QqwCfURR8
7xpG07f3CBCY//eRd92o26Y=
=s0xF
-----END PGP SIGNATURE-----

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
