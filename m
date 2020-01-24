From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: RE: [PATCH 5/5] ARM: dts: stm32: add Fast Mode Plus info in I2C nodes
 of stm32mp151
Date: Fri, 24 Jan 2020 08:57:21 +0000
Message-ID: <c7e1ed1294894d5697c649a26f82f498@SFHDAG5NODE2.st.com>
References: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
 <1579795970-22319-6-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1579795970-22319-6-git-send-email-alain.volmat@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alain VOLMAT <alain.volmat@st.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Fabrice GASNIER <fabrice.gasnier@st.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Ok pour la serie

-----Original Message-----
From: Alain VOLMAT <alain.volmat@st.com> 
Sent: jeudi 23 janvier 2020 17:13
To: wsa@the-dreams.de; robh+dt@kernel.org
Cc: mark.rutland@arm.com; Pierre Yves MORDRET <pierre-yves.mordret@st.com>; mcoquelin.stm32@gmail.com; Alexandre TORGUE <alexandre.torgue@st.com>; linux-i2c@vger.kernel.org; devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Fabrice GASNIER <fabrice.gasnier@st.com>; Alain VOLMAT <alain.volmat@st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add Fast Mode Plus info in I2C nodes of stm32mp151

Add the syscfg-fmp property in each i2c node in order to allow Fast Mode Plus speed if clock-frequency >= 1MHz is indicated.

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
