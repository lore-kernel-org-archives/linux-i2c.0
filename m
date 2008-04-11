From: Jochen Friedrich <jochen@scram.de>
Subject: [PATCH7/7] [POWERPC] Add i2c pins to dts and board setup
Date: Fri, 11 Apr 2008 16:12:01 +0200
Message-ID: <47FF71B1.9070907@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760826AbYDKOMf@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>, Laurent Pinchart <laurentp@cse-semaphore.com>
List-Id: linux-i2c@vger.kernel.org

Initialize I2C pins on boards with CPM1/CPM2 controllers.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/boot/dts/mpc8272ads.dts         |   10 ++++++++++
 arch/powerpc/boot/dts/mpc866ads.dts          |   10 ++++++++++
 arch/powerpc/boot/dts/mpc885ads.dts          |   10 ++++++++++
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++++
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++++
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 +++
 6 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 7285ca1..7273996 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -215,6 +215,16 @@
 				linux,network-index = <1>;
 				fsl,cpm-command = <16200300>;
 			};
+
+			i2c@11860 {
+				compatible = "fsl,mpc8248-i2c",
+					     "fsl,cpm2-i2c",
+					     "fsl,cpm-i2c";
+				reg = <11860 20 8afc 2>;
+				interrupts = <1 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-command = <29600000>;
+			};
 		};
 
 		PIC: interrupt-controller@10c00 {
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index daf9433..d669049 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -169,6 +169,16 @@
 				fsl,cpm-command = <0000>;
 				linux,network-index = <1>;
 			};
+
+			i2c@860 {
+				compatible = "fsl,mpc866-i2c",
+					     "fsl,cpm1-i2c",
+					     "fsl,cpm-i2c";
+				reg = <860 20 3c80 30>;
+				interrupts = <10>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0010>;
+			};
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index d84a012..d3ddda7 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -214,6 +214,16 @@
 				fsl,cpm-command = <0080>;
 				linux,network-index = <2>;
 			};
+
+			i2c@860 {
+				compatible = "fsl,mpc885-i2c",
+					     "fsl,cpm1-i2c",
+					     "fsl,cpm-i2c";
+				reg = <860 20 3c80 30>;
+				interrupts = <10>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0010>;
+			};
 		};
 	};
 
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 7d30187..8054c68 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -96,6 +96,10 @@ static struct cpm_pin mpc8272_ads_pins[] = {
 	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* I2C */
+	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 };
 
 static void __init init_ioports(void)
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index c028a5b..caaec29 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -65,6 +65,10 @@ static struct cpm_pin mpc866ads_pins[] = {
 	{CPM_PORTD, 13, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 14, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 15, CPM_PIN_OUTPUT},
+
+	/* I2C */
+	{CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
+	{CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
 };
 
 static void __init init_ioports(void)
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 6e7ded0..45ed6cd 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -158,6 +158,9 @@ static struct cpm_pin mpc885ads_pins[] = {
 	{CPM_PORTE, 28, CPM_PIN_OUTPUT},
 	{CPM_PORTE, 29, CPM_PIN_OUTPUT},
 #endif
+	/* I2C */
+	{CPM_PORTB, 26, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
+	{CPM_PORTB, 27, CPM_PIN_INPUT | CPM_PIN_OPENDRAIN},
 };
 
 static void __init init_ioports(void)
-- 
1.5.4.5
