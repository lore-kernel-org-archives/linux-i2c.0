From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v3 3/7] i2c: i2c-cbus-gpio: Add vendor prefix to retu node in example
Date: Sat,  1 Apr 2017 03:18:50 -0400
Message-ID: <20170401071854.23198-4-javier@osg.samsung.com>
References: <20170401071854.23198-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170401071854.23198-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org

The example contains a device node for a retu-mfd device,
but its compatible string doesn't have a vendor prefix.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
index 8ce9cd2855b5..32bcb1943f00 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
@@ -21,7 +21,7 @@ i2c@0 {
 	#size-cells = <0>;
 
 	retu-mfd: retu@1 {
-		compatible = "retu-mfd";
+		compatible = "nokia,retu-mfd";
 		reg = <0x1>;
 	};
 };
-- 
2.9.3
