From: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
Subject: [PATCH] i2c: Floppy controller bus driver (V0.3)
Date: Mon, 18 Aug 2008 19:04:39 +0200
Message-ID: <20080818170439.GA1947@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: I2C ML <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


here is the updated version (docu fixes, removed
the unused device section) of the I2C floppy
controller bus driver ... thanks for the feedback!

please consider for (mainline) inclusion!

TIA,
Herbert


Signed-off-by: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>

diff -NurpP --minimal linux-2.6.27-rc3/Documentation/i2c/busses/i2c-floppy linux-2.6.27-rc3-fi2c-v0.3/Documentation/i2c/busses/i2c-floppy
--- linux-2.6.27-rc3/Documentation/i2c/busses/i2c-floppy	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.27-rc3-fi2c-v0.3/Documentation/i2c/busses/i2c-floppy	2008-08-18 18:47:24.000000000 +0200
@@ -0,0 +1,37 @@
+Kernel driver i2c-floppy
+
+Author: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
+
+This driver is for a simple do-it-yourself floppy controller to
+I2C adapter which uses direct I/O access to control both Motor
+Enable lines (A/B) and read back data via the Disk Changed line.
+
+The following circuit is not suited to be used together with
+a Floppy drive (which would need some logic to work properly)
+but as replacement.
+
+ +---+
+ | F |  Motor Enable A [/MOTEA,10] -------------- SCL
+ | L |
+ | O |  Motor Enable B [/MOTEB,16] ------+------- SDA
+ | P |                                   |
+ | P |                                   |
+ | Y |  Disk Change   [/DSKCHG,34] ------+    +-- GND
+ +-+-+                                        |
+   |                                          |
+  GND	                                     GND
+
+The Motor Enable output of floppy disk controllers is an open
+drain output (48mA), usually pulled up to +5V via 1k or higher,
+and the Disk Change is a Schmitt Trigger (0.8V/2.2V) input with
+max 150uA input current (data taken from the WD/FDC 37C6xx
+Floppy Disk Subsystem Controller datasheets, which basically
+combine all the necessary parts of the PC floppy circuit).
+
+So it should be fine to connect it to all 5V I2C devices, and
+most 3.3V devices (which are usually capable of handling 5V
+I2C bus voltages).
+
+Power for those devices can be drawn from either the Floppy
+power connector (+5V/+12V) or from the SATA 3.3V lines
+(or if you prefer from some external source).
diff -NurpP --minimal linux-2.6.27-rc3/drivers/i2c/busses/i2c-floppy.c linux-2.6.27-rc3-fi2c-v0.3/drivers/i2c/busses/i2c-floppy.c
--- linux-2.6.27-rc3/drivers/i2c/busses/i2c-floppy.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.27-rc3-fi2c-v0.3/drivers/i2c/busses/i2c-floppy.c	2008-08-18 18:45:06.000000000 +0200
@@ -0,0 +1,245 @@
+/* ------------------------------------------------------------------------ *
+ * i2c-floppy.c I2C bus over floppy controller                              *
+ * ------------------------------------------------------------------------ *
+   Copyright (C) 2008 Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
+
+   Somewhat based on i2c-parport-light.c driver
+   Copyright (C) 2003-2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * ------------------------------------------------------------------------ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/io.h>
+
+static struct platform_device *pdev;
+static unsigned char dor;
+
+static u16 base;
+module_param(base, ushort, 0);
+MODULE_PARM_DESC(base, "Base I/O address");
+
+
+#define DEFAULT_BASE	0x3F0		/* for PC style hardware */
+#define DRVNAME		"i2c-floppy"
+
+
+#define FOFF_DOR	0x02
+#define FOFF_DIR	0x07
+
+#define FDOR_MOTEA	0x10
+#define FDOR_MOTEB	0x20
+
+#define FDIR_DCHNG	0x80
+
+#define SCL		FDOR_MOTEA
+#define SDA		FDOR_MOTEB
+#define SDA_IN		FDIR_DCHNG
+
+#define LO_INV		(SDA|SCL)
+#define LI_INV		(SDA_IN)
+
+
+/* ----- Low-level floppy access ------------------------------------------ */
+
+static inline void port_dor_out(unsigned char d)
+{
+	outb(d ^ LO_INV, base + FOFF_DOR);
+}
+
+static inline unsigned char port_dir_in(void)
+{
+	return inb(base + FOFF_DIR) ^ LI_INV;
+}
+
+
+/* ----- I2C algorithm call-back functions and structures ----------------- */
+
+static void floppy_setscl(void *data, int state)
+{
+	if (state)
+		dor |= SCL;
+	else
+		dor &= ~SCL;
+
+	port_dor_out(dor);
+}
+
+static void floppy_setsda(void *data, int state)
+{
+	if (state)
+		dor |= SDA;
+	else
+		dor &= ~SDA;
+
+	port_dor_out(dor);
+}
+
+static int floppy_getsda(void *data)
+{
+	return port_dir_in() & SDA_IN;
+}
+
+/* Encapsulate the functions above in the correct structure
+   Note that getscl is set to NULL because SCL cannot be read
+   back with the current driver */
+static struct i2c_algo_bit_data floppy_algo_data = {
+	.setsda		= floppy_setsda,
+	.setscl		= floppy_setscl,
+	.getsda		= floppy_getsda,
+	.udelay		= 50,
+	.timeout	= HZ,
+};
+
+
+/* ----- Driver registration ---------------------------------------------- */
+
+static struct i2c_adapter floppy_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON,
+	.algo_data	= &floppy_algo_data,
+	.name		= "Floppy controller adapter",
+};
+
+static int __devinit i2c_floppy_probe(struct platform_device *pdev)
+{
+	int err;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, res->end - res->start + 1, DRVNAME))
+		return -EBUSY;
+
+	/* Reset hardware to a sane state (SCL and SDA high) */
+	floppy_setsda(NULL, 1);
+	floppy_setscl(NULL, 1);
+
+	floppy_adapter.dev.parent = &pdev->dev;
+	err = i2c_bit_add_bus(&floppy_adapter);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to register with I2C\n");
+		goto exit_region;
+	}
+	return 0;
+
+exit_region:
+	release_region(res->start, res->end - res->start + 1);
+	return err;
+}
+
+static int __devexit i2c_floppy_remove(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	i2c_del_adapter(&floppy_adapter);
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start, res->end - res->start + 1);
+	return 0;
+}
+
+static struct platform_driver i2c_floppy_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= DRVNAME,
+	},
+	.probe		= i2c_floppy_probe,
+	.remove		= __devexit_p(i2c_floppy_remove),
+};
+
+static int __init i2c_floppy_device_add(u16 address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + 7,
+		.name	= DRVNAME,
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc(DRVNAME, -1);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
+		       err);
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(pdev);
+exit:
+	return err;
+}
+
+static int __init i2c_floppy_init(void)
+{
+	int err;
+
+	if (base == 0) {
+		pr_info(DRVNAME ": using default base 0x%x\n", DEFAULT_BASE);
+		base = DEFAULT_BASE;
+	}
+
+	/* Sets global pdev as a side effect */
+	err = i2c_floppy_device_add(base);
+	if (err)
+		goto exit;
+
+	err = platform_driver_register(&i2c_floppy_driver);
+	if (err)
+		goto exit_device;
+
+	return 0;
+
+exit_device:
+	platform_device_unregister(pdev);
+exit:
+	return err;
+}
+
+static void __exit i2c_floppy_exit(void)
+{
+	platform_driver_unregister(&i2c_floppy_driver);
+	platform_device_unregister(pdev);
+}
+
+
+MODULE_AUTHOR("Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>");
+MODULE_DESCRIPTION("I2C bus over floppy controller");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_floppy_init);
+module_exit(i2c_floppy_exit);
diff -NurpP --minimal linux-2.6.27-rc3/drivers/i2c/busses/Kconfig linux-2.6.27-rc3-fi2c-v0.3/drivers/i2c/busses/Kconfig
--- linux-2.6.27-rc3/drivers/i2c/busses/Kconfig	2008-08-15 21:19:24.000000000 +0200
+++ linux-2.6.27-rc3-fi2c-v0.3/drivers/i2c/busses/Kconfig	2008-08-18 03:46:31.000000000 +0200
@@ -490,6 +490,22 @@ config I2C_VERSATILE
 
 comment "External I2C/SMBus adapter drivers"
 
+config I2C_FLOPPY
+	tristate "Floppy controller adapter"
+	select I2C_ALGOBIT
+	default n
+	help
+	  This supports a simple do-it-yourself floppy controller to
+	  I2C adapters using the motor control lines for SDA and SCL,
+	  and the drive change input for SDA readback.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-floppy.
+
+	  If you do not have such a device, and do not plan to build one,
+	  it's safe to say N here. Do not say Y here and to the floppy
+	  driver unless you know exactly what you are doing.
+
 config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT
diff -NurpP --minimal linux-2.6.27-rc3/drivers/i2c/busses/Makefile linux-2.6.27-rc3-fi2c-v0.3/drivers/i2c/busses/Makefile
--- linux-2.6.27-rc3/drivers/i2c/busses/Makefile	2008-08-15 21:19:24.000000000 +0200
+++ linux-2.6.27-rc3-fi2c-v0.3/drivers/i2c/busses/Makefile	2008-08-18 03:46:42.000000000 +0200
@@ -48,6 +48,7 @@ obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 
 # External I2C/SMBus adapter drivers
+obj-$(CONFIG_I2C_FLOPPY)	+= i2c-floppy.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
 obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
diff -NurpP --minimal linux-2.6.27-rc3/include/linux/i2c-id.h linux-2.6.27-rc3-fi2c-v0.3/include/linux/i2c-id.h
--- linux-2.6.27-rc3/include/linux/i2c-id.h	2008-08-15 21:20:04.000000000 +0200
+++ linux-2.6.27-rc3-fi2c-v0.3/include/linux/i2c-id.h	2008-08-15 21:42:14.000000000 +0200



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
