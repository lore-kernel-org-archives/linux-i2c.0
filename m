From: Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v6 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429
 SoC
Date: Tue, 13 Dec 2016 11:01:48 +0100
Message-ID: <da86d0db-9fe2-8d0b-6e22-61a9eea92cc5@st.com>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-4-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481559342-6106-4-git-send-email-cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Cedric,

On 12/12/2016 05:15 PM, M'boumba Cedric Madianga wrote:
> Signed-off-by: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Please Add a commit message.

> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 7de52ee..cbdece7 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -48,6 +48,7 @@
>  #include "skeleton.dtsi"
>  #include "armv7-m.dtsi"
>  #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
> +#include <dt-bindings/mfd/stm32f4-rcc.h>
>
>  / {
>  	clocks {
> @@ -337,6 +338,16 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			i2c1_pins_b: i2c1@0 {
> +				pins1 {
> +					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
> +					drive-open-drain;
> +				};
> +				pins2 {
> +					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
> +				};
> +			};
>  		};
>
>  		rcc: rcc@40023810 {
> @@ -409,6 +420,18 @@
>  			interrupts = <80>;
>  			clocks = <&rcc 0 38>;
>  		};
> +
> +		i2c1: i2c@40005400 {

Can you check the order on device node please ? (should follow base@)

> +			compatible = "st,stm32f4-i2c";
> +			reg = <0x40005400 0x400>;
> +			interrupts = <31>,
> +				     <32>;
> +			resets = <&rcc STM32F4_APB1_RESET(I2C1)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(I2C1)>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
>  	};
>  };
>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
