From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/6] i2c: send STOP after successful bus recovery
Date: Mon,  4 Dec 2017 13:36:39 +0100
Message-ID: <20171204123640.3382-6-wsa+renesas@sang-engineering.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org

If we managed to get a client release SDA again, send a STOP afterwards
to make sure we have a consistent state on the bus again.

Cc: Phil Reid <preid@electromag.com.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index dae7f4a783dbe4..29d6606d653229 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -200,6 +200,18 @@ int i2c_generic_scl_recovery(struct i2c_adapter *adap)
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
