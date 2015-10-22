From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 9/9] MIPS: BMIPS: brcmstb: add I2C node for bcm7362
Date: Wed, 21 Oct 2015 18:57:28 -0700
Message-ID: <56284288.8060505@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-10-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36202 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489AbbJVB5b (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 21:57:31 -0400
In-Reply-To: <1445395021-4204-10-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Le 20/10/2015 19:37, Jaedon Shin a =C3=A9crit :
> Add I2C device nodes to BMIPS based BCM7362 platform.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/mips/boot/dts/brcm/bcm7362.dtsi     | 52 ++++++++++++++++++++++=
++++++++--
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts | 12 ++++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dt=
s/brcm/bcm7362.dtsi
> index 6e65db86fc61..5f817be2553c 100644
> --- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
> @@ -87,14 +87,32 @@
>  			compatible =3D "brcm,bcm7120-l2-intc";
>  			reg =3D <0x406600 0x8>;
> =20
> -			brcm,int-map-mask =3D <0x44>;
> +			brcm,int-map-mask =3D <0x44>, <0x7000000>;
>  			brcm,int-fwd-mask =3D <0x70000>;
> =20
>  			interrupt-controller;
>  			#interrupt-cells =3D <1>;
> =20
>  			interrupt-parent =3D <&periph_intc>;
> -			interrupts =3D <56>;
> +			interrupts =3D <56>, <54>;
> +			interrupt-names =3D "upg_main", "upg_bsc";
> +		};
> +
> +		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
> +			compatible =3D "brcm,bcm7120-l2-intc";
> +			reg =3D <0x408b80 0x8>;
> +
> +			brcm,int-map-mask =3D <0x40>, <0x8000000>, <0x100000>;
> +			brcm,int-fwd-mask =3D <0>;
> +			brcm,irq-can-wake;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <1>;
> +
> +			interrupt-parent =3D <&periph_intc>;
> +			interrupts =3D <57>, <55>, <59>;
> +			interrupt-names =3D "upg_main_aon", "upg_bsc_aon",
> +					  "upg_spi";
>  		};
> =20
>  		sun_top_ctrl: syscon@404000 {
> @@ -144,6 +162,36 @@
>  			status =3D "disabled";
>  		};
> =20
> +		bsca: i2c@406200 {
> +		      clock-frequency =3D <390000>;
> +		      compatible =3D "brcm,brcmstb-i2c";
> +		      interrupt-parent =3D <&upg_irq0_intc>;
> +		      reg =3D <0x406200 0x58>;
> +		      interrupts =3D <24>;
> +		      interrupt-names =3D "upg_bsca";
> +		      status =3D "disabled";
> +		};
> +
> +		bscb: i2c@406280 {
> +		      clock-frequency =3D <390000>;
> +		      compatible =3D "brcm,brcmstb-i2c";
> +		      interrupt-parent =3D <&upg_irq0_intc>;
> +		      reg =3D <0x406280 0x58>;
> +		      interrupts =3D <25>;
> +		      interrupt-names =3D "upg_bscb";
> +		      status =3D "disabled";
> +		};
> +
> +		bscd: i2c@408980 {
> +		      clock-frequency =3D <390000>;
> +		      compatible =3D "brcm,brcmstb-i2c";
> +		      interrupt-parent =3D <&upg_aon_irq0_intc>;
> +		      reg =3D <0x408980 0x58>;
> +		      interrupts =3D <27>;
> +		      interrupt-names =3D "upg_bscd";
> +		      status =3D "disabled";
> +		};
> +
>  		enet0: ethernet@430000 {
>  			phy-mode =3D "internal";
>  			phy-handle =3D <&phy1>;
> diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boo=
t/dts/brcm/bcm97362svmb.dts
> index 739c2ef5663b..9c99bfd1e781 100644
> --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> @@ -29,6 +29,18 @@
>  	status =3D "okay";
>  };
> =20
> +&bsca {
> +	status =3D "okay";
> +};
> +
> +&bscb {
> +	status =3D "okay";
> +};
> +
> +&bscd {
> +	status =3D "okay";
> +};
> +
>  &enet0 {
>  	status =3D "okay";
>  };
>=20


--=20
=46lorian
