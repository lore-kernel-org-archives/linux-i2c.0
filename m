From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 08/14] mfd: max77843: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:15 +0200
Message-ID: <20190722172623.4166-9-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/max77843.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 25cbb2242b26..209ee24d9ce1 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -70,11 +70,11 @@ static int max77843_chg_init(struct max77693_dev *max77843)
 {
 	int ret;
 
-	max77843->i2c_chg = i2c_new_dummy(max77843->i2c->adapter, I2C_ADDR_CHG);
-	if (!max77843->i2c_chg) {
+	max77843->i2c_chg = i2c_new_dummy_device(max77843->i2c->adapter, I2C_ADDR_CHG);
+	if (IS_ERR(max77843->i2c_chg)) {
 		dev_err(&max77843->i2c->dev,
 				"Cannot allocate I2C device for Charger\n");
-		return -ENODEV;
+		return PTR_ERR(max77843->i2c_chg);
 	}
 	i2c_set_clientdata(max77843->i2c_chg, max77843);
 
-- 
2.20.1
