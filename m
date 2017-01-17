From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v9 4/5] ARM: dts: stm32: Add I2C1 support for STM32429 eval board
Date: Tue, 17 Jan 2017 16:27:00 +0100
Message-ID: <1484666821-20551-5-git-send-email-cedric.madianga@gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36458 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbdAQP1e (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Jan 2017 10:27:34 -0500
In-Reply-To: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

This patch adds I2C1 instance support for STM32x9I-Eval board.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 76f7206..c943539 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -146,3 +146,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
