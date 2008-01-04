From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [patch 1/2] i2c: check for i2c_add_adapter() failures
Date: Fri, 4 Jan 2008 13:37:54 -0700
Message-ID: <200801041337.54913.bjorn.helgaas@hp.com>
References: <200801041336.33058.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801041336.33058.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Check for i2c_add_adapter() failure so we can release resources before the
driver is unloaded.  I copied the strategy from i2c-ali1563.c.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

---
 drivers/i2c/busses/i2c-ali1535.c |   38 +++++++++++++++++++++++---------------
 drivers/i2c/busses/i2c-ali1563.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c |   26 +++++++++++++++++++-------
 drivers/i2c/busses/i2c-amd756.c  |    3 +--
 drivers/i2c/busses/i2c-amd8111.c |    1 +
 drivers/i2c/busses/i2c-i801.c    |    5 ++---
 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 drivers/i2c/busses/i2c-pasemi.c  |    1 +
 drivers/i2c/busses/i2c-piix4.c   |    2 +-
 drivers/i2c/busses/i2c-sis5595.c |    1 +
 drivers/i2c/busses/i2c-sis630.c  |   24 ++++++++++++++++++------
 drivers/i2c/busses/i2c-sis96x.c  |   18 +++++++++++-------
 drivers/i2c/busses/i2c-viapro.c  |    3 ++-
 drivers/i2c/busses/scx200_acb.c  |    4 ++--
 14 files changed, 84 insertions(+), 46 deletions(-)

Index: work3/drivers/i2c/busses/i2c-ali1535.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-ali1535.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-ali1535.c	2008-01-04 13:25:01.000000000 -0700
@@ -141,7 +141,6 @@
    defined to make the transition easier. */
 static int ali1535_setup(struct pci_dev *dev)
 {
-	int retval = -ENODEV;
 	unsigned char temp;
 
 	/* Check the following things:
@@ -156,14 +155,14 @@
 	if (ali1535_smba == 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
-		goto exit;
+		return -ENODEV;
 	}
 
 	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 			    ali1535_driver.name)) {
 		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
 			ali1535_smba);
-		goto exit;
+		return -ENODEV;
 	}
 
 	/* check if whole device is enabled */
@@ -193,14 +192,16 @@
 	pci_read_config_byte(dev, SMBREV, &temp);
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
-
-	retval = 0;
-exit:
-	return retval;
+	return 0;
 
 exit_free:
 	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
-	return retval;
+	return -ENODEV;
+}
+
+static void ali1535_shutdown(struct pci_dev *dev)
+{
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 static int ali1535_transaction(struct i2c_adapter *adap)
@@ -488,24 +489,31 @@
 
 static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (ali1535_setup(dev)) {
-		dev_warn(&dev->dev,
-			"ALI1535 not detected, module not inserted.\n");
-		return -ENODEV;
-	}
+	int error;
+
+	if ((error = ali1535_setup(dev)))
+		goto exit;
 
 	/* set up the sysfs linkage to our parent device */
 	ali1535_adapter.dev.parent = &dev->dev;
 
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
 		"SMBus ALI1535 adapter at %04x", ali1535_smba);
-	return i2c_add_adapter(&ali1535_adapter);
+	if ((error = i2c_add_adapter(&ali1535_adapter)))
+		goto exit_shutdown;
+	return 0;
+
+exit_shutdown:
+	ali1535_shutdown(dev);
+exit:
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", error);
+	return error;
 }
 
 static void __devexit ali1535_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali1535_adapter);
-	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
+	ali1535_shutdown(dev);
 }
 
 static struct pci_driver ali1535_driver = {
Index: work3/drivers/i2c/busses/i2c-ali15x3.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-ali15x3.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-ali15x3.c	2008-01-04 13:25:01.000000000 -0700
@@ -225,6 +225,11 @@
 	return -ENODEV;
 }
 
+static void ali15x3_shutdown(struct pci_dev *dev)
+{
+	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+}
+
 /* Another internally used function */
 static int ali15x3_transaction(struct i2c_adapter *adap)
 {
@@ -483,24 +488,31 @@
 
 static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (ali15x3_setup(dev)) {
-		dev_err(&dev->dev,
-			"ALI15X3 not detected, module not inserted.\n");
-		return -ENODEV;
-	}
+	int error;
+
+	if ((error = ali15x3_setup(dev)))
+		goto exit;
 
 	/* set up the sysfs linkage to our parent device */
 	ali15x3_adapter.dev.parent = &dev->dev;
 
 	snprintf(ali15x3_adapter.name, sizeof(ali15x3_adapter.name),
 		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
-	return i2c_add_adapter(&ali15x3_adapter);
+	if ((error = i2c_add_adapter(&ali15x3_adapter)))
+		goto exit_shutdown;
+	return 0;
+
+exit_shutdown:
+	ali15x3_shutdown(dev);
+exit:
+	dev_warn(&dev->dev, "SMBus probe failed (%d)\n", error);
+	return error;
 }
 
 static void __devexit ali15x3_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali15x3_adapter);
-	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+	ali15x3_shutdown(dev);
 }
 
 static struct pci_driver ali15x3_driver = {
Index: work3/drivers/i2c/busses/i2c-amd756.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-amd756.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-amd756.c	2008-01-04 13:25:01.000000000 -0700
@@ -382,8 +382,7 @@
 
 	error = i2c_add_adapter(&amd756_smbus);
 	if (error) {
-		dev_err(&pdev->dev,
-			"Adapter registration failed, module not inserted\n");
+		dev_err(&pdev->dev, "SMBus probe failed (%d)\n", error);
 		goto out_err;
 	}
 
Index: work3/drivers/i2c/busses/i2c-amd8111.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-amd8111.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-amd8111.c	2008-01-04 13:25:01.000000000 -0700
@@ -387,6 +387,7 @@
 	release_region(smbus->base, smbus->size);
  out_kfree:
 	kfree(smbus);
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", error);
 	return error;
 }
 
Index: work3/drivers/i2c/busses/i2c-i801.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-i801.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-i801.c	2008-01-04 13:25:01.000000000 -0700
@@ -616,15 +616,14 @@
 	snprintf(i801_adapter.name, sizeof(i801_adapter.name),
 		"SMBus I801 adapter at %04lx", i801_smba);
 	err = i2c_add_adapter(&i801_adapter);
-	if (err) {
-		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
+	if (err)
 		goto exit_release;
-	}
 	return 0;
 
 exit_release:
 	pci_release_region(dev, SMBBAR);
 exit:
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", err);
 	return err;
 }
 
Index: work3/drivers/i2c/busses/i2c-nforce2.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-nforce2.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-nforce2.c	2008-01-04 13:27:56.000000000 -0700
@@ -331,7 +331,7 @@
 
 	error = i2c_add_adapter(&smbus->adapter);
 	if (error) {
-		dev_err(&smbus->adapter.dev, "Failed to register adapter.\n");
+		dev_err(&smbus->adapter.dev, "SMBus probe failed (%d)\n", error);
 		release_region(smbus->base, smbus->size);
 		return -1;
 	}
Index: work3/drivers/i2c/busses/i2c-pasemi.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-pasemi.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-pasemi.c	2008-01-04 13:25:01.000000000 -0700
@@ -382,6 +382,7 @@
 	release_region(smbus->base, smbus->size);
  out_kfree:
 	kfree(smbus);
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", error);
 	return error;
 }
 
Index: work3/drivers/i2c/busses/i2c-piix4.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-piix4.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-piix4.c	2008-01-04 13:25:01.000000000 -0700
@@ -432,7 +432,7 @@
 		"SMBus PIIX4 adapter at %04x", piix4_smba);
 
 	if ((retval = i2c_add_adapter(&piix4_adapter))) {
-		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		dev_err(&dev->dev, "SMBus probe failed (%d)\n", retval);
 		release_region(piix4_smba, SMBIOSIZE);
 		piix4_smba = 0;
 	}
Index: work3/drivers/i2c/busses/i2c-sis5595.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-sis5595.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-sis5595.c	2008-01-04 13:25:01.000000000 -0700
@@ -395,6 +395,7 @@
 	err = i2c_add_adapter(&sis5595_adapter);
 	if (err) {
 		release_region(sis5595_base + SMB_INDEX, 2);
+		dev_err(&dev->dev, "SMBus probe failed (%d)\n", err);
 		return err;
 	}
 
Index: work3/drivers/i2c/busses/i2c-sis630.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-sis630.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-sis630.c	2008-01-04 13:25:01.000000000 -0700
@@ -449,6 +449,10 @@
 	return retval;
 }
 
+static void sis630_shutdown(struct pci_dev *dev)
+{
+	release_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION);
+}
 
 static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= sis630_access,
@@ -472,10 +476,10 @@
 
 static int __devinit sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (sis630_setup(dev)) {
-		dev_err(&dev->dev, "SIS630 comp. bus not detected, module not inserted.\n");
-		return -ENODEV;
-	}
+	int error;
+
+	if ((error = sis630_setup(dev)))
+		goto exit;
 
 	/* set up the sysfs linkage to our parent device */
 	sis630_adapter.dev.parent = &dev->dev;
@@ -483,14 +487,22 @@
 	sprintf(sis630_adapter.name, "SMBus SIS630 adapter at %04x",
 		acpi_base + SMB_STS);
 
-	return i2c_add_adapter(&sis630_adapter);
+	if ((error = i2c_add_adapter(&sis630_adapter)))
+		goto exit_shutdown;
+	return 0;
+
+exit_shutdown:
+	sis630_shutdown(dev);
+exit:
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", error);
+	return error;
 }
 
 static void __devexit sis630_remove(struct pci_dev *dev)
 {
 	if (acpi_base) {
 		i2c_del_adapter(&sis630_adapter);
-		release_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION);
+		sis630_shutdown(dev);
 		acpi_base = 0;
 	}
 }
Index: work3/drivers/i2c/busses/i2c-sis96x.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-sis96x.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-sis96x.c	2008-01-04 13:25:01.000000000 -0700
@@ -293,8 +293,8 @@
 			"already in use!\n", sis96x_smbus_base,
 			sis96x_smbus_base + SMB_IOSIZE - 1);
 
-		sis96x_smbus_base = 0;
-		return -EINVAL;
+		retval = -EINVAL;
+		goto exit;
 	}
 
 	/* set up the sysfs linkage to our parent device */
@@ -303,12 +303,16 @@
 	snprintf(sis96x_adapter.name, sizeof(sis96x_adapter.name),
 		"SiS96x SMBus adapter at 0x%04x", sis96x_smbus_base);
 
-	if ((retval = i2c_add_adapter(&sis96x_adapter))) {
-		dev_err(&dev->dev, "Couldn't register adapter!\n");
-		release_region(sis96x_smbus_base, SMB_IOSIZE);
-		sis96x_smbus_base = 0;
-	}
+	if ((retval = i2c_add_adapter(&sis96x_adapter)))
+		goto exit_release;
+
+	return 0;
 
+exit_release:
+	release_region(sis96x_smbus_base, SMB_IOSIZE);
+exit:
+	sis96x_smbus_base = 0;
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", retval);
 	return retval;
 }
 
Index: work3/drivers/i2c/busses/i2c-viapro.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-viapro.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-viapro.c	2008-01-04 13:25:01.000000000 -0700
@@ -407,7 +407,8 @@
 		 "SMBus Via Pro adapter at %04x", vt596_smba);
 
 	vt596_pdev = pci_dev_get(pdev);
-	if (i2c_add_adapter(&vt596_adapter)) {
+	if ((error = i2c_add_adapter(&vt596_adapter))) {
+		dev_err(&pdev->dev, "SMBus probe failed (%d)\n", error);
 		pci_dev_put(vt596_pdev);
 		vt596_pdev = NULL;
 	}
Index: work3/drivers/i2c/busses/scx200_acb.c
===================================================================
--- work3.orig/drivers/i2c/busses/scx200_acb.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/scx200_acb.c	2008-01-04 13:26:55.000000000 -0700
@@ -465,8 +465,8 @@
 
 	scx200_acb_reset(iface);
 
-	if (i2c_add_adapter(adapter) < 0) {
-		printk(KERN_ERR NAME ": failed to register\n");
+	if ((rc = i2c_add_adapter(adapter))) {
+		printk(KERN_ERR NAME " SMBus probe failed (%d)\n", rc);
 		return -ENODEV;
 	}
 
Index: work3/drivers/i2c/busses/i2c-ali1563.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-ali1563.c	2008-01-04 11:44:46.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-ali1563.c	2008-01-04 13:25:01.000000000 -0700
@@ -392,7 +392,7 @@
 exit_shutdown:
 	ali1563_shutdown(dev);
 exit:
-	dev_warn(&dev->dev, "ALi1563 SMBus probe failed (%d)\n", error);
+	dev_err(&dev->dev, "SMBus probe failed (%d)\n", error);
 	return error;
 }
