From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] i2c: axxia: disable clks in case of failure in probe
Date: Fri, 23 Sep 2016 11:15:26 +0200
Message-ID: <1474622126-1996-1-git-send-email-khoroshilov@ispras.ru>
References: <20160922175703.GE1861@katana>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160922175703.GE1861@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-i2c@vger.kernel.org

axxia_i2c_probe() does not disable clock in case of failure
in i2c_add_adapter(). Also it ignores returned value from
clk_prepare_enable().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-axxia.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index d3bcaf4..4351a93 100644
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
@@ -558,7 +562,13 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, idev);
 
-	return i2c_add_adapter(&idev->adapter);
+	ret = i2c_add_adapter(&idev->adapter);
+	if (ret) {
+		clk_disable_unprepare(idev->i2c_clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int axxia_i2c_remove(struct platform_device *pdev)
-- 
2.7.4
