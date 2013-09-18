From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] ARM: STi: Supply I2C configuration to STiH415 SoC
Date: Wed, 18 Sep 2013 13:00:12 +0100
Message-ID: <20130918120012.GE16984@lee--X1>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-4-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379498483-4236-4-git-send-email-maxime.coquelin@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Maxime COQUELIN <maxime.coquelin@st.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, srinivas.kandagatla@st.com, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, stephen.gallimore@st.com, stuart.menefy@st.com, gabriel.fernandez@st.com, olivier.clergeaud@st.com
List-Id: linux-i2c@vger.kernel.org

On Wed, 18 Sep 2013, Maxime COQUELIN wrote:

> This patch supplies I2C configuration to STiH415 SoC.
>=20
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/stih415-pinctrl.dtsi |   36 ++++++++++++++++++++
>  arch/arm/boot/dts/stih415.dtsi         |   57 ++++++++++++++++++++++=
++++++++++
>  2 files changed, 93 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/d=
ts/stih415-pinctrl.dtsi
> index 1d322b2..e56449d 100644
> --- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
> @@ -86,6 +86,24 @@
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
> @@ -143,6 +161,24 @@
>  				reg		=3D <0x7000 0x100>;
>  				st,bank-name	=3D "PIO12";
>  			};
> +
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
> diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih4=
15.dtsi
> index 74ab8de..643ae1c 100644
> --- a/arch/arm/boot/dts/stih415.dtsi
> +++ b/arch/arm/boot/dts/stih415.dtsi
> @@ -9,6 +9,7 @@
>  #include "stih41x.dtsi"
>  #include "stih415-clock.dtsi"
>  #include "stih415-pinctrl.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  / {
> =20
>  	L2: cache-controller {
> @@ -83,5 +84,61 @@
>  			pinctrl-names 	=3D "default";
>  			pinctrl-0	=3D <&pinctrl_sbc_serial1>;
>  		};
> +
> +		i2c0: i2c@fed40000{

Space before the '{'.

> +			compatible	=3D "st,comms-i2c";
> +			status		=3D "disabled";

Consider putting the node status at the bottom.

> +			reg		=3D <0xfed40000 0x110>;
> +			interrupts	=3D  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +			clocks		=3D <&CLKS_ICN_REG_0>;
> +			clock-frequency =3D <400000>;
> +			pinctrl-names	=3D "default";
> +			pinctrl-0	=3D <&pinctrl_i2c0_default>;
> +			st,glitches;
> +			st,glitch-clk	=3D <500>;
> +			st,glitch-dat	=3D <500>;
> +		};
> +
> +		i2c1: i2c@fed41000{

Same here and throughout.

> +			compatible	=3D "st,comms-i2c";
> +			status		=3D "disabled";

Same here and throughout.

> +			reg		=3D <0xfed41000 0x110>;
> +			interrupts	=3D  <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
> +			clocks		=3D <&CLKS_ICN_REG_0>;
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

Is this odd tabbing just the result of the patch format?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
