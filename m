From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH RESEND v6 6/6] dts: arm64: mt8183: Add I2C nodes
Date: Mon, 15 Apr 2019 19:23:07 +0200
Message-ID: <dc21ff44-bbe5-4072-3102-c2a92a1b8be3@gmail.com>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
 <1554208560-14817-7-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554208560-14817-7-git-send-email-qii.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Qii Wang,

On 02/04/2019 14:36, Qii Wang wrote:
> This patch adds i2c nodes for I2C controllers
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi |  192 ++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
> 

No upstream version of the dtsi file present right now. But we are getting
slowly there. Please rebase and resubmit when basic support got accepted. Thanks
a lot.
Matthias

> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 75c4881..3dde2be 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -16,6 +16,21 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
> +		i2c9 = &i2c9;
> +		i2c10 = &i2c10;
> +		i2c11 = &i2c11;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -299,6 +314,183 @@
>  			status = "disabled";
>  		};
>  
> +		i2c6: i2c@11005000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11005000 0 0x1000>,
> +				<0 0x11000600 0 0x80>;
> +			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C6>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c@11007000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11007000 0 0x1000>,
> +				<0 0x11000080 0 0x80>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C0>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@11008000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			id = <4>;
> +			reg = <0 0x11008000 0 0x1000>,
> +				<0 0x11000100 0 0x80>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C1>,
> +				 <&infracfg CLK_INFRA_AP_DMA>,
> +				 <&infracfg CLK_INFRA_I2C1_ARBITER>;
> +			clock-names = "main", "dma","arb";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@11009000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11009000 0 0x1000>,
> +				<0 0x11000280 0 0x80>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C2>,
> +				 <&infracfg CLK_INFRA_AP_DMA>,
> +				 <&infracfg CLK_INFRA_I2C2_ARBITER>;
> +			clock-names = "main", "dma", "arb";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@1100f000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x1100f000 0 0x1000>,
> +				<0 0x11000400 0 0x80>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C3>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@11011000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11011000 0 0x1000>,
> +				<0 0x11000480 0 0x80>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C4>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +
> +		i2c9: i2c@11014000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11014000 0 0x1000>,
> +				<0 0x11000180 0 0x80>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C1_IMM>,
> +				 <&infracfg CLK_INFRA_AP_DMA>,
> +				 <&infracfg CLK_INFRA_I2C1_ARBITER>;
> +			clock-names = "main", "dma", "arb";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c10: i2c@11015000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11015000 0 0x1000>,
> +				<0 0x11000300 0 0x80>;
> +			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C2_IMM>,
> +				 <&infracfg CLK_INFRA_AP_DMA>,
> +				 <&infracfg CLK_INFRA_I2C2_ARBITER>;
> +			clock-names = "main", "dma", "arb";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c5: i2c@11016000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11016000 0 0x1000>,
> +				<0 0x11000500 0 0x80>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C5>,
> +				 <&infracfg CLK_INFRA_AP_DMA>,
> +				 <&infracfg CLK_INFRA_I2C5_ARBITER>;
> +			clock-names = "main", "dma", "arb";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c11: i2c@11017000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x11017000 0 0x1000>,
> +				<0 0x11000580 0 0x80>;
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C5_IMM>,
> +				 <&infracfg CLK_INFRA_AP_DMA>,
> +				 <&infracfg CLK_INFRA_I2C5_ARBITER>;
> +			clock-names = "main", "dma", "arb";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +
> +		i2c7: i2c@1101a000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x1101a000 0 0x1000>,
> +				<0 0x11000680 0 0x80>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C7>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c8: i2c@1101b000 {
> +			compatible = "mediatek,mt8183-i2c";
> +			reg = <0 0x1101b000 0 0x1000>,
> +				<0 0x11000700 0 0x80>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_I2C8>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		audiosys: syscon@11220000 {
>  			compatible = "mediatek,mt8183-audiosys", "syscon";
>  			reg = <0 0x11220000 0 0x1000>;
> 
