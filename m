From: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] i2c designware add support of I2C standard mode
Date: Tue,  8 Oct 2013 17:00:55 +0200
Message-ID: <1381244455-3836-2-git-send-email-romainba@abilis.com>
References: <20130828153429.GB7066@ab42.lan>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130828153429.GB7066-7oYq3qWSd+k@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Chiau Ee Chew <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some legacy devices support ony I2C standard mode at 100kHz. 
This patch allows to select the standard mode through the DTS 
with the use of the existing clock-frequency parameter.

When clock-frequency parameter is not set, the fast mode is selected.
Only when the parameter is set at 100000, the standard mode is selected.

Signed-off-by: Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-designware.txt     |    1 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |   17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index 5199b0c..16d0bef 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -9,6 +9,7 @@ Required properties :
 Recommended properties :
 
  - clock-frequency : desired I2C bus clock frequency in Hz.
+   Only standard mode at 100kHz and fast mode at 400kHz are supported.
 
 Optional properties :
  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0d6fe47..5f06848 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -87,6 +87,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *mem;
 	int irq, r;
+	u32 clk_freq;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -122,6 +123,9 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->clk);
 	clk_prepare_enable(dev->clk);
 
+	/* fast mode by default */
+	clk_freq = 400000;
+
 	if (pdev->dev.of_node) {
 		u32 ht = 0;
 		u32 ic_clk = dev->get_clk_rate_khz(dev);
@@ -136,6 +140,11 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node,
 				     "i2c-scl-falling-time-ns",
 				     &dev->scl_falling_time);
+
+		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				     &clk_freq);
+		if (clk_freq != 100000 && clk_freq != 400000)
+			return -EINVAL;
 	}
 
 	dev->functionality =
@@ -145,8 +154,12 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
-	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
+	if (clk_freq == 100000)
+		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_STD;
+	else
+		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
 	/* Try first if we can configure the device from ACPI */
 	r = dw_i2c_acpi_configure(pdev);
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
