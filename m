From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 357/493] i2c: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:06 -0500
Message-ID: <1353349642-3677-357-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks  <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> 
Cc: "Ben Dooks " <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> 
Cc: Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org> 
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org 
---
 drivers/i2c/busses/i2c-mpc.c        | 4 ++--
 drivers/i2c/busses/i2c-sh_mobile.c  | 2 +-
 drivers/i2c/busses/i2c-sirf.c       | 2 +-
 drivers/i2c/busses/i2c-tegra.c      | 2 +-
 drivers/i2c/busses/i2c-xiic.c       | 2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index c26095d..4327dba 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -175,7 +175,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 }
 
 #if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)
-static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] __devinitconst = {
+static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
 	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
 	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
 	{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
@@ -296,7 +296,7 @@ static void mpc_i2c_setup_512x(struct device_node *node,
 #endif /* CONFIG_PPC_MPC512x */
 
 #ifdef CONFIG_FSL_SOC
-static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] __devinitconst = {
+static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
 	{160, 0x0120}, {192, 0x0121}, {224, 0x0122}, {256, 0x0123},
 	{288, 0x0100}, {320, 0x0101}, {352, 0x0601}, {384, 0x0102},
 	{416, 0x0602}, {448, 0x0126}, {480, 0x0103}, {512, 0x0127},
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 8110ca4..0a2a1cd 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -714,7 +714,7 @@ static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
 	.runtime_resume = sh_mobile_i2c_runtime_nop,
 };
 
-static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst = {
+static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rmobile-iic", },
 	{},
 };
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 7f81a2c..65de4aa 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -433,7 +433,7 @@ static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
 };
 #endif
 
-static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
+static const struct of_device_id sirfsoc_i2c_of_match[] = {
 	{ .compatible = "sirf,prima2-i2c", },
 	{},
 };
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 577887b..c658daa 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -642,7 +642,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
-static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
+static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra30-i2c", .data = &tegra30_i2c_hw, },
 	{ .compatible = "nvidia,tegra20-i2c", .data = &tegra20_i2c_hw, },
 	{ .compatible = "nvidia,tegra20-i2c-dvc", .data = &tegra20_i2c_hw, },
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index f4e54a9..bb72d00 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -800,7 +800,7 @@ static int __devexit xiic_i2c_remove(struct platform_device* pdev)
 }
 
 #if defined(CONFIG_OF)
-static const struct of_device_id xiic_of_match[] __devinitconst = {
+static const struct of_device_id xiic_of_match[] = {
 	{ .compatible = "xlnx,xps-iic-2.00.a", },
 	{},
 };
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index a7a5584..c6b70b5 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -255,7 +255,7 @@ static int __devexit i2c_mux_pinctrl_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static const struct of_device_id i2c_mux_pinctrl_of_match[] __devinitconst = {
+static const struct of_device_id i2c_mux_pinctrl_of_match[] = {
 	{ .compatible = "i2c-mux-pinctrl", },
 	{},
 };
-- 
1.8.0
