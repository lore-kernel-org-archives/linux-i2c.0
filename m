From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: i2c: at91: document optional bus
 recovery properties
Date: Mon, 27 Jan 2020 09:49:24 +0100
Message-ID: <20200127084924.4iflicf64pzzhouq@M43218.corp.atmel.com>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-2-codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 15, 2020 at 01:54:17PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> 
> The at91 I2C controller can support bus recovery by re-assigning SCL
> and SDA to gpios. Add the optional pinctrl and gpio properties to do
> so.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> [codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org: rebased]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

> ---
> 
> Changes in v3:
>  - rebased;
>  - added Reviewed-by tag from Rob;
> 
> Changes in v2:
>  - none;
> 
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> index d4bad86107b8..96c914e048f5 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -28,8 +28,13 @@ Optional properties:
>  	"atmel,sama5d4-i2c",
>  	"atmel,sama5d2-i2c",
>  	"microchip,sam9x60-i2c".
> +- scl-gpios: specify the gpio related to SCL pin
> +- sda-gpios: specify the gpio related to SDA pin
> +- pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
> +  bus recovery, call it "gpio" state
>  - Child nodes conforming to i2c bus binding
>  
> +
>  Examples :
>  
>  i2c0: i2c@fff84000 {
> @@ -64,6 +69,11 @@ i2c0: i2c@f8034600 {
>  	clocks = <&flx0>;
>  	atmel,fifo-size = <16>;
>  	i2c-sda-hold-time-ns = <336>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c0>;
> +	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +	sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
>  
>  	wm8731: wm8731@1a {
>  		compatible = "wm8731";
> -- 
> 2.20.1
> 
