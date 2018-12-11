From: Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700 I2C support
Date: Tue, 11 Dec 2018 09:04:47 +0100
Message-ID: <20181211080448.24007-4-pn@denx.de>
References: <20181211080448.24007-1-pn@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211080448.24007-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: manivannan.sadhasivam@linaro.org, afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, Parthiban Nallathambi <pn@denx.de>
List-Id: linux-i2c@vger.kernel.org

Add S700 to the list of devices supported by Owl I2C driver.

Add Actions Semiconductor Owl family S700 I2C driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/i2c/busses/i2c-owl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 96b4572e6d9c..b6b5a495118b 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id owl_i2c_of_match[] = {
+	{ .compatible = "actions,s700-i2c" },
 	{ .compatible = "actions,s900-i2c" },
 	{ /* sentinel */ }
 };
-- 
2.17.2
