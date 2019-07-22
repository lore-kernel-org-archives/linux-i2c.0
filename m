From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 02/14] mfd: 88pm860x-core: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:09 +0200
Message-ID: <20190722172623.4166-3-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/88pm860x-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 9e0bd135730f..c9bae71f643a 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1178,12 +1178,12 @@ static int pm860x_probe(struct i2c_client *client)
 	 */
 	if (pdata->companion_addr && (pdata->companion_addr != client->addr)) {
 		chip->companion_addr = pdata->companion_addr;
-		chip->companion = i2c_new_dummy(chip->client->adapter,
+		chip->companion = i2c_new_dummy_device(chip->client->adapter,
 						chip->companion_addr);
-		if (!chip->companion) {
+		if (IS_ERR(chip->companion)) {
 			dev_err(&client->dev,
 				"Failed to allocate I2C companion device\n");
-			return -ENODEV;
+			return PTR_ERR(chip->companion);
 		}
 		chip->regmap_companion = regmap_init_i2c(chip->companion,
 							&pm860x_regmap_config);
-- 
2.20.1
