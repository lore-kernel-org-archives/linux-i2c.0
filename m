From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] I2C: add driver for SMBus Control Method Interface
Date: Thu, 27 Aug 2009 10:29:58 +0800
Message-ID: <20090827022958.GA18079@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver supports the SMBus Control Method Interface. It needs BIOS declare
ACPI control methods via SMBus Control Method Interface Spec.
http://smbus.org/specs/smbus_cmi10.pdf

Hi Jean,
This driver can give BIOS a chance to avoid SMBus access conflicts on runtime.
And it obeys the SMBus CMI spec.
Please apply.

Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/Kconfig   |   11 ++
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/cmi_i2c.c |  391 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/cmi_i2c.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8206442..c4a5d6c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -761,4 +761,15 @@ config SCx200_ACB
 	  This support is also available as a module.  If so, the module
 	  will be called scx200_acb.
 
+config CMI_I2C
+	tristate "SMBus Control Method Interface"
+	depends on X86 && ACPI
+	help
+	  This driver supports the SMBus Control Method Interface. It needs
+	  BIOS declare ACPI control methods via SMBus Control Method Interface
+	  Spec.
+
+	  To compile this driver as a module, choose M here:
+	  the modules will be called cmi_i2c.
+
 endmenu
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e654263..12806df 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_CMI_I2C)		+= cmi_i2c.o
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/busses/cmi_i2c.c b/drivers/i2c/busses/cmi_i2c.c
new file mode 100644
index 0000000..69f3202
--- /dev/null
+++ b/drivers/i2c/busses/cmi_i2c.c
@@ -0,0 +1,391 @@
+/*
+ * SMBus driver for ACPI SMBus CMI
+ *
+ * Copyright (C) 2009 Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation version 2.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+
+#define ACPI_SMB_HC_COMPONENT	0x00080000
+#define ACPI_SMB_HC_CLASS	"smbus"
+#define ACPI_SMB_HC_DEVICE_NAME	"smbus cmi"
+#define SMB_HC_DEVICE_NAME	"SMBus CMI adapter"
+
+#define _COMPONENT		ACPI_SMB_HC_COMPONENT
+
+ACPI_MODULE_NAME("smbus_cmi");
+
+struct smbus_methods {
+	char *mt_info;
+	char *mt_sbr;
+	char *mt_sbw;
+};
+
+struct acpi_smbus_cmi {
+	acpi_handle handle;
+	struct i2c_adapter adapter;
+	struct smbus_methods *methods;
+};
+
+static const struct smbus_methods smb_mtds = {
+	.mt_info = "_SBI",
+	.mt_sbr = "_SBR",
+	.mt_sbw = "_SBW",
+};
+
+static const struct acpi_device_id i2c_device_ids[] = {
+	{"SMBUS01", 0},
+	{"", 0},
+};
+
+static int acpi_smb_cmi_add(struct acpi_device *device);
+static int acpi_smb_cmi_remove(struct acpi_device *device, int type);
+
+static struct acpi_driver acpi_smb_cmi_driver = {
+	.name = ACPI_SMB_HC_DEVICE_NAME,
+	.class = ACPI_SMB_HC_CLASS,
+	.ids = i2c_device_ids,
+	.ops = {
+		.add = acpi_smb_cmi_add,
+		.remove = acpi_smb_cmi_remove,
+		},
+};
+
+#define ACPI_SMB_STATUS_OK		0x00
+#define ACPI_SMB_STATUS_FAIL		0x07
+#define ACPI_SMB_STATUS_DNAK		0x10
+#define ACPI_SMB_STATUS_DERR		0x11
+#define ACPI_SMB_STATUS_CMD_DENY	0x12
+#define ACPI_SMB_STATUS_UNKNOWN		0x13
+#define ACPI_SMB_STATUS_ACC_DENY	0x17
+#define ACPI_SMB_STATUS_TIMEOUT		0x18
+#define ACPI_SMB_STATUS_NOTSUP		0x19
+#define ACPI_SMB_STATUS_BUSY		0x1A
+#define ACPI_SMB_STATUS_PEC		0x1F
+
+#define ACPI_SMB_PRTCL_WRITE			0x0
+#define ACPI_SMB_PRTCL_READ			0x01
+#define ACPI_SMB_PRTCL_QUICK			0x02
+#define ACPI_SMB_PRTCL_BYTE			0x04
+#define ACPI_SMB_PRTCL_BYTE_DATA		0x06
+#define ACPI_SMB_PRTCL_WORD_DATA		0x08
+#define ACPI_SMB_PRTCL_BLOCK_DATA		0x0a
+#define ACPI_SMB_PRTCL_PROC_CALL		0x0c
+#define ACPI_SMB_PRTCL_BLOCK_PROC_CALL		0x0d
+#define ACPI_SMB_PRTCL_PEC			0x80
+
+
+static int
+acpi_smb_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
+		   char read_write, u8 command, int size,
+		   union i2c_smbus_data *data)
+{
+	int result = 0;
+	struct acpi_smbus_cmi *smbus_cmi = adap->algo_data;
+	unsigned char protocol, len = 0;
+	acpi_status status = 0;
+	struct acpi_object_list input;
+	union acpi_object mt_params[5];
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	union acpi_object *pkg;
+	char *mthd;
+
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		protocol = ACPI_SMB_PRTCL_QUICK;
+		command = 0;
+		if (read_write == I2C_SMBUS_WRITE) {
+			mt_params[3].type = ACPI_TYPE_INTEGER;
+			mt_params[3].integer.value = 0;
+			mt_params[4].type = ACPI_TYPE_INTEGER;
+			mt_params[4].integer.value = 0;
+		}
+		break;
+
+	case I2C_SMBUS_BYTE:
+		protocol = ACPI_SMB_PRTCL_BYTE;
+		if (read_write == I2C_SMBUS_WRITE) {
+			mt_params[3].type = ACPI_TYPE_INTEGER;
+			mt_params[3].integer.value = 0;
+			mt_params[4].type = ACPI_TYPE_INTEGER;
+			mt_params[4].integer.value = 0;
+		} else {
+			command = 0;
+		}
+		break;
+
+	case I2C_SMBUS_BYTE_DATA:
+		protocol = ACPI_SMB_PRTCL_BYTE_DATA;
+		if (read_write == I2C_SMBUS_WRITE) {
+			mt_params[3].type = ACPI_TYPE_INTEGER;
+			mt_params[3].integer.value = 1;
+			mt_params[4].type = ACPI_TYPE_INTEGER;
+			mt_params[4].integer.value = data->byte;
+		}
+		break;
+
+	case I2C_SMBUS_WORD_DATA:
+		protocol = ACPI_SMB_PRTCL_WORD_DATA;
+		if (read_write == I2C_SMBUS_WRITE) {
+			mt_params[3].type = ACPI_TYPE_INTEGER;
+			mt_params[3].integer.value = 2;
+			mt_params[4].type = ACPI_TYPE_INTEGER;
+			mt_params[4].integer.value = data->word;
+		}
+		break;
+
+	case I2C_SMBUS_BLOCK_DATA:
+		protocol = ACPI_SMB_PRTCL_BLOCK_DATA;
+		if (read_write == I2C_SMBUS_WRITE) {
+			len = data->block[0];
+			if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
+				return -EINVAL;
+			mt_params[3].type = ACPI_TYPE_INTEGER;
+			mt_params[3].integer.value = len;
+			mt_params[4].type = ACPI_TYPE_BUFFER;
+			mt_params[4].buffer.pointer = data->block + 1;
+		}
+		break;
+
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus CMI adapter: "
+				  "Unsupported transaction %d\n", size));
+		return -EOPNOTSUPP;
+	}
+
+	if (read_write == I2C_SMBUS_READ) {
+		protocol |= ACPI_SMB_PRTCL_READ;
+		mthd = smbus_cmi->methods->mt_sbr;
+		input.count = 3;
+	} else {
+		protocol |= ACPI_SMB_PRTCL_WRITE;
+		mthd = smbus_cmi->methods->mt_sbw;
+		input.count = 5;
+	}
+
+	input.pointer = mt_params;
+	mt_params[0].type = ACPI_TYPE_INTEGER;
+	mt_params[0].integer.value = protocol;
+	mt_params[1].type = ACPI_TYPE_INTEGER;
+	mt_params[1].integer.value = addr;
+	mt_params[2].type = ACPI_TYPE_INTEGER;
+	mt_params[2].integer.value = command;
+
+	status = acpi_evaluate_object(smbus_cmi->handle, mthd, &input, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error evaluate %s\n", mthd));
+		return -EIO;
+	}
+
+	pkg = buffer.pointer;
+	if (pkg && pkg->type == ACPI_TYPE_PACKAGE)
+		obj = pkg->package.elements;
+	else {
+		result = -EIO;
+		goto out;
+	}
+	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus status object type \
+						error\n"));
+		result = -EIO;
+		goto out;
+	}
+
+	result = obj->integer.value;
+	switch (result) {
+	case ACPI_SMB_STATUS_OK:
+		break;
+	case ACPI_SMB_STATUS_BUSY:
+		result = -EBUSY;
+		goto out;
+	case ACPI_SMB_STATUS_TIMEOUT:
+		result = -ETIMEDOUT;
+		goto out;
+	case ACPI_SMB_STATUS_DNAK:
+		result = -ENXIO;
+		goto out;
+	default:
+		result = -EIO;
+		goto out;
+	}
+
+	if (read_write == I2C_SMBUS_WRITE)
+		goto out;
+
+	obj = pkg->package.elements + 1;
+	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus return package object \
+						type error\n"));
+		result = -EIO;
+		goto out;
+	}
+
+	len = obj->integer.value;
+	obj = pkg->package.elements + 2;
+	switch (size) {
+	case I2C_SMBUS_BYTE:
+	case I2C_SMBUS_BYTE_DATA:
+	case I2C_SMBUS_WORD_DATA:
+		if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus return package \
+						object type error\n"));
+			result = -EIO;
+			goto out;
+		}
+		if (len == 2)
+			data->word = obj->integer.value & 0xffff;
+		else
+			data->byte = obj->integer.value & 0xff;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		if (obj == NULL || obj->type != ACPI_TYPE_BUFFER) {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus return package \
+						object type error\n"));
+			result = -EIO;
+			goto out;
+		}
+		data->block[0] = len;
+		if (data->block[0] == 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
+			return -EPROTO;
+		memcpy(data->block + 1, obj->buffer.pointer, len);
+		break;
+	}
+
+out:
+	kfree(buffer.pointer);
+	return result;
+}
+
+static u32 acpi_smb_cmi_func(struct i2c_adapter *adapter)
+{
+
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static const struct i2c_algorithm acpi_smbus_cmi_algorithm = {
+	.smbus_xfer = acpi_smb_cmi_access,
+	.functionality = acpi_smb_cmi_func,
+};
+
+static int acpi_smb_cmi_add(struct acpi_device *device)
+{
+	int status;
+	struct acpi_smbus_cmi *smb_cmi;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	if (!device)
+		return -EINVAL;
+
+	smb_cmi = kzalloc(sizeof(struct acpi_smbus_cmi), GFP_KERNEL);
+	if (!smb_cmi)
+		return -ENOMEM;
+
+	smb_cmi->handle = device->handle;
+	strcpy(acpi_device_name(device), ACPI_SMB_HC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
+	device->driver_data = smb_cmi;
+	smb_cmi->methods = (struct smbus_methods *)(&smb_mtds);
+
+	status = acpi_evaluate_object(smb_cmi->handle,
+					smb_cmi->methods->mt_info,
+					NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error obtaining _SBI\n"));
+		goto err;
+	}
+
+	obj = buffer.pointer;
+	if (obj && obj->type == ACPI_TYPE_PACKAGE)
+		obj = obj->package.elements;
+	else {
+		kfree(buffer.pointer);
+		goto err;
+	}
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus CMI Version object type \
+								error\n"));
+	} else
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "SMBus CMI Version %0x\n",
+					(int)obj->integer.value));
+	kfree(buffer.pointer);
+
+	snprintf(smb_cmi->adapter.name, sizeof(smb_cmi->adapter.name),
+		"SMBus CMI adapter");
+	smb_cmi->adapter.owner = THIS_MODULE;
+	smb_cmi->adapter.algo = &acpi_smbus_cmi_algorithm;
+	smb_cmi->adapter.algo_data = smb_cmi;
+	smb_cmi->adapter.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	smb_cmi->adapter.dev.parent = &device->dev;
+
+	if (i2c_add_adapter(&smb_cmi->adapter)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+			  "SMBus CMI adapter: Failed to register adapter\n"));
+		kfree(smb_cmi);
+		return -EIO;
+	}
+
+	printk(KERN_INFO PREFIX "%s [%s]\n",
+	       acpi_device_name(device), acpi_device_bid(device));
+
+	return AE_OK;
+
+err:
+	kfree(smb_cmi);
+	device->driver_data = NULL;
+	return -EIO;
+}
+
+static int acpi_smb_cmi_remove(struct acpi_device *device, int type)
+{
+	struct acpi_smbus_cmi *smbus_cmi;
+
+	if (!device)
+		return -EINVAL;
+
+	smbus_cmi = acpi_driver_data(device);
+
+	i2c_del_adapter(&smbus_cmi->adapter);
+	kfree(smbus_cmi);
+
+	return AE_OK;
+}
+
+static int __init acpi_smb_cmi_init(void)
+{
+	int result;
+
+	result = acpi_bus_register_driver(&acpi_smb_cmi_driver);
+	if (result < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit acpi_smb_cmi_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_smb_cmi_driver);
+}
+
+module_init(acpi_smb_cmi_init);
+module_exit(acpi_smb_cmi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Crane Cai");
+MODULE_DESCRIPTION("ACPI SMBus CMI driver");
-- 
1.6.0.4
