From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [V5, 2/2] dt-bindings: i2c: Add i2c-brcmstb dt bindings
Date: Tue, 9 Jun 2015 15:36:21 -0400
Message-ID: <1433878581-22666-2-git-send-email-kdasu.kdev@gmail.com>
References: <1433878581-22666-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433878581-22666-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c Device tree binding documentation for brcmstb
SoCs.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-brcmstb.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt b/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
new file mode 100644
index 0000000..d6f724e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
@@ -0,0 +1,28 @@
+Broadcom stb bsc iic master controller
+
+Required properties:
+
+- compatible: should be "brcm,brcmstb-i2c"
+- clock-frequency: 32-bit decimal value of iic master clock freqency in Hz
+		   valid values are 375000, 390000, 187500, 200000
+		   93750, 97500, 46875 and 50000
+- reg: specifies the base physical address and size of the registers
+
+Optional properties :
+
+- interrupt-parent: specifies the phandle to the parent interrupt controller
+  this one is cascaded from
+- interrupts: specifies the interrupt number, the irq line to be used
+- interrupt-names: Interrupt name string
+
+Example:
+
+bsca: i2c@f0406200 {
+      clock-frequency = <390000>;
+      compatible = "brcm,brcmstb-i2c";
+      interrupt-parent = <&irq0_intc>;
+      reg = <0xf0406200 0x58>;
+      interrupts = <0x18>;
+      interrupt-names = "upg_bsca";
+};
+
-- 
2.3.2
