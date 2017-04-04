From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v4 5/8] i2c: i2c-cbus-gpio: Add vendor prefix to retu node in example
Date: Tue,  4 Apr 2017 11:30:33 -0400
Message-ID: <20170404153036.6651-6-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org

The example contains a device node for a retu device, but
its compatible string doesn't have a vendor prefix.

While being there, drop the -mfd suffix since isn't correct.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v4:
- Avoid using MFD in Device Tree (Lee Jones).

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
index 8ce9cd2855b5..c143948b2a37 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
@@ -20,8 +20,8 @@ i2c@0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	retu-mfd: retu@1 {
-		compatible = "retu-mfd";
+	retu: retu@1 {
+		compatible = "nokia,retu";
 		reg = <0x1>;
 	};
 };
-- 
2.9.3
