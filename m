From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH] ARM: dts: stm32: set i2c4 bus freq to 400KHz on stm32mp15 DK boards
Date: Mon, 10 Feb 2020 18:17:36 +0100
Message-ID: <1581355056-13884-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47581 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbgBJRRv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Feb 2020 12:17:51 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com, alain.volmat@st.com

On DK boards, all I2C4 bus slaves supports I2C Fast Mode hence setting
the bus frequency to 400 KHz.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 7f5fcb2c5b03..2521f428ae67 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -221,6 +221,7 @@
 	pinctrl-1 = <&i2c4_pins_sleep_a>;
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
+	clock-frequency = <400000>;
 	status = "okay";
 	/* spare dmas for other usage */
 	/delete-property/dmas;
-- 
2.7.4
