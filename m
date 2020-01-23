From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH 2/5] dt-bindings: i2c: i2c-stm32f7: add st,stm32mp15-i2c compatible
Date: Thu, 23 Jan 2020 17:12:47 +0100
Message-ID: <1579795970-22319-3-git-send-email-alain.volmat@st.com>
References: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com, alain.volmat@st.com
List-Id: linux-i2c@vger.kernel.org

Add a new stm32mp15 specific compatible to handle FastMode+
registers which are different on the stm32mp15 compared
to the stm32f7 or stm32h7.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
index 900ec1ab6a47..ffe00737446e 100644
--- a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
@@ -17,6 +17,7 @@ allOf:
           contains:
             enum:
               - st,stm32f7-i2c
+              - st,stm32mp15-i2c
     then:
       properties:
         i2c-scl-rising-time-ns:
@@ -52,6 +53,7 @@ properties:
     enum:
       - st,stm32f4-i2c
       - st,stm32f7-i2c
+      - st,stm32mp15-i2c
 
   reg:
     maxItems: 1
@@ -121,12 +123,12 @@ examples:
           clocks = <&rcc 1 CLK_I2C1>;
       };
 
-    //Example 3 (with st,stm32f7-i2c compatible on stm32mp)
+    //Example 3 (with st,stm32mp15-i2c compatible on stm32mp)
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
     #include <dt-bindings/reset/stm32mp1-resets.h>
       i2c@40013000 {
-          compatible = "st,stm32f7-i2c";
+          compatible = "st,stm32mp15-i2c";
           #address-cells = <1>;
           #size-cells = <0>;
           reg = <0x40013000 0x400>;
-- 
2.7.4
