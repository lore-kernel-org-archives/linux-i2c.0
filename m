From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 3/4] ARM: at91/dt: sama5d4: update i2c compatible string
Date: Thu, 3 Dec 2015 11:33:24 +0100
Message-ID: <56601A74.3040507@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-5-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449136434-27619-5-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de, alexandre.belloni@free-electrons.com
Cc: devicetree@vger.kernel.org, plagnioj@jcrosoft.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Le 03/12/2015 10:53, Ludovic Desroches a =E9crit :
> A new compatible string has been introduced: atmel,sama5d4-i2c. It
> allows to use the i2c-sda-hold-time-ns property if needed.
> =

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Wolfram, we'll take this one with us in the at91 branches that will go
into arm-soc. It'll be queued in at91-4.5-dt branch soon.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.d=
tsi
> index 2193637..83d7e7c 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -916,7 +916,7 @@
>  			};
>  =

>  			i2c0: i2c@f8014000 {
> -				compatible =3D "atmel,at91sam9x5-i2c";
> +				compatible =3D "atmel,sama5d4-i2c";
>  				reg =3D <0xf8014000 0x4000>;
>  				interrupts =3D <32 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas =3D <&dma1
> @@ -935,7 +935,7 @@
>  			};
>  =

>  			i2c1: i2c@f8018000 {
> -				compatible =3D "atmel,at91sam9x5-i2c";
> +				compatible =3D "atmel,sama5d4-i2c";
>  				reg =3D <0xf8018000 0x4000>;
>  				interrupts =3D <33 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas =3D <&dma1
> @@ -975,7 +975,7 @@
>  			};
>  =

>  			i2c2: i2c@f8024000 {
> -				compatible =3D "atmel,at91sam9x5-i2c";
> +				compatible =3D "atmel,sama5d4-i2c";
>  				reg =3D <0xf8024000 0x4000>;
>  				interrupts =3D <34 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas =3D <&dma1
> =



-- =

Nicolas Ferre
