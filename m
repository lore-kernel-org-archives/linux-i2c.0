From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: STi: Supply I2C configuration to STiH416 SoC
Date: Wed, 18 Sep 2013 13:03:40 +0100
Message-ID: <20130918120340.GF16984@lee--X1>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-3-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379498483-4236-3-git-send-email-maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stephen.gallimore-qxv4g6HH51o@public.gmane.org, stuart.menefy-qxv4g6HH51o@public.gmane.org, gabriel.fernandez-qxv4g6HH51o@public.gmane.org, olivier.clergeaud-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> This patch supplies I2C configuration to STiH416 SoC.
>=20
> Cc: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
> ---
>  arch/arm/boot/dts/stih416-pinctrl.dtsi |   35 ++++++++++++++++++++
>  arch/arm/boot/dts/stih416.dtsi         |   57 ++++++++++++++++++++++=
++++++++++
>  2 files changed, 92 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/d=
ts/stih416-pinctrl.dtsi

I genuinely don't know the answer to this question, but are these
nodes identical to the ones you've just put in the stih415 DTSI file?
If so, I think it will be worth creating a stih41x DTSI rather than
duplicating lots of stuff unnecessarily.

> index 0f246c9..b29ff4b 100644
> --- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
> @@ -97,6 +97,24 @@
>  					};
>  				};
>  			};
> +
> +			sbc_i2c0 {
> +				pinctrl_sbc_i2c0_default: sbc_i2c0-default {
> +					st,pins {
> +						sda =3D <&PIO4 6 ALT1 BIDIR>;
> +						scl =3D <&PIO4 5 ALT1 BIDIR>;
> +					};
> +				};
> +			};
> +
> +			sbc_i2c1 {
> +				pinctrl_sbc_i2c1_default: sbc_i2c1-default {
> +					st,pins {
> +						sda =3D <&PIO3 2 ALT2 BIDIR>;
> +						scl =3D <&PIO3 1 ALT2 BIDIR>;
> +					};
> +				};
> +			};
>  		};
> =20
>  		pin-controller-front {
> @@ -175,6 +193,23 @@
>  				};
>  			};
> =20
> +			i2c0 {
> +				pinctrl_i2c0_default: i2c0-default {
> +					st,pins {
> +						sda =3D <&PIO9 3 ALT1 BIDIR>;
> +						scl =3D <&PIO9 2 ALT1 BIDIR>;
> +					};
> +				};
> +			};
> +
> +			i2c1 {
> +				pinctrl_i2c1_default: i2c1-default {
> +					st,pins {
> +						sda =3D <&PIO12 1 ALT1 BIDIR>;
> +						scl =3D <&PIO12 0 ALT1 BIDIR>;
> +					};
> +				};
> +			};
>  		};
> =20
>  		pin-controller-rear {
> diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih4=
16.dtsi
> index 1a0326e..8856470 100644
> --- a/arch/arm/boot/dts/stih416.dtsi
> +++ b/arch/arm/boot/dts/stih416.dtsi
> @@ -9,6 +9,7 @@
>  #include "stih41x.dtsi"
>  #include "stih416-clock.dtsi"
>  #include "stih416-pinctrl.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  / {
>  	L2: cache-controller {
>  		compatible =3D "arm,pl310-cache";
> @@ -92,5 +93,61 @@
>  			pinctrl-0 	=3D <&pinctrl_sbc_serial1>;
>  			clocks          =3D <&CLK_SYSIN>;
>  		};
> +
> +		i2c0: i2c@fed40000{

Same issues here. I assume most of this is copy paste.

> +			compatible	=3D "st,comms-i2c";
> +			status		=3D "disabled";
> +			reg		=3D <0xfed40000 0x110>;
> +			interrupts	=3D  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +			clocks		=3D <&CLK_S_ICN_REG_0>;
> +			clock-frequency =3D <400000>;
> +			pinctrl-names	=3D "default";
> +			pinctrl-0	=3D <&pinctrl_i2c0_default>;
> +			st,glitches;
> +			st,glitch-clk	=3D <500>;
> +			st,glitch-dat	=3D <500>;
> +		};
> +
> +		i2c1: i2c@fed41000{
> +			compatible	=3D "st,comms-i2c";
> +			status		=3D "disabled";
> +			reg		=3D <0xfed41000 0x110>;
> +			interrupts	=3D  <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
> +			clocks		=3D <&CLK_S_ICN_REG_0>;
> +			clock-frequency =3D <400000>;
> +			pinctrl-names	=3D "default";
> +			pinctrl-0	=3D <&pinctrl_i2c1_default>;
> +			st,glitches;
> +			st,glitch-clk	=3D <500>;
> +			st,glitch-dat	=3D <500>;
> +		};
> +
> +		sbc_i2c0: i2c@fe540000{
> +			compatible	=3D "st,comms-i2c";
> +			status		=3D "disabled";
> +			reg		=3D <0xfe540000 0x110>;
> +			interrupts	=3D  <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>;
> +			clocks		=3D <&CLK_SYSIN>;
> +			clock-frequency =3D <400000>;
> +			pinctrl-names	=3D "default";
> +			pinctrl-0	=3D <&pinctrl_sbc_i2c0_default>;
> +			st,glitches;
> +			st,glitch-clk	=3D <500>;
> +			st,glitch-dat	=3D <500>;
> +		};
> +
> +		sbc_i2c1: i2c@fe541000{
> +			compatible	=3D "st,comms-i2c";
> +			status		=3D "disabled";
> +			reg		=3D <0xfe541000 0x110>;
> +			interrupts	=3D  <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>;
> +			clocks		=3D <&CLK_SYSIN>;
> +			clock-frequency =3D <400000>;
> +			pinctrl-names	=3D "default";
> +			pinctrl-0	=3D <&pinctrl_sbc_i2c1_default>;
> +			st,glitches;
> +			st,glitch-clk	=3D <500>;
> +			st,glitch-dat	=3D <500>;
> +		};
>  	};
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
