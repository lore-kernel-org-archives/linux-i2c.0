From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] dt-bindings: i2c: rcar: Add r8a774a1 support
Date: Tue, 14 Aug 2018 13:32:55 +0100
Message-ID: <1534249975-15588-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Document RZ/G2M (R8A774A1) I2C compatibility with the relevant driver
dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 7bb6484..39cd21d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:
 	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
+	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
 	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
@@ -21,7 +22,8 @@ Required properties:
 	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
 	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
 				device.
-	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 compatible device.
+	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 or RZ/G2 compatible
+				device.
 	"renesas,i2c-rcar" (deprecated)
 
 	When compatible with the generic version, nodes must list the
-- 
2.7.4
