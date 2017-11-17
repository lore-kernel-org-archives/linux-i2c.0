From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 5/5] ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker
Date: Fri, 17 Nov 2017 16:02:36 +0800
Message-ID: <20171117080236.32504-6-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:58274 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934396AbdKQIES (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 03:04:18 -0500
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

In the S400 board, The I2C master-1 is connecting to
the audio speaker daughter board.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7b39a9fe2b0f..74730e40f992 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -28,3 +28,9 @@
 	pinctrl-0 = <&eth_rgmii_y_pins>;
 	pinctrl-names = "default";
 };
+
+&i2c_m1 {
+	status = "okay";
+	pinctrl-0 = <&i2c_m1_z_pins>;
+	pinctrl-names = "default";
+};
-- 
2.14.1
