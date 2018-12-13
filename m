From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Date: Thu, 13 Dec 2018 20:19:02 +0000
Message-ID: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Biju Das <biju.das@bp.renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Document RZ/G2E (R8A774C0) I2C compatibility with the relevant driver
dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 30c0485..3ee5e8f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -7,6 +7,7 @@ Required properties:
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
 	"renesas,i2c-r8a77470" if the device is a part of a R8A77470 SoC.
 	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
+	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
 	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
-- 
2.7.4
