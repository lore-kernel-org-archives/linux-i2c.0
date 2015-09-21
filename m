From: Zhiqiang Hou <B48286@freescale.com>
Subject: [PATCH 5/6] clk: qoriq: Add ls1043a support.
Date: Mon, 21 Sep 2015 20:22:37 +0800
Message-ID: <1442838158-2964-6-git-send-email-B48286@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442838158-2964-1-git-send-email-B48286@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Hou Zhiqiang <B48286@freescale.com>, Shaohui.Xie@freescale.com, corbet@lwn.net, bhupesh.sharma@freescale.com, mturquette@baylibre.com, wsa@the-dreams.de, sboyd@codeaurora.org, wim@iguana.be, Wenbin.Song@freescale.com, scottwood@freescale.com, Mingkai.Hu@freescale.com, leoli@freescale.com
List-Id: linux-i2c@vger.kernel.org

From: Hou Zhiqiang <B48286@freescale.com>

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
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
