From: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 3/3] i2c: xlp9xx: device tree bindings
Date: Wed, 18 Mar 2015 17:20:30 +0530
Message-ID: <1426679430-26134-4-git-send-email-jchandra@broadcom.com>
References: <1426679430-26134-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426679430-26134-1-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add document Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
for Netlogic XLP9XX/5XX i2c controller. The compatible string is
"netlogic,xlp980-i2c".
---
 .../devicetree/bindings/i2c/i2c-xlp9xx.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt b/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
new file mode 100644
index 00000000..f818ef5
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
@@ -0,0 +1,22 @@
+Device tree configuration for the I2C controller on the XLP9xx/5xx SoC
+
+Required properties:
+- compatible      : should be "netlogic,xlp980-i2c"
+- reg             : bus address start and address range size of device
+- interrupts      : interrupt number
+
+Optional properties:
+- clock-frequency : frequency of bus clock in Hz
+                    Defaults to 100 KHz when the property is not specified
+
+Example:
+
+i2c0: i2c@113100 {
+	compatible = "netlogic,xlp980-i2c";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0 0x113100 0x100>;
+	clock-frequency = <400000>;
+	interrupts = <30>;
+	interrupt-parent = <&pic>;
+};
-- 
1.9.1
