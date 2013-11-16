From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: [PATCH] i2c: Fallback to of_node of parent
Date: Sat, 16 Nov 2013 16:40:31 +0100
Message-ID: <528791EF.9060505@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Many busses (e.g. tegra, omap, bcm2835)
need to set the of_node of the adapter
device to the one of the parent device, i.e.

adap->dev.of_node = pdev->dev.of_node;

As suggested by Stephen Warren, this could also
be done in the i2c core and it is a common mistake
to forget this line:

I2C: BCM2835: Linking platform nodes to adapter nodes
i2c: Fix device tree binding for i2c-cbus-gpio

Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Suggested-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 430c001..c8e33a5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1310,6 +1310,9 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	struct device *dev = &adapter->dev;
 	int id;

+	if (!dev->of_node && dev->parent)
+		dev->of_node = dev->parent->of_node;
+
 	if (dev->of_node) {
 		id = of_alias_get_id(dev->of_node, "i2c");
 		if (id >= 0) {
-- 
1.7.9.5
