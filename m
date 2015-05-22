From: "s. wicki" <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: [PATCH] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Fri, 22 May 2015 10:36:51 +0200
Message-ID: <1432283811-22226-1-git-send-email-linux_wi@tinag.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "s. wicki" <linux_wi-ADq4ffItWIY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

fixes:	round down divider instead of incrementing
adds:	make sure bits 16-31 of cdiv register are always 0
adds:	assume minimal divider of 2 if divider resulted in 0
	(bcm2835 sets divider to 32768 if cdiv is set to 0)

Signed-off-by: s. wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index c9336a3..745181c 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -51,6 +51,9 @@
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
 #define BCM2835_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define BCM2835_I2C_CDIV_MIN	0x0002
+#define BCM2835_I2C_CDIV_MAX	0xFFFE
+#define BCM2835_I2C_CDIV_BITMSK	0xFFFE
 
 struct bcm2835_i2c_dev {
 	struct device *dev;
@@ -251,13 +254,34 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	}
 
 	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
-	/*
-	 * Per the datasheet, the register is always interpreted as an even
-	 * number, by rounding down. In other words, the LSB is ignored. So,
-	 * if the LSB is set, increment the divider to avoid any issue.
-	 */
-	if (divider & 1)
-		divider++;
+	if (divider == 0) {
+		/*
+		 * divider results in 0 by extremely high bus_clk_rate values
+		 * such as bus_clk_rate >= 4044967297 and core_clock = 250MHz.
+		 * In such a case assume the minimal possible divider since
+		 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
+		 */
+		divider = BCM2835_I2C_CDIV_MIN;
+	} else {
+		/* check if divider meets certain bcm2835 specific criterias */
+		if ((divider & BCM2835_I2C_CDIV_BITMSK) != divider) {
+			if (divider > BCM2835_I2C_CDIV_MAX)
+				/*
+				 * Per the datasheet it must be made sure
+				 * that bits 16-31 are set to 0. If that is
+				 * not the case, then set to the maximum
+				 * allowed value.
+				 */
+				divider = BCM2835_I2C_CDIV_MAX;
+			else
+				/*
+				 * Per datasheet the cdiv is always rounded
+				 * down to an even number. Bitmask takes care
+				 * of this and clears the LSB
+				 */
+				divider &= BCM2835_I2C_CDIV_BITMSK;
+		}
+	}
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-- 
2.1.4
