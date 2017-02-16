From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 3/3] ARM64: bcm2837-rpi: Fix pwm and i2c pin control
Date: Thu, 16 Feb 2017 21:20:47 +0000
Message-ID: <1487280047-29608-4-git-send-email-stefan.wahren@i2se.com>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933107AbdBPVVq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Feb 2017 16:21:46 -0500
In-Reply-To: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

According to the firmware DT blob [1] the RPi 3 uses different
pins for i2c0 and pwm.

[1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts

Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi
index 6ddf7df..9f3f3ed 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi.dtsi
@@ -46,7 +46,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_gpio0>;
+	pinctrl-0 = <&i2c0_gpio44>;
 	status = "okay";
 	clock-frequency = <100000>;
 };
@@ -71,7 +71,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
+	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
 	status = "okay";
 };
 
-- 
1.7.9.5
