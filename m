From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 3/3] i2c: core: Map OF IRQ at probe time
Date: Thu, 30 Oct 2014 15:59:38 +0200
Message-ID: <1414677578-27412-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

I2C clients instantiated from OF get their IRQ mapped at device
registration time. This leads to the IRQ being silently ignored if the
related irqchip hasn't been proved yet.

Fix this by moving IRQ mapping at probe time using of_get_irq(). The
function operates as irq_of_parse_and_map() but additionally returns
-EPROBE_DEFER if the irqchip isn't available, allowing us to defer I2C
client probing.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/i2c/i2c-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 258765b29684..c6694f232240 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -631,6 +631,15 @@ static int i2c_device_probe(struct device *dev)
 	if (!client)
 		return 0;
 
+	if (!client->irq && dev->of_node) {
+		int irq = of_irq_get(dev->of_node, 0);
+
+		if (irq < 0)
+			return irq;
+
+		client->irq = irq;
+	}
+
 	driver = to_i2c_driver(dev->driver);
 	if (!driver->probe || !driver->id_table)
 		return -ENODEV;
@@ -1412,7 +1421,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 			continue;
 		}
 
-		info.irq = irq_of_parse_and_map(node, 0);
 		info.of_node = of_node_get(node);
 		info.archdata = &dev_ad;
 
@@ -1426,7 +1434,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
 				node->full_name);
 			of_node_put(node);
-			irq_dispose_mapping(info.irq);
 			continue;
 		}
 	}
-- 
2.0.4
