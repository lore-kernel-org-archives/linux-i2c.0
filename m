From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: sun6i-p2wi: Add YAML schemas
Date: Mon, 10 Jun 2019 15:34:18 -0600
Message-ID: <CAL_JsqKC7uP0J14A8_CvPhbZkoSRNWSpS1ee+Q4sG013jY=JeQ@mail.gmail.com>
References: <20190605122936.11972-1-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190605122936.11972-1-maxime.ripard@bootlin.com>
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
> ---
>  .../i2c/allwinner,sun6i-a31-p2wi.yaml         | 71 +++++++++++++++++++
>  .../bindings/i2c/i2c-sun6i-p2wi.txt           | 41 -----------
>  2 files changed, 71 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-sun6i-p2wi.txt
>
> diff --git a/Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml b/Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml
> new file mode 100644
> index 000000000000..780a33080140
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/allwinner,sun6i-a31-p2wi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A31 P2WI (Push/Pull 2 Wires Interface) Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These 2 are covered by i2c-controller.yaml, right?

> +
> +  compatible:
> +    const: allwinner,sun6i-a31-p2wi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    minimum: 1
> +    maximum: 6000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +# FIXME: We should set it, but it would report all the generic
> +# properties as additional properties.
> +# additionalProperties: false
> +
> +examples:
> +  - |
> +    p2wi@1f03400 {

i2c@...

That should fail on the schema (I need to get the schema checking of
examples finished.)

> +      compatible = "allwinner,sun6i-a31-p2wi";
> +      reg = <0x01f03400 0x400>;
> +      interrupts = <0 39 4>;
> +      clocks = <&apb0_gates 3>;
> +      clock-frequency = <6000000>;
> +      resets = <&apb0_rst 3>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      axp221: pmic@68 {
> +        compatible = "x-powers,axp221";
> +        reg = <0x68>;
> +      };
> +    };
> +
> +...
