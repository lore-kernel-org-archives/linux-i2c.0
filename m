From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] dt-bindings: i2c: Replace DW I2C legacy bindings
 with YAML-based one
Date: Thu, 12 Mar 2020 16:43:08 -0500
Message-ID: <20200312214308.GA17405@bogus>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132011.66A7A80307C4@mail.baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200306132011.66A7A80307C4-wa7pjkrhtJ0iPEH9HxOKe7DSMK2IXMYWh13vi7wywA4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 06, 2020 at 04:19:51PM +0300, Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org wrote:
> From: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
> 
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces Synopsys DW I2C
> legacy bare text bindings with YAML file. As before the bindings file
> states that the corresponding dts node is supposed to be compatible
> either with generic DW I2C controller or with Microsemi Ocelot SoC I2C
> one, to have registers, interrupts and clocks properties. In addition
> the node may have clock-frequency, i2c-sda-hold-time-ns,
> i2c-scl-falling-time-ns and i2c-sda-falling-time-ns optional properties.
> 
> Signed-off-by: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
> Signed-off-by: Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
> Cc: Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>
> Cc: Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> ---
>  .../bindings/i2c/i2c-designware.txt           |  73 --------
>  .../bindings/i2c/snps,designware-i2c.yaml     | 156 ++++++++++++++++++
>  2 files changed, 156 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> deleted file mode 100644
> index 08be4d3846e5..000000000000
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -* Synopsys DesignWare I2C
> -
> -Required properties :
> -
> - - compatible : should be "snps,designware-i2c"
> -                or "mscc,ocelot-i2c" with "snps,designware-i2c" for fallback
> - - reg : Offset and length of the register set for the device
> - - interrupts : <IRQ> where IRQ is the interrupt number.
> - - clocks : phandles for the clocks, see the description of clock-names below.
> -   The phandle for the "ic_clk" clock is required. The phandle for the "pclk"
> -   clock is optional. If a single clock is specified but no clock-name, it is
> -   the "ic_clk" clock. If both clocks are listed, the "ic_clk" must be first.
> -
> -Recommended properties :
> -
> - - clock-frequency : desired I2C bus clock frequency in Hz.
> -
> -Optional properties :
> -
> - - clock-names : Contains the names of the clocks:
> -    "ic_clk", for the core clock used to generate the external I2C clock.
> -    "pclk", the interface clock, required for register access.
> -
> - - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
> -   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> -
> - - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
> -   This option is only supported in hardware blocks version 1.11a or newer and
> -   on Microsemi SoCs ("mscc,ocelot-i2c" compatible).
> -
> - - i2c-scl-falling-time-ns : should contain the SCL falling time in nanoseconds.
> -   This value which is by default 300ns is used to compute the tLOW period.
> -
> - - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
> -   This value which is by default 300ns is used to compute the tHIGH period.
> -
> -Examples :
> -
> -	i2c@f0000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "snps,designware-i2c";
> -		reg = <0xf0000 0x1000>;
> -		interrupts = <11>;
> -		clock-frequency = <400000>;
> -	};
> -
> -	i2c@1120000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "snps,designware-i2c";
> -		reg = <0x1120000 0x1000>;
> -		interrupt-parent = <&ictl>;
> -		interrupts = <12 1>;
> -		clock-frequency = <400000>;
> -		i2c-sda-hold-time-ns = <300>;
> -		i2c-sda-falling-time-ns = <300>;
> -		i2c-scl-falling-time-ns = <300>;
> -	};
> -
> -	i2c@1120000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0x2000 0x100>;
> -		clock-frequency = <400000>;
> -		clocks = <&i2cclk>;
> -		interrupts = <0>;
> -
> -		eeprom@64 {
> -			compatible = "linux,slave-24c02";
> -			reg = <0x40000064>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> new file mode 100644
> index 000000000000..3f348f1ce172
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/snps,designware-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare APB I2C Device Tree Bindings
> +
> +maintainers:
> +  - Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: mscc,ocelot-i2c
> +then:
> +  properties:
> +    reg:
> +      minItems: 1
> +      items:
> +        - description: DW APB I2C controller memory mapped registers.
> +        - description: ICPU_CFG:TWI_DELAY registers to setup the SDA hold time.

This won't work (it would be good to have an example that exercises 
this). You need to move this definition to the main 'reg' definition 
below and then do:

if:
  properties:
    compatible:
      not:
        contains:
          const: mscc,ocelot-i2c
then:
  properties:
    reg:
      maxItems: 1

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Generic Synopsys DesignWare I2C controller.
> +        const: snps,designware-i2c
> +      - description: Microsemi Ocelot SoCs I2C controller.
> +        items:
> +          - const: mscc,ocelot-i2c
> +          - const: snps,designware-i2c
> +
> +  reg:
> +    items:
> +      - description: DW APB I2C controller memory mapped registers.
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: I2C controller reference clock source.
> +      - description: APB interface clock source.
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: Desired I2C bus clock frequency in Hz.
> +    enum: [100000, 400000, 1000000, 3400000]
> +    default: 400000
> +
> +  i2c-sda-hold-time-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Anything with a unit suffix has a type, so you can drop this.

> +    description: |
> +      The property should contain the SDA hold time in nanoseconds. This option
> +      is only supported in hardware blocks version 1.11a or newer or on
> +      Microsemi SoCs.
> +
> +  i2c-scl-falling-time-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The property should contain the SCL falling time in nanoseconds.
> +      This value is used to compute the tLOW period.
> +    default: 300
> +
> +  i2c-sda-falling-time-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The property should contain the SDA falling time in nanoseconds.
> +      This value is used to compute the tHIGH period.
> +    default: 300
> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel.
> +      - description: RX DMA Channel.
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +

> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1

No need for this as i2c-controller.yaml does this.

> +
> +additionalProperties: false

This doesn't work with i2c-controller.yaml. Change it to 
'unevaluatedProperties: false' and eventually that will do what we need.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - interrupts
> +
> +examples:
> +  - |
> +    i2c@f0000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "snps,designware-i2c";
> +      reg = <0xf0000 0x1000>;
> +      interrupts = <11>;
> +      clock-frequency = <400000>;
> +    };
> +
> +  - |
> +    i2c@1120000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "snps,designware-i2c";
> +      reg = <0x1120000 0x1000>;
> +      interrupt-parent = <&ictl>;
> +      interrupts = <12 1>;
> +      clock-frequency = <400000>;
> +      i2c-sda-hold-time-ns = <300>;
> +      i2c-sda-falling-time-ns = <300>;
> +      i2c-scl-falling-time-ns = <300>;
> +    };
> +
> +  - |
> +    i2c@1120000 {
> +      compatible = "snps,designware-i2c";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0x2000 0x100>;
> +      clock-frequency = <400000>;
> +      clocks = <&i2cclk>;
> +      interrupts = <0>;
> +
> +      eeprom@64 {
> +        compatible = "linux,slave-24c02";
> +        reg = <0x40000064>;
> +      };
> +    };
> +...
> -- 
> 2.25.1
> 
