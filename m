From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 i2c/for-next] i2c: rcar: Add per-Generation fallback bindings
Date: Fri,  2 Dec 2016 09:10:27 +0100
Message-ID: <1480666227-7622-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 2 and Gen 3. But beyond that its not clear what the
relationship between IP blocks might be. For example, I believe that
r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
descendant of the former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Also:
* Deprecate renesas,i2c-rcar. It seems poorly named as it is only
  compatible with R-Car Gen 1. It also appears unused in mainline.
* Add some text to describe per-SoC bindings

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* Consistently use renesas,<family>-<module> for new compat strings
* Drop RFC designation

v2
* Include accidently omitted i2c-rcar.c portion of patch
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 32 ++++++++++++++--------
 drivers/i2c/busses/i2c-rcar.c                      |  5 +++-
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 239632a0d709..50c378ccb8e7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -1,17 +1,25 @@
 I2C for R-Car platforms
 
 Required properties:
-- compatible: Must be one of
-	"renesas,i2c-rcar"
-	"renesas,i2c-r8a7778"
-	"renesas,i2c-r8a7779"
-	"renesas,i2c-r8a7790"
-	"renesas,i2c-r8a7791"
-	"renesas,i2c-r8a7792"
-	"renesas,i2c-r8a7793"
-	"renesas,i2c-r8a7794"
-	"renesas,i2c-r8a7795"
-	"renesas,i2c-r8a7796"
+- compatible:
+	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
+	"renesas,i2c-r8a7779" if the device is a part of a R8A7797 SoC.
+	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
+	"renesas,i2c-r8a7791" if the device is a part of a R8A7791 SoC.
+	"renesas,i2c-r8a7792" if the device is a part of a R8A7792 SoC.
+	"renesas,i2c-r8a7793" if the device is a part of a R8A7793 SoC.
+	"renesas,i2c-r8a7794" if the device is a part of a R8A7794 SoC.
+	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
+	"renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
+	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
+	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 compatible device.
+	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 compatible device.
+	"renesas,i2c-rcar" (deprecated)
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed
+	by the generic version.
+
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: interrupt specifier.
@@ -33,7 +41,7 @@ Examples :
 i2c0: i2c@e6508000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	compatible = "renesas,i2c-r8a7791";
+	compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 	reg = <0 0xe6508000 0 0x40>;
 	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 726615e54f2a..622def6b43e2 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -793,7 +793,6 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 };
 
 static const struct of_device_id rcar_i2c_dt_ids[] = {
-	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
@@ -803,6 +802,10 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3 },
 	{ .compatible = "renesas,i2c-r8a7796", .data = (void *)I2C_RCAR_GEN3 },
+	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },	// Deprecated
+	{ .compatible = "renesas,rcar-gen1-i2c", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,rcar-gen2-i2c", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,rcar-gen3-i2c", .data = (void *)I2C_RCAR_GEN3 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
-- 
2.7.0.rc3.207.g0ac5344
