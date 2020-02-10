From: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] ARM: dts: stm32: set i2c4 bus freq to 400KHz on stm32mp157c-ed1
Date: Mon, 10 Feb 2020 18:17:21 +0100
Message-ID: <1581355041-13845-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, alain.volmat-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On this board, the I2C4 bus has only a single slave (pmic) which
supports I2C Fast Mode hence setting bus frequency to 400 KHz.

Signed-off-by: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 209dae010be4..ac4f7ee4ad55 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -135,6 +135,7 @@
 	pinctrl-0 = <&i2c4_pins_sleep_a>;
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
+	clock-frequency = <400000>;
 	status = "okay";
 	/* spare dmas for other usage */
 	/delete-property/dmas;
-- 
2.7.4
