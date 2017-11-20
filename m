From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH v2 5/5] ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker
Date: Mon, 20 Nov 2017 22:54:15 +0800
Message-ID: <20171120145415.6581-6-yixun.lan@amlogic.com>
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120145415.6581-1-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

In the S400 board, The I2C master-1 is connecting to
the audio speaker daughter board.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7b39a9fe2b0f..0864d1ff2d9b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -28,3 +28,9 @@
 	pinctrl-0 = <&eth_rgmii_y_pins>;
 	pinctrl-names = "default";
 };
+
+&i2c1 {
+	status = "okay";
+	pinctrl-0 = <&i2c1_z_pins>;
+	pinctrl-names = "default";
+};
-- 
2.15.0
