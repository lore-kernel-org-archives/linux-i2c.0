From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Fri, 17 Oct 2014 11:27:06 +0200
Message-ID: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux PowerPC Kernel <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Holger Brunck <holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With "fsl-i2c" compatibility the i2c frequency is not set
correctly, because it sets no prescaler. According to the AN2919 from
Freescale and the QorIQ (P2041) documentation, the source clock is 1/2
the platform clock. This implies that a prescaler of 2 must be used.

This changes the compatibility of the qoriq-i2c .dtsi files to pick the
mpc8543, which uses the same driver but sets the correct prescaler.

Signed-off-by: Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
---

 arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi | 4 ++--
 arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
index 5f9bf7d..aa6c366 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
@@ -36,7 +36,7 @@ i2c@118000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <0>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x118000 0x100>;
 	interrupts = <38 2 0 0>;
 	dfsrr;
@@ -46,7 +46,7 @@ i2c@118100 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <1>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x118100 0x100>;
 	interrupts = <38 2 0 0>;
 	dfsrr;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
index 7989bf5..b697a3b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
@@ -36,7 +36,7 @@ i2c@119000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <2>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x119000 0x100>;
 	interrupts = <39 2 0 0>;
 	dfsrr;
@@ -46,7 +46,7 @@ i2c@119100 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	cell-index = <3>;
-	compatible = "fsl-i2c";
+	compatible = "fsl,mpc8543-i2c", "fsl-i2c";
 	reg = <0x119100 0x100>;
 	interrupts = <39 2 0 0>;
 	dfsrr;
-- 
1.8.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
