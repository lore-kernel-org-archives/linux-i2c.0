From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v3 4/6] ARM: at91/dt: sama5d3: add i2c gpio pinctrl
Date: Mon, 27 Jan 2020 09:55:34 +0100
Message-ID: <20200127085534.gux7rjtr275al4pb@M43218.corp.atmel.com>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-5-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-5-codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 15, 2020 at 01:54:20PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> 
> Add the i2c gpio pinctrls to support the i2c bus recovery
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> [codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org: removed gpio pull-ups]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

> ---
> 
> Changes in v3:
>  - removed gpio pull-ups;
> 
> Changes in v2:
>   - none;
> 
>  arch/arm/boot/dts/sama5d3.dtsi | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index f770aace0efd..1cea2137decf 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -159,8 +159,11 @@
>  				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(7)>,
>  				       <&dma0 2 AT91_DMA_CFG_PER_ID(8)>;
>  				dma-names = "tx", "rx";
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&pinctrl_i2c0>;
> +				pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +				sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				clocks = <&twi0_clk>;
> @@ -174,8 +177,11 @@
>  				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(9)>,
>  				       <&dma0 2 AT91_DMA_CFG_PER_ID(10)>;
>  				dma-names = "tx", "rx";
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&pinctrl_i2c1>;
> +				pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +				sda-gpios = <&pioC 26 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioC 27 GPIO_ACTIVE_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				clocks = <&twi1_clk>;
> @@ -357,8 +363,11 @@
>  				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(11)>,
>  				       <&dma1 2 AT91_DMA_CFG_PER_ID(12)>;
>  				dma-names = "tx", "rx";
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&pinctrl_i2c2>;
> +				pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +				sda-gpios = <&pioA 18 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioA 19 GPIO_ACTIVE_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				clocks = <&twi2_clk>;
> @@ -639,6 +648,12 @@
>  							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA30 periph A TWD0 pin, conflicts with URXD1, ISI_VSYNC */
>  							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA31 periph A TWCK0 pin, conflicts with UTXD1, ISI_HSYNC */
>  					};
> +
> +					pinctrl_i2c0_gpio: i2c0-gpio {
> +						atmel,pins =
> +							<AT91_PIOA 30 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +							 AT91_PIOA 31 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
>  				};
>  
>  				i2c1 {
> @@ -647,6 +662,12 @@
>  							<AT91_PIOC 26 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC26 periph B TWD1 pin, conflicts with SPI1_NPCS1, ISI_D11 */
>  							 AT91_PIOC 27 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC27 periph B TWCK1 pin, conflicts with SPI1_NPCS2, ISI_D10 */
>  					};
> +
> +					pinctrl_i2c1_gpio: i2c1-gpio {
> +						atmel,pins =
> +							<AT91_PIOC 26 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +							 AT91_PIOC 27 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
>  				};
>  
>  				i2c2 {
> @@ -655,6 +676,12 @@
>  							<AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_NONE	/* TWD2 pin, conflicts with LCDDAT18, ISI_D2 */
>  							 AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* TWCK2 pin, conflicts with LCDDAT19, ISI_D3 */
>  					};
> +
> +					pinctrl_i2c2_gpio: i2c2-gpio {
> +						atmel,pins =
> +							<AT91_PIOA 18 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +							 AT91_PIOA 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
>  				};
>  
>  				isi {
> -- 
> 2.20.1
> 
