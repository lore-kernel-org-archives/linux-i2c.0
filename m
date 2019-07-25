From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/3] i2c: sprd: Change to use devm_platform_ioremap_resource()
Date: Thu, 25 Jul 2019 15:56:17 +0800
Message-ID: <29fa51009a97e6b7d8622190810b7505819ac0b2.1564041157.git.baolin.wang@linaro.org>
References: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
In-Reply-To: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
References: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/i2c-sprd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 8002835..bbcb056 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -478,7 +478,6 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sprd_i2c *i2c_dev;
-	struct resource *res;
 	u32 prop;
 	int ret;
 
@@ -488,8 +487,7 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 	if (!i2c_dev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i2c_dev->base = devm_ioremap_resource(dev, res);
+	i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(i2c_dev->base))
 		return PTR_ERR(i2c_dev->base);
 
-- 
1.7.9.5
