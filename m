From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 4/4] i2c: pca-platform: use dev_warn/dev_info instead of printk
Date: Tue, 13 Jun 2017 13:56:41 +1200
Message-ID: <20170613015641.29373-5-chris.packham@alliedtelesis.co.nz>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34272 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbdFMB4r (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Jun 2017 21:56:47 -0400
In-Reply-To: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index ee217ef5d879..f3285c4c159c 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -107,8 +107,8 @@ static int i2c_pca_pf_waitforcompletion(void *pd)
 static void i2c_pca_pf_dummyreset(void *pd)
 {
 	struct i2c_pca_pf_data *i2c = pd;
-	printk(KERN_WARNING "%s: No reset-pin found. Chip may get stuck!\n",
-		i2c->adap.name);
+
+	dev_warn(&i2c->adap.dev, "No reset-pin found. Chip may get stuck!\n");
 }
 
 static void i2c_pca_pf_resetchip(void *pd)
@@ -213,8 +213,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 			gpio_direction_output(i2c->gpio, 1);
 			i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
 		} else {
-			printk(KERN_WARNING "%s: Registering gpio failed!\n",
-				i2c->adap.name);
+			dev_warn(&pdev->dev, "Registering gpio failed!\n");
 			i2c->gpio = ret;
 		}
 	}
@@ -232,7 +231,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	printk(KERN_INFO "%s registered.\n", i2c->adap.name);
+	dev_info(&pdev->dev, "registered.\n");
 
 	return 0;
 }
-- 
2.13.0
