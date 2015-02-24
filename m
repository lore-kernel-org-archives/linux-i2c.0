From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT
 bindings documentation
Date: Tue, 24 Feb 2015 18:29:02 +0800
Message-ID: <1424773744-15106-3-git-send-email-wens@csie.org>
References: <1424773744-15106-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBANFWGTQKGQE5OFY3NI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1424773744-15106-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Reduced Serial Bus (RSB) is an SMBus like bus used to communicate
with some PMICs (like the AXP223) or other peripherals.

The RSB DT bindings are pretty much the same as the one defined for
the marvell's mv64xxx controller, with the additional RSB specific
"allwinner,rsb-hw-addr" property for slave device nodes.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-sunxi-rsb.txt      | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt b/Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt
new file mode 100644
index 000000000000..90aa5066873c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt
@@ -0,0 +1,50 @@
+
+* Allwinner RSB (Reduced Serial Bus) controller
+
+Required properties :
+
+ - reg             : Offset and length of the register set for the device.
+ - compatible      : Should be "allwinner,sun8i-a23-rsb".
+ - interrupts      : The interrupt line connected to the RSB peripheral.
+ - clocks          : The gate clk connected to the RSB peripheral.
+ - resets          : The reset line connected to the RSB peripheral.
+
+Optional properties :
+
+ - clock-frequency : Desired RSB bus clock frequency in Hz. If not set
+		     the default frequency is 100kHz. Maximum is 20MHz.
+
+An RSB device node may contain up to 15 child nodes each encoding an RSB
+slave device.
+
+Slave device properties:
+  Required properties:
+   - reg           : The runtime address used to access the device.
+   - allwinner,rsb-hw-addr : The RSB hardware address for the device. This
+			     is only used when configuring the runtime
+			     address of the device.
+
+  Valid runtime addresses - There are only 15 valid runtime addresses:
+
+      0x17, 0x2d, 0x3a, 0x4e, 0x59, 0x63, 0x74, 0x8b,
+      0x9c, 0xa6, 0xb1, 0xc5, 0xd2, 0xe8, 0xff
+
+
+Example:
+
+	rsb@01f03400 {
+		compatible = "allwinner,sun8i-a23-rsb";
+		reg = <0x01f03400 0x400>;
+		interrupts = <0 39 4>;
+		clocks = <&apb0_gates 3>;
+		clock-frequency = <3000000>;
+		resets = <&apb0_rst 3>;
+
+		axp223: pmic@2d {
+			compatible = "x-powers,axp223", "x-powers,axp221";
+			reg = <0x2d>;
+			allwinner,rsb-hw-addr = <0x3e3>;
+
+			/* ... */
+		};
+	};
-- 
2.1.4
