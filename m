From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] I2C: add driver for SMBus Control Method Interface
Date: Wed, 16 Sep 2009 15:48:46 +0200
Message-ID: <20090916154846.70413d42@hyperion.delvare>
References: <20090916091825.GA29707@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090916091825.GA29707@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Crane,

On Wed, 16 Sep 2009 17:18:25 +0800, Crane Cai wrote:
> This driver supports the SMBus Control Method Interface. It needs BIOS declare
> ACPI control methods which described in SMBus Control Method Interface Spec.
> http://smbus.org/specs/smbus_cmi10.pdf
> 
> Hi Jean,
> This driver is modified as you commented last time and it is verified OK. Could
> you put some time to review and apply it?

Here you go:

> Thanks.
> 
> Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig   |   11 +
>  drivers/i2c/busses/Makefile  |    3 +
>  drivers/i2c/busses/i2c-cmi.c |  442 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 456 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-cmi.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8206442..afbc468 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -761,4 +761,15 @@ config SCx200_ACB
>  	  This support is also available as a module.  If so, the module
>  	  will be called scx200_acb.
>  
> +config I2C_CMI
> +	tristate "SMBus Control Method Interface"
> +	depends on ACPI
> +	help
> +	  This driver supports the SMBus Control Method Interface. It needs the
> +	  BIOS to declare ACPI control methods as described in the SMBus Control
> +	  Method Interface specification.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called i2c-cmi.
> +

I believe we should create a specific part in the Kconfig menu for this
driver, as we just did for ACPI-based hardware monitoring drivers.

>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index e654263..4e83162 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -2,6 +2,9 @@
>  # Makefile for the i2c bus drivers.
>  #
>  
> +# SMBus CMI driver
> +obj-$(CONFIG_I2C_CMI)		+= i2c-cmi.o
> +
>  # PC SMBus host controller drivers
>  obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
>  obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
> diff --git a/drivers/i2c/busses/i2c-cmi.c b/drivers/i2c/busses/i2c-cmi.c
> new file mode 100644
> index 0000000..555b482
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-cmi.c
> @@ -0,0 +1,442 @@
> +/*
> + * SMBus driver for ACPI SMBus CMI
> + *
> + * Copyright (C) 2009 Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation version 2.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/stddef.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/acpi.h>
> +
> +#define ACPI_SMBUS_HC_COMPONENT		0x00080000

This one isn't used anywhere. Is this OK?

> +#define ACPI_SMBUS_HC_CLASS		"smbus"
> +#define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
> +
> +ACPI_MODULE_NAME("smbus_cmi");
> +
> +struct smbus_methods_t {
> +	const char *mt_info;
> +	const char *mt_sbr;
> +	const char *mt_sbw;

I can see that adding const here required casts elsewhere in the code.
I didn't expect that, so it's probably better to remove the const here
to avoid the ugly casts.

> +};
> +
> +struct acpi_smbus_cmi {
> +	acpi_handle handle;
> +	struct i2c_adapter adapter;
> +	u8 cap_info:1;
> +	u8 cap_read:1;
> +	u8 cap_write:1;
> +};
> +
> +static const struct smbus_methods_t smbus_methods = {
> +	.mt_info = "_SBI",
> +	.mt_sbr  = "_SBR",
> +	.mt_sbw  = "_SBW",
> +};
> +
> +static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
> +	{"SMBUS01", 0},
> +	{"", 0}
> +};
> +
> +#define ACPI_SMBUS_STATUS_OK			0x00
> +#define ACPI_SMBUS_STATUS_FAIL			0x07
> +#define ACPI_SMBUS_STATUS_DNAK			0x10
> +#define ACPI_SMBUS_STATUS_DERR			0x11
> +#define ACPI_SMBUS_STATUS_CMD_DENY		0x12
> +#define ACPI_SMBUS_STATUS_UNKNOWN		0x13
> +#define ACPI_SMBUS_STATUS_ACC_DENY		0x17
> +#define ACPI_SMBUS_STATUS_TIMEOUT		0x18
> +#define ACPI_SMBUS_STATUS_NOTSUP		0x19
> +#define ACPI_SMBUS_STATUS_BUSY			0x1A
> +#define ACPI_SMBUS_STATUS_PEC			0x1F
> +
> +#define ACPI_SMBUS_PRTCL_WRITE			0x00
> +#define ACPI_SMBUS_PRTCL_READ			0x01
> +#define ACPI_SMBUS_PRTCL_QUICK			0x02
> +#define ACPI_SMBUS_PRTCL_BYTE			0x04
> +#define ACPI_SMBUS_PRTCL_BYTE_DATA		0x06
> +#define ACPI_SMBUS_PRTCL_WORD_DATA		0x08
> +#define ACPI_SMBUS_PRTCL_BLOCK_DATA		0x0a
> +
> +
> +static int
> +acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
> +		   char read_write, u8 command, int size,
> +		   union i2c_smbus_data *data)
> +{
> +	int result = 0;
> +	struct acpi_smbus_cmi *smbus_cmi = adap->algo_data;
> +	unsigned char protocol;
> +	acpi_status status = 0;
> +	struct acpi_object_list input;
> +	union acpi_object mt_params[5];
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	union acpi_object *pkg;
> +	char *method;
> +	int len = 0;
> +
> +	dev_dbg(&adap->dev, "access size: %d %s\n", size,
> +		(read_write) ? "READ" : "WRITE");
> +	switch (size) {
> +	case I2C_SMBUS_QUICK:
> +		protocol = ACPI_SMBUS_PRTCL_QUICK;
> +		command = 0;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			mt_params[3].type = ACPI_TYPE_INTEGER;
> +			mt_params[3].integer.value = 0;
> +			mt_params[4].type = ACPI_TYPE_INTEGER;
> +			mt_params[4].integer.value = 0;
> +		}
> +		break;
> +
> +	case I2C_SMBUS_BYTE:
> +		protocol = ACPI_SMBUS_PRTCL_BYTE;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			mt_params[3].type = ACPI_TYPE_INTEGER;
> +			mt_params[3].integer.value = 0;
> +			mt_params[4].type = ACPI_TYPE_INTEGER;
> +			mt_params[4].integer.value = 0;
> +		} else {
> +			command = 0;
> +		}
> +		break;
> +
> +	case I2C_SMBUS_BYTE_DATA:
> +		protocol = ACPI_SMBUS_PRTCL_BYTE_DATA;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			mt_params[3].type = ACPI_TYPE_INTEGER;
> +			mt_params[3].integer.value = 1;
> +			mt_params[4].type = ACPI_TYPE_INTEGER;
> +			mt_params[4].integer.value = data->byte;
> +		}
> +		break;
> +
> +	case I2C_SMBUS_WORD_DATA:
> +		protocol = ACPI_SMBUS_PRTCL_WORD_DATA;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			mt_params[3].type = ACPI_TYPE_INTEGER;
> +			mt_params[3].integer.value = 2;
> +			mt_params[4].type = ACPI_TYPE_INTEGER;
> +			mt_params[4].integer.value = data->word;
> +		}
> +		break;
> +
> +	case I2C_SMBUS_BLOCK_DATA:
> +		protocol = ACPI_SMBUS_PRTCL_BLOCK_DATA;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			len = data->block[0];
> +			if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
> +				return -EINVAL;
> +			mt_params[3].type = ACPI_TYPE_INTEGER;
> +			mt_params[3].integer.value = len;
> +			mt_params[4].type = ACPI_TYPE_BUFFER;
> +			mt_params[4].buffer.pointer = data->block + 1;
> +		}
> +		break;
> +
> +	default:
> +		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (read_write == I2C_SMBUS_READ) {
> +		protocol |= ACPI_SMBUS_PRTCL_READ;
> +		method = (char *)smbus_methods.mt_sbr;
> +		input.count = 3;
> +	} else {
> +		protocol |= ACPI_SMBUS_PRTCL_WRITE;
> +		method = (char *)smbus_methods.mt_sbw;
> +		input.count = 5;
> +	}
> +
> +	input.pointer = mt_params;
> +	mt_params[0].type = ACPI_TYPE_INTEGER;
> +	mt_params[0].integer.value = protocol;
> +	mt_params[1].type = ACPI_TYPE_INTEGER;
> +	mt_params[1].integer.value = addr;
> +	mt_params[2].type = ACPI_TYPE_INTEGER;
> +	mt_params[2].integer.value = command;
> +
> +	status = acpi_evaluate_object(smbus_cmi->handle, method, &input,
> +				      &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_ERROR((AE_INFO, "Evaluating %s: %i", method, status));
> +		return -EIO;
> +	}
> +
> +	pkg = buffer.pointer;
> +	if (pkg && pkg->type == ACPI_TYPE_PACKAGE)
> +		obj = pkg->package.elements;
> +	else {
> +		ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +		result = -EIO;
> +		goto out;
> +	}
> +	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
> +		ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +		result = -EIO;
> +		goto out;
> +	}
> +
> +	result = obj->integer.value;
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s return status: %i\n",
> +			  method, result));
> +
> +	switch (result) {
> +	case ACPI_SMBUS_STATUS_OK:
> +		break;
> +	case ACPI_SMBUS_STATUS_BUSY:
> +		result = -EBUSY;
> +		goto out;
> +	case ACPI_SMBUS_STATUS_TIMEOUT:
> +		result = -ETIMEDOUT;
> +		goto out;
> +	case ACPI_SMBUS_STATUS_DNAK:
> +		result = -ENXIO;
> +		goto out;
> +	default:
> +		result = -EIO;
> +		goto out;
> +	}
> +
> +	if (read_write == I2C_SMBUS_WRITE || size == I2C_SMBUS_QUICK)
> +		goto out;
> +
> +	obj = pkg->package.elements + 1;
> +	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
> +		ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +		result = -EIO;
> +		goto out;
> +	}
> +
> +	len = obj->integer.value;
> +	obj = pkg->package.elements + 2;
> +	switch (size) {
> +	case I2C_SMBUS_BYTE:
> +	case I2C_SMBUS_BYTE_DATA:
> +	case I2C_SMBUS_WORD_DATA:
> +		if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
> +			ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +			result = -EIO;
> +			goto out;
> +		}
> +		if (len == 2)
> +			data->word = obj->integer.value;
> +		else
> +			data->byte = obj->integer.value;
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (obj == NULL || obj->type != ACPI_TYPE_BUFFER) {
> +			ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +			result = -EIO;
> +			goto out;
> +		}
> +		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
> +			return -EPROTO;
> +		data->block[0] = len;
> +		memcpy(data->block + 1, obj->buffer.pointer, len);
> +		break;
> +	}
> +
> +out:
> +	kfree(buffer.pointer);
> +	dev_dbg(&adap->dev, "Transaction status: %i\n", result);
> +	return result;
> +}
> +
> +static u32 acpi_smbus_cmi_func(struct i2c_adapter *adapter)
> +{
> +	struct acpi_smbus_cmi *smbus_cmi = adapter->algo_data;
> +	u32 ret;
> +
> +	ret = smbus_cmi->cap_read | smbus_cmi->cap_write ?
> +		I2C_FUNC_SMBUS_QUICK : 0;
> +
> +	ret |= smbus_cmi->cap_read ?
> +		(I2C_FUNC_SMBUS_READ_BYTE |
> +		I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +		I2C_FUNC_SMBUS_READ_WORD_DATA |
> +		I2C_FUNC_SMBUS_READ_BLOCK_DATA) : 0;
> +
> +	ret |= smbus_cmi->cap_write ?
> +		(I2C_FUNC_SMBUS_WRITE_BYTE |
> +		I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WRITE_WORD_DATA |
> +		I2C_FUNC_SMBUS_WRITE_BLOCK_DATA) : 0;
> +
> +	return ret;
> +}
> +
> +static const struct i2c_algorithm acpi_smbus_cmi_algorithm = {
> +	.smbus_xfer = acpi_smbus_cmi_access,
> +	.functionality = acpi_smbus_cmi_func,
> +};
> +
> +static int acpi_smbus_cmi_add_cap(struct acpi_smbus_cmi *smbus_cmi,
> +				  const char *name)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	int i;
> +	acpi_status status;
> +
> +	if (!strcmp(name, smbus_methods.mt_info)) {
> +		status = acpi_evaluate_object(smbus_cmi->handle,
> +					(char *)smbus_methods.mt_info,
> +					NULL, &buffer);
> +		if (ACPI_FAILURE(status)) {
> +			ACPI_ERROR((AE_INFO, "Evaluating %s: %i",
> +				   smbus_methods.mt_info, status));
> +			return -EIO;
> +		}
> +
> +		obj = buffer.pointer;
> +		if (obj && obj->type == ACPI_TYPE_PACKAGE)
> +			obj = obj->package.elements;
> +		else {
> +			ACPI_ERROR((AE_INFO, "Invalid argument type"));
> +			kfree(buffer.pointer);
> +			return -EIO;
> +		}
> +
> +		if (obj->type != ACPI_TYPE_INTEGER) {
> +			ACPI_ERROR((AE_INFO, "Invalid argument type"));

Shouldn't you free buffer.pointer here?

> +			return -EIO;
> +		} else
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SMBus CMI Version %x"
> +					  "\n", (int)obj->integer.value));
> +
> +		obj = obj->package.elements + 1;
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SMB_INFO:\n"));
> +		for (i = 0; i < obj->buffer.length; i++) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%02x ",
> +						*(obj->buffer.pointer + i)));
> +			if (i > 0 && (i % 16) == 0 && i != obj->buffer.length-1)
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "\n"));

Did you try this? I suspect this will insert log level codes all around
the place and the output will be a mess. Fragmented logging is strongly
discouraged.

> +		}
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "\n"));
> +
> +		kfree(buffer.pointer);
> +		smbus_cmi->cap_info = 1;
> +	} else if (!strcmp(name, smbus_methods.mt_sbr))
> +		smbus_cmi->cap_read = 1;
> +	else if (!strcmp(name, smbus_methods.mt_sbw))
> +		smbus_cmi->cap_write = 1;
> +	else
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "CMI Methods: %s\n", name));

It won't be clear why this is printed. What about: "Unsupported CMI
method\n"?

> +
> +	return 0;
> +}
> +
> +static acpi_status acpi_smbus_cmi_query_methods(acpi_handle handle, u32 level,
> +			void *context, void **return_value)
> +{
> +	char node_name[5];
> +	struct acpi_buffer buffer = { sizeof(node_name), node_name };
> +	struct acpi_smbus_cmi *smbus_cmi = context;
> +	acpi_status status;
> +
> +	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
> +
> +	if (ACPI_SUCCESS(status))
> +		acpi_smbus_cmi_add_cap(smbus_cmi, node_name);
> +
> +	return AE_OK;
> +}
> +
> +static int acpi_smbus_cmi_add(struct acpi_device *device)
> +{
> +	struct acpi_smbus_cmi *smbus_cmi;
> +
> +	smbus_cmi = kzalloc(sizeof(struct acpi_smbus_cmi), GFP_KERNEL);
> +	if (!smbus_cmi)
> +		return -ENOMEM;
> +
> +	smbus_cmi->handle = device->handle;
> +	strcpy(acpi_device_name(device), ACPI_SMBUS_HC_DEVICE_NAME);
> +	strcpy(acpi_device_class(device), ACPI_SMBUS_HC_CLASS);
> +	device->driver_data = smbus_cmi;
> +	smbus_cmi->cap_info = 0;
> +	smbus_cmi->cap_read = 0;
> +	smbus_cmi->cap_write = 0;
> +
> +	acpi_walk_namespace(ACPI_TYPE_METHOD, smbus_cmi->handle, 1,
> +			    acpi_smbus_cmi_query_methods, smbus_cmi, NULL);
> +
> +	if (smbus_cmi->cap_info == 0)
> +		goto err;
> +
> +	snprintf(smbus_cmi->adapter.name, sizeof(smbus_cmi->adapter.name),
> +		"SMBus CMI adapter at %s-%s",
> +		acpi_device_name(device),
> +		acpi_device_uid(device));

"at" sounds strange, as what follows isn't an address. I'd rather use:

	"SMBus CMI adapter %s (%s)",
	acpi_device_name(device),
	acpi_device_uid(device)

> +	smbus_cmi->adapter.owner = THIS_MODULE;
> +	smbus_cmi->adapter.algo = &acpi_smbus_cmi_algorithm;
> +	smbus_cmi->adapter.algo_data = smbus_cmi;
> +	smbus_cmi->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	smbus_cmi->adapter.dev.parent = &device->dev;
> +
> +	if (i2c_add_adapter(&smbus_cmi->adapter)) {
> +		dev_err(&device->dev, "Couldn't register adapter!\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	kfree(smbus_cmi);
> +	device->driver_data = NULL;
> +	return -EIO;
> +}
> +
> +static int acpi_smbus_cmi_remove(struct acpi_device *device, int type)
> +{
> +	struct acpi_smbus_cmi *smbus_cmi = acpi_driver_data(device);
> +
> +	i2c_del_adapter(&smbus_cmi->adapter);
> +	kfree(smbus_cmi);
> +	smbus_cmi = NULL;

This is a no-op, smbus_cmi is a local variable. What you really want to
do is:

	device->driver_data = NULL;

> +
> +	return 0;
> +}
> +
> +static struct acpi_driver acpi_smbus_cmi_driver = {
> +	.name = ACPI_SMBUS_HC_DEVICE_NAME,
> +	.class = ACPI_SMBUS_HC_CLASS,
> +	.ids = acpi_smbus_cmi_ids,
> +	.ops = {
> +		.add = acpi_smbus_cmi_add,
> +		.remove = acpi_smbus_cmi_remove,
> +	},
> +};
> +
> +static int __init acpi_smbus_cmi_init(void)
> +{
> +	int result;
> +
> +	result = acpi_bus_register_driver(&acpi_smbus_cmi_driver);
> +
> +	return result;

This can be simplified to:

	return acpi_bus_register_driver(&acpi_smbus_cmi_driver);

> +}
> +
> +static void __exit acpi_smbus_cmi_exit(void)
> +{
> +	acpi_bus_unregister_driver(&acpi_smbus_cmi_driver);
> +}
> +
> +module_init(acpi_smbus_cmi_init);
> +module_exit(acpi_smbus_cmi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>");
> +MODULE_DESCRIPTION("ACPI SMBus CMI driver");

If you are fine with my latest proposals, I'll implement them myself,
no need to resend a patch. Thanks a lot for writing the driver!

I am considering renaming the driver to i2c-scmi, too. "i2c-cmi"
seems somewhat short and I fear name collisions in the future.

-- 
Jean Delvare
