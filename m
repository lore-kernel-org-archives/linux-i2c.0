From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 06/11] ARM: dts: imx6q-sabrelite: add ssi device
Date: Fri, 27 Apr 2012 15:03:00 +0800
Message-ID: <1335510185-7906-7-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Signed-off-by: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    9 +++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   18 +++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 4e13293..7bd8855 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -22,6 +22,15 @@
 	};
 
 	soc {
+		aips-bus@02000000 { /* AIPS1 */
+			spba-bus@02000000 {
+				ssi1: ssi@02028000 {
+					fsl,mode = "i2s-slave";
+					status = "okay";
+				};
+			};
+		};
+
 		aips-bus@02100000 { /* AIPS2 */
 			enet@02188000 {
 				phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fe8c80d..da42fc0 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -177,19 +177,31 @@
 					interrupts = <0 51 0x04>;
 				};
 
-				ssi@02028000 { /* SSI1 */
+				ssi1: ssi@02028000 {
+					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <38 37>;
+					status = "disabled";
 				};
 
-				ssi@0202c000 { /* SSI2 */
+				ssi2: ssi@0202c000 {
+					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <42 41>;
+					status = "disabled";
 				};
 
-				ssi@02030000 { /* SSI3 */
+				ssi3: ssi@02030000 {
+					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <46 45>;
+					status = "disabled";
 				};
 
 				asrc@02034000 {
-- 
1.7.5.4
