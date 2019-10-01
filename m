From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: at24: convert the binding document
 to yaml
Date: Tue, 1 Oct 2019 08:37:41 -0500
Message-ID: <20191001133741.GA3357@bogus>
References: <20190930085957.2779-1-brgl@bgdev.pl>
 <20190930085957.2779-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190930085957.2779-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 30, 2019 at 10:59:56AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for at24 EEPROMs from txt to yaml. The
> compatible property uses a regex pattern to address all the possible
> combinations of "vendor,model" strings.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> [robh: rework compatible schema, fix missing allOf for $ref, fix errors in example]
> Signed-off-by: Rob Herring <robh@kernel.org>
> [Bartosz: added comments explaining the compatible property]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/eeprom/at24.txt       |  90 +--------
>  .../devicetree/bindings/eeprom/at24.yaml      | 179 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 181 insertions(+), 90 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml


> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> new file mode 100644
> index 000000000000..aee0890d3b7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -0,0 +1,179 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright 2019 BayLibre SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/eeprom/at24.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: I2C EEPROMs compatible with Atmel's AT24
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^eeprom@[0-9a-f]{1,2}$"
> +
> +  # There are multiple known vendors who manufacture EEPROM chips compatible
> +  # with Atmel's AT24. The compatible string requires either a single item
> +  # if the memory comes from Atmel (in which case the vendor part must be
> +  # 'atmel') or two items with the same 'model' part where the vendor part of
> +  # the first one is the actual manufacturer and the second item is the
> +  # corresponding 'atmel,<model>' from Atmel.
> +  #
> +  # While the below schema would technically allow the following:
> +  #
> +  #     compatible = "atmel,24c01", "atmel,24c01";

This is prevented in the common 'compatible' schema that requires unique 
items.

> +  #
> +  # this obviously must not be used.
> +  compatible:
> +    oneOf:
> +      - allOf:
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              - pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|mac)[0-9]+|spd)$"
> +              - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
> +          - oneOf:
> +              - items:
> +                  pattern: c00$
> +              - items:
> +                  pattern: c01$
> +              - items:
> +                  pattern: c02$
> +              - items:
> +                  pattern: c04$
> +              - items:
> +                  pattern: c08$

Need to add the 'cs' variants I missed.

> +              - items:
> +                  pattern: c16$
> +              - items:
> +                  pattern: cs16$
> +              - items:
> +                  pattern: c32$
> +              - items:
> +                  pattern: cs32$
> +              - items:
> +                  pattern: c64$
> +              - items:
> +                  pattern: cs64$
> +              - items:
> +                  pattern: c128$
> +              - items:
> +                  pattern: cs128$
> +              - items:
> +                  pattern: c256$
> +              - items:
> +                  pattern: cs256$
> +              - items:
> +                  pattern: c512$
> +              - items:
> +                  pattern: cs512$
> +              - items:
> +                  pattern: c1024$
> +              - items:
> +                  pattern: cs1024$
> +              - items:
> +                  pattern: c2048$
> +              - items:
> +                  pattern: cs2048$
> +              - items:
> +                  pattern: spd$
> +      # These are special cases that don't conform to the above pattern.
> +      # Each requires a standard at24 model as fallback.
> +      - items:
> +          - const: rohm,br24t01
> +          - const: atmel,24c01
> +      - items:
> +          - const: nxp,se97b
> +          - const: atmel,24c02
> +      - items:
> +          - const: renesas,r1ex24002
> +          - const: atmel,24c02
> +      - items:
> +          - const: renesas,r1ex24016
> +          - const: atmel,24c16
> +      - items:
> +          - const: renesas,r1ex24128
> +          - const: atmel,24c128
> +
> +  reg:
> +    maxItems: 1
> +
> +  pagesize:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The length of the pagesize for writing. Please consult the
> +      manual of your device, that value varies a lot. A wrong value
> +      may result in data loss! If not specified, a safety value of
> +      '1' is used which will be very slow.
> +    enum: [ 1, 8, 16, 32, 64, 128, 258 ]
> +    default: 1
> +
> +  read-only:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      Disables writes to the eeprom.
> +
> +  size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Total eeprom size in bytes.
> +
> +  no-read-rollover:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      Indicates that the multi-address eeprom does not automatically roll
> +      over reads to the next slave address. Please consult the manual of
> +      your device.
> +
> +  wp-gpios:
> +    description:
> +      GPIO to which the write-protect pin of the chip is connected.
> +    maxItems: 1
> +
> +  address-width:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Number of address bits.
> +    default: 8
> +    enum: [ 8, 16 ]
> +
> +  num-addresses:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Total number of i2c slave addresses this device takes.
> +    default: 1
> +    minimum: 1
> +    maximum: 8
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      eeprom@52 {
> +          compatible = "microchip,24c32", "atmel,24c32";
> +          reg = <0x52>;
> +          pagesize = <32>;
> +          wp-gpios = <&gpio1 3 0>;
> +          num-addresses = <8>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..320fc8bba872 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2699,7 +2699,7 @@ M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
>  L:	linux-i2c@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/eeprom/at24.txt
> +F:	Documentation/devicetree/bindings/eeprom/at24.yaml
>  F:	drivers/misc/eeprom/at24.c
>  
>  ATA OVER ETHERNET (AOE) DRIVER
> -- 
> 2.23.0
> 
