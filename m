From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 5/6] arm64: renesas: draak: enable I2C controller 1
Date: Wed, 15 Nov 2017 16:25:25 +0100
Message-ID: <1510759526-30346-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-i2c@vger.kernel.org

No devices to add, I2C1 has an external connector only.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 64a6339..91f247f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -51,6 +51,11 @@
 		function = "i2c0";
 	};
 
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
 	pwm0_pins: pwm0 {
 		groups = "pwm0_c";
 		function = "pwm0";
@@ -84,6 +89,12 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.7.4
