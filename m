From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: i2c-imx-hdmi: add support of iMX6 HDMI DDC I2C
 master bus
Date: Wed, 12 Nov 2014 23:44:08 +0200
Message-ID: <5463D4A8.9080206@mentor.com>
References: <1414688075-12134-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414688075-12134-1-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram, Philipp,

On 30.10.2014 18:54, Vladimir Zapolskiy wrote:
> Please review a proposed iMX6 HDMI DDC controller driver written on
> top of I2C framework.
> 
> The driver intends to support HDMI on-controller I2C master bus with
> limited cababilities, however by nature of the sub-device it seems
> reasonable to separate it into a stand-alone driver, which also can be
> used independently on general HDMI controller driver, for example as
> an additional I2C bus on a board, but please be aware that the bus is
> not compliant to I2C specification. To support the selected I2C bus
> approach, I suppose it should be possible to read/write e.g. a
> connected EEPROM device, not just HDMI EDID blobs.
> 
> In my practice I've met iMX6Q boards, where HDMI DDC lines are
> connected to iMX6 HDMI DDC pins and not to any of 3 I2C busses, so
> presence in the kernel of this driver or a driver with similar
> functionality seems to be important.
> 
> Main issues with the device/driver:
> * iMX6 HDMI controller becomes a shared device (both interrupt and
>   memory region) between HDMI driver itself and this I2C bus driver,
> * Only two patterns of I2C transactions are supported due to hardware
>   limitation, these patters are described in driver's code header.
> * The bus controller supports one more multi-byte read pattern (so
>   called Extended Read Mode), but Freescale documentation is too vague
>   to easily add this mode into the driver.
> 
> If somebody wants to test the driver, please do additional changes to
> the code:
> 
> -----8<-----8<-----8<-----8<-----8<-----
> 
> I. iMX6QDL SoC DTS:
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index c701af9..8475e12 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -916,6 +916,19 @@
>  				status = "disabled";
>  			};
>  
> +			hdmi_ddc: i2c@00120000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx6q-hdmi-ddc";
> +				reg = <0x00120000 0x8000>;
> +				interrupts-extended =
> +					<&intc 0 115 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6QDL_CLK_HDMI_IAHB>,
> +					 <&clks IMX6QDL_CLK_HDMI_ISFR>;
> +				clock-names = "iahb", "isfr";
> +				status = "disabled";
> +			};
> +
>  			i2c1: i2c@021a0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> 
> Also you may want to add an I2C alias to assign an I2C bus, iMX6Q example:
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e9f3646..e54d81e 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -14,6 +14,7 @@
>  
>  / {
>  	aliases {
> +		i2c3 = &hdmi_ddc;
>  		spi4 = &ecspi5;
>  	};
>  
> 
> II. iMX6 Board DTS (iMX6Q SabreLite example), testing with main HDMI driver:
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> index 0a36129..161593e 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> @@ -173,6 +173,18 @@
>  	status = "okay";
>  };
>  
> +&hdmi {
> +	ddc-i2c-bus = <&hdmi_ddc>;
> +	status = "okay";
> +};
> +
> +&hdmi_ddc {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi_ddc>;
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -258,6 +270,13 @@
>  			>;
>  		};
>  
> +		pinctrl_hdmi_ddc: hdmi_ddcgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__HDMI_TX_DDC_SCL    0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__HDMI_TX_DDC_SDA    0x4001b8b1
> +			>;
> +		};
> +
>  		pinctrl_i2c1: i2c1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
> 
> III. iMX6 HDMI controller driver (remove I2C bus interrupt mutes):
> 
> diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
> index 18c9ccd..1914b0b 100644
> --- a/drivers/staging/imx-drm/imx-hdmi.c
> +++ b/drivers/staging/imx-drm/imx-hdmi.c
> @@ -1342,8 +1342,6 @@ static void initialize_hdmi_ih_mutes(struct imx_hdmi *hdmi)
>  	hdmi_writeb(hdmi, 0xff, HDMI_GP_MASK);
>  	hdmi_writeb(hdmi, 0xff, HDMI_A_APIINTMSK);
>  	hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
> -	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_INT);
> -	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_CTLINT);
>  
>  	/* Disable interrupts in the IH_MUTE_* registers */
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_FC_STAT0);
> @@ -1351,7 +1349,6 @@ static void initialize_hdmi_ih_mutes(struct imx_hdmi *hdmi)
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_FC_STAT2);
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_AS_STAT0);
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_PHY_STAT0);
> -	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_I2CM_STAT0);
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_CEC_STAT0);
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_VP_STAT0);
>  	hdmi_writeb(hdmi, 0xff, HDMI_IH_MUTE_I2CMPHY_STAT0);
> 
> -----8<-----8<-----8<-----8<-----8<-----
> 
> As I mentioned above the bus driver may be used independently on
> presence/absence of iMX6 HDMI driver.
> 
> I'd appreciate to get review responses, if the selected approach based
> on I2C framework is acceptable, I'll remove RFC tag and add updates
> of all the missing parts (iMX6 DTS files, Documentation, HDMI driver
> and addressed review comments). Comments how to gracefully align this
> driver with iMX HDMI driver are welcome as well.
> 
> The patch is based and tested on 3.17, but it is cleanly applicable to
> 3.18-rc2.
> 
> Vladimir Zapolskiy (1):
>   i2c: i2c-imx-hdmi: add support of iMX6 HDMI DDC I2C master bus
> 
>  drivers/i2c/busses/Kconfig        |   13 +
>  drivers/i2c/busses/Makefile       |    1 +
>  drivers/i2c/busses/i2c-imx-hdmi.c |  485 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 499 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-imx-hdmi.c
> 

unfortunately I haven't received any comments about acceptance or
aversion of the selected approach for handling iMX6 HDMI DDC bus,
especially I was interested in DTS layout. So, I plan to resend the
proposed change for review with minor changes only, add DTS
documentation and remove RFC tag, hopefully inclusion into the next may
happen.

Please feel free to recommend any potentially interested or concerned
persons into the list of reviewers.

--
With best wishes,
Vladimir
