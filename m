From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
Date: Wed, 26 Sep 2018 17:27:50 +0530
Message-ID: <20180926115751.20421-2-vigneshr@ti.com>
References: <20180926115751.20421-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926115751.20421-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

AM654 SoCs have similar I2C IP as OMAP SoCs. Add new compatible to
handle AM654 SoCs.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 7e49839d4124..11ce869d682d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -2,7 +2,8 @@ I2C for OMAP platforms
 
 Required properties :
 - compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
-  or "ti,omap4-i2c"
+  or "ti,omap4-i2c" for OMAP2+ SoCs
+- compatible : Must "ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.19.0
