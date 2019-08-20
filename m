From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] rtc: max77686: convert to devm_i2c_new_dummy_device()
Date: Tue, 20 Aug 2019 17:42:37 +0200
Message-ID: <20190820154239.8230-2-wsa+renesas@sang-engineering.com>
References: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I was about to simplify the call to i2c_unregister_device() when I
realized that converting to devm_i2c_new_dummy_device() will simplify
the driver a lot. So I took this approach.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/rtc/rtc-max77686.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index d04fd1024697..4027b33034dc 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -693,8 +693,8 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	info->rtc = i2c_new_dummy_device(parent_i2c->adapter,
-				  info->drv_data->rtc_i2c_addr);
+	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
+					      info->drv_data->rtc_i2c_addr);
 	if (IS_ERR(info->rtc)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
 		return PTR_ERR(info->rtc);
@@ -705,7 +705,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 	if (IS_ERR(info->rtc_regmap)) {
 		ret = PTR_ERR(info->rtc_regmap);
 		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
-		goto err_unregister_i2c;
+		return ret;
 	}
 
 add_rtc_irq:
@@ -715,15 +715,10 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 				  &info->rtc_irq_data);
 	if (ret < 0) {
 		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
-		goto err_unregister_i2c;
+		return ret;
 	}
 
 	return 0;
-
-err_unregister_i2c:
-	if (info->rtc)
-		i2c_unregister_device(info->rtc);
-	return ret;
 }
 
 static int max77686_rtc_probe(struct platform_device *pdev)
@@ -786,8 +781,6 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 err_rtc:
 	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
-	if (info->rtc)
-		i2c_unregister_device(info->rtc);
 
 	return ret;
 }
@@ -798,8 +791,6 @@ static int max77686_rtc_remove(struct platform_device *pdev)
 
 	free_irq(info->virq, info);
 	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
-	if (info->rtc)
-		i2c_unregister_device(info->rtc);
 
 	return 0;
 }
-- 
2.20.1
