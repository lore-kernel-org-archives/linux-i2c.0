From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 2/2] dt-bindings: at24: add new compatible
Date: Wed,  2 Oct 2019 09:20:47 +0200
Message-ID: <20191002072047.20895-3-brgl@bgdev.pl>
References: <20191002072047.20895-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002072047.20895-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh@kernel.org>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

arch/arm/boot/dts/at91-dvk_som60.dt.yaml uses the compatible string
'giantec,gt24c32a' for an at24 EEPROM with a fallback to 'atmel,24c32'.

Add this model as a special case to the binding document.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index c56f27fde3b3..e8778560d966 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -107,6 +107,9 @@ properties:
       - items:
           - const: renesas,r1ex24016
           - const: atmel,24c16
+      - items:
+          - const: giantec,gt24c32a
+          - const: atmel,24c32
       - items:
           - const: renesas,r1ex24128
           - const: atmel,24c128
-- 
2.23.0
