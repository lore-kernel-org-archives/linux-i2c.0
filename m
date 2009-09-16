From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] I2C: add driver for SMBus Control Method Interface
Date: Wed, 16 Sep 2009 17:35:00 +0800
Message-ID: <20090916093500.GA13319@crane-desktop>
References: <20090827022958.GA18079@crane-desktop> <20090909180431.5253d624@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090909180431.5253d624-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

I revised the driver and resubmit a new new for you. I listed the changes below
so that it can make your review a little easy. One thing I missed:

> It would also look better if the two blocks above had the same
> indentation, and if you stuck to capitals or not capitals for
> hexadecimal numbers.
applied, removed it, sorry I missed the capital issue.

On Wed, Sep 09, 2009 at 06:04:31PM +0200, Jean Delvare wrote:
> > +config CMI_I2C
> 
> I2C_CMI
applied
> 
> > +	tristate "SMBus Control Method Interface"
> > +	depends on X86 && ACPI
> 
> Why depend on X86? As far as I know, IA64 systems can support ACPI too.
> And this dependency is already handled by CONFIG_ACPI so drivers
> shouldn't have to care.
applied
> 
> > +	help
> > +	  This driver supports the SMBus Control Method Interface. It needs
> > +	  BIOS declare ACPI control methods via SMBus Control Method Interface
> > +	  Spec.
> 
> I suggest rewording the second sentence as follows: "It needs the BIOS
> to declare ACPI control methods as described in the SMBus Control
> Method Interface specification."
applied
> 
> > +
> > +	  To compile this driver as a module, choose M here:
> > +	  the modules will be called cmi_i2c.
> 
> module (no s)
applied
> 
> >  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
> >  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> > +obj-$(CONFIG_CMI_I2C)		+= cmi_i2c.o
> 
> The i2c-cmi driver should probably be listed first: if built into the
> kernel, it should be loaded before native drivers.
applied
> 
> > +#include <linux/version.h>
> 
> This header file should never be included by in-tree drivers.
applied
> 
> > +#include <linux/delay.h>
> 
> Your driver doesn't seem to delay or sleep, so not needed.
applied
> 
> > +
> > +#define ACPI_SMB_HC_COMPONENT	0x00080000
> > +#define ACPI_SMB_HC_CLASS	"smbus"
> > +#define ACPI_SMB_HC_DEVICE_NAME	"smbus cmi"
> > +#define SMB_HC_DEVICE_NAME	"SMBus CMI adapter"
> 
> This last define is not used anywhere.
applied
> 
> > +
> > +#define _COMPONENT		ACPI_SMB_HC_COMPONENT
> 
> Nor this one.
applied
> 
> > +
> > +ACPI_MODULE_NAME("smbus_cmi");
> > +
> > +struct smbus_methods {
> > +	char *mt_info;
> > +	char *mt_sbr;
> > +	char *mt_sbw;
> 
> Shouldn't these be const char*?
applied
> 
> > +};
> > +
> > +struct acpi_smbus_cmi {
> > +	acpi_handle handle;
> > +	struct i2c_adapter adapter;
> > +	struct smbus_methods *methods;
> > +};
> > +
> > +static const struct smbus_methods smb_mtds = {
> 
> I suggest that you never use "smb" as an abbreviation for "SMBus":
> "smb" stands for a number of different things in computer science, so
> it can easily get confusing. And "smbus" isn't much longer.
> 
> Likewise, "mtds" as an abbreviation for "methods" doesn't save much
> space and somewhat hurts readability IMHO.
applied, smb -> smbus, mtds-> methods
> 
> > +	.mt_info = "_SBI",
> > +	.mt_sbr = "_SBR",
> > +	.mt_sbw = "_SBW",
> > +};
> 
> What's the point of having a per-device structure for this if all
> devices end up using the same hard-coded structure?
applied, remove it from per-device structure
> 
> > +
> > +static const struct acpi_device_id i2c_device_ids[] = {
> 
> I would suggest a different name than i2c_device_ids, because it's
> almost similar to an existing type (i2c_device_id). What about
> "acpi_smbus_cmi_ids"?
applied
> 
> > +	{"SMBUS01", 0},
> > +	{"", 0},
> 
> Trailing comma isn't needed, as you have a list terminator.
applied
> 
> > +static struct acpi_driver acpi_smb_cmi_driver = {
> > +	.name = ACPI_SMB_HC_DEVICE_NAME,
> > +	.class = ACPI_SMB_HC_CLASS,
> > +	.ids = i2c_device_ids,
> > +	.ops = {
> > +		.add = acpi_smb_cmi_add,
> > +		.remove = acpi_smb_cmi_remove,
> > +		},
> 
> Bad indentation for the last curly brace (should be aligned with ".ops".
applied
> 
> > +};
> 
> What about moving this driver definition later in the file, so that you
> no longer need to forward-declare the _add and _remove methods?
applied
> 
> > +
> > +#define ACPI_SMB_STATUS_PEC		0x1F
> > +
> > +#define ACPI_SMB_PRTCL_WRITE			0x0
> 
> 0x00 for consistency.
applied
> 
> > +#define ACPI_SMB_PRTCL_READ			0x01
> > +#define ACPI_SMB_PRTCL_QUICK			0x02
> > +#define ACPI_SMB_PRTCL_BYTE			0x04
> > +#define ACPI_SMB_PRTCL_BYTE_DATA		0x06
> > +#define ACPI_SMB_PRTCL_WORD_DATA		0x08
> > +#define ACPI_SMB_PRTCL_BLOCK_DATA		0x0a
> > +#define ACPI_SMB_PRTCL_PROC_CALL		0x0c
> > +#define ACPI_SMB_PRTCL_BLOCK_PROC_CALL		0x0d
> 
> Can't see this one in the CMI specification, and your driver doesn't
> use it anyway.
applied, removed it
> 
> > +#define ACPI_SMB_PRTCL_PEC			0x80
> 
> It would also look better if the two blocks above had the same
> indentation, and if you stuck to capitals or not capitals for
> hexadecimal numbers.
applied, removed it, sorry I missed the capital issue.
> 
> > +
> > +	result = obj->integer.value;
> > +	switch (result) {
> > +	case ACPI_SMB_STATUS_OK:
> 
> This assumes that ACPI_SMB_STATUS_OK == 0, which is true but is only a
> coincidence.
applied, add debug message
> 
> > +		break;
> > +	case ACPI_SMB_STATUS_BUSY:
> > +		result = -EBUSY;
> > +		goto out;
> > +	case ACPI_SMB_STATUS_TIMEOUT:
> > +		result = -ETIMEDOUT;
> > +		goto out;
> > +	case ACPI_SMB_STATUS_DNAK:
> > +		result = -ENXIO;
> > +		goto out;
> > +	default:
> > +		result = -EIO;
> > +		goto out;
> > +	}
> 
> You might want to log error messages for unknown errors, and maybe
> debug messages for known errors too.
applied, add dev_dbg for debug usage
> 
> > +
> > +	if (read_write == I2C_SMBUS_WRITE)
> 
> I think you also want to quit here on size == SMBUS_QUICK. What the CMI
> specification names "quick read" is really a write from a functional
> perspective.
applied
> 
> > +		goto out;
> > +
> > +	obj = pkg->package.elements + 1;
> > +	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
> > +		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus return package object \
> > +						type error\n"));
> 
> Not the right way to split a string.
applied
> 
> > +		result = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	len = obj->integer.value;
> > +	obj = pkg->package.elements + 2;
> > +	switch (size) {
> > +	case I2C_SMBUS_BYTE:
> > +	case I2C_SMBUS_BYTE_DATA:
> > +	case I2C_SMBUS_WORD_DATA:
> > +		if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
> > +			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus return package \
> > +						object type error\n"));
> 
> Same here.
applied
> 
> > +			result = -EIO;
> > +			goto out;
> > +		}
> > +		if (len == 2)
> > +			data->word = obj->integer.value & 0xffff;
> > +		else
> > +			data->byte = obj->integer.value & 0xff;
> 
> Masking is a no-op.
applied, removed them
> 
> > +		break;
> > +	case I2C_SMBUS_BLOCK_DATA:
> > +		if (obj == NULL || obj->type != ACPI_TYPE_BUFFER) {
> > +			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus return package \
> > +						object type error\n"));
> 
> Not the right way to split a string.
applied
> 
> > +			result = -EIO;
> > +			goto out;
> > +		}
> > +		data->block[0] = len;
> > +		if (data->block[0] == 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
> > +			return -EPROTO;
> 
> You should check the value of len before copying it to data->block[0].
> data->block[0] is a u8 so you might get wrapping issues.
applied
> 
> > +		memcpy(data->block + 1, obj->buffer.pointer, len);
> > +		break;
> > +	}
> > +
> > +out:
> > +	kfree(buffer.pointer);
> > +	return result;
> > +}
> > +
> > +static u32 acpi_smb_cmi_func(struct i2c_adapter *adapter)
> > +{
> > +
> > +	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> > +		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> > +		I2C_FUNC_SMBUS_BLOCK_DATA;
> > +}
> 
> It doesn't look correct to hard-code this. As I read the CMI
> specification, each SMBus segment exposed may or may not support each
> type of SMBus transaction. Unfortunately there doesn't seem to be any
> way to know the exact subset of transactions that are supported. But at
> least you could use the presence or absence of methods _SBR and _SBW to
> determine whether reading, writing or both are supported.
> 
> I hope this limitation won't cause too much trouble... some drivers
> really test for adapter functionality, and use different methods
> depending on the result.
applied, scan methods to determined its capability.
> 
> > +
> > +static const struct i2c_algorithm acpi_smbus_cmi_algorithm = {
> > +	.smbus_xfer = acpi_smb_cmi_access,
> > +	.functionality = acpi_smb_cmi_func,
> > +};
> > +
> > +static int acpi_smb_cmi_add(struct acpi_device *device)
> > +{
> > +	int status;
> > +	struct acpi_smbus_cmi *smb_cmi;
> > +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	union acpi_object *obj;
> > +
> > +	if (!device)
> > +		return -EINVAL;
> 
> How could this ever happen?
applied, removed it
> 
> > +	if (obj->type != ACPI_TYPE_INTEGER) {
> > +		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus CMI Version object type \
> > +								error\n"));
> 
> This isn't how strings are split in C. Instead, do:
> 
> 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus CMI Version object type "
> 								"error\n"));
applied
> 
> > +	} else
> > +		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus CMI Version %0x\n",
> 
> How does %0x differ from %x? This might be displayed nicer anyway, as
> we know this byte is encoded in BCD.
applied
> 
> > +					(int)obj->integer.value));
> > +	kfree(buffer.pointer);
> 
> Maybe list some more information from the SMB_INFO object, in
> particular the version of SMBus that is supported, and the number of
> devices on the bus? Icing on the cake would be the complete list of
> devices, but this can be added later.
applied, printed SMB_INFO out in debug message.
> 
> > +
> > +	snprintf(smb_cmi->adapter.name, sizeof(smb_cmi->adapter.name),
> > +		"SMBus CMI adapter");
> 
> Isn't it possible for a given systems to have more than one SMBus
> adapter of this type? The CMI specification suggests so. The i2c_adapter
> name is supposed to be unique within a given system. We usually add the
> device address or any other unique identifier at the end of the name.
> As I read the CMI specification, we should be able to use _UID for this
> purpose?
applied
> 
> > +	smb_cmi->adapter.owner = THIS_MODULE;
> > +	smb_cmi->adapter.algo = &acpi_smbus_cmi_algorithm;
> > +	smb_cmi->adapter.algo_data = smb_cmi;
> > +	smb_cmi->adapter.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> > +	smb_cmi->adapter.dev.parent = &device->dev;
> > +
> > +	if (i2c_add_adapter(&smb_cmi->adapter)) {
> > +		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> > +			  "SMBus CMI adapter: Failed to register adapter\n"));
> > +		kfree(smb_cmi);
> > +		return -EIO;
> 
> Why not just "goto err"?
applied
> 
> > +	}
> > +
> > +	printk(KERN_INFO PREFIX "%s [%s]\n",
> > +	       acpi_device_name(device), acpi_device_bid(device));
> 
> That's a little rough IMHO.
applied, removed
> 
> > +
> > +	return AE_OK;
> 
> I am surprised that you mix regular error codes with ACPI-specific ones.
applied
> 
> > +	if (!device)
> > +		return -EINVAL;
> 
> I fail to see how this would be possible.
applied
> 
> > +
> > +	smbus_cmi = acpi_driver_data(device);
> > +
> > +	i2c_del_adapter(&smbus_cmi->adapter);
> > +	kfree(smbus_cmi);
> 
> Care to reset driver data to NULL?
applied
> 
> > +
> > +	return AE_OK;
> 
> Here again, I am surprised by the mix of regular error codes and ACPI
> ones.
> 
> > +}
> > +
> > +static int __init acpi_smb_cmi_init(void)
> > +{
> > +	int result;
> > +
> > +	result = acpi_bus_register_driver(&acpi_smb_cmi_driver);
> > +	if (result < 0)
> > +		return -ENODEV;
> 
> Why don't you simply return the error code? Would be simpler and more
> informative too.
applied
> 
> > +MODULE_AUTHOR("Crane Cai");
> 
> No e-mail address?
applied
> 
> And lastly a general comment: is it OK that you always use
> ACPI_DEBUG_PRINT((ACPI_DB_WARN for all kernel messages, be they errors,
> warning or informational?
applied, ACPI_DEBUG_PRINT -> ACPI_ERROR etc.
> 
> -- 
> Jean Delvare

-- 
Best Regards,
- Crane
