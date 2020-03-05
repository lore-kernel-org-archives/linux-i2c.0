From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/5] dt-bindings: i2c: i2c-rk3x: add description for rk3036
Date: Thu,  5 Mar 2020 15:36:08 +0100
Message-ID: <20200305143611.10733-2-jbx6244@gmail.com>
References: <20200305143611.10733-1-jbx6244@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200305143611.10733-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The description below is already in use for rk3036.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3036-i2c", "rockchip,rk3288-i2c"
for i2c nodes on a rk3036 platform to i2c-rk3x.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 962aefb7d..0bba39998 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -28,6 +28,10 @@ properties:
       - const: rockchip,rk3399-i2c
       - items:
           - enum:
+            - rockchip,rk3036-i2c
+          - const: rockchip,rk3288-i2c
+      - items:
+          - enum:
             - rockchip,rk3328-i2c
           - const: rockchip,rk3399-i2c
 
-- 
2.11.0
