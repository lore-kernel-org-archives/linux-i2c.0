From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c : busses : emev2 : Handle return value of clk_prepare_enable
Date: Wed, 24 May 2017 19:31:06 +0530
Message-ID: <302ae3da44202f585419ca80770426f98768b410.1495634283.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-emev2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index 3129127..d2e8448 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -375,7 +375,9 @@ static int em_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sclk))
 		return PTR_ERR(priv->sclk);
 
-	clk_prepare_enable(priv->sclk);
+	ret = clk_prepare_enable(priv->sclk);
+	if (ret)
+		return ret;
 
 	priv->adap.timeout = msecs_to_jiffies(100);
 	priv->adap.retries = 5;
-- 
1.9.1
