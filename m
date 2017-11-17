From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 2/3] i2c: add runtime PM handling to core
Date: Fri, 17 Nov 2017 19:05:38 +0100
Message-ID: <20171117180539.4984-3-l.stach@pengutronix.de>
References: <20171117180539.4984-1-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53557 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161078AbdKQSFl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 13:05:41 -0500
In-Reply-To: <20171117180539.4984-1-l.stach@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de, Lukas Rusak <lorusak@gmail.com>, Chris Healy <cphealy@gmail.com>

This allows to simplify the drivers if they opt to use the runtime PM
provided by the core. Even more importantly it allows to move the
runtime PM handling out of the i2c bus lock. As runtime PM may need to
take other locks itself (i.e. when manipulating clocks), holding the
bus lock may lead to deadlocks, due to different lock ordering.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/i2c/i2c-core-base.c | 18 ++++++++++++++++--
 include/linux/i2c.h         |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 56e46581b84b..3c971711171c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1931,11 +1931,19 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		}
 #endif
 
+		if (adap->auto_rpm) {
+			ret = pm_runtime_get_sync(adap->dev.parent);
+			if (ret < 0)
+				return ret;
+		}
+
 		if (in_atomic() || irqs_disabled()) {
 			ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
-			if (!ret)
+			if (!ret) {
 				/* I2C activity is ongoing. */
-				return -EAGAIN;
+				ret = -EAGAIN;
+				goto out_rpm;
+			}
 		} else {
 			i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 		}
@@ -1943,6 +1951,12 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		ret = __i2c_transfer(adap, msgs, num);
 		i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
+out_rpm:
+		if (adap->auto_rpm) {
+			pm_runtime_mark_last_busy(adap->dev.parent);
+			pm_runtime_put_autosuspend(adap->dev.parent);
+		}
+
 		return ret;
 	} else {
 		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index d501d3956f13..6bc3d1ed554e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -585,6 +585,7 @@ struct i2c_adapter {
 	int nr;
 	char name[48];
 	struct completion dev_released;
+	bool auto_rpm;			/* runtime PM managed by core */
 
 	struct mutex userspace_clients_lock;
 	struct list_head userspace_clients;
-- 
2.11.0
