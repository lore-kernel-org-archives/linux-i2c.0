From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Date: Mon, 25 Nov 2013 09:01:50 +0100
Message-ID: <529303EE.4080606@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

In order to find I2C devices in the device tree, the platform nodes
have to be known by the I2C core. This requires setting the
dev.of_node parameter of the adapter.

Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
---

Since the general approach is not easy enough
(see [PATCH] i2c: Fallback to of_node of parent),
this patch adds the required line to the bcm2835 bus.

 drivers/i2c/busses/i2c-bcm2835.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c
b/drivers/i2c/busses/i2c-bcm2835.c
index ea4b08f..8beecfa 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -299,6 +299,7 @@ static int bcm2835_i2c_probe(struct platform_device
*pdev)
 	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm2835_i2c_algo;
 	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;

 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);

-- 1.7.9.5
