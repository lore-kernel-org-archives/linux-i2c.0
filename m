From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] ARM: dts: add twi nodes for atmel SOCs
Date: Tue, 21 Aug 2012 18:10:56 +0200
Message-ID: <5033B310.2020904@atmel.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com> <1345559345-13988-5-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345559345-13988-5-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/21/2012 04:29 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Add twi nodes for atmel SOCs and remove i2c-gpio ones.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Yes, we will move to it once people test it a little bit...

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 23 ++++++-------
>  arch/arm/boot/dts/at91sam9263.dtsi | 23 ++++++-------
>  arch/arm/boot/dts/at91sam9g45.dtsi | 33 +++++++++++-------
>  arch/arm/boot/dts/at91sam9n12.dtsi | 33 +++++++++++-------
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 69 +++++++++++++++++---------------------
>  5 files changed, 90 insertions(+), 91 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index f449efc..0ab7a3c 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -28,6 +28,7 @@
>  		gpio2 = &pioC;
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
> +		i2c0 = &i2c0;
>  	};
>  	cpus {
>  		cpu@0 {
> @@ -198,6 +199,15 @@
>  				status = "disabled";
>  			};
>  
> +			i2c0: i2c@fffac000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xfffac000 0x100>;
> +				interrupts = <11 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
>  			adc0: adc@fffe0000 {
>  				compatible = "atmel,at91sam9260-adc";
>  				reg = <0xfffe0000 0x100>;
> @@ -257,17 +267,4 @@
>  			status = "disabled";
>  		};
>  	};
> -
> -	i2c@0 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioA 23 0 /* sda */
> -			 &pioA 24 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
>  };
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 0209913..efb86dd 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -24,6 +24,7 @@
>  		gpio3 = &pioD;
>  		gpio4 = &pioE;
>  		tcb0 = &tcb0;
> +		i2c0 = &i2c0;
>  	};
>  	cpus {
>  		cpu@0 {
> @@ -179,6 +180,15 @@
>  				interrupts = <24 4>;
>  				status = "disabled";
>  			};
> +
> +			i2c0: i2c@fff88000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xfff88000 0x100>;
> +				interrupts = <13 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		nand0: nand@40000000 {
> @@ -204,17 +214,4 @@
>  			status = "disabled";
>  		};
>  	};
> -
> -	i2c@0 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioB 4 0 /* sda */
> -			 &pioB 5 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
>  };
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 7dbccaf..8dd3ff8 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -29,6 +29,8 @@
>  		gpio4 = &pioE;
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
>  	};
>  	cpus {
>  		cpu@0 {
> @@ -200,6 +202,24 @@
>  				status = "disabled";
>  			};
>  
> +			i2c0: i2c@fff84000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xfff84000 0x100>;
> +				interrupts = <12 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@fff88000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xfff88000 0x100>;
> +				interrupts = <13 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
>  			adc0: adc@fffb0000 {
>  				compatible = "atmel,at91sam9260-adc";
>  				reg = <0xfffb0000 0x100>;
> @@ -268,17 +288,4 @@
>  			status = "disabled";
>  		};
>  	};
> -
> -	i2c@0 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioA 20 0 /* sda */
> -			 &pioA 21 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
>  };
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index cb84de7..8a1969d 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -26,6 +26,8 @@
>  		gpio3 = &pioD;
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
>  	};
>  	cpus {
>  		cpu@0 {
> @@ -178,6 +180,24 @@
>  				atmel,use-dma-tx;
>  				status = "disabled";
>  			};
> +
> +			i2c0: i2c@f8010000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xf8010000 0x100>;
> +				interrupts = <9 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@f8014000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xf8014000 0x100>;
> +				interrupts = <10 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		nand0: nand@40000000 {
> @@ -205,17 +225,4 @@
>  			status = "disabled";
>  		};
>  	};
> -
> -	i2c@0 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioA 30 0 /* sda */
> -			 &pioA 31 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
>  };
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 6b3ef43..ec56eaf 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -27,6 +27,9 @@
>  		gpio3 = &pioD;
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
>  	};
>  	cpus {
>  		cpu@0 {
> @@ -191,6 +194,33 @@
>  				status = "disabled";
>  			};
>  
> +			i2c0: i2c@f8010000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xf8010000 0x100>;
> +				interrupts = <9 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@f8014000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xf8014000 0x100>;
> +				interrupts = <10 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@f8018000 {
> +				compatible = "atmel,at91sam9260-i2c";
> +				reg = <0xf8018000 0x100>;
> +				interrupts = <11 4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
>  			adc0: adc@f804c000 {
>  				compatible = "atmel,at91sam9260-adc";
>  				reg = <0xf804c000 0x100>;
> @@ -259,43 +289,4 @@
>  			status = "disabled";
>  		};
>  	};
> -
> -	i2c@0 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioA 30 0 /* sda */
> -			 &pioA 31 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c@1 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioC 0 0 /* sda */
> -			 &pioC 1 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c@2 {
> -		compatible = "i2c-gpio";
> -		gpios = <&pioB 4 0 /* sda */
> -			 &pioB 5 0 /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
>  };
> 


-- 
Nicolas Ferre
