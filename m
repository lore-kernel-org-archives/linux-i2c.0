From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c-designware: configure SDA hold time from ACPI
Date: Wed,  3 Jul 2013 12:52:40 +0300
Message-ID: <1372845160-32625-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some Intel LPSS I2C devices make the SDA hold time parameter available via
SSCN (standard mode) and FMCN (fast mode) ACPI methods. If we find that
such method exist, we evaluate it and pass the returned SDA hold value to
the i2c-designware core analogous to Device Tree.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 8b9d3f1..c7cfdac 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -57,13 +57,30 @@ static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	acpi_string name;
 
-	if (!ACPI_HANDLE(&pdev->dev))
+	if (!handle)
 		return -ENODEV;
 
 	dev->adapter.nr = -1;
 	dev->tx_fifo_depth = 32;
 	dev->rx_fifo_depth = 32;
+
+	name = dev->master_cfg & DW_IC_CON_SPEED_FAST ? "FMCN" : "SSCN";
+	if (ACPI_SUCCESS(acpi_evaluate_object(handle, name, NULL, &buf))) {
+		union acpi_object *obj = (union acpi_object *)buf.pointer;
+
+		if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 3) {
+			const union acpi_object *objs = obj->package.elements;
+
+			dev->sda_hold_time = (u32)objs[2].integer.value;
+		}
+
+		kfree(buf.pointer);
+	}
+
 	return 0;
 }
 
-- 
1.8.3.2
