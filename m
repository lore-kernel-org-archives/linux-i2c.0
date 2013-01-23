From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx51-babbage: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 08:30:59 +0100
Message-ID: <20130123073059.GP1906@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <1358922764-31654-2-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358922764-31654-2-git-send-email-Ying.Liu@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, w.sang@pengutronix.de, shawn.guo@linaro.org, linus.walleij@linaro.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, liu.y.victor@gmail.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 23, 2013 at 02:32:44PM +0800, Liu Ying wrote:
> This patch adds at24c512b i2c device to the device tree
> along with the necessary i2c device node and pinctrl
> settings for i2c bus.
> The eeprom chip is populated on the accessory board of
> the imx51-babbage board.

Given that it's optional should the binding be here anyway? I don't have
this accessory board and this may conflict with the boards other people
have connected on this port.

Sascha

> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts |   12 ++++++++++++
>  arch/arm/boot/dts/imx51.dtsi        |    9 +++++++++
>  2 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 567e7ee..4f0fc75 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -241,6 +241,18 @@
>  				};
>  			};
>  
> +			i2c@83fc8000 { /* I2C1 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c1_1>;
> +				status = "okay";
> +
> +				at24@50 {
> +					compatible = "at24,24c512b";
> +					pagesize = <128>;
> +					reg = <0x50>;
> +				};
> +			};
> +
>  			audmux@83fd0000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_audmux_1>;
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 1f5d45e..6495c69 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -311,6 +311,15 @@
>  					};
>  				};
>  
> +				i2c1 {
> +					pinctrl_i2c1_1: i2c1grp-1 {
> +						fsl,pins = <
> +							4  0x400001ed	/* MX51_PAD_EIM_D16__I2C1_SDA */
> +							23 0x400001ed	/* MX51_PAD_EIM_D19__I2C1_SCL */
> +						>;
> +					};
> +				};
> +
>  				i2c2 {
>  					pinctrl_i2c2_1: i2c2grp-1 {
>  						fsl,pins = <
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
