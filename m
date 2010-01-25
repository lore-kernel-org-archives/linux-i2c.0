From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C bindings
Date: Mon, 25 Jan 2010 09:27:09 +0100
Message-ID: <1264408029-5290-4-git-send-email-wg@grandegger.com>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
 <1264408029-5290-2-git-send-email-wg@grandegger.com>
 <1264408029-5290-3-git-send-email-wg@grandegger.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264408029-5290-3-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

This patch adds the MPC5121 to the list of supported devices,
enhances the doc of the "clock-frequency" property and removes
the obsolete "cell-index" property from the example nodes.

Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
---
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
index b6d2e21..2af8a05 100644
--- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
@@ -9,8 +9,8 @@ Recommended properties :
 
  - compatible : compatibility list with 2 entries, the first should
    be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
-   e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second one
-   should be "fsl-i2c".
+   e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b. The
+   second one should be "fsl-i2c".
  - interrupts : <a b> where a is the interrupt number and b is a
    field that represents an encoding of the sense and level
    information for the interrupt.  This should be encoded based on
@@ -20,7 +20,9 @@ Recommended properties :
    services interrupts for this device.
  - fsl,preserve-clocking : boolean; if defined, the clock settings
    from the bootloader are preserved (not touched).
- - clock-frequency : desired I2C bus clock frequency in Hz.
+ - clock-frequency : desired I2C bus clock frequency in Hz.  If this
+   property and "fsl,preserve-clocking" is not defined, a safe fixed
+   clock divider value is used (resulting in a small clock frequency).
 
 Examples :
 
@@ -28,7 +30,6 @@ Examples :
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-		cell-index = <0>;
 		reg = <0x3d00 0x40>;
 		interrupts = <2 15 0>;
 		interrupt-parent = <&mpc5200_pic>;
@@ -38,7 +39,6 @@ Examples :
 	i2c@3100 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cell-index = <1>;
 		compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 		reg = <0x3100 0x100>;
 		interrupts = <43 2>;
-- 
1.6.2.5
