From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 02/10] i2c: meson: remove member irq from struct meson_i2c
Date: Tue, 14 Mar 2017 22:50:55 +0100
Message-ID: <8a323b32-4ccf-1a17-4095-23b151dc6c74@gmail.com>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33855 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdCNVyY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 17:54:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so1941485wmg.1
        for <linux-i2c@vger.kernel.org>; Tue, 14 Mar 2017 14:54:23 -0700 (PDT)
In-Reply-To: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

Member irq can be replaced with a local variable in probe
because it's nowhere else accessed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
v2:
- added Reviewed-by
v3:
- no changes
v4:
- no changes
---
 drivers/i2c/busses/i2c-meson.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 40e5da9a..50059d09 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -82,7 +82,6 @@ struct meson_i2c {
 	struct device		*dev;
 	void __iomem		*regs;
 	struct clk		*clk;
-	int			irq;
 
 	struct i2c_msg		*msg;
 	int			state;
@@ -391,7 +390,7 @@ static int meson_i2c_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct meson_i2c *i2c;
 	struct resource *mem;
-	int ret = 0;
+	int irq, ret = 0;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct meson_i2c), GFP_KERNEL);
 	if (!i2c)
@@ -418,14 +417,14 @@ static int meson_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c->regs))
 		return PTR_ERR(i2c->regs);
 
-	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "can't find IRQ\n");
-		return i2c->irq;
+		return irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, i2c->irq, meson_i2c_irq,
-			       0, dev_name(&pdev->dev), i2c);
+	ret = devm_request_irq(&pdev->dev, irq, meson_i2c_irq, 0,
+			       dev_name(&pdev->dev), i2c);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can't request IRQ\n");
 		return ret;
-- 
2.12.0
