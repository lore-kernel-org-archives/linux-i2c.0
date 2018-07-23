From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 2/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date: Mon, 23 Jul 2018 09:10:21 +0530
Message-ID: <20180723034025.5763-3-manivannan.sadhasivam@linaro.org>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc: linus.walleij@linaro.org, linux-i2c@vger.kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Add pinctrl definition for Actions Semiconductor S900 I2C controller.
Pinctrl definitions are only available for I2C0, I2C1, and I2C2.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/actions/s900-bubblegum-96-pins.dtsi   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
new file mode 100644
index 000000000000..95e8b31071f9
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+&pinctrl {
+
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.17.1
