From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: actions: s700-cubieboard7: Enable
 I2C0 and I2C1
Date: Sat, 5 Jan 2019 23:29:04 +0530
Message-ID: <20190105175904.GB32306@Mani-XPS-13-9360>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-5-pn@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-5-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Parthiban Nallathambi <pn@denx.de>
Cc: afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 11, 2018 at 09:04:48AM +0100, Parthiban Nallathambi wrote:
> Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
> Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Applied to dt-next branch where I have been collecting patches for
Andreas.

Thanks,
Mani

> ---
>  .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 28f3f4a0f7f0..63e375cd9eb4 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -30,6 +30,59 @@
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_default>;
> +};
> +
> +&pinctrl {
> +	i2c0_default: i2c0_default {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			groups = "i2c1_dummy";
> +			function = "i2c1";
> +		};
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_default: i2c2_default {
> +		pinmux {
> +			groups = "i2c2_dummy";
> +			function = "i2c2";
> +		};
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &timer {
>  	clocks = <&hosc>;
>  };
> -- 
> 2.17.2
> 
