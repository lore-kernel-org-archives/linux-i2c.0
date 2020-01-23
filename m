From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add Fast Mode Plus info in I2C nodes of stm32mp151
Date: Thu, 23 Jan 2020 17:12:50 +0100
Message-ID: <1579795970-22319-6-git-send-email-alain.volmat@st.com>
References: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21436 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728904AbgAWQNe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Jan 2020 11:13:34 -0500
In-Reply-To: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com, alain.volmat@st.com

Add the syscfg-fmp property in each i2c node in order to allow
Fast Mode Plus speed if clock-frequency >= 1MHz is indicated.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 2dbf32ca9b36..ecd0a932aa78 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -483,6 +483,7 @@
 			resets = <&rcc I2C1_R>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			st,syscfg-fmp = <&syscfg 0x4 0x1>;
 			wakeup-source;
 			status = "disabled";
 		};
@@ -497,6 +498,7 @@
 			resets = <&rcc I2C2_R>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			st,syscfg-fmp = <&syscfg 0x4 0x2>;
 			wakeup-source;
 			status = "disabled";
 		};
@@ -511,6 +513,7 @@
 			resets = <&rcc I2C3_R>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			st,syscfg-fmp = <&syscfg 0x4 0x4>;
 			wakeup-source;
 			status = "disabled";
 		};
@@ -525,6 +528,7 @@
 			resets = <&rcc I2C5_R>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			st,syscfg-fmp = <&syscfg 0x4 0x10>;
 			wakeup-source;
 			status = "disabled";
 		};
@@ -1477,6 +1481,7 @@
 			resets = <&rcc I2C4_R>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			st,syscfg-fmp = <&syscfg 0x4 0x8>;
 			wakeup-source;
 			status = "disabled";
 		};
@@ -1513,6 +1518,7 @@
 			resets = <&rcc I2C6_R>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			st,syscfg-fmp = <&syscfg 0x4 0x20>;
 			wakeup-source;
 			status = "disabled";
 		};
-- 
2.7.4
