From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: [PATCH] i2c: busses: i2c-bcm2835: S-Register clear reserved bits
Date: Tue, 16 Jun 2015 17:40:59 +0200
Message-ID: <1434469259-6474-1-git-send-email-linux_wi@tinag.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux_wi-ADq4ffItWIY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The Datasheet mentions on page 31 that the bits 10-31 must be read as
don't care and written as 0.
https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

We cannot guarantee that we reed bits 10-31 as always 0 (becuase the
datasheet says read as don't care). We clear the bits with a bitmask to
prevent writing back unknown data at the reserved bits.

Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index c9336a3..aa06da1 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -50,6 +50,8 @@
 #define BCM2835_I2C_S_CLKT	BIT(9)
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
+#define BCM2835_I2C_BITMSK_S	0x03FF
+
 #define BCM2835_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
 struct bcm2835_i2c_dev {
@@ -111,6 +113,7 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 	u32 val, err;
 
 	val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+	val &= BCM2835_I2C_BITMSK_S;
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, val);
 
 	err = val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
-- 
2.1.4
