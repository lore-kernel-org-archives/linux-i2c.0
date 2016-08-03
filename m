From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] i2c: ocores: add missed clk_disable_unprepare() on failure paths
Date: Thu,  4 Aug 2016 02:38:44 +0300
Message-ID: <1470267524-14753-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-i2c@vger.kernel.org

clk_disable_unprepare() is missed on failure paths in ocores_i2c_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-ocores.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index dfa7a4b4a91d..ac88a524143e 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -379,6 +379,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 			if (!clock_frequency_present) {
 				dev_err(&pdev->dev,
 					"Missing required parameter 'opencores,ip-clock-frequency'\n");
+				clk_disable_unprepare(i2c->clk);
 				return -ENODEV;
 			}
 			i2c->ip_clock_khz = clock_frequency / 1000;
@@ -467,20 +468,21 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 		default:
 			dev_err(&pdev->dev, "Unsupported I/O width (%d)\n",
 				i2c->reg_io_width);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_clk;
 		}
 	}
 
 	ret = ocores_init(&pdev->dev, i2c);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	init_waitqueue_head(&i2c->wait);
 	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
 			       pdev->name, i2c);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		return ret;
+		goto err_clk;
 	}
 
 	/* hook up driver to tree */
@@ -494,7 +496,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add adapter\n");
-		return ret;
+		goto err_clk;
 	}
 
 	/* add in known devices to the bus */
@@ -504,6 +506,10 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(i2c->clk);
+	return ret;
 }
 
 static int ocores_i2c_remove(struct platform_device *pdev)
-- 
1.9.1
