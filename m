From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 11/14] mfd: max8997: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:18 +0200
Message-ID: <20190722172623.4166-12-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/max8997.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 8c06c09e36d1..68d8f2b95287 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -185,25 +185,25 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
 
 	mutex_init(&max8997->iolock);
 
-	max8997->rtc = i2c_new_dummy(i2c->adapter, I2C_ADDR_RTC);
-	if (!max8997->rtc) {
+	max8997->rtc = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_RTC);
+	if (IS_ERR(max8997->rtc)) {
 		dev_err(max8997->dev, "Failed to allocate I2C device for RTC\n");
-		return -ENODEV;
+		return PTR_ERR(max8997->rtc);
 	}
 	i2c_set_clientdata(max8997->rtc, max8997);
 
-	max8997->haptic = i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
-	if (!max8997->haptic) {
+	max8997->haptic = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_HAPTIC);
+	if (IS_ERR(max8997->haptic)) {
 		dev_err(max8997->dev, "Failed to allocate I2C device for Haptic\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(max8997->haptic);
 		goto err_i2c_haptic;
 	}
 	i2c_set_clientdata(max8997->haptic, max8997);
 
-	max8997->muic = i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
-	if (!max8997->muic) {
+	max8997->muic = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_MUIC);
+	if (IS_ERR(max8997->muic)) {
 		dev_err(max8997->dev, "Failed to allocate I2C device for MUIC\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(max8997->muic);
 		goto err_i2c_muic;
 	}
 	i2c_set_clientdata(max8997->muic, max8997);
-- 
2.20.1
