From: Zhiqiang Hou <B48286@freescale.com>
Subject: [PATCH V3 5/6] clk: qoriq: Add ls1043a support.
Date: Wed, 14 Oct 2015 19:34:57 +0800
Message-ID: <1444822498-16477-6-git-send-email-B48286@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1444822498-16477-1-git-send-email-B48286@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, mark.rutland@arm.com
Cc: Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com, scottwood@freescale.com, bhupesh.sharma@freescale.com, leoli@freescale.com, wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net, mturquette@baylibre.com, sboyd@codeaurora.org, Wenbin.Song@freescale.com, Hou Zhiqiang <B48286@freescale.com>
List-Id: linux-i2c@vger.kernel.org

From: Hou Zhiqiang <B48286@freescale.com>

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V3:
 - No change.

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

