From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v6 4/4] ARM: STi: Add I2C config to B2000 and B2020 boards
Date: Wed,  6 Nov 2013 09:25:15 +0100
Message-ID: <1383726315-27534-5-git-send-email-maxime.coquelin@st.com>
References: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383726315-27534-1-git-send-email-maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: stephen.gallimore-qxv4g6HH51o@public.gmane.org, stuart.menefy-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, gabriel.fernandez-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch supplies I2C configuration to B2000 and B2020
based on either STiH415 or STiH416 SoCs.

Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi |    9 +++++++++
 arch/arm/boot/dts/stih41x-b2020.dtsi |   22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index 8e694d2..1e6aa92 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -37,5 +37,14 @@
 			};
 		};
 
+		/* HDMI Tx I2C */
+		i2c@fed41000 {
+			/* HDMI V1.3a supports Standard mode only */
+			clock-frequency = <100000>;
+			i2c-min-scl-pulse-width-us = <0>;
+			i2c-min-sda-pulse-width-us = <5>;
+
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index 133e181..0ef0a69 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -38,5 +38,27 @@
 				default-state = "off";
 			};
 		};
+
+		i2c@fed40000 {
+			status = "okay";
+		};
+
+		/* HDMI Tx I2C */
+		i2c@fed41000 {
+			/* HDMI V1.3a supports Standard mode only */
+			clock-frequency = <100000>;
+			i2c-min-scl-pulse-width-us = <0>;
+			i2c-min-sda-pulse-width-us = <5>;
+
+			status = "okay";
+		};
+
+		i2c@fe540000 {
+			status = "okay";
+		};
+
+		i2c@fe541000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
