From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 4/4] ARM: at91/dt: sama5d2 Xplained: pmic needs a
 specific sda hold time
Date: Thu, 3 Dec 2015 11:34:08 +0100
Message-ID: <56601AA0.5020201@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-6-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449136434-27619-6-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de, alexandre.belloni@free-electrons.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Le 03/12/2015 10:53, Ludovic Desroches a =E9crit :
> Data have to be held longer for the PMIC device. The ACT8945A
> datasheet claims that minimum SDA data hold time is about 300 ns.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Same here, we'll take this one with at91 material in at91-4.5-dt branch
soon.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

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
