From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH] i2c: uniphier{-f}: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 22:11:40 +0200
Message-ID: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:46328 "EHLO mail.zeus03.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbcHIUS2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 16:18:28 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa-dev@sang-engineering.com>

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 5 -----
 drivers/i2c/busses/i2c-uniphier.c   | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index aeead0d27d1007..35608531fe070d 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -550,11 +550,6 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 	}
 
 	ret = i2c_add_adapter(&priv->adap);
-	if (ret) {
-		dev_err(dev, "failed to add I2C adapter\n");
-		goto err;
-	}
-
 err:
 	if (ret)
 		clk_disable_unprepare(priv->clk);
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 475a5eb514e215..d6e612a0e02a9d 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -407,11 +407,6 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = i2c_add_adapter(&priv->adap);
-	if (ret) {
-		dev_err(dev, "failed to add I2C adapter\n");
-		goto err;
-	}
-
 err:
 	if (ret)
 		clk_disable_unprepare(priv->clk);
-- 
2.8.1
