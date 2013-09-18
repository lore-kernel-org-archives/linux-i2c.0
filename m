From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] ARM: STi: Add I2C config to B2000 and B2020 boards
Date: Wed, 18 Sep 2013 12:40:32 +0100
Message-ID: <20130918114032.GD16984@lee--X1>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-5-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379498483-4236-5-git-send-email-maxime.coquelin@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Maxime COQUELIN <maxime.coquelin@st.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, srinivas.kandagatla@st.com, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, stephen.gallimore@st.com, stuart.menefy@st.com, gabriel.fernandez@st.com, olivier.clergeaud@st.com
List-Id: linux-i2c@vger.kernel.org

On Wed, 18 Sep 2013, Maxime COQUELIN wrote:

> This patch supplies I2C configuration to B2000 and B2020
> based on either STiH415 or STiH416 SoCs.
>=20
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/stih41x-b2000.dtsi |    7 +++++++
>  arch/arm/boot/dts/stih41x-b2020.dtsi |   20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts=
/stih41x-b2000.dtsi
> index 8e694d2..346cc4bc 100644
> --- a/arch/arm/boot/dts/stih41x-b2000.dtsi
> +++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
> @@ -37,5 +37,12 @@
>  			};
>  		};
> =20
> +		/* HDMI Tx I2C */
> +		i2c1: i2c@fed41000{

nit: Space before the '{'

> +			status =3D "okay";

Consider enabling the node at the bottom.

> +
> +			/* HDMI V1.3a supports Standard mode only */
> +			clock-frequency =3D <100000>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts=
/stih41x-b2020.dtsi
> index 133e181..10b98da 100644
> --- a/arch/arm/boot/dts/stih41x-b2020.dtsi
> +++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
> @@ -38,5 +38,25 @@
>  				default-state =3D "off";
>  			};
>  		};
> +
> +		i2c0: i2c@fed40000{

As above.

> +			status =3D "okay";
> +		};
> +
> +		/* HDMI Tx I2C */
> +		i2c1: i2c@fed41000{

As above.

> +			status =3D "okay";

As above.

> +			/* HDMI V1.3a supports Standard mode only */
> +			clock-frequency =3D <100000>;
> +		};
> +
> +		sbc_i2c0: i2c@fe540000{

As above.

> +			status =3D "okay";
> +		};
> +
> +		sbc_i2c1: i2c@fe541000{

Are these nodes referenced by phandle at all?

If not, consider dropping the <lable>:s

> +			status =3D "okay";
> +		};
>  	};
>  };

Odd tabbing here.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
