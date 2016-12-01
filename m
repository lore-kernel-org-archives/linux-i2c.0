From: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: [PATCH/RFC i2c/for-next] i2c: rcar: Add per-Generation fallback bindings
Date: Thu,  1 Dec 2016 16:18:14 +0100
Message-ID: <1480605494-32460-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
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

Also deprecate renesas,i2c-rcar. It seems poorly named as it is only
compatible with R-Car Gen 1. It also appears unused in mainline.

Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 32 ++++++++++++++--------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 239632a0d709..8c679b17c4c6 100644
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
+	"renesas,i2c-rcar-gen1" for a generic R-Car Gen1 compatible device.
+	"renesas,i2c-rcar-gen2" for a generic R-Car Gen2 compatible device.
+	"renesas,i2c-rcar-gen3" for a generic R-Car Gen3 compatible device.
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
+	compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
 	reg = <0 0xe6508000 0 0x40>;
 	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
-- 
2.7.0.rc3.207.g0ac5344

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
