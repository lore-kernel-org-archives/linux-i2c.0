From: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v4 2/3] i2c: convert i2c-isch to platform_device
Date: Mon, 01 Mar 2010 18:59:55 +0200
Message-ID: <4B8BF28B.1060701@compulab.co.il>
References: <4B73DAEE.5080400@compulab.co.il> <4B73DBB2.7020601@compulab.co.il> <4B7C0E5D.3070909@compulab.co.il> <4B812B42.2090405@compulab.co.il> <20100228190015.GB3589@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100228190015.GB3589-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

v2: there is no acpi_check_region, it will be implemented in mfd-core
v3: patch refreshed against the latest Linus tree
v4: refreshed again

Signed-off-by: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

---
 drivers/i2c/busses/Kconfig    |    2 +-
 drivers/i2c/busses/i2c-isch.c |   68 ++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..d15b6d3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -104,7 +104,7 @@ config I2C_I801

 config I2C_ISCH
 	tristate "Intel SCH SMBus 1.0"
-	depends on PCI
+	select LPC_SCH
 	help
 	  Say Y here if you want to use SMBus controller on the Intel SCH
 	  based systems.
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index dba6eb0..ddc258e 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -27,7 +27,7 @@
 */

 #include <linux/module.h>
-#include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/stddef.h>
@@ -46,12 +46,6 @@
 #define SMBHSTDAT1	(7 + sch_smba)
 #define SMBBLKDAT	(0x20 + sch_smba)

-/* count for request_region */
-#define SMBIOSIZE	64
-
-/* PCI Address Constants */
-#define SMBBA_SCH	0x40
-
 /* Other settings */
 #define MAX_TIMEOUT	500

@@ -63,7 +57,6 @@
 #define SCH_BLOCK_DATA		0x05

 static unsigned short sch_smba;
-static struct pci_driver sch_driver;
 static struct i2c_adapter sch_adapter;

 /*
@@ -256,37 +249,23 @@ static struct i2c_adapter sch_adapter = {
 	.algo		= &smbus_algorithm,
 };

-static struct pci_device_id sch_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SCH_LPC) },
-	{ 0, }
-};
-
-MODULE_DEVICE_TABLE(pci, sch_ids);
-
-static int __devinit sch_probe(struct pci_dev *dev,
-				const struct pci_device_id *id)
+static int __devinit smbus_sch_probe(struct platform_device *dev)
 {
+	struct resource *res;
 	int retval;
-	unsigned int smba;

-	pci_read_config_dword(dev, SMBBA_SCH, &smba);
-	if (!(smba & (1 << 31))) {
-		dev_err(&dev->dev, "SMBus I/O space disabled!\n");
-		return -ENODEV;
-	}
+	res = platform_get_resource(dev, IORESOURCE_IO, 0);
+	if (!res)
+		return -EBUSY;

-	sch_smba = (unsigned short)smba;
-	if (sch_smba == 0) {
-		dev_err(&dev->dev, "SMBus base address uninitialized!\n");
-		return -ENODEV;
-	}
-	if (acpi_check_region(sch_smba, SMBIOSIZE, sch_driver.name))
-		return -ENODEV;
-	if (!request_region(sch_smba, SMBIOSIZE, sch_driver.name)) {
+	if (!request_region(res->start, resource_size(res), dev->name)) {
 		dev_err(&dev->dev, "SMBus region 0x%x already in use!\n",
 			sch_smba);
 		return -EBUSY;
 	}
+
+	sch_smba = res->start;
+
 	dev_dbg(&dev->dev, "SMBA = 0x%X\n", sch_smba);

 	/* set up the sysfs linkage to our parent device */
@@ -298,37 +277,43 @@ static int __devinit sch_probe(struct pci_dev *dev,
 	retval = i2c_add_adapter(&sch_adapter);
 	if (retval) {
 		dev_err(&dev->dev, "Couldn't register adapter!\n");
-		release_region(sch_smba, SMBIOSIZE);
+		release_region(res->start, resource_size(res));
 		sch_smba = 0;
 	}

 	return retval;
 }

-static void __devexit sch_remove(struct pci_dev *dev)
+static int __devexit smbus_sch_remove(struct platform_device *pdev)
 {
+	struct resource *res;
 	if (sch_smba) {
 		i2c_del_adapter(&sch_adapter);
-		release_region(sch_smba, SMBIOSIZE);
+		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		release_region(res->start, resource_size(res));
 		sch_smba = 0;
 	}
+
+	return 0;
 }

-static struct pci_driver sch_driver = {
-	.name		= "isch_smbus",
-	.id_table	= sch_ids,
-	.probe		= sch_probe,
-	.remove		= __devexit_p(sch_remove),
+static struct platform_driver smbus_sch_driver = {
+	.driver = {
+		.name = "isch_smbus",
+		.owner = THIS_MODULE,
+	},
+	.probe		= smbus_sch_probe,
+	.remove		= __devexit_p(smbus_sch_remove),
 };

 static int __init i2c_sch_init(void)
 {
-	return pci_register_driver(&sch_driver);
+	return platform_driver_register(&smbus_sch_driver);
 }

 static void __exit i2c_sch_exit(void)
 {
-	pci_unregister_driver(&sch_driver);
+	platform_driver_unregister(&smbus_sch_driver);
 }

 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
@@ -337,3 +322,4 @@ MODULE_LICENSE("GPL");

 module_init(i2c_sch_init);
 module_exit(i2c_sch_exit);
+MODULE_ALIAS("platform:isch_smbus");
-- 
1.6.3.3
