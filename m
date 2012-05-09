From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2 09/11] ARM: dts: imx6q-sabrelite: add serial2 pinctrl support
Date: Wed, 9 May 2012 19:33:08 +0800
Message-ID: <1336563190-19974-10-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 arch/arm/boot/dts/imx6q.dtsi          |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 5a35bfd..e0ec929 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -73,6 +73,8 @@
 
 			uart2: serial@021e8000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_serial2_1>;
 			};
 
 			i2c@021a0000 { /* I2C1 */
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 5795b93..31c3d5f 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -502,6 +502,13 @@
 					};
 				};
 
+				serial2 {
+					pinctrl_serial2_1: serial2grp-1 {
+						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
+							    191 0x1b0b1>;	/* MX6Q_PAD_EIM_D27__UART2_RXD */
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-- 
1.7.5.4
