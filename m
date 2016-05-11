From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH 4/5] ARM: dts: Add I2C1 support for STM32429 eval board
Date: Wed, 11 May 2016 17:36:13 +0200
Message-ID: <1462980974-22091-5-git-send-email-cedric.madianga@gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35141 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489AbcEKPhe (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 11:37:34 -0400
In-Reply-To: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mcoquelin.stm32@gmail.com, patrice.chotard@st.com, wsa@the-dreams.de, robh+dt@kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc595..0bf427a 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -123,3 +123,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
