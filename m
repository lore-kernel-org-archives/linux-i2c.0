From: Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: [PATCH 2/3] i2c: xlp9xx: Get clock frequency with clk API
Date: Wed, 27 Sep 2017 20:22:22 +0530
Message-ID: <1506523943-8632-3-git-send-email-kamlakant.patel@cavium.com>
References: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:21856
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbdI0Owf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 27 Sep 2017 10:52:35 -0400
In-Reply-To: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kamlakant Patel <kamlakant.patel@cavium.com>

From: Jayachandran C <jnair@caviumnetworks.com>

Get the input clock frequency to the controller from the linux clk
API, if it is available. This allows us to pass in the block input
frequency either from ACPI (using APD) or from device tree.

The old hardcoded frequency is used as default for backwards compatibility.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 6b106e9..f0bef2d 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -84,6 +85,7 @@ struct xlp9xx_i2c_dev {
 	u32 __iomem *base;
 	u32 msg_buf_remaining;
 	u32 msg_len;
+	u32 ip_clk_hz;
 	u32 clk_hz;
 	u32 msg_err;
 	u8 *msg_buf;
@@ -213,7 +215,7 @@ static int xlp9xx_i2c_init(struct xlp9xx_i2c_dev *priv)
 	 * The controller uses 5 * SCL clock internally.
 	 * So prescale value should be divided by 5.
 	 */
-	prescale = DIV_ROUND_UP(XLP9XX_I2C_IP_CLK_FREQ, priv->clk_hz);
+	prescale = DIV_ROUND_UP(priv->ip_clk_hz, priv->clk_hz);
 	prescale = ((prescale - 8) / 5) - 1;
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_RST);
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_EN |
@@ -342,9 +344,19 @@ static const struct i2c_algorithm xlp9xx_i2c_algo = {
 static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 				    struct xlp9xx_i2c_dev *priv)
 {
+	struct clk *clk;
 	u32 freq;
 	int err;
 
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		priv->ip_clk_hz = XLP9XX_I2C_IP_CLK_FREQ;
+		dev_dbg(&pdev->dev, "using default input frequency %u\n",
+			priv->ip_clk_hz);
+	} else {
+		priv->ip_clk_hz = clk_get_rate(clk);
+	}
+
 	err = device_property_read_u32(&pdev->dev, "clock-frequency", &freq);
 	if (err) {
 		freq = XLP9XX_I2C_DEFAULT_FREQ;
-- 
2.7.4
