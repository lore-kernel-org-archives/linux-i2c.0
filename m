From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-piix4: Drop redundant PCI function number check
Date: Thu, 17 Jan 2008 14:20:30 +0100
Message-ID: <20080117142030.434b094e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Checking the PCI function number doesn't add any value, and it makes
adding dynamic IDs to the driver more difficult. Drop this check.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c |   41 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

--- linux-2.6.24-rc8.orig/drivers/i2c/busses/i2c-piix4.c	2008-01-17 13:47:47.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/busses/i2c-piix4.c	2008-01-17 14:13:42.000000000 +0100
@@ -121,10 +121,6 @@ static int __devinit piix4_setup(struct 
 {
 	unsigned char temp;
 
-	/* match up the function */
-	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
-		return -ENODEV;
-
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
 	/* Don't access SMBus on IBM systems which get corrupted eeproms */
@@ -389,28 +385,21 @@ static struct i2c_adapter piix4_adapter 
 };
 
 static struct pci_device_id piix4_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3),
-	  .driver_data = 3 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_SMBUS),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000SB),
-	  .driver_data = 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3),
-	  .driver_data = 3 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
-	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_CSB5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_CSB6) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_HT1000SB) },
 	{ 0, }
 };
 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
