From: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2 5/6] clk: qoriq: Add ls1043a support.
Date: Tue, 22 Sep 2015 20:34:04 +0800
Message-ID: <1442925245-39246-5-git-send-email-B48286@freescale.com>
References: <1442925245-39246-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442925245-39246-1-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org, leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/clk/clk-qoriq.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 7753fa3..e71927b 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -244,6 +244,28 @@ static const struct clockgen_muxinfo clockgen2_cmux_cgb = {
 	},
 };
 
+static const struct clockgen_muxinfo ls1043a_hwa1 = {
+	{
+		{},
+		{},
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV3 },
+		{},
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+	},
+};
+
+static const struct clockgen_muxinfo ls1043a_hwa2 = {
+	{
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV1 },
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+	},
+};
+
 static const struct clockgen_muxinfo t1023_hwa1 = {
 	{
 		{},
@@ -452,6 +474,21 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.pll_mask = 0x03,
 	},
 	{
+		.compat = "fsl,ls1043a-clockgen",
+		.init_periph = t2080_init_periph,
+		.cmux_groups = {
+			&t1040_cmux
+		},
+		.hwaccel = {
+			&ls1043a_hwa1, &ls1043a_hwa2
+		},
+		.cmux_to_group = {
+			0, -1
+		},
+		.pll_mask = 0x07,
+		.flags = CG_PLL_8BIT,
+	},
+	{
 		.compat = "fsl,ls2080a-clockgen",
 		.cmux_groups = {
 			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
@@ -1228,6 +1265,7 @@ err:
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
 
 /* Legacy nodes */
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
