From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 09/14] mfd: max8907: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:16 +0200
Message-ID: <20190722172623.4166-10-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/max8907.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index cc01f706cb32..d44baafd9d14 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -214,9 +214,9 @@ static int max8907_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap_gen;
 	}
 
-	max8907->i2c_rtc = i2c_new_dummy(i2c->adapter, MAX8907_RTC_I2C_ADDR);
-	if (!max8907->i2c_rtc) {
-		ret = -ENOMEM;
+	max8907->i2c_rtc = i2c_new_dummy_device(i2c->adapter, MAX8907_RTC_I2C_ADDR);
+	if (IS_ERR(max8907->i2c_rtc)) {
+		ret = PTR_ERR(max8907->i2c_rtc);
 		goto err_dummy_rtc;
 	}
 	i2c_set_clientdata(max8907->i2c_rtc, max8907);
-- 
2.20.1
