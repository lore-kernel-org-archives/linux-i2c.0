From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v5 3/6] i2c: at91: update documentation for DT bindings
Date: Tue, 9 Jun 2015 18:04:54 +0200
Message-ID: <55770EA6.8020908@atmel.com>
References: <cover.1433348016.git.cyrille.pitchen@atmel.com> <aa2a1ec2bd3da46c9a3bbbe0812d82de09d66095.1433348016.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa2a1ec2bd3da46c9a3bbbe0812d82de09d66095.1433348016.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, ludovic.desroches@atmel.com, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, robh+dt@kernel.org
List-Id: linux-i2c@vger.kernel.org

Le 03/06/2015 18:25, Cyrille Pitchen a =E9crit :
> add a new value "atmel,at91sama5d2-i2c" for the "compatible" property=
=2E

Well, here I would like "atmel,sama5d2-i2c" like any other "SAMA5"
product compatibility string out there...

Aka NAK for me ;-)


> add a new optional property "atmel,fifo-size" to enable FIFO support =
when
> available.
> add missing optional properties "dmas" and "dma-names".
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 29 ++++++++++++=
++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Doc=
umentation/devicetree/bindings/i2c/i2c-at91.txt
> index 388f0a2..7c04fd9 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -2,8 +2,8 @@ I2C for Atmel platforms
> =20
>  Required properties :
>  - compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2=
c",
> -     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sa=
m9g10-i2c"
> -     or "atmel,at91sam9x5-i2c"
> +     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sa=
m9g10-i2c",
> +     "atmel,at91sam9x5-i2c" or "atmel,at91sama5d2-i2c"

Ditto

>  - reg: physical base address of the controller and length of memory =
mapped
>       region.
>  - interrupts: interrupt number to the cpu.
> @@ -13,6 +13,9 @@ Required properties :
> =20
>  Optional properties:
>  - clock-frequency: Desired I2C bus frequency in Hz, otherwise defaul=
ts to 100000
> +- dmas: A list of two dma specifiers, one for each entry in dma-name=
s.
> +- dma-names: should contain "tx" and "rx".
> +- atmel,fifo-size: size of the RX and TX FIFOs, if available.
>  - Child nodes conforming to i2c bus binding
> =20
>  Examples :
> @@ -32,3 +35,25 @@ i2c0: i2c@fff84000 {
>  		pagesize =3D <128>;
>  	}
>  }
> +
> +i2c0: i2c@f8034600 {
> +	compatible =3D "atmel,at91sama5d2-i2c";

Ditto

> +	reg =3D <0xf8034600 0x100>;
> +	interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
> +	dmas =3D <&dma0
> +		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> +		AT91_XDMAC_DT_PERID(11)>,
> +	       <&dma0
> +		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> +		AT91_XDMAC_DT_PERID(12)>;
> +	dma-names =3D "tx", "rx";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	clocks =3D <&flx0>;
> +	atmel,fifo-size =3D <32>;
> +
> +	wm8731: wm8731@1a {
> +		compatible =3D "wm8731";
> +		reg =3D <0x1a>;
> +	};
> +};
>=20


--=20
Nicolas Ferre
