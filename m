From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 03/10] i2c: meson: set clock divider in probe instead of
 setting it for each transfer
Date: Sat, 11 Mar 2017 19:23:08 +0100
Message-ID: <7144f1ca-839f-7c54-5abb-0d73202cc5bc@gmail.com>
References: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33269 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754943AbdCKSYq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 11 Mar 2017 13:24:46 -0500
Received: by mail-wr0-f193.google.com with SMTP id g10so15276845wrg.0
        for <linux-i2c@vger.kernel.org>; Sat, 11 Mar 2017 10:24:45 -0800 (PST)
In-Reply-To: <a0ebd65b-712d-2b15-dcc6-3b8a9a619770@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

The bus frequency won't change, therefore we can set the clock divider
in probe already and we don't have to set it for each transfer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
v3:
- change order of patches
---
 drivers/i2c/busses/i2c-meson.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 50059d09..e597764e 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -73,7 +73,6 @@ enum {
  * @error:	Flag set when an error is received
  * @lock:	To avoid race conditions between irq handler and xfer code
  * @done:	Completion used to wait for transfer termination
- * @frequency:	Operating frequency of I2C bus clock
  * @tokens:	Sequence of tokens to be written to the device
  * @num_tokens:	Number of tokens
  */
@@ -92,7 +91,6 @@ struct meson_i2c {
 
 	spinlock_t		lock;
 	struct completion	done;
-	unsigned int		frequency;
 	u32			tokens[2];
 	int			num_tokens;
 };
@@ -131,17 +129,17 @@ static void meson_i2c_write_tokens(struct meson_i2c *i2c)
 	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
 }
 
-static void meson_i2c_set_clk_div(struct meson_i2c *i2c)
+static void meson_i2c_set_clk_div(struct meson_i2c *i2c, unsigned int freq)
 {
 	unsigned long clk_rate = clk_get_rate(i2c->clk);
 	unsigned int div;
 
-	div = DIV_ROUND_UP(clk_rate, i2c->frequency * 4);
+	div = DIV_ROUND_UP(clk_rate, freq * 4);
 	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_CLKDIV_MASK,
 			   div << REG_CTRL_CLKDIV_SHIFT);
 
 	dev_dbg(i2c->dev, "%s: clk %lu, freq %u, div %u\n", __func__,
-		clk_rate, i2c->frequency, div);
+		clk_rate, freq, div);
 }
 
 static void meson_i2c_get_data(struct meson_i2c *i2c, char *buf, int len)
@@ -361,7 +359,6 @@ static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	int i, ret = 0, count = 0;
 
 	clk_enable(i2c->clk);
-	meson_i2c_set_clk_div(i2c);
 
 	for (i = 0; i < num; i++) {
 		ret = meson_i2c_xfer_msg(i2c, msgs + i, i == num - 1);
@@ -390,15 +387,15 @@ static int meson_i2c_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct meson_i2c *i2c;
 	struct resource *mem;
+	u32 freq;
 	int irq, ret = 0;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct meson_i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				 &i2c->frequency))
-		i2c->frequency = DEFAULT_FREQ;
+	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency", &freq))
+		freq = DEFAULT_FREQ;
 
 	i2c->dev = &pdev->dev;
 	platform_set_drvdata(pdev, i2c);
@@ -456,6 +453,8 @@ static int meson_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	meson_i2c_set_clk_div(i2c, freq);
+
 	return 0;
 }
 
-- 
2.12.0
