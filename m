From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] i2c: axxia: disable clks in case of failure in probe
Date: Fri, 16 Sep 2016 23:30:54 +0300
Message-ID: <1474057854-22545-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:52160 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965082AbcIPUbJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 16:31:09 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

axxia_i2c_probe() does not disable clock in case of failure
in i2c_add_adapter(). Also it ignores returned value from
clk_prepare_enable().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-axxia.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index c335cc7852f9..5c05b3050393 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -545,7 +545,11 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	clk_prepare_enable(idev->i2c_clk);
+	ret = clk_prepare_enable(idev->i2c_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		return ret;
+	}
 
 	i2c_set_adapdata(&idev->adapter, idev);
 	strlcpy(idev->adapter.name, pdev->name, sizeof(idev->adapter.name));
@@ -561,6 +565,7 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 	ret = i2c_add_adapter(&idev->adapter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add adapter\n");
+		clk_disable_unprepare(idev->i2c_clk);
 		return ret;
 	}
 
-- 
2.7.4
