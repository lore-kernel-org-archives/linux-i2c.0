From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/4] rtc: max77686: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:16 +0200
Message-ID: <20190722172618.4061-3-wsa+renesas@sang-engineering.com>
References: <20190722172618.4061-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172618.4061-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/rtc/rtc-max77686.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 4aff349ae301..d04fd1024697 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -693,11 +693,11 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	info->rtc = i2c_new_dummy(parent_i2c->adapter,
+	info->rtc = i2c_new_dummy_device(parent_i2c->adapter,
 				  info->drv_data->rtc_i2c_addr);
-	if (!info->rtc) {
+	if (IS_ERR(info->rtc)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return -ENODEV;
+		return PTR_ERR(info->rtc);
 	}
 
 	info->rtc_regmap = devm_regmap_init_i2c(info->rtc,
-- 
2.20.1
