From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v4 7/7] i2c: bcm2835: Add support for dynamic clock
Date: Mon,  3 Oct 2016 22:06:14 +0200
Message-ID: <1475525174-28604-8-git-send-email-noralf@tronnes.org>
References: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:39364 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbcJCUGp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Oct 2016 16:06:45 -0400
In-Reply-To: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

Support a dynamic clock by reading the frequency and setting the
divisor in the transfer function instead of during probe.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 51 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index d2085dd..c3436f6 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -58,6 +58,7 @@ struct bcm2835_i2c_dev {
 	void __iomem *regs;
 	struct clk *clk;
 	int irq;
+	u32 bus_clk_rate;
 	struct i2c_adapter adapter;
 	struct completion completion;
 	struct i2c_msg *curr_msg;
@@ -78,6 +79,30 @@ static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_dev *i2c_dev, u32 reg)
 	return readl(i2c_dev->regs + reg);
 }
 
+static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
+{
+	u32 divider;
+
+	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk),
+			       i2c_dev->bus_clk_rate);
+	/*
+	 * Per the datasheet, the register is always interpreted as an even
+	 * number, by rounding down. In other words, the LSB is ignored. So,
+	 * if the LSB is set, increment the divider to avoid any issue.
+	 */
+	if (divider & 1)
+		divider++;
+	if ((divider < BCM2835_I2C_CDIV_MIN) ||
+	    (divider > BCM2835_I2C_CDIV_MAX)) {
+		dev_err_ratelimited(i2c_dev->dev, "Invalid clock-frequency\n");
+		return -EINVAL;
+	}
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
+
+	return 0;
+}
+
 static void bcm2835_fill_txfifo(struct bcm2835_i2c_dev *i2c_dev)
 {
 	u32 val;
@@ -224,7 +249,7 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 {
 	struct bcm2835_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
 	unsigned long time_left;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < (num - 1); i++)
 		if (msgs[i].flags & I2C_M_RD) {
@@ -233,6 +258,10 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			return -EOPNOTSUPP;
 		}
 
+	ret = bcm2835_i2c_set_divider(i2c_dev);
+	if (ret)
+		return ret;
+
 	i2c_dev->curr_msg = msgs;
 	i2c_dev->num_msgs = num;
 	reinit_completion(&i2c_dev->completion);
@@ -282,7 +311,6 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev;
 	struct resource *mem, *irq;
-	u32 bus_clk_rate, divider;
 	int ret;
 	struct i2c_adapter *adap;
 
@@ -306,27 +334,12 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				   &bus_clk_rate);
+				   &i2c_dev->bus_clk_rate);
 	if (ret < 0) {
 		dev_warn(&pdev->dev,
 			 "Could not read clock-frequency property\n");
-		bus_clk_rate = 100000;
-	}
-
-	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
-	/*
-	 * Per the datasheet, the register is always interpreted as an even
-	 * number, by rounding down. In other words, the LSB is ignored. So,
-	 * if the LSB is set, increment the divider to avoid any issue.
-	 */
-	if (divider & 1)
-		divider++;
-	if ((divider < BCM2835_I2C_CDIV_MIN) ||
-	    (divider > BCM2835_I2C_CDIV_MAX)) {
-		dev_err(&pdev->dev, "Invalid clock-frequency\n");
-		return -ENODEV;
+		i2c_dev->bus_clk_rate = 100000;
 	}
-	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq) {
-- 
2.8.2
