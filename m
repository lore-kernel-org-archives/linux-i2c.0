From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 079/107] i2c: iop3xx: Fix memory leak in probe error path
Date: Fri, 24 Jan 2020 09:17:49 -0500
Message-ID: <20200124141817.28793-79-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, kbuild test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit e64175776d06a8ceebbfd349d7e66a4a46ca39ef ]

When handling devm_gpiod_get_optional() errors, free the memory already
allocated.  This fixes Smatch warnings:

    drivers/i2c/busses/i2c-iop3xx.c:437 iop3xx_i2c_probe() warn: possible memory leak of 'new_adapter'
    drivers/i2c/busses/i2c-iop3xx.c:442 iop3xx_i2c_probe() warn: possible memory leak of 'new_adapter'

Fixes: fdb7e884ad61 ("i2c: iop: Use GPIO descriptors")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-iop3xx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 38556381f4cad..2f8b8050a2233 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -433,13 +433,17 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 	adapter_data->gpio_scl = devm_gpiod_get_optional(&pdev->dev,
 							 "scl",
 							 GPIOD_ASIS);
-	if (IS_ERR(adapter_data->gpio_scl))
-		return PTR_ERR(adapter_data->gpio_scl);
+	if (IS_ERR(adapter_data->gpio_scl)) {
+		ret = PTR_ERR(adapter_data->gpio_scl);
+		goto free_both;
+	}
 	adapter_data->gpio_sda = devm_gpiod_get_optional(&pdev->dev,
 							 "sda",
 							 GPIOD_ASIS);
-	if (IS_ERR(adapter_data->gpio_sda))
-		return PTR_ERR(adapter_data->gpio_sda);
+	if (IS_ERR(adapter_data->gpio_sda)) {
+		ret = PTR_ERR(adapter_data->gpio_sda);
+		goto free_both;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-- 
2.20.1
