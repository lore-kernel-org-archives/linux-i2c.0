From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 2/6] i2c: add identifier in declarations for i2c_bus_recovery
Date: Tue,  9 Jan 2018 14:58:55 +0100
Message-ID: <20180109135859.20771-3-wsa@the-dreams.de>
References: <20180109135859.20771-1-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180109135859.20771-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

No reason to have them undefined, so let's add them.

Tested-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since V1:

* add more identifiers

 include/linux/i2c.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f8a9d81e911e52..fd87b806b5f165 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -559,14 +559,14 @@ struct i2c_timings {
  * @sda_gpiod: gpiod of the SDA line. Only required for GPIO recovery.
  */
 struct i2c_bus_recovery_info {
-	int (*recover_bus)(struct i2c_adapter *);
+	int (*recover_bus)(struct i2c_adapter *adap);
 
-	int (*get_scl)(struct i2c_adapter *);
-	void (*set_scl)(struct i2c_adapter *, int val);
-	int (*get_sda)(struct i2c_adapter *);
+	int (*get_scl)(struct i2c_adapter *adap);
+	void (*set_scl)(struct i2c_adapter *adap, int val);
+	int (*get_sda)(struct i2c_adapter *adap);
 
-	void (*prepare_recovery)(struct i2c_adapter *);
-	void (*unprepare_recovery)(struct i2c_adapter *);
+	void (*prepare_recovery)(struct i2c_adapter *adap);
+	void (*unprepare_recovery)(struct i2c_adapter *adap);
 
 	/* gpio recovery */
 	struct gpio_desc *scl_gpiod;
-- 
2.11.0
