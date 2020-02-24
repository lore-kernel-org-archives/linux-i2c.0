From: Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 02/89] dt-bindings: i2c: brcmstb: Add BCM2711 BSC/AUTO-I2C
 binding
Date: Mon, 24 Feb 2020 10:06:04 +0100
Message-ID: <9e427ff22fa40b7146b44aee6468559499deb1f1.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Eric Anholt <eric@anholt.net>
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Tim Gover <tim.gover@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Phil Elwell <phil@raspberrypi.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>
List-Id: linux-i2c@vger.kernel.org

The HDMI blocks in the BCM2771 have an i2c controller to retrieve the
EDID. This block is split into two parts, the BSC and the AUTO_I2C,
lying in two separate register areas.

The AUTO_I2C block has a mailbox-like interface and will take away the
BSC control from the CPU if enabled. However, the BSC is the actually
the same controller than the one supported by the brcmstb driver, and
the AUTO_I2C doesn't really bring any immediate benefit.

We can model it in the DT as a single device with two register range,
which will allow us to use or or the other in the driver without
changing anything in the DT.

Cc: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml | 40 ++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml b/Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
index 3189d74096e8..edbca2476128 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
@@ -15,11 +15,21 @@ allOf:
 properties:
   compatible:
     enum:
+      - brcm,bcm2711-hdmi-i2c
       - brcm,brcmstb-i2c
       - brcm,brcmper-i2c
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: BSC register range
+      - description: Auto-I2C register range
+
+  reg-names:
+    items:
+      - const: bsc
+      - const: auto-i2c
 
   interrupts:
     maxItems: 1
@@ -45,6 +55,26 @@ required:
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - brcm,bcm2711-hdmi-i2c
+
+then:
+  properties:
+    reg:
+      minItems: 2
+
+  required:
+    - reg-names
+
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 examples:
   - |
       bsca: i2c@f0406200 {
@@ -56,4 +86,12 @@ examples:
           interrupt-names = "upg_bsca";
       };
 
+  - |
+      ddc0: i2c@7ef04500 {
+          compatible = "brcm,bcm2711-hdmi-i2c";
+          reg = <0x7ef04500 0x100>, <0x7ef00b00 0x300>;
+          reg-names = "bsc", "auto-i2c";
+          clock-frequency = <390000>;
+      };
+
 ...
-- 
git-series 0.9.1
