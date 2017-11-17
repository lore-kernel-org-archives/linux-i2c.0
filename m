From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 1/5] dt-bindings: i2c: update documentation for the Meson-AXG
Date: Fri, 17 Nov 2017 16:02:32 +0800
Message-ID: <20171117080236.32504-2-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

Update the doc to explicitly add Meson-AXG to support list

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 611b934c7e10..3097d2b44dad 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -2,6 +2,7 @@ Amlogic Meson I2C controller
 
 Required properties:
  - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
+						"amlogic,meson-axg-i2c"
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
  - clocks: clock for the device
-- 
2.14.1
