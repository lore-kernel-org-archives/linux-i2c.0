From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 07/14] mfd: max77693: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:14 +0200
Message-ID: <20190722172623.4166-8-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/max77693.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index 901d99d65924..596ed85cab3b 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -183,17 +183,17 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	} else
 		dev_info(max77693->dev, "device ID: 0x%x\n", reg_data);
 
-	max77693->i2c_muic = i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
-	if (!max77693->i2c_muic) {
+	max77693->i2c_muic = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_MUIC);
+	if (IS_ERR(max77693->i2c_muic)) {
 		dev_err(max77693->dev, "Failed to allocate I2C device for MUIC\n");
-		return -ENODEV;
+		return PTR_ERR(max77693->i2c_muic);
 	}
 	i2c_set_clientdata(max77693->i2c_muic, max77693);
 
-	max77693->i2c_haptic = i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
-	if (!max77693->i2c_haptic) {
+	max77693->i2c_haptic = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_HAPTIC);
+	if (IS_ERR(max77693->i2c_haptic)) {
 		dev_err(max77693->dev, "Failed to allocate I2C device for Haptic\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(max77693->i2c_haptic);
 		goto err_i2c_haptic;
 	}
 	i2c_set_clientdata(max77693->i2c_haptic, max77693);
-- 
2.20.1
