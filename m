From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-voodoo3: Delete
Date: Fri, 18 Sep 2009 23:12:29 +0200
Message-ID: <20090918231229.56460522@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Superseded by tdfxfb. I2C/DDC support used to live in a separate
driver but this caused driver conflicts.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
---
Scheduled for kernel 2.6.33.

 Documentation/feature-removal-schedule.txt |    9 -
 Documentation/i2c/busses/i2c-voodoo3       |   62 -------
 drivers/i2c/busses/Kconfig                 |   16 -
 drivers/i2c/busses/Makefile                |    3 
 drivers/i2c/busses/i2c-voodoo3.c           |  248 ----------------------------
 5 files changed, 338 deletions(-)

--- linux-2.6.32-pre.orig/Documentation/feature-removal-schedule.txt	2009-09-18 18:56:51.000000000 +0200
+++ linux-2.6.32-pre/Documentation/feature-removal-schedule.txt	2009-09-18 23:04:29.000000000 +0200
@@ -412,15 +412,6 @@ Who:	Alex Chiang <achiang-VXdhtT5mjnY@public.gmane.org>
 
 ---------------------------
 
-What:	i2c-voodoo3 driver
-When:	October 2009
-Why:	Superseded by tdfxfb. I2C/DDC support used to live in a separate
-	driver but this caused driver conflicts.
-Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-	Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
-
----------------------------
-
 What:	CONFIG_RFKILL_INPUT
 When:	2.6.33
 Why:	Should be implemented in userspace, policy daemon.
--- linux-2.6.32-pre.orig/Documentation/i2c/busses/i2c-voodoo3	2009-06-10 05:05:27.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,62 +0,0 @@
-Kernel driver i2c-voodoo3
-
-Supported adapters:
-  * 3dfx Voodoo3 based cards
-  * Voodoo Banshee based cards
-
-Authors: 
-	Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, 
-	Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, 
-	Ralph Metzler <rjkm-KutymZ0aA5sRtNtAH2Wc8g@public.gmane.org>,
-	Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-
-Main contact: Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
-	
-The code is based upon Ralph's test code (he did the hard stuff ;')
-
-Description
------------
-
-The 3dfx Voodoo3 chip contains two I2C interfaces (aka a I2C 'master' or
-'host'). 
-
-The first interface is used for DDC (Data Display Channel) which is a
-serial channel through the VGA monitor connector to a DDC-compliant
-monitor. This interface is defined by the Video Electronics Standards
-Association (VESA). The standards are available for purchase at
-http://www.vesa.org .
-
-The second interface is a general-purpose I2C bus. The intent by 3dfx was
-to allow manufacturers to add extra chips to the video card such as a
-TV-out chip such as the BT869 or possibly even I2C based temperature
-sensors like the ADM1021 or LM75.
-
-Stability
----------
-
-Seems to be stable on the test machine, but needs more testing on other
-machines. Simultaneous accesses of the DDC and I2C busses may cause errors.
-
-Supported Devices
------------------
-
-Specifically, this driver was written and tested on the '3dfx Voodoo3 AGP
-3000' which has a tv-out feature (s-video or composite).  According to the
-docs and discussions, this code should work for any Voodoo3 based cards as
-well as Voodoo Banshee based cards.  The DDC interface has been tested on a
-Voodoo Banshee card.
-	
-Issues
-------
-
-Probably many, but it seems to work OK on my system. :')
-
-
-External Device Connection
---------------------------
-
-The digital video input jumpers give availability to the I2C bus. 
-Specifically, pins 13 and 25 (bottom row middle, and bottom right-end) are     
-the I2C clock and I2C data lines, respectively. +5V and GND are probably
-also easily available making the addition of extra I2C/SMBus devices easy
-to implement.
--- linux-2.6.32-pre.orig/drivers/i2c/busses/Kconfig	2009-09-18 22:40:54.000000000 +0200
+++ linux-2.6.32-pre/drivers/i2c/busses/Kconfig	2009-09-18 23:04:23.000000000 +0200
@@ -640,22 +640,6 @@ config I2C_TINY_USB
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-tiny-usb.
 
-comment "Graphics adapter I2C/DDC channel drivers"
-	depends on PCI
-
-config I2C_VOODOO3
-	tristate "Voodoo 3 (DEPRECATED)"
-	depends on PCI
-	select I2C_ALGOBIT
-	help
-	  If you say yes to this option, support will be included for the
-	  Voodoo 3 I2C interface. This driver is deprecated and you should
-	  use the tdfxfb driver instead, which additionally provides
-	  framebuffer support.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-voodoo3.
-
 comment "Other I2C/SMBus bus drivers"
 
 config I2C_ACORN
--- linux-2.6.32-pre.orig/drivers/i2c/busses/Makefile	2009-09-18 22:40:54.000000000 +0200
+++ linux-2.6.32-pre/drivers/i2c/busses/Makefile	2009-09-18 23:04:16.000000000 +0200
@@ -61,9 +61,6 @@ obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-p
 obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
 obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
 
-# Graphics adapter I2C/DDC channel drivers
-obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
-
 # Other I2C/SMBus bus drivers
 obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
--- linux-2.6.32-pre.orig/drivers/i2c/busses/i2c-voodoo3.c	2009-09-10 10:08:18.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,248 +0,0 @@
-/*
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
-    Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
-    Ralph Metzler <rjkm-KutymZ0aA5sRtNtAH2Wc8g@public.gmane.org>, and
-    Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    
-    Based on code written by Ralph Metzler <rjkm-KutymZ0aA5sRtNtAH2Wc8g@public.gmane.org> and
-    Simon Vogl
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-/* This interfaces to the I2C bus of the Voodoo3 to gain access to
-    the BT869 and possibly other I2C devices. */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/io.h>
-
-/* the only registers we use */
-#define REG		0x78
-#define REG2 		0x70
-
-/* bit locations in the register */
-#define DDC_ENAB	0x00040000
-#define DDC_SCL_OUT	0x00080000
-#define DDC_SDA_OUT	0x00100000
-#define DDC_SCL_IN	0x00200000
-#define DDC_SDA_IN	0x00400000
-#define I2C_ENAB	0x00800000
-#define I2C_SCL_OUT	0x01000000
-#define I2C_SDA_OUT	0x02000000
-#define I2C_SCL_IN	0x04000000
-#define I2C_SDA_IN	0x08000000
-
-/* initialization states */
-#define INIT2		0x2
-#define INIT3		0x4
-
-/* delays */
-#define CYCLE_DELAY	10
-#define TIMEOUT		(HZ / 2)
-
-
-static void __iomem *ioaddr;
-
-/* The voo GPIO registers don't have individual masks for each bit
-   so we always have to read before writing. */
-
-static void bit_vooi2c_setscl(void *data, int val)
-{
-	unsigned int r;
-	r = readl(ioaddr + REG);
-	if (val)
-		r |= I2C_SCL_OUT;
-	else
-		r &= ~I2C_SCL_OUT;
-	writel(r, ioaddr + REG);
-	readl(ioaddr + REG);	/* flush posted write */
-}
-
-static void bit_vooi2c_setsda(void *data, int val)
-{
-	unsigned int r;
-	r = readl(ioaddr + REG);
-	if (val)
-		r |= I2C_SDA_OUT;
-	else
-		r &= ~I2C_SDA_OUT;
-	writel(r, ioaddr + REG);
-	readl(ioaddr + REG);	/* flush posted write */
-}
-
-/* The GPIO pins are open drain, so the pins always remain outputs.
-   We rely on the i2c-algo-bit routines to set the pins high before
-   reading the input from other chips. */
-
-static int bit_vooi2c_getscl(void *data)
-{
-	return (0 != (readl(ioaddr + REG) & I2C_SCL_IN));
-}
-
-static int bit_vooi2c_getsda(void *data)
-{
-	return (0 != (readl(ioaddr + REG) & I2C_SDA_IN));
-}
-
-static void bit_vooddc_setscl(void *data, int val)
-{
-	unsigned int r;
-	r = readl(ioaddr + REG);
-	if (val)
-		r |= DDC_SCL_OUT;
-	else
-		r &= ~DDC_SCL_OUT;
-	writel(r, ioaddr + REG);
-	readl(ioaddr + REG);	/* flush posted write */
-}
-
-static void bit_vooddc_setsda(void *data, int val)
-{
-	unsigned int r;
-	r = readl(ioaddr + REG);
-	if (val)
-		r |= DDC_SDA_OUT;
-	else
-		r &= ~DDC_SDA_OUT;
-	writel(r, ioaddr + REG);
-	readl(ioaddr + REG);	/* flush posted write */
-}
-
-static int bit_vooddc_getscl(void *data)
-{
-	return (0 != (readl(ioaddr + REG) & DDC_SCL_IN));
-}
-
-static int bit_vooddc_getsda(void *data)
-{
-	return (0 != (readl(ioaddr + REG) & DDC_SDA_IN));
-}
-
-static int config_v3(struct pci_dev *dev)
-{
-	unsigned long cadr;
-
-	/* map Voodoo3 memory */
-	cadr = dev->resource[0].start;
-	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
-	ioaddr = ioremap_nocache(cadr, 0x1000);
-	if (ioaddr) {
-		writel(0x8160, ioaddr + REG2);
-		writel(0xcffc0020, ioaddr + REG);
-		dev_info(&dev->dev, "Using Banshee/Voodoo3 I2C device at %p\n", ioaddr);
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static struct i2c_algo_bit_data voo_i2c_bit_data = {
-	.setsda		= bit_vooi2c_setsda,
-	.setscl		= bit_vooi2c_setscl,
-	.getsda		= bit_vooi2c_getsda,
-	.getscl		= bit_vooi2c_getscl,
-	.udelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT
-};
-
-static struct i2c_adapter voodoo3_i2c_adapter = {
-	.owner		= THIS_MODULE,
-	.name		= "I2C Voodoo3/Banshee adapter",
-	.algo_data	= &voo_i2c_bit_data,
-};
-
-static struct i2c_algo_bit_data voo_ddc_bit_data = {
-	.setsda		= bit_vooddc_setsda,
-	.setscl		= bit_vooddc_setscl,
-	.getsda		= bit_vooddc_getsda,
-	.getscl		= bit_vooddc_getscl,
-	.udelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT
-};
-
-static struct i2c_adapter voodoo3_ddc_adapter = {
-	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_DDC, 
-	.name		= "DDC Voodoo3/Banshee adapter",
-	.algo_data	= &voo_ddc_bit_data,
-};
-
-static struct pci_device_id voodoo3_ids[] __devinitdata = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE) },
-	{ 0, }
-};
-
-MODULE_DEVICE_TABLE (pci, voodoo3_ids);
-
-static int __devinit voodoo3_probe(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	int retval;
-
-	retval = config_v3(dev);
-	if (retval)
-		return retval;
-
-	/* set up the sysfs linkage to our parent device */
-	voodoo3_i2c_adapter.dev.parent = &dev->dev;
-	voodoo3_ddc_adapter.dev.parent = &dev->dev;
-
-	retval = i2c_bit_add_bus(&voodoo3_i2c_adapter);
-	if (retval)
-		return retval;
-	retval = i2c_bit_add_bus(&voodoo3_ddc_adapter);
-	if (retval)
-		i2c_del_adapter(&voodoo3_i2c_adapter);
-	return retval;
-}
-
-static void __devexit voodoo3_remove(struct pci_dev *dev)
-{
-	i2c_del_adapter(&voodoo3_i2c_adapter);
-	i2c_del_adapter(&voodoo3_ddc_adapter);
-	iounmap(ioaddr);
-}
-
-static struct pci_driver voodoo3_driver = {
-	.name		= "voodoo3_smbus",
-	.id_table	= voodoo3_ids,
-	.probe		= voodoo3_probe,
-	.remove		= __devexit_p(voodoo3_remove),
-};
-
-static int __init i2c_voodoo3_init(void)
-{
-	return pci_register_driver(&voodoo3_driver);
-}
-
-static void __exit i2c_voodoo3_exit(void)
-{
-	pci_unregister_driver(&voodoo3_driver);
-}
-
-
-MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, "
-		"Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, "
-		"Ralph Metzler <rjkm-KutymZ0aA5sRtNtAH2Wc8g@public.gmane.org>, "
-		"and Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>");
-MODULE_DESCRIPTION("Voodoo3 I2C/SMBus driver");
-MODULE_LICENSE("GPL");
-
-module_init(i2c_voodoo3_init);
-module_exit(i2c_voodoo3_exit);


-- 
Jean Delvare
