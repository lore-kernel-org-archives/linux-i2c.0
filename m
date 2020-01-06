From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH 1/6] ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp15xx-dkx
Date: Mon, 6 Jan 2020 14:28:29 +0100
Message-ID: <1578317314-17197-2-git-send-email-alain.volmat@st.com>
References: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

Add the sleep state pinctrl entry for the i2c4 node
of the stm32mp15xx-dkx.dtsi

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index f6672e87aef3..7f5fcb2c5b03 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -216,8 +216,9 @@
 };
 
 &i2c4 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c4_pins_a>;
+	pinctrl-1 = <&i2c4_pins_sleep_a>;
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
 	status = "okay";
-- 
2.7.4
