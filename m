From: Shikhar Dogra <shidogra@cisco.com>
Subject: [PATCH] i2c: designware: make *CNT values configurable
Date: Wed, 25 Oct 2017 11:50:22 -0700
Message-ID: <20171025185022.GA25920@sjc-ads-4188.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

The values are already configurable from ACPI.

This patch makes the high count (HCNT) and low count (LCNT)
register values configurable through device tree.

Cc: xe-linux-external@cisco.com
Signed-off-by: Shikhar Dogra <shidogra@cisco.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 16 ++++++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c              | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fee26dc..2b9ddca 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -20,6 +20,18 @@ Optional properties :
  - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tHIGH period.
 
+ - i2c-ss-hcnt : should contain the I2C controller standard speed HCNT value.
+   If this is not set we use the calculated and more conservative values.
+
+ - i2c-ss-lcnt : should contain the I2C controller standard speed LCNT value.
+   If this is not set we use the calculated and more conservative values.
+
+ - i2c-fs-hcnt : should contain the I2C controller fast speed HCNT value.
+   If this is not set we use the calculated and more conservative values.
+
+ - i2c-fs-lcnt : should contain the I2C controller fast speed LCNT value.
+   If this is not set we use the calculated and more conservative values.
+
 Example :
 
 	i2c@f0000 {
@@ -42,4 +54,8 @@ Example :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		i2c-ss-hcnt = /bits/ 16 <5000>;
+		i2c-ss-lcnt = /bits/ 16 <5000>;
+		i2c-fs-hcnt = /bits/ 16 <5000>;
+		i2c-fs-lcnt = /bits/ 16 <5000>;
 	};
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6b00061c..25c3b0c 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -177,6 +177,18 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				     &clk_freq);
 
+		of_property_read_u16(pdev->dev.of_node,
+				     "i2c-ss-hcnt", &dev->ss_hcnt);
+
+		of_property_read_u16(pdev->dev.of_node,
+				     "i2c-ss-lcnt", &dev->ss_lcnt);
+
+		of_property_read_u16(pdev->dev.of_node,
+				     "i2c-fs-hcnt", &dev->fs_hcnt);
+
+		of_property_read_u16(pdev->dev.of_node,
+				     "i2c-fs-lcnt", &dev->fs_lcnt);
+
 		/* Only standard mode at 100kHz and fast mode at 400kHz
 		 * are supported.
 		 */
-- 
2.7.4
