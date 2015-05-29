From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: [PATCH v2] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Fri, 29 May 2015 12:26:44 +0200
Message-ID: <1432895204-19924-1-git-send-email-linux_wi@tinag.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adds: make sure bits 16-31 of DIV register are always 0
Adds: assume minimal divider of 2 if divider resulted in 0
      (bcm2835 sets divider to 32768 if cdiv is set to 0)

See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index c9336a3..8195b04 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -50,6 +50,9 @@
 #define BCM2835_I2C_S_CLKT	BIT(9)
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
+#define BCM2835_I2C_CDIV_MIN	0x0002
+#define BCM2835_I2C_CDIV_MAX	0xFFFE
+
 #define BCM2835_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
 struct bcm2835_i2c_dev {
@@ -252,12 +255,22 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 
 	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
 	/*
+	 * Divider results in 0 by extremely high bus_clk_rate values
+	 * such as bus_clk_rate >= 4044967297 and core_clock = 250MHz.
+	 * In such a case assume the minimal possible divider since
+	 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
+	 */
+	if (divider < BCM2835_I2C_CDIV_MIN)
+		divider = BCM2835_I2C_CDIV_MIN;
+	/*
 	 * Per the datasheet, the register is always interpreted as an even
 	 * number, by rounding down. In other words, the LSB is ignored. So,
 	 * if the LSB is set, increment the divider to avoid any issue.
 	 */
 	if (divider & 1)
 		divider++;
+	if (divider > BCM2835_I2C_CDIV_MAX)
+		divider = BCM2835_I2C_CDIV_MAX;
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-- 
2.1.4
