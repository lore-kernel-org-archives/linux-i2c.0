From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] i2c: hix5hd2: Make sure clk is disabled in remove
Date: Thu,  7 Dec 2017 22:27:55 +0100
Message-ID: <1512682075-29755-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:33670 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdLGV2P (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 16:28:15 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

pm_runtime_set_suspended() does not lead to call of suspend callback,
so clk may be left undisabled in hix5hd2_i2c_remove().

By the way, the patch adds error handling for clk_prepare_enable().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..8a921b5135ad 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -446,7 +446,11 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot get clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable clock\n");
+		return ret;
+	}
 
 	strlcpy(priv->adap.name, "hix5hd2-i2c", sizeof(priv->adap.name));
 	priv->dev = &pdev->dev;
@@ -496,8 +500,9 @@ static int hix5hd2_i2c_remove(struct platform_device *pdev)
 	struct hix5hd2_i2c_priv *priv = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&priv->adap);
-	pm_runtime_disable(priv->dev);
-	pm_runtime_set_suspended(priv->dev);
+
+	/* Make sure priv->clk is disabled */
+	pm_runtime_force_suspend(priv->dev);
 
 	return 0;
 }
-- 
2.7.4
