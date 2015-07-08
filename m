From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/10] i2c: i2c-arb-gpio-challenge: use of_get_i2c_adapter_by_node interface
Date: Wed, 8 Jul 2015 16:00:21 +0300
Message-ID: <1436360421-9600-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This change is needed to properly lock I2C bus driver, which serves DDC.

Prior to this change i2c_put_adapter() is misused, which may lead
to an overflow over zero of I2C bus driver user counter.
By the way added of_node_put() to eliminate memory leak, if OF_DYNAMIC
is enabled.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 5cf1b60..402e3a6 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -196,7 +196,8 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return -EINVAL;
 	}
-	arb->parent = of_find_i2c_adapter_by_node(parent_np);
+	arb->parent = of_get_i2c_adapter_by_node(parent_np);
+	of_node_put(parent_np);
 	if (!arb->parent) {
 		dev_err(dev, "Cannot find parent bus\n");
 		return -EPROBE_DEFER;
-- 
2.1.4
