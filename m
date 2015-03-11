From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
Subject: [RFC] Revert "i2c: core: Dispose OF IRQ mapping at client removal time"
Date: Wed, 11 Mar 2015 18:35:36 +0100
Message-ID: <1426095336-16108-1-git-send-email-kubakici@wp.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This reverts commit e4df3a0b6228
("i2c: core: Dispose OF IRQ mapping at client removal time")

Calling irq_dispose_mapping() will destroy the mapping and
disassociate the IRQ from the IRQ chip to which it belongs.
There should be no real need to dispose of the mapping in
the first place.

Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
---
Hi there!

reverted patch makes it impossible to rebind to a device or reload the driver.

I'm using GPIO IRQs, the GPIO IRQ controllers create mappings for all their
interrupts by themselves and bind them the controller chip with
irq_set_chip_and_handler() at boot time. When i2c calls of_irq_get() this
mapping is simply reused (irq_create_mapping() checks for an existing mapping).

If the mapping is destroyed by i2c on .remove(), nothing can bind the mapping
back to the chip therefore __irq_set_trigger() will fail to set the type.

I'm testing with sc16is7xx on a RaspberryPi.
---
 drivers/i2c/i2c-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e9eae57a2b50..63663332391d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -679,9 +679,6 @@ static int i2c_device_remove(struct device *dev)
 		status = driver->remove(client);
 	}
 
-	if (dev->of_node)
-		irq_dispose_mapping(client->irq);
-
 	dev_pm_domain_detach(&client->dev, true);
 	return status;
 }
-- 
2.1.0
