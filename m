From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 4/4] ARM: at91/dt: sama5d2 Xplained: pmic needs a specific
 sda hold time
Date: Wed, 2 Dec 2015 12:08:16 +0100
Message-ID: <565ED120.3090603@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
 <1449052747-20991-4-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:17431 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170AbbLBLH6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Dec 2015 06:07:58 -0500
In-Reply-To: <1449052747-20991-4-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de, alexandre.belloni@free-electrons.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Le 02/12/2015 11:39, Ludovic Desroches a =E9crit :
> Data have to been hold longer for the PMIC device.

s/been/be/

It can also be interesting to know where the value comes from...


> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/b=
oot/dts/at91-sama5d2_xplained.dts
> index ad6de73..9bced00 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -129,6 +129,7 @@
>  				dmas =3D <0>, <0>;
>  				pinctrl-names =3D "default";
>  				pinctrl-0 =3D <&pinctrl_i2c0_default>;
> +				i2c-sda-hold-time-ns =3D <350>;
>  				status =3D "okay";
> =20
>  				pmic: act8865@5b {
>=20


--=20
Nicolas Ferre
