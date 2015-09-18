From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch V5] ARM: dts: imx6qdl-sabresd: add i2c pinctrl gpio state
 for bus recovery
Date: Fri, 18 Sep 2015 07:39:05 +0000
Message-ID: <CY1PR0301MB0858EFF5EA41BBD2D309AB08CF590@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <1441968155-10918-2-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441968155-10918-2-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ping...
From: Gao Pan <mailto:b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org> Sent: Friday, September 11, 2015 6:43 PM
> To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org;
> shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Duan Fugang-B38611; Gao
> Pan-B54642; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: [Patch V5] ARM: dts: imx6qdl-sabresd: add i2c pinctrl gpio state
> for bus recovery
> 
> When i2c bus SCL/SDA are stuck low during transfer, the i2c pinctrl
> should be configured to gpio mode to do bus recovery.
> 
> Genenally, we can use sleep state for bus recovery. But it's not a good
> choice to use sleep state here because it will be confused. This patch
> introduces a dedicated gpio state.
> 
> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 944eb81..6e97018 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -172,8 +172,11 @@
> 
>  &i2c1 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	scl-gpios = <&gpio5 26 0>;
> +	sda-gpios = <&gpio5 27 0>;
>  	status = "okay";
> 
>  	codec: wm8962@1a {
> @@ -393,6 +396,13 @@
>  			>;
>  		};
> 
> +		pinctrl_i2c1_gpio: i2c1grp_gpio {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26        0x1b0b0
> +				MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27        0x1b0b0
> +			>
> +		};
> +
>  		pinctrl_i2c2: i2c2grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
> --
> 1.9.1
