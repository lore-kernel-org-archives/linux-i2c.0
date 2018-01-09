From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 5/6] i2c: send STOP after successful bus recovery
Date: Tue,  9 Jan 2018 14:58:58 +0100
Message-ID: <20180109135859.20771-6-wsa@the-dreams.de>
References: <20180109135859.20771-1-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180109135859.20771-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we managed to get a client release SDA again, send a STOP afterwards
to make sure we have a consistent state on the bus again.

Tested-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 54cef80990a11a..23f353630db32f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -199,6 +199,18 @@ int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 	if (bri->get_sda && !bri->get_sda(adap))
 		ret = -EBUSY;
 
+	/* If all went well, send STOP for a sane bus state. */
+	if (ret == 0 && bri->set_sda) {
+		bri->set_scl(adap, 0);
+		ndelay(RECOVERY_NDELAY / 2);
+		bri->set_sda(adap, 0);
+		ndelay(RECOVERY_NDELAY / 2);
+		bri->set_scl(adap, 1);
+		ndelay(RECOVERY_NDELAY / 2);
+		bri->set_sda(adap, 1);
+		ndelay(RECOVERY_NDELAY / 2);
+	}
+
 	if (bri->unprepare_recovery)
 		bri->unprepare_recovery(adap);
 
-- 
2.11.0
