From: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c:at91: Add device tree property to set clock-frequency
Date: Sun, 23 Feb 2014 03:19:00 -0500
Message-ID: <1393143540-627-1-git-send-email-mark.roszko@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This adds the ability to set "clock-frequency" in the device tree for the i2c bus following
the naming of other i2c bus implementations. If the property is not set, the clock
frequency will default to the previously used define of 100KHz.

Signed-off-by: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt |    2 ++
 drivers/i2c/busses/i2c-at91.c                      |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index 4fade84..388f0a2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -12,6 +12,7 @@ Required properties :
 - clocks: phandles to input clocks.
 
 Optional properties:
+- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000
 - Child nodes conforming to i2c bus binding
 
 Examples :
@@ -23,6 +24,7 @@ i2c0: i2c@fff84000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clocks = <&twi0_clk>;
+	clock-frequency = <400000>;
 
 	24c512@50 {
 		compatible = "24c512";
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 843d012..8e0871e 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -32,7 +32,7 @@
 #include <linux/slab.h>
 #include <linux/platform_data/dma-atmel.h>
 
-#define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
+#define DEFAULT_TWI_CLK_HZ		100000		/* max 400 Kbits/s */
 #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
 #define AT91_I2C_DMA_THRESHOLD	8			/* enable DMA if transfer size is bigger than this threshold */
 
@@ -711,6 +711,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int rc;
 	u32 phy_addr;
+	int bus_clk_rate;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -756,7 +757,12 @@ static int at91_twi_probe(struct platform_device *pdev)
 			dev->use_dma = true;
 	}
 
-	at91_calc_twi_clock(dev, TWI_CLK_HZ);
+	ret = of_property_read_u32(dev->dev->of_node, "clock-frequency",
+			&bus_clk_rate);
+	if (ret < 0)
+		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
+
+	at91_calc_twi_clock(dev, bus_clk_rate);
 	at91_init_twi_bus(dev);
 
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
-- 
1.7.10.4
