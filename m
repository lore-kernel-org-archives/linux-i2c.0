From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/14] mfd: max14577: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:13 +0200
Message-ID: <20190722172623.4166-7-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/max14577.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index ebb13d5de530..fd8864cafd25 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -297,11 +297,11 @@ static int max77836_init(struct max14577 *max14577)
 	int ret;
 	u8 intsrc_mask;
 
-	max14577->i2c_pmic = i2c_new_dummy(max14577->i2c->adapter,
+	max14577->i2c_pmic = i2c_new_dummy_device(max14577->i2c->adapter,
 			I2C_ADDR_PMIC);
-	if (!max14577->i2c_pmic) {
+	if (IS_ERR(max14577->i2c_pmic)) {
 		dev_err(max14577->dev, "Failed to register PMIC I2C device\n");
-		return -ENODEV;
+		return PTR_ERR(max14577->i2c_pmic);
 	}
 	i2c_set_clientdata(max14577->i2c_pmic, max14577);
 
-- 
2.20.1
