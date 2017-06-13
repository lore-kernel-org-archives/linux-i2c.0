From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/4] i2c: pca-platform: use gpio_is_valid
Date: Tue, 13 Jun 2017 13:56:39 +1200
Message-ID: <20170613015641.29373-3-chris.packham@alliedtelesis.co.nz>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>
List-Id: linux-i2c@vger.kernel.org

Use gpio_is_valid() instead of gpio > -1.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index ca63fee400cb..79d737eb2770 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -196,7 +196,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
-		i2c->gpio = -1;
+		i2c->gpio = -ENODEV;
 	}
 
 	i2c->algo_data.data = i2c;
@@ -219,8 +219,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Use gpio_is_valid() when in mainline */
-	if (i2c->gpio > -1) {
+	if (gpio_is_valid(i2c->gpio)) {
 		ret = gpio_request(i2c->gpio, i2c->adap.name);
 		if (ret == 0) {
 			gpio_direction_output(i2c->gpio, 1);
@@ -254,7 +253,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (irq)
 		free_irq(irq, i2c);
 e_reqirq:
-	if (i2c->gpio > -1)
+	if (gpio_is_valid(i2c->gpio))
 		gpio_free(i2c->gpio);
 
 	iounmap(i2c->reg_base);
@@ -276,7 +275,7 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
 	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
-	if (i2c->gpio > -1)
+	if (gpio_is_valid(i2c->gpio))
 		gpio_free(i2c->gpio);
 
 	iounmap(i2c->reg_base);
-- 
2.13.0
