From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/4] ARM: at91/dt: sama5d4: update i2c compatible string
Date: Wed, 2 Dec 2015 12:07:08 +0100
Message-ID: <565ED0DC.9010907@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
 <1449052747-20991-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:17091 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900AbbLBLGv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Dec 2015 06:06:51 -0500
In-Reply-To: <1449052747-20991-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de, alexandre.belloni@free-electrons.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Le 02/12/2015 11:39, Ludovic Desroches a =E9crit :
> A new compatible string has been introduced: atmel,sama5d4-i2c. It
> allows to use the i2c-sda-hold-time-ns property if needed.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Ok, we'll need to synchronize with Wolfram for the 2 remaining ones of
this series.


> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5=
d4.dtsi
> index 2193637..83d7e7c 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -916,7 +916,7 @@
>  			};
> =20
>  			i2c0: i2c@f8014000 {
> -				compatible =3D "atmel,at91sam9x5-i2c";
> +				compatible =3D "atmel,sama5d4-i2c";
>  				reg =3D <0xf8014000 0x4000>;
>  				interrupts =3D <32 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas =3D <&dma1
> @@ -935,7 +935,7 @@
>  			};
> =20
>  			i2c1: i2c@f8018000 {
> -				compatible =3D "atmel,at91sam9x5-i2c";
> +				compatible =3D "atmel,sama5d4-i2c";
>  				reg =3D <0xf8018000 0x4000>;
>  				interrupts =3D <33 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas =3D <&dma1
> @@ -975,7 +975,7 @@
>  			};
> =20
>  			i2c2: i2c@f8024000 {
> -				compatible =3D "atmel,at91sam9x5-i2c";
> +				compatible =3D "atmel,sama5d4-i2c";
>  				reg =3D <0xf8024000 0x4000>;
>  				interrupts =3D <34 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas =3D <&dma1
>=20


--=20
Nicolas Ferre
