From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/2] i2c: sh_mobile: Add per-Generation fallback bindings
Date: Wed,  7 Dec 2016 11:39:53 +0100
Message-ID: <1481107193-32502-1-git-send-email-horms+renesas@verge.net.au>
References: <1481106689-22312-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481106689-22312-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Add per-Generation fallback bindings for R-Car SoCs.

This is in keeping with the compatibility string scheme is being adopted
for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 17 ++++++++++++++---
 drivers/i2c/busses/i2c-sh_mobile.c                      |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 214f94c25d37..7716acc55dec 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -1,8 +1,7 @@
 Device tree configuration for Renesas IIC (sh_mobile) driver
 
 Required properties:
-- compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as fallback
-		     Examples with soctypes are:
+- compatible      :
 			- "renesas,iic-r8a73a4" (R-Mobile APE6)
 			- "renesas,iic-r8a7740" (R-Mobile A1)
 			- "renesas,iic-r8a7790" (R-Car H2)
@@ -12,6 +11,17 @@ Required properties:
 			- "renesas,iic-r8a7794" (R-Car E2)
 			- "renesas,iic-r8a7795" (R-Car H3)
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
+			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 compatible device)
+			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 compatible device)
+			- "renesas,rmobile-iic" (generic device)
+
+			When compatible with a generic R-Car version, nodes
+			must list the SoC-specific version corresponding to
+			the platform first followed by the generic R-Car
+			version.
+
+			renesas,rmobile-iic must always follow.
+
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
 - clocks          : clock for device
@@ -31,7 +41,8 @@ Pinctrl properties might be needed, too. See there.
 Example:
 
 	iic0: i2c@e6500000 {
-		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 6335ad35902d..3d9ebe6e5716 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -834,7 +834,9 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7793", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7794", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,rcar-gen2-iic", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7795", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,rcar-gen3-iic", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-sh73a0", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{},
-- 
2.7.0.rc3.207.g0ac5344
