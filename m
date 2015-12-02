From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: at91: update bindings documention
Date: Wed, 2 Dec 2015 12:04:18 +0100
Message-ID: <565ED032.5040306@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
 <1449052747-20991-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449052747-20991-2-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Le 02/12/2015 11:39, Ludovic Desroches a =E9crit :
> The i2c-sda-hold-time-ns property is supported from atmel,sama5d4-i2c=
=2E
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Doc=
umentation/devicetree/bindings/i2c/i2c-at91.txt
> index 6e81dc1..67c6f2e 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -3,7 +3,7 @@ I2C for Atmel platforms
>  Required properties :
>  - compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2=
c",
>       "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sa=
m9g10-i2c",
> -     "atmel,at91sam9x5-i2c" or "atmel,sama5d2-i2c"
> +     "atmel,at91sam9x5-i2c", "atmel,sama5d4-i2c" or "atmel,sama5d2-i=
2c"
>  - reg: physical base address of the controller and length of memory =
mapped
>       region.
>  - interrupts: interrupt number to the cpu.
> @@ -17,6 +17,7 @@ Optional properties:
>  - dma-names: should contain "tx" and "rx".
>  - atmel,fifo-size: maximum number of data the RX and TX FIFOs can st=
ore for FIFO
>    capable I2C controllers.
> +- i2c-sda-hold-time-ns: TWD hold time, only available from "atmel,sa=
ma5d4-i2c".

Yep, but you must make it clearer that sama5d2 also has this property
available: people usually don't know that sama5d2 comes after sama5d4
over time...

Bye,

>  - Child nodes conforming to i2c bus binding
> =20
>  Examples :
> @@ -52,6 +53,7 @@ i2c0: i2c@f8034600 {
>  	#size-cells =3D <0>;
>  	clocks =3D <&flx0>;
>  	atmel,fifo-size =3D <16>;
> +	i2c-sda-hold-time-ns =3D <336>;
> =20
>  	wm8731: wm8731@1a {
>  		compatible =3D "wm8731";
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
