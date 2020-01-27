From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v3 5/6] ARM: at91/dt: sama5d4: add i2c gpio pinctrl
Date: Mon, 27 Jan 2020 09:56:57 +0100
Message-ID: <20200127085657.wt4isv6f3v76jcr3@M43218.corp.atmel.com>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-6-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-6-codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 15, 2020 at 01:54:21PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> 
> Add the i2c gpio pinctrls so the i2c bus recovery option can be enabled
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
>  - none;
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 6ab27a7b388d..26ce868096c2 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -458,8 +458,11 @@
>  					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
>  					| AT91_XDMAC_DT_PERID(3))>;
>  				dma-names = "tx", "rx";
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&pinctrl_i2c0>;
> +				pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +				sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
> @@ -477,8 +480,11 @@
>  					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
>  					| AT91_XDMAC_DT_PERID(5))>;
>  				dma-names = "tx", "rx";
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&pinctrl_i2c1>;
> +				pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +				sda-gpios = <&pioE 29 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioE 30 GPIO_ACTIVE_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
> @@ -519,8 +525,11 @@
>  					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
>  					| AT91_XDMAC_DT_PERID(7))>;
>  				dma-names = "tx", "rx";
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&pinctrl_i2c2>;
> +				pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +				sda-gpios = <&pioB 29 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioB 30 GPIO_ACTIVE_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
> @@ -1122,6 +1131,12 @@
>  							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE
>  							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
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
> @@ -1130,6 +1145,12 @@
>  							<AT91_PIOE 29 AT91_PERIPH_C AT91_PINCTRL_NONE	/* TWD1, conflicts with UART0 RX and DIBP */
>  							 AT91_PIOE 30 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* TWCK1, conflicts with UART0 TX and DIBN */
>  					};
> +
> +					pinctrl_i2c1_gpio: i2c1-gpio {
> +						atmel,pins =
> +							<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +							 AT91_PIOE 30 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
>  				};
>  
>  				i2c2 {
> @@ -1138,6 +1159,12 @@
>  							<AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* TWD2, conflicts with RD0 and PWML1 */
>  							 AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE>; /* TWCK2, conflicts with RF0 */
>  					};
> +
> +					pinctrl_i2c2_gpio: i2c2-gpio {
> +						atmel,pins =
> +							<AT91_PIOB 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +							 AT91_PIOB 30 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
>  				};
>  
>  				isi {
> -- 
> 2.20.1
> 
