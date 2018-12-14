From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH v2] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Date: Fri, 14 Dec 2018 08:41:47 +0000
Message-ID: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das@bp.renesas.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* Improved the style according to Peter's comment

 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index bc876b7..202602e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -8,6 +8,7 @@ Required properties:
 			- "renesas,iic-r8a7744" (RZ/G1N)
 			- "renesas,iic-r8a7745" (RZ/G1E)
 			- "renesas,iic-r8a774a1" (RZ/G2M)
+			- "renesas,iic-r8a774c0" (RZ/G2E)
 			- "renesas,iic-r8a7790" (R-Car H2)
 			- "renesas,iic-r8a7791" (R-Car M2-W)
 			- "renesas,iic-r8a7792" (R-Car V2H)
@@ -32,10 +33,10 @@ Required properties:
 			When compatible with "renesas,rmobile-iic" it should
 			be the last compatibility string listed.
 
-			The r8a77990 (R-Car E3) controller is not
-			considered compatible with "renesas,rcar-gen3-iic"
-			or "renesas,rmobile-iic" due to the absence of
-			automatic transmission registers.
+			The r8a77990 (R-Car E3) and r8a774c0 (RZ/G2E)
+			controllers are not considered compatible with
+			"renesas,rcar-gen3-iic" or "renesas,rmobile-iic"
+			due to the absence of automatic transmission registers.
 
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
-- 
2.7.4
