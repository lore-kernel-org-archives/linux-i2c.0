From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH 1/2] dt-bindings: i2c: replace property
 i2c-mux-idle-disconnect
Date: Mon, 14 Oct 2019 11:41:48 +0000
Message-ID: <DB7PR04MB44906CD36066595307E7848C8F900@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20191014112558.3881-1-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191014112558.3881-1-biwen.li@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>, "peda@axentia.se" <peda@axentia.se>, Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter, Rob

This patch is a new method for https://lore.kernel.org/patchwork/patch/1132=
445/

Best Regards,
Biwen Li
>=20
> This replaces property i2c-mux-idle-disconnect with idle-state
>=20
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index 30ac6a60f041..f2db517b1635 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -25,9 +25,7 @@ Required Properties:
>  Optional Properties:
>=20
>    - reset-gpios: Reference to the GPIO connected to the reset input.
> -  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconne=
ct
> all
> -    children in idle state. This is necessary for example, if there are =
several
> -    multiplexers on the bus and the devices behind them use same I2C
> addresses.
> +  - idle-state: Please refer to
> Documentation/devicetree/bindings/mux/mux-controller.txt
>    - interrupts: Interrupt mapping for IRQ.
>    - interrupt-controller: Marks the device node as an interrupt controll=
er.
>    - #interrupt-cells : Should be two.
> --
> 2.17.1
