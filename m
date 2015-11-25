From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH 1/1] arm64: dts: add all hi6220 i2c nodes
Date: Wed, 25 Nov 2015 18:35:05 +0800
Message-ID: <56558ED9.2010802@hisilicon.com>
References: <1448444942-5780-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448444942-5780-1-git-send-email-kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bintian.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

+to linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 2015/11/25 17:49, Xinwei Kong wrote:
> This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
> use this I2C IP of Synopsys Designware for HiKey board.
> 
> Signed-off-by: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 37 +++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 82d2488..6b591a9 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -208,5 +208,42 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			status = "disabled";
>  		};
> +
> +		i2c0: i2c@f7100000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7100000 0x0 0x1000>;
> +			interrupts = <0 44 4>;
> +			clocks = <&sys_ctrl HI6220_I2C0_CLK>;
> +			clock-names = "clk_i2c0";
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +			status = "ok";
> +		};
> +
> +		i2c1: i2c@f7101000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7101000 0x0 0x1000>;
> +			interrupts = <0 45 4>;
> +			clocks = <&sys_ctrl HI6220_I2C1_CLK>;
> +			clock-names = "clk_i2c1";
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
> +			status = "ok";
> +		};
> +
> +		i2c2: i2c@f7102000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7102000 0x0 0x1000>;
> +			interrupts = <0 46 4>;
> +			clocks = <&sys_ctrl HI6220_I2C2_CLK>;
> +			clock-names = "clk_i2c2";
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
> +			status = "ok";
> +		};
> +
>  	};
>  };
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
