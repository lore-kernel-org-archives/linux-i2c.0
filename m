From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH i2c/for-next] i2c: sh_mobile: document support for r8a7796 (R-Car M3-W)
Date: Thu, 26 Jan 2017 09:47:31 +0100
Message-ID: <1485420451-11752-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Explicitly list per-SoC binding for r8a7796. No driver change
is required as the initialisation sequence is currently the same
as for the R-Car Gen3 fallback binding.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 7716acc55dec..ae9c2a735f39 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -10,6 +10,7 @@ Required properties:
 			- "renesas,iic-r8a7793" (R-Car M2-N)
 			- "renesas,iic-r8a7794" (R-Car E2)
 			- "renesas,iic-r8a7795" (R-Car H3)
+			- "renesas,iic-r8a7796" (R-Car M3-W)
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
 			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 compatible device)
 			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 compatible device)
-- 
2.7.0.rc3.207.g0ac5344
