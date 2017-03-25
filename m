From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 05/10] i2c: meson: use full 12 bits for clock divider
Date: Sat, 25 Mar 2017 14:07:57 +0100
Message-ID: <8b913c11-e51e-11aa-4525-fc3c8c4d972e@gmail.com>
References: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33384 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdCYNOk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 25 Mar 2017 09:14:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11so2860271wma.0
        for <linux-i2c@vger.kernel.org>; Sat, 25 Mar 2017 06:14:39 -0700 (PDT)
In-Reply-To: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

The clock divider has 12 bits, splitted into a 10 bit field and a
2 bit field. The extra 2 bits aren't used currently.

Change this to use the full 12 bits and warn if the requested
frequency is too low.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
v2:
- added Acked-by
v3:
- changed order of patches
v4:
- no changes
v5:
- change WARN_ON to dev_err
---
 drivers/i2c/busses/i2c-meson.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index ac0ac82d..25ea05fc 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -35,7 +35,9 @@
 #define REG_CTRL_STATUS		BIT(2)
 #define REG_CTRL_ERROR		BIT(3)
 #define REG_CTRL_CLKDIV_SHIFT	12
-#define REG_CTRL_CLKDIV_MASK	((BIT(10) - 1) << REG_CTRL_CLKDIV_SHIFT)
+#define REG_CTRL_CLKDIV_MASK	GENMASK(21, 12)
+#define REG_CTRL_CLKDIVEXT_SHIFT 28
+#define REG_CTRL_CLKDIVEXT_MASK	GENMASK(29, 28)
 
 #define I2C_TIMEOUT_MS		500
 
@@ -134,8 +136,18 @@ static void meson_i2c_set_clk_div(struct meson_i2c *i2c, unsigned int freq)
 	unsigned int div;
 
 	div = DIV_ROUND_UP(clk_rate, freq * 4);
+
+	/* clock divider has 12 bits */
+	if (div >= (1 << 12)) {
+		dev_err(i2c->dev, "requested bus frequency too low\n");
+		div = (1 << 12) - 1;
+	}
+
 	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_CLKDIV_MASK,
-			   div << REG_CTRL_CLKDIV_SHIFT);
+			   (div & GENMASK(9, 0)) << REG_CTRL_CLKDIV_SHIFT);
+
+	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_CLKDIVEXT_MASK,
+			   (div >> 10) << REG_CTRL_CLKDIVEXT_SHIFT);
 
 	dev_dbg(i2c->dev, "%s: clk %lu, freq %u, div %u\n", __func__,
 		clk_rate, freq, div);
-- 
2.12.0
