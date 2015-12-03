From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 2/4] i2c: at91: update bindings documention
Date: Thu, 3 Dec 2015 11:32:01 +0100
Message-ID: <56601A21.4030900@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-4-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:30839 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759618AbbLCKbn (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 3 Dec 2015 05:31:43 -0500
In-Reply-To: <1449136434-27619-4-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, wsa@the-dreams.de, alexandre.belloni@free-electrons.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Le 03/12/2015 10:53, Ludovic Desroches a =E9crit :
> The i2c-sda-hold-time-ns property is supported from atmel,sama5d4-i2c=
=2E
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Doc=
umentation/devicetree/bindings/i2c/i2c-at91.txt
> index 6e81dc1..ef973a0 100644
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
> @@ -17,6 +17,8 @@ Optional properties:
>  - dma-names: should contain "tx" and "rx".
>  - atmel,fifo-size: maximum number of data the RX and TX FIFOs can st=
ore for FIFO
>    capable I2C controllers.
> +- i2c-sda-hold-time-ns: TWD hold time, only available for "atmel,sam=
a5d4-i2c"
> +  and "atmel,sama5d2-i2c".
>  - Child nodes conforming to i2c bus binding
> =20
>  Examples :
> @@ -52,6 +54,7 @@ i2c0: i2c@f8034600 {
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
