From: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v6 1/2] i2c: sunxi: add P2WI DT bindings documentation
Date: Wed, 11 Jun 2014 10:39:39 +0200
Message-ID: <1402475980-15513-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1402475980-15513-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402475980-15513-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

P2WI (Push/Pull 2 Wire Interface) is an SMBus like bus used to communicate
with some PMICs (like the AXP221).

Document P2WI DT bindings which are pretty much the same as the one defined
for the marvell's mv64xxx controller.

Signed-off-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-sunxi-p2wi.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt b/Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
new file mode 100644
index 0000000..6b76548
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
@@ -0,0 +1,41 @@
+
+* Allwinner P2WI (Push/Pull 2 Wire Interface) controller
+
+Required properties :
+
+ - reg             : Offset and length of the register set for the device.
+ - compatible      : Should one of the following:
+                     - "allwinner,sun6i-a31-p2wi"
+ - interrupts      : The interrupt line connected to the P2WI peripheral.
+ - clocks          : The gate clk connected to the P2WI peripheral.
+ - resets          : The reset line connected to the P2WI peripheral.
+
+Optional properties :
+
+ - clock-frequency : Desired P2WI bus clock frequency in Hz. If not set the
+default frequency is 100kHz
+
+A P2WI may contain one child node encoding a P2WI slave device.
+
+Slave device properties:
+  Required properties:
+   - reg           : the I2C slave address used during the initialization
+                     process to switch from I2C to P2WI mode
+
+Example:
+
+	p2wi@01f03400 {
+		compatible = "allwinner,sun6i-a31-p2wi";
+		reg = <0x01f03400 0x400>;
+		interrupts = <0 39 4>;
+		clocks = <&apb0_gates 3>;
+		clock-frequency = <6000000>;
+		resets = <&apb0_rst 3>;
+
+		axp221: pmic@68 {
+			compatible = "x-powers,axp221";
+			reg = <0x68>;
+
+			/* ... */
+		};
+	};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
