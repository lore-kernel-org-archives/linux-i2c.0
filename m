From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 5/7] i2c: sh_mobile: add helper to check frequency calculations
Date: Mon, 18 Dec 2017 22:58:00 +0100
Message-ID: <20171218215802.28591-6-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because we will add a second formula soon, put the sanity checks for the
computed results into a seperate function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 49 +++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index f1a9b971e2c14a..b111191a449a69 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -246,11 +246,36 @@ static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, u32 tf)
 	return (((count_khz * (tHIGH + tf)) + 5000) / 10000);
 }
 
+static int sh_mobile_i2c_check_timing(struct sh_mobile_i2c_data *pd)
+{
+	u16 max_val = pd->flags & IIC_FLAG_HAS_ICIC67 ? 0x1ff : 0xff;
+
+	if (pd->iccl > max_val || pd->icch > max_val) {
+		dev_err(pd->dev, "timing values out of range: L/H=0x%x/0x%x\n",
+			pd->iccl, pd->icch);
+		return -EINVAL;
+	}
+
+	/* one more bit of ICCL in ICIC */
+	if (pd->iccl & 0x100)
+		pd->icic |= ICIC_ICCLB8;
+	else
+		pd->icic &= ~ICIC_ICCLB8;
+
+	/* one more bit of ICCH in ICIC */
+	if (pd->icch & 0x100)
+		pd->icic |= ICIC_ICCHB8;
+	else
+		pd->icic &= ~ICIC_ICCHB8;
+
+	dev_dbg(pd->dev, "timing values: L/H=0x%x/0x%x\n", pd->iccl, pd->icch);
+	return 0;
+}
+
 static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 {
 	unsigned long i2c_clk_khz;
 	u32 tHIGH, tLOW, tf;
-	uint16_t max_val;
 
 	i2c_clk_khz = clk_get_rate(pd->clk) / 1000 / pd->clks_per_count;
 
@@ -271,27 +296,7 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	pd->iccl = sh_mobile_i2c_iccl(i2c_clk_khz, tLOW, tf);
 	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, tf);
 
-	max_val = pd->flags & IIC_FLAG_HAS_ICIC67 ? 0x1ff : 0xff;
-	if (pd->iccl > max_val || pd->icch > max_val) {
-		dev_err(pd->dev, "timing values out of range: L/H=0x%x/0x%x\n",
-			pd->iccl, pd->icch);
-		return -EINVAL;
-	}
-
-	/* one more bit of ICCL in ICIC */
-	if (pd->iccl & 0x100)
-		pd->icic |= ICIC_ICCLB8;
-	else
-		pd->icic &= ~ICIC_ICCLB8;
-
-	/* one more bit of ICCH in ICIC */
-	if (pd->icch & 0x100)
-		pd->icic |= ICIC_ICCHB8;
-	else
-		pd->icic &= ~ICIC_ICCHB8;
-
-	dev_dbg(pd->dev, "timing values: L/H=0x%x/0x%x\n", pd->iccl, pd->icch);
-	return 0;
+	return sh_mobile_i2c_check_timing(pd);
 }
 
 static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
-- 
2.11.0
