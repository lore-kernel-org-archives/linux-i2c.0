From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 5/5] i2c: i801: Use managed pcim_* PCI device initialization and reservation
Date: Wed, 11 Feb 2015 14:32:08 +0200
Message-ID: <1423657928-25534-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423657928-25534-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Simplifies the code a bit and makes easier to disable PCI device on driver
detach by removing the pcim_pin_device() call in the future if needed.

Reason why i2c-i801.c doesn't ever call pci_disable_device() was because it
made some systems to hang during power-off. See commit d6fcb3b9cf77
("[PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled")
and
http://marc.info/?l=linux-kernel&m=115160053309535&w=2

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5fb35464f693..9f7b69743233 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1180,12 +1180,13 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 	priv->features &= ~disable_features;
 
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err) {
 		dev_err(&dev->dev, "Failed to enable SMBus PCI device (%d)\n",
 			err);
 		goto exit;
 	}
+	pcim_pin_device(dev);
 
 	/* Determine the address of the SMBus area */
 	priv->smba = pci_resource_start(dev, SMBBAR);
@@ -1202,7 +1203,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto exit;
 	}
 
-	err = pci_request_region(dev, SMBBAR, dev_driver_string(&dev->dev));
+	err = pcim_iomap_regions(dev, 1 << SMBBAR, dev_driver_string(&dev->dev));
 	if (err) {
 		dev_err(&dev->dev,
 			"Failed to request SMBus region 0x%lx-0x%Lx\n",
@@ -1276,7 +1277,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
 		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
-		goto exit_release;
+		goto exit;
 	}
 
 	i801_probe_optional_slaves(priv);
@@ -1287,8 +1288,6 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	return 0;
 
-exit_release:
-	pci_release_region(dev, SMBBAR);
 exit:
 	return err;
 }
@@ -1301,8 +1300,6 @@ static void i801_remove(struct pci_dev *dev)
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 
-	pci_release_region(dev, SMBBAR);
-
 	/*
 	 * do not call pci_disable_device(dev) since it can cause hard hangs on
 	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E8010)
-- 
2.1.4
