From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] power: supply: bq24190_charger: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:54 +0100
Message-ID: <20200326210954.12931-2-wsa+renesas@sang-engineering.com>
References: <20200326210954.12931-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326210954.12931-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API in this comment.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 453d6332d43a..4540e913057f 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -673,7 +673,7 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
 	 *   { .type = "bq24190", .addr = 0x6b, .properties = pe, .irq = irq };
 	 * struct i2c_adapter ad = { ... };
 	 * i2c_add_adapter(&ad);
-	 * i2c_new_device(&ad, &bi);
+	 * i2c_new_client_device(&ad, &bi);
 	 */
 	if (device_property_read_bool(bdi->dev, "disable-reset"))
 		return 0;
-- 
2.20.1
