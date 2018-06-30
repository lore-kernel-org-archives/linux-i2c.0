From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3 2/6] arm64: dts: actions: Add Actions Semiconductor
 S900 I2C controller nodes
Date: Sat, 30 Jun 2018 22:57:46 +0200
Message-ID: <F8B97397-EBE6-400A-A9A8-CD415EE24C55@axentia.se>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
 <20180630133330.23858-3-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180630133330.23858-3-manivannan.sadhasivam@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc: devicetree@vger.kernel.org, daniel.thompson@linaro.org, manivannanece23@gmail.com, jeff.chen@actions-semi.com, hzhang@ucrobotics.com, thomas.liau@actions-semi.com, linus.walleij@linaro.org, liuwei@actions-semi.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, linux-gpio@vger.kernel.org, andy.shevchenko@gmail.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, bdong@ucrobotics.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On June 30, 2018 3:33:26 PM GMT+02:00, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
>Add I2C controller nodes for Actions Semiconductor S900 SoC.
>
>Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>---
> arch/arm64/boot/dts/actions/s900.dtsi | 60 +++++++++++++++++++++++++++
> 1 file changed, 60 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/actions/s900.dtsi
>b/arch/arm64/boot/dts/actions/s900.dtsi
>index 7ae8b931f000..6f7b89edbe4d 100644
>--- a/arch/arm64/boot/dts/actions/s900.dtsi
>+++ b/arch/arm64/boot/dts/actions/s900.dtsi
>@@ -174,6 +174,66 @@
> 			#clock-cells = <1>;
> 		};
> 
>+		i2c0: i2c@e0170000 {
>+			compatible = "actions,s900-i2c";
>+			reg = <0 0xe0170000 0 0x1000>;
>+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			status = "disabled";
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&i2c0_default>;
>+		};
>+
>+		i2c1: i2c@e0172000 {
>+			compatible = "actions,s900-i2c";
>+			reg = <0 0xe0172000 0 0x1000>;
>+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			status = "disabled";
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&i2c1_default>;
>+		};
>+
>+		i2c2: i2c@e0174000 {
>+			compatible = "actions,s900-i2c";
>+			reg = <0 0xe0174000 0 0x1000>;
>+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			status = "disabled";
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&i2c2_default>;
>+		};
>+
>+		i2c3: i2c@e0176000 {
>+			compatible = "actions,s900-i2c";
>+			reg = <0 0xe0176000 0 0x1000>;
>+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			status = "disabled";
>+		};
>+
>+		i2c4: i2c@e0178000 {
>+			compatible = "actions,s900-i2c";
>+			reg = <0 0xe0178000 0 0x1000>;
>+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			status = "disabled";
>+		};
>+
>+		i2c5: i2c@e017a000 {
>+			compatible = "actions,s900-i2c";
>+			reg = <0 0xe017a000 0 0x1000>;
>+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			status = "disabled";
>+		};
>+
> 		pinctrl: pinctrl@e01b0000 {
> 			compatible = "actions,s900-pinctrl";
> 			reg = <0x0 0xe01b0000 0x0 0x1000>;

This patch *still* depends on patch 3/6. You need to reorder the series so that it is properly bisectable.

Cheers,
Peter
