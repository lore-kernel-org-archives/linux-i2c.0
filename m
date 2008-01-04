From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [patch 2/2] i2c: announce SMBus host controllers
Date: Fri, 4 Jan 2008 13:38:39 -0700
Message-ID: <200801041338.39470.bjorn.helgaas@hp.com>
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

Note where we find SMBus host controllers and what resources they use.

I tried to put these in the probe() methods just before returning success,
but in some cases I put them in a setup() method instead to be closer to
the request_resource() call.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

---
 drivers/i2c/busses/i2c-ali1535.c |    5 +++--
 drivers/i2c/busses/i2c-ali1563.c |    5 +++--
 drivers/i2c/busses/i2c-ali15x3.c |    6 ++++--
 drivers/i2c/busses/i2c-amd756.c  |    5 +++--
 drivers/i2c/busses/i2c-amd8111.c |    3 +++
 drivers/i2c/busses/i2c-i801.c    |   10 +++++-----
 drivers/i2c/busses/i2c-nforce2.c |    4 +++-
 drivers/i2c/busses/i2c-pasemi.c  |    2 ++
 drivers/i2c/busses/i2c-piix4.c   |   14 +++++++++-----
 drivers/i2c/busses/i2c-sis5595.c |    4 +++-
 drivers/i2c/busses/i2c-sis630.c  |    5 ++++-
 drivers/i2c/busses/i2c-sis96x.c  |    4 ++--
 drivers/i2c/busses/i2c-via.c     |    3 +++
 drivers/i2c/busses/i2c-viapro.c  |    3 +++
 drivers/i2c/busses/scx200_acb.c  |   13 +++++++++++--
 15 files changed, 61 insertions(+), 25 deletions(-)

Index: work3/drivers/i2c/busses/i2c-ali1535.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-ali1535.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-ali1535.c	2008-01-04 13:30:24.000000000 -0700
@@ -190,8 +190,9 @@
 		dev_dbg(&dev->dev, "ALI1535 using Interrupt 9 for SMBus.\n");
 	*/
 	pci_read_config_byte(dev, SMBREV, &temp);
-	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
+	dev_info(&dev->dev, "SMBus Host Controller rev 0x%x at ioports "
+		"0x%x-0x%x\n", temp, ali1535_smba,
+		ali1535_smba + ALI1535_SMB_IOSIZE - 1);
 	return 0;
 
 exit_free:
Index: work3/drivers/i2c/busses/i2c-ali1563.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-ali1563.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-ali1563.c	2008-01-04 13:30:24.000000000 -0700
@@ -351,9 +351,10 @@
 			ali1563_smba);
 		goto Err;
 	}
-	dev_info(&dev->dev, "Found ALi1563 SMBus at 0x%04x\n", ali1563_smba);
-
+	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%x-0x%x\n",
+		ali1563_smba, ali1563_smba + ALI1563_SMB_IOSIZE - 1);
 	return 0;
+
 Err:
 	return -ENODEV;
 }
Index: work3/drivers/i2c/busses/i2c-ali15x3.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-ali15x3.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-ali15x3.c	2008-01-04 13:30:24.000000000 -0700
@@ -216,10 +216,12 @@
 		dev_dbg(&ALI15X3_dev->dev, "ALI15X3 using Interrupt 9 for SMBus.\n");
 	*/
 	pci_read_config_byte(ALI15X3_dev, SMBREV, &temp);
-	dev_dbg(&ALI15X3_dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&ALI15X3_dev->dev, "iALI15X3_smba = 0x%X\n", ali15x3_smba);
 
+	dev_info(&ALI15X3_dev->dev, "SMBus Host Controller rev 0x%x at ioports "
+		"0x%x-0x%x\n", temp,
+		ali15x3_smba, ali15x3_smba + ALI15X3_SMB_IOSIZE - 1);
 	return 0;
+
 error:
 	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
 	return -ENODEV;
Index: work3/drivers/i2c/busses/i2c-amd756.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-amd756.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-amd756.c	2008-01-04 13:30:24.000000000 -0700
@@ -371,8 +371,6 @@
 	}
 
 	pci_read_config_byte(pdev, SMBREV, &temp);
-	dev_dbg(&pdev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&pdev->dev, "AMD756_smba = 0x%X\n", amd756_ioport);
 
 	/* set up the sysfs linkage to our parent device */
 	amd756_smbus.dev.parent = &pdev->dev;
@@ -386,6 +384,9 @@
 		goto out_err;
 	}
 
+	dev_info(&pdev->dev, "SMBus Host Controller rev 0x%x at ioports "
+		"0x%x-0x%x\n", temp, amd756_ioport,
+		amd756_ioport + SMB_IOSIZE - 1);
 	return 0;
 
  out_err:
Index: work3/drivers/i2c/busses/i2c-amd8111.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-amd8111.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-amd8111.c	2008-01-04 13:30:24.000000000 -0700
@@ -381,6 +381,9 @@
 		goto out_release_region;
 
 	pci_set_drvdata(dev, smbus);
+
+	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%x-0x%x\n",
+		smbus->base, smbus->base + smbus->size - 1);
 	return 0;
 
  out_release_region:
Index: work3/drivers/i2c/busses/i2c-i801.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-i801.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-i801.c	2008-01-04 13:30:24.000000000 -0700
@@ -605,11 +605,6 @@
 	}
 	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
 
-	if (temp & SMBHSTCFG_SMB_SMI_EN)
-		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
-	else
-		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
-
 	/* set up the sysfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
 
@@ -618,6 +613,11 @@
 	err = i2c_add_adapter(&i801_adapter);
 	if (err)
 		goto exit_release;
+
+	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%lx-0x%lx "
+		"using %s\n", i801_smba,
+		(unsigned long) (i801_smba + pci_resource_len(dev, SMBBAR) - 1),
+		temp & SMBHSTCFG_SMB_SMI_EN ? "SMI#" : "PCI interrupt");
 	return 0;
 
 exit_release:
Index: work3/drivers/i2c/busses/i2c-nforce2.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-nforce2.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-nforce2.c	2008-01-04 13:30:24.000000000 -0700
@@ -335,7 +335,9 @@
 		release_region(smbus->base, smbus->size);
 		return -1;
 	}
-	dev_info(&smbus->adapter.dev, "nForce2 SMBus adapter at %#x\n", smbus->base);
+
+	dev_info(&smbus->adapter.dev, "SMBus Host Controller at ioports "
+		"0x%x-0x%x\n", smbus->base, smbus->base+smbus->size-1);
 	return 0;
 }
 
Index: work3/drivers/i2c/busses/i2c-pasemi.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-pasemi.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-pasemi.c	2008-01-04 13:30:24.000000000 -0700
@@ -376,6 +376,8 @@
 
 	pci_set_drvdata(dev, smbus);
 
+	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%x-0x%x\n",
+		smbus->base, smbus->base + smbus->size - 1);
 	return 0;
 
  out_release_region:
Index: work3/drivers/i2c/busses/i2c-piix4.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-piix4.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-piix4.c	2008-01-04 13:30:24.000000000 -0700
@@ -120,6 +120,7 @@
 				const struct pci_device_id *id)
 {
 	unsigned char temp;
+	char *interrupt_config;
 
 	/* match up the function */
 	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
@@ -192,17 +193,20 @@
 	}
 
 	if (((temp & 0x0E) == 8) || ((temp & 0x0E) == 2))
-		dev_dbg(&PIIX4_dev->dev, "Using Interrupt 9 for SMBus.\n");
+		interrupt_config = "interrupt 9";
 	else if ((temp & 0x0E) == 0)
-		dev_dbg(&PIIX4_dev->dev, "Using Interrupt SMI# for SMBus.\n");
-	else
+		interrupt_config = "SMI#";
+	else {
+		interrupt_config = "illegal interrupt configuration";
 		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
 			"(or code out of date)!\n");
+	}
 
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
-	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
 
+	dev_info(&PIIX4_dev->dev, "SMBus Host Controller rev 0x%x at ioports "
+		"0x%x-0x%x using %s\n", temp,
+		piix4_smba, piix4_smba + SMBIOSIZE - 1, interrupt_config);
 	return 0;
 }
 
Index: work3/drivers/i2c/busses/i2c-sis5595.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-sis5595.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-sis5595.c	2008-01-04 13:30:24.000000000 -0700
@@ -214,7 +214,9 @@
 		}
 	}
 
-	/* Everything is happy */
+	dev_info(&SIS5595_dev->dev, "SMBus Host Controller at ioports "
+		"0x%x-0x%x\n", sis5595_base + SMB_INDEX,
+		sis5595_base + SMB_INDEX + 2 - 1);
 	return 0;
 
 error:
Index: work3/drivers/i2c/busses/i2c-sis630.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-sis630.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-sis630.c	2008-01-04 13:30:24.000000000 -0700
@@ -441,7 +441,10 @@
 		goto exit;
 	}
 
-	retval = 0;
+	dev_info(&sis630_dev->dev, "SMBus Host Controller at ioports "
+		"0x%x-0x%x\n", acpi_base + SMB_STS,
+		acpi_base + SMB_STS + SIS630_SMB_IOREGION - 1);
+	return 0;
 
 exit:
 	if (retval)
Index: work3/drivers/i2c/busses/i2c-sis96x.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-sis96x.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-sis96x.c	2008-01-04 13:30:24.000000000 -0700
@@ -283,8 +283,6 @@
 			"not initialized!\n");
 		return -EINVAL;
 	}
-	dev_info(&dev->dev, "SiS96x SMBus base address: 0x%04x\n",
-			sis96x_smbus_base);
 
 	/* Everything is happy, let's grab the memory and set things up. */
 	if (!request_region(sis96x_smbus_base, SMB_IOSIZE,
@@ -306,6 +304,8 @@
 	if ((retval = i2c_add_adapter(&sis96x_adapter)))
 		goto exit_release;
 
+	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%x-0x%x\n",
+		sis96x_smbus_base, sis96x_smbus_base + SMB_IOSIZE - 1);
 	return 0;
 
 exit_release:
Index: work3/drivers/i2c/busses/i2c-via.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-via.c	2008-01-04 13:29:37.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-via.c	2008-01-04 13:30:24.000000000 -0700
@@ -147,6 +147,9 @@
 		pm_io_base = 0;
 		return res;
 	}
+
+	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%x-0x%x\n",
+		I2C_DIR, I2C_DIR + IOSPACE - 1);
 	return 0;
 }
 
Index: work3/drivers/i2c/busses/i2c-viapro.c
===================================================================
--- work3.orig/drivers/i2c/busses/i2c-viapro.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/i2c-viapro.c	2008-01-04 13:30:24.000000000 -0700
@@ -413,6 +413,9 @@
 		vt596_pdev = NULL;
 	}
 
+	dev_info(&pdev->dev, "SMBus Host Controller at ioports 0x%x-0x%x\n",
+		vt596_smba, vt596_smba + 8 - 1);
+
 	/* Always return failure here.  This is to allow other drivers to bind
 	 * to this pci device.  We don't really want to have control over the
 	 * pci device, we only wanted to read as few register values from it.
Index: work3/drivers/i2c/busses/scx200_acb.c
===================================================================
--- work3.orig/drivers/i2c/busses/scx200_acb.c	2008-01-04 13:30:02.000000000 -0700
+++ work3/drivers/i2c/busses/scx200_acb.c	2008-01-04 13:30:24.000000000 -0700
@@ -506,8 +506,14 @@
 	iface->base = pci_resource_start(iface->pdev, iface->bar);
 	rc = scx200_acb_create(iface);
 
-	if (rc == 0)
+	if (rc == 0) {
+		dev_info(&pdev->dev, "SMBus Host Controller at ioports "
+			"0x%x-0x%x\n", iface->base,
+			iface->base +
+				pci_resource_len(iface->pdev, iface->bar) - 1);
+
 		return 0;
+	}
 
 	pci_release_region(iface->pdev, iface->bar);
 	pci_dev_put(iface->pdev);
@@ -537,8 +543,11 @@
 	iface->base = base;
 	rc = scx200_acb_create(iface);
 
-	if (rc == 0)
+	if (rc == 0) {
+		printk(KERN_INFO NAME ": ISA SMBus Host Controller at ioports "
+			"0x%x-0x%x\n", iface->base, iface->base + 8 - 1);
 		return 0;
+	}
 
 	release_region(base, 8);
  errout_free:
