From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: [PATCH v5] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Thu, 18 Jun 2015 11:10:11 +0200
Message-ID: <1434618611-16062-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux_wi-ADq4ffItWIY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Checks if the cdiv value is in between min (0x2) and max (0xFFFE)
supported values by the bcm2835. If not, it returns -ENODEV.

See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
---
 PATCH v5: instead of falling back to a supported clock speed, return an error.

 drivers/i2c/busses/i2c-bcm2835.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index c9336a3..6411bfa 100644
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
@@ -258,6 +261,11 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	 */
 	if (divider & 1)
 		divider++;
+	if ((divider < BCM2835_I2C_CDIV_MIN) ||
+	    (divider > BCM2835_I2C_CDIV_MAX)) {
+		dev_err(&pdev->dev, "Invalid clock-frequency\n");
+		return -ENODEV;
+	}
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-- 
2.1.4
