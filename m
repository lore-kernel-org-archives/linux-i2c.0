From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/3] i2c: sprd: Validate the return value of clock initialization
Date: Thu, 25 Jul 2019 15:56:18 +0800
Message-ID: <5f64dc0eedb348b15442f31f2f22f5bded7cd6ef.1564041157.git.baolin.wang@linaro.org>
References: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
In-Reply-To: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
References: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The 'enable' clock of I2C master is required, we should return an error
if failed to get the 'enable' clock, to make sure the I2C driver can be
defer probe if the clock resource is not ready.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/i2c-sprd.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index bbcb056..b432e75 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -466,9 +466,9 @@ static int sprd_i2c_clk_init(struct sprd_i2c *i2c_dev)
 
 	i2c_dev->clk = devm_clk_get(i2c_dev->dev, "enable");
 	if (IS_ERR(i2c_dev->clk)) {
-		dev_warn(i2c_dev->dev, "i2c%d can't get the enable clock\n",
-			 i2c_dev->adap.nr);
-		i2c_dev->clk = NULL;
+		dev_err(i2c_dev->dev, "i2c%d can't get the enable clock\n",
+			i2c_dev->adap.nr);
+		return PTR_ERR(i2c_dev->clk);
 	}
 
 	return 0;
@@ -519,7 +519,10 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 	if (i2c_dev->bus_freq != 100000 && i2c_dev->bus_freq != 400000)
 		return -EINVAL;
 
-	sprd_i2c_clk_init(i2c_dev);
+	ret = sprd_i2c_clk_init(i2c_dev);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, i2c_dev);
 
 	ret = clk_prepare_enable(i2c_dev->clk);
-- 
1.7.9.5
