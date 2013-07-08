From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] i2c-designware: configure *CNT values from ACPI
Date: Mon,  8 Jul 2013 14:45:27 +0300
Message-ID: <1373283927-21677-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373283927-21677-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some Intel LPSS I2C devices make the *CNT values available from ACPI
namespace in similar way than the SDA hold value. These values allow
platform/BIOS to specify the most accurate *CNT values for the device
driver to use.

So change the ACPI part of the driver to use these values if they exists
and otherwise use the default method based solely on the input clock speed.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
This applies on top of following patch which is not yet in i2c tree:

http://permalink.gmane.org/gmane.linux.drivers.i2c/15754

 drivers/i2c/busses/i2c-designware-platdrv.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index c7cfdac..a1488df 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -59,7 +59,6 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
-	acpi_string name;
 
 	if (!handle)
 		return -ENODEV;
@@ -68,14 +67,32 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dev->tx_fifo_depth = 32;
 	dev->rx_fifo_depth = 32;
 
-	name = dev->master_cfg & DW_IC_CON_SPEED_FAST ? "FMCN" : "SSCN";
-	if (ACPI_SUCCESS(acpi_evaluate_object(handle, name, NULL, &buf))) {
+	/* Standard speed configuration */
+	if (ACPI_SUCCESS(acpi_evaluate_object(handle, "SSCN", NULL, &buf))) {
 		union acpi_object *obj = (union acpi_object *)buf.pointer;
 
 		if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 3) {
 			const union acpi_object *objs = obj->package.elements;
 
-			dev->sda_hold_time = (u32)objs[2].integer.value;
+			dev->ss_hcnt = (u16)objs[0].integer.value;
+			dev->ss_lcnt = (u16)objs[1].integer.value;
+			if (!(dev->master_cfg & DW_IC_CON_SPEED_FAST))
+				dev->sda_hold_time = (u32)objs[2].integer.value;
+		}
+
+		kfree(buf.pointer);
+	}
+	/* Fast speed configuration */
+	if (ACPI_SUCCESS(acpi_evaluate_object(handle, "FMCN", NULL, &buf))) {
+		union acpi_object *obj = (union acpi_object *)buf.pointer;
+
+		if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 3) {
+			const union acpi_object *objs = obj->package.elements;
+
+			dev->fs_hcnt = (u16)objs[0].integer.value;
+			dev->fs_lcnt = (u16)objs[1].integer.value;
+			if (dev->master_cfg & DW_IC_CON_SPEED_FAST)
+				dev->sda_hold_time = (u32)objs[2].integer.value;
 		}
 
 		kfree(buf.pointer);
-- 
1.8.3.2
