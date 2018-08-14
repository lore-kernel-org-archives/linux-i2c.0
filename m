From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774a1 support
Date: Tue, 14 Aug 2018 13:33:08 +0100
Message-ID: <1534249988-15635-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms+renesas@verge.net.au>, Biju Das <biju.das@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index fc7e178..872673a 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -6,6 +6,7 @@ Required properties:
 			- "renesas,iic-r8a7740" (R-Mobile A1)
 			- "renesas,iic-r8a7743" (RZ/G1M)
 			- "renesas,iic-r8a7745" (RZ/G1E)
+			- "renesas,iic-r8a774a1" (RZ/G2M)
 			- "renesas,iic-r8a7790" (R-Car H2)
 			- "renesas,iic-r8a7791" (R-Car M2-W)
 			- "renesas,iic-r8a7792" (R-Car V2H)
@@ -17,7 +18,8 @@ Required properties:
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
 			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 or RZ/G1
 							compatible device)
-			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 compatible device)
+			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 or RZ/G2
+							compatible device)
 			- "renesas,rmobile-iic" (generic device)
 
 			When compatible with a generic R-Car version, nodes
-- 
2.7.4
