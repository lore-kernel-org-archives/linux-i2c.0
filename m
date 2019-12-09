From: shubhrajyoti.datta@gmail.com
Subject: [PATCH 1/4] i2c: cadence: Fix error printing in case of defer
Date: Mon,  9 Dec 2019 16:10:49 +0530
Message-ID: <1575888052-20447-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: michal.simek@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Do not print error in case of EPROBE_DEFER.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 1ffd21a..7b989a2 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -924,7 +924,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 	id->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(id->clk)) {
-		dev_err(&pdev->dev, "input clock not found.\n");
+		if (PTR_ERR(id->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "input clock not found.\n");
 		return PTR_ERR(id->clk);
 	}
 	ret = clk_prepare_enable(id->clk);
-- 
2.1.1
