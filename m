From: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed,  9 Apr 2014 12:22:43 -0400
Message-ID: <1397060563-30431-1-git-send-email-prarit@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Janet Morgan <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

RFC and a work in progress ... I need to go through and do a bunch of error
condition checking, more testing, etc.  I'm just throwing this out there to see
if anyone has any major concerns about doing something like this.

TODO:

- decipher error returns from ACPI AML operations (and implement those too)
- additional error checking from i2c and acpi function calls (this code is
not robust enough)
- testing

P.

----8<----

Some ACPI tables on new systems implement an SBUS device in ACPI.  This results
in a conflict with the ACPI tables and the i2c-i801 driver over the address
space.  As a result the i2c-i801 driver will not load.  To workaround this, we
have users use the kernel parameter "acpi_enforce_resources=lax".  This,
isn't a good solution as I've seen other conflicts on some systems that are
also overriden.  I thought about implementing an i2c-core kernel parameter and
a wrapper function for acpi_check_resource_conflict() but that seems rather
clunky and doesn't resolve the issue of the shared resource between the ACPI
and the device.

There isn't any documentaton on Intel's website about the SBUS device but from
reading the acpidump it looks like the operations are straightforward.

SSXB
     transmit one byte
SRXB
     receive one byte
SWRB
     write one byte
SRDB
     read one byte
SWRW
     write one word
SRDW
     read one word
SBLW
     write block
SBRW
     read block

I've implemented these as an i2c algorithm so that users who cannot load the
regular i801 i2c driver can at least get the functionality they are looking
for.

Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Janet Morgan <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/algos/Kconfig         |    3 +
 drivers/i2c/algos/Makefile        |    1 +
 drivers/i2c/algos/i2c-algo-i801.c |  211 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig        |    1 +
 4 files changed, 216 insertions(+)
 create mode 100644 drivers/i2c/algos/i2c-algo-i801.c

diff --git a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
index f1cfe7e..98b382c 100644
--- a/drivers/i2c/algos/Kconfig
+++ b/drivers/i2c/algos/Kconfig
@@ -14,4 +14,7 @@ config I2C_ALGOPCF
 config I2C_ALGOPCA
 	tristate "I2C PCA 9564 interfaces"
 
+config I2C_ALGOI801
+	tristate "I2C I801 interfaces"
+
 endmenu
diff --git a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
index 215303f..2c7cc99 100644
--- a/drivers/i2c/algos/Makefile
+++ b/drivers/i2c/algos/Makefile
@@ -5,5 +5,6 @@
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOPCA)	+= i2c-algo-pca.o
+obj-$(CONFIG_I2C_ALGOI801)	+= i2c-algo-i801.o
 
 ccflags-$(CONFIG_I2C_DEBUG_ALGO) := -DDEBUG
diff --git a/drivers/i2c/algos/i2c-algo-i801.c b/drivers/i2c/algos/i2c-algo-i801.c
new file mode 100644
index 0000000..c7e615c3
--- /dev/null
+++ b/drivers/i2c/algos/i2c-algo-i801.c
@@ -0,0 +1,211 @@
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+
+/* From an ACPI dump the supported ACPI SBUS operations are:
+ *
+ * SSXB
+ *	transmit one byte
+ * SRXB
+ *	receive one byte
+ * SWRB
+ *	write one byte
+ * SRDB
+ *	read one byte
+ * SWRW
+ *	write one word
+ * SRDW
+ *	read one word
+ * SBLW
+ *	write block
+ * SBRW
+ *	read block
+ *
+ * A lot of this code is based on what the existing i2c-i801.c driver is
+ * doing.  Note that the i2c-i801.c driver also implements I2C_SMBUS_QUICK,
+ * and I2C_SMBUS_I2C_BLOCK_DATA which do not appear to be implemented in the
+ * ACPI driver.
+ */
+
+struct i2c_adapter i2c_acpi_sbus_adapter;
+
+/* all operations are noted as being serialized in the acpidump so no
+ * locking should be required.
+ */
+static s32 i2c_acpi_sbus_access(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	acpi_status status;
+	acpi_handle handle = adap->algo_data;
+	char *op;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_object_list args;
+	union acpi_object *buffer_obj;
+	union acpi_object objects[4];
+	unsigned long long value;
+
+	args.pointer = objects;
+	objects[0].type = ACPI_TYPE_INTEGER;
+	/* taken directly from i2c-smbus.c */
+	objects[0].integer.value = ((addr & 0x7f) << 1) | (read_write & 0x01);
+
+	switch (size) {
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_WRITE) {
+			op = "SSXB";
+			args.count = 2;
+			objects[1].type = ACPI_TYPE_INTEGER;
+			objects[1].integer.value = command;
+		} else {
+			op = "SRXB";
+			args.count = 1;
+		}
+		status = acpi_evaluate_integer(handle, op, &args, &value);
+		data->byte = value;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		objects[1].type = ACPI_TYPE_INTEGER;
+		objects[1].integer.value = command;
+		if (read_write == I2C_SMBUS_WRITE) {
+			op = "SWRB";
+			args.count = 3;
+			objects[2].type = ACPI_TYPE_INTEGER;
+			objects[2].integer.value = data->byte;
+		} else {
+			op = "SRDB";
+			args.count = 2;
+		}
+		status = acpi_evaluate_integer(handle, op, &args, &value);
+		data->byte = value;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		objects[1].type = ACPI_TYPE_INTEGER;
+		objects[1].integer.value = command;
+		if (read_write == I2C_SMBUS_WRITE) {
+			op = "SWRW";
+			args.count = 3;
+			objects[2].type = ACPI_TYPE_INTEGER;
+			objects[2].integer.value = data->word;
+		} else {
+			op = "SRDW";
+			args.count = 2;
+		}
+		status = acpi_evaluate_integer(handle, op, &args, &value);
+		data->word = value;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		objects[1].type = ACPI_TYPE_INTEGER;
+		objects[1].integer.value = command;
+		if (read_write == I2C_SMBUS_WRITE) {
+			op = "SBLW";
+			args.count = 3;
+			objects[2].buffer.length = data->block[0];
+			objects[2].buffer.pointer = data->block + 1;
+			status = acpi_evaluate_integer(handle, op, &args,
+						       &value);
+			data->byte = value;
+		} else {
+			op = "SBLR";
+			args.count = 2;
+			status = acpi_evaluate_object(handle, op, &args,
+						      &buffer);
+			if (ACPI_SUCCESS(status)) {
+				buffer_obj = buffer.pointer;
+				memcpy(data->block,
+				       buffer_obj->buffer.pointer,
+				       buffer_obj->buffer.length);
+			}
+		}
+		break;
+	default:
+		pr_warn("%s: Unsupported transaction %d\n",
+			i2c_acpi_sbus_adapter.name, size);
+		return -EOPNOTSUPP;
+	}
+
+	if (ACPI_FAILURE(status)) {
+		pr_warn("%s: Transaction failure.\n",
+			i2c_acpi_sbus_adapter.name);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static u32 i2c_acpi_sbus_func(struct i2c_adapter *adapter)
+{
+	return (I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA);
+}
+
+static const struct i2c_algorithm i2c_acpi_sbus_algorithm = {
+	.smbus_xfer	= i2c_acpi_sbus_access,
+	.functionality	= i2c_acpi_sbus_func,
+};
+
+struct i2c_adapter i2c_acpi_sbus_adapter = {
+	.owner	= THIS_MODULE,
+	.class	= I2C_CLASS_HWMON,
+	.algo	= &i2c_acpi_sbus_algorithm,
+	.name	= "i2c ACPI(SBUS) SMBus",
+};
+
+static acpi_status i2c_acpi_sbus_find_device(acpi_handle handle, u32 level,
+					     void *context, void **return_value)
+{
+	acpi_status status;
+	char node_name[5];
+	struct acpi_buffer buffer = {sizeof(node_name), node_name};
+	struct acpi_device *device = NULL;
+	int ret;
+
+	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+	if (ACPI_FAILURE(status) || strcmp("SBUS", node_name) != 0)
+		return AE_OK;
+
+	acpi_bus_get_device(handle, &device);
+	if (!device) {
+		pr_err("%s: SBUS name found but no matching device\n",
+		       i2c_acpi_sbus_adapter.name);
+		return AE_NOT_FOUND;
+	}
+
+	i2c_acpi_sbus_adapter.dev.parent = &device->dev;
+	i2c_acpi_sbus_adapter.algo_data = handle;
+
+	ret = i2c_add_adapter(&i2c_acpi_sbus_adapter);
+	if (ret)
+		pr_err("%s: i2c core failed to add i2c_sbus\n",
+		       i2c_acpi_sbus_adapter.name);
+		return AE_ERROR;
+	}
+
+	pr_info("%s device found.\n", i2c_acpi_sbus_adapter.name);
+	return AE_OK;
+}
+
+static int __init i2c_acpi_sbus_init(void)
+{
+	acpi_status status;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, i2c_acpi_sbus_find_device,
+				     NULL, NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("%s no device found\n", i2c_acpi_sbus_adapter.name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit i2c_acpi_sbus_exit(void)
+{
+	i2c_del_adapter(&i2c_acpi_sbus_adapter);
+}
+
+module_init(i2c_acpi_sbus_init);
+module_exit(i2c_acpi_sbus_exit);
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 014afab..a4d97ae 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -81,6 +81,7 @@ config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
 	depends on PCI
 	select CHECK_SIGNATURE if X86 && DMI
+	select I2C_ALGOI801
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
-- 
1.7.9.3
