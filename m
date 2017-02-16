From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 2/3] ARM64: bcm2837-rpi: remove link to bcm2835-rpi.dtsi
Date: Thu, 16 Feb 2017 21:20:46 +0000
Message-ID: <1487280047-29608-3-git-send-email-stefan.wahren@i2se.com>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbdBPVVr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Feb 2017 16:21:47 -0500
In-Reply-To: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

Before we can make any Raspberry Pi specific changes we need
a local copy of bcm2835-rpi.dtsi instead of a link. After that
we include this file and remove the unnecessary link.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi    |    1 -
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts |    2 +-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi    |   89 ++++++++++++++++++++++
 3 files changed, 90 insertions(+), 2 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
deleted file mode 120000
index 3937b77..0000000
--- a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm2835-rpi.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index c309633..e80db7e 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 #include "bcm2837.dtsi"
-#include "bcm2835-rpi.dtsi"
+#include "bcm2837-rpi.dtsi"
 #include "bcm283x-rpi-smsc9514.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
 
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi
new file mode 100644
index 0000000..6ddf7df
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi
@@ -0,0 +1,89 @@
+#include <dt-bindings/power/raspberrypi-power.h>
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		act {
+			label = "ACT";
+			default-state = "keep";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	soc {
+		firmware: firmware {
+			compatible = "raspberrypi,bcm2835-firmware";
+			mboxes = <&mailbox>;
+		};
+
+		power: power {
+			compatible = "raspberrypi,bcm2835-power";
+			firmware = <&firmware>;
+			#power-domain-cells = <1>;
+		};
+	};
+};
+
+&gpio {
+	pinctrl-names = "default";
+
+	gpioout: gpioout {
+		brcm,pins = <6>;
+		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
+	};
+
+	alt0: alt0 {
+		brcm,pins = <4 5 7 8 9 10 11 14 15>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_gpio0>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_gpio2>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio48>;
+	status = "okay";
+	bus-width = <4>;
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
+	status = "okay";
+};
+
+&usb {
+	power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
+
+&v3d {
+	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
+};
+
+&hdmi {
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
+};
-- 
1.7.9.5
