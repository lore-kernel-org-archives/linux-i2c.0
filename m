From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: mv64xxx: Add YAML schemas
Date: Mon, 10 Jun 2019 15:37:17 -0600
Message-ID: <CAL_JsqJczoTpq=8BS5FwL3TJmitZp9e4Mh4oXcvgOMdRmoURvQ@mail.gmail.com>
References: <20190605122936.11972-1-maxime.ripard@bootlin.com>
 <20190605122936.11972-2-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190605122936.11972-2-maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Gregory Clement <gregory.clement@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Linux I2C <linux-i2c@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 5, 2019 at 6:29 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - Fix the maintainers
> ---
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt   |  64 -----------
>  .../bindings/i2c/marvell,mv64xxx-i2c.yaml     | 105 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml

> diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
> new file mode 100644
> index 000000000000..a1c631eaeafd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/marvell,mv64xxx-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MV64XXX I2C Controller Device Tree Bindings
> +
> +maintainers:
> +  - Gregory CLEMENT <gregory.clement@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun4i-a10-i2c
> +      - items:
> +          - const: allwinner,sun7i-a20-i2c
> +          - const: allwinner,sun4i-a10-i2c
> +      - const: allwinner,sun6i-a31-i2c
> +      - items:
> +          - const: allwinner,sun8i-a23-i2c
> +          - const: allwinner,sun6i-a31-i2c
> +      - items:
> +          - const: allwinner,sun8i-a83t-i2c
> +          - const: allwinner,sun6i-a31-i2c
> +      - items:
> +          - const: allwinner,sun50i-a64-i2c
> +          - const: allwinner,sun6i-a31-i2c
> +
> +      - const: marvell,mv64xxx-i2c
> +      - const: marvell,mv78230-i2c
> +      - const: marvell,mv78230-a0-i2c
> +
> +    description:
> +      Only use "marvell,mv78230-a0-i2c" for a very rare, initial
> +      version of the SoC which had broken offload support. Linux
> +      auto-detects this and sets it appropriately.
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Reference clock for the I2C bus
> +      - description: Bus clock (Only for Armada 7K/8K)
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: core
> +      - const: reg
> +    description:
> +      Mandatory if two clocks are used (only for Armada 7k and 8k).
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun4i-a10-i2c
> +              - allwinner,sun6i-a31-i2c
> +
> +    then:
> +      required:
> +        - clocks
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun6i-a31-i2c
> +
> +    then:
> +      required:
> +        - resets
> +
> +# FIXME: We should set it, but it would report all the generic
> +# properties as additional properties.
> +# additionalProperties: false
> +
> +examples:
> +  - |
> +    timer {

timer?

(and missing unit-address)

> +      compatible = "allwinner,sun4i-a10-timer";
> +      reg = <0x01c20c00 0x400>;
> +      interrupts = <22>;
> +      clocks = <&osc>;
> +    };
> +...
> --
> 2.21.0
>
