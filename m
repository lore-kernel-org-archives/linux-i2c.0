From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH 3/6] arm64: renesas: r8a77995: add I2C support
Date: Wed, 17 Jan 2018 17:21:33 +0000
Message-ID: <ba3b094e-91f3-fa4d-7dbb-ab7741c5470c@ideasonboard.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759526-30346-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759526-30346-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Content-Language: en-GB
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Ulrich, Wolfram,

Is there any update to this patch series?
This seems to be the latest I could find for D3.

I need I2C on D3 for my current additional task, so I'll try to use these
patches as the base for now.

(Patch 3, 4, 5 apply on top of renesas-drivers-2018-01-09-v4.15-rc7, so if it
works - that's enough for me for the moment)

Please let me know if there is a newer series or branch that I should be
considering as a base.

--
Kieran


On 15/11/17 15:25, Ulrich Hecht wrote:
> Defines R-Car D3 I2C controllers 0-3.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 64 +++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> index 5fa7572..b3113003 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -400,6 +400,70 @@
>  			status = "disabled";
>  		};
>  
> +		i2c0: i2c@e6500000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "renesas,i2c-r8a77995",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe6500000 0 0x40>;
> +			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 931>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 931>;
> +			dmas = <&dmac1 0x91>, <&dmac1 0x90>;
> +			dma-names = "tx", "rx";
> +			i2c-scl-internal-delay-ns = <110>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@e6508000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "renesas,i2c-r8a77995",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe6508000 0 0x40>;
> +			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 930>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 930>;
> +			dmas = <&dmac1 0x93>, <&dmac1 0x92>;
> +			dma-names = "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@e6510000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "renesas,i2c-r8a77995",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe6510000 0 0x40>;
> +			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 929>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 929>;
> +			dmas = <&dmac1 0x95>, <&dmac1 0x94>;
> +			dma-names = "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@e66d0000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "renesas,i2c-r8a77995",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe66d0000 0 0x40>;
> +			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 928>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 928>;
> +			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
> +			dma-names = "tx", "rx";
> +			i2c-scl-internal-delay-ns = <110>;
> +			status = "disabled";
> +		};
> +
>  		pwm0: pwm@e6e30000 {
>  			compatible = "renesas,pwm-r8a77995", "renesas,pwm-rcar";
>  			reg = <0 0xe6e30000 0 0x8>;
> 
