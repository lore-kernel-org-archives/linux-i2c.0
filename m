From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] dt-bindings: at24: convert the binding document to yaml
Date: Mon, 23 Sep 2019 20:34:46 +0200
Message-ID: <CAMRc=MfEtSg9eABT5Zb=KQWqXn4BiWxC9eTibSSMAOnHMw8DGQ@mail.gmail.com>
References: <20190923175211.2060-1-brgl@bgdev.pl> <b3a3ca68-45ab-c60a-7f48-636b102b32c1@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b3a3ca68-45ab-c60a-7f48-636b102b32c1@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

pon., 23 wrz 2019 o 20:30 Peter Rosin <peda@axentia.se> napisa=C5=82(a):
>
> On 2019-09-23 19:52, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for at24 EEPROMs from txt to yaml. The
> > compatible property uses a regex pattern to address all the possible
> > combinations of "vendor,model" strings.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../devicetree/bindings/eeprom/at24.txt       |  90 +--------------
> >  .../devicetree/bindings/eeprom/at24.yaml      | 107 ++++++++++++++++++
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 109 insertions(+), 90 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Docume=
ntation/devicetree/bindings/eeprom/at24.txt
> > index 22aead844d0f..c94acbb8cb0c 100644
> > --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> > @@ -1,89 +1 @@
> > -EEPROMs (I2C)
> > -
> > -Required properties:
> > -
> > -  - compatible: Must be a "<manufacturer>,<model>" pair. The following=
 <model>
> > -                values are supported (assuming "atmel" as manufacturer=
):
> > -
> > -                "atmel,24c00",
> > -                "atmel,24c01",
> > -                "atmel,24cs01",
> > -                "atmel,24c02",
> > -                "atmel,24cs02",
> > -                "atmel,24mac402",
> > -                "atmel,24mac602",
> > -                "atmel,spd",
> > -                "atmel,24c04",
> > -                "atmel,24cs04",
> > -                "atmel,24c08",
> > -                "atmel,24cs08",
> > -                "atmel,24c16",
> > -                "atmel,24cs16",
> > -                "atmel,24c32",
> > -                "atmel,24cs32",
> > -                "atmel,24c64",
> > -                "atmel,24cs64",
> > -                "atmel,24c128",
> > -                "atmel,24c256",
> > -                "atmel,24c512",
> > -                "atmel,24c1024",
> > -                "atmel,24c2048",
> > -
> > -                If <manufacturer> is not "atmel", then a fallback must=
 be used
> > -                with the same <model> and "atmel" as manufacturer.
> > -
> > -                Example:
> > -                        compatible =3D "microchip,24c128", "atmel,24c1=
28";
> > -
> > -                Supported manufacturers are:
> > -
> > -                "catalyst",
> > -                "microchip",
> > -                "nxp",
> > -                "ramtron",
> > -                "renesas",
> > -                "rohm",
> > -                "st",
> > -
> > -                Some vendors use different model names for chips which=
 are just
> > -                variants of the above. Known such exceptions are liste=
d below:
> > -
> > -                "nxp,se97b" - the fallback is "atmel,24c02",
> > -                "renesas,r1ex24002" - the fallback is "atmel,24c02"
> > -                "renesas,r1ex24016" - the fallback is "atmel,24c16"
> > -                "renesas,r1ex24128" - the fallback is "atmel,24c128"
> > -                "rohm,br24t01" - the fallback is "atmel,24c01"
> > -
> > -  - reg: The I2C address of the EEPROM.
> > -
> > -Optional properties:
> > -
> > -  - pagesize: The length of the pagesize for writing. Please consult t=
he
> > -              manual of your device, that value varies a lot. A wrong =
value
> > -              may result in data loss! If not specified, a safety valu=
e of
> > -              '1' is used which will be very slow.
> > -
> > -  - read-only: This parameterless property disables writes to the eepr=
om.
> > -
> > -  - size: Total eeprom size in bytes.
> > -
> > -  - no-read-rollover: This parameterless property indicates that the
> > -                      multi-address eeprom does not automatically roll=
 over
> > -                      reads to the next slave address. Please consult =
the
> > -                      manual of your device.
> > -
> > -  - wp-gpios: GPIO to which the write-protect pin of the chip is conne=
cted.
> > -
> > -  - address-width: number of address bits (one of 8, 16).
> > -
> > -  - num-addresses: total number of i2c slave addresses this device tak=
es
> > -
> > -Example:
> > -
> > -eeprom@52 {
> > -     compatible =3D "atmel,24c32";
> > -     reg =3D <0x52>;
> > -     pagesize =3D <32>;
> > -     wp-gpios =3D <&gpio1 3 0>;
> > -     num-addresses =3D <8>;
> > -};
> > +This file has been moved to at24.yaml.
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Docum=
entation/devicetree/bindings/eeprom/at24.yaml
> > new file mode 100644
> > index 000000000000..28c8b068c8a1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2019 BayLibre SAS
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/eeprom/at24.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: I2C EEPROMs compatible with Atmel's AT24
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +
> > +properties:
> > +  compatible:
> > +    additionalItems: true
> > +    maxItems: 2
> > +    pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),=
24(c|cs|mac)[0-9]+$"
> > +    oneOf:
> > +      - const: nxp,se97b
> > +      - const: renesas,r1ex24002
> > +      - const: renesas,r1ex24016
> > +      - const: renesas,r1ex24128
> > +      - const: rohm,br24t01
> > +    contains:
> > +      enum:
> > +        - atmel,24c00
> > +        - atmel,24c01
> > +        - atmel,24cs01
> > +        - atmel,24c02
> > +        - atmel,24cs02
> > +        - atmel,24mac402
> > +        - atmel,24mac602
> > +        - atmel,spd
> > +        - atmel,24c04
> > +        - atmel,24cs04
> > +        - atmel,24c08
> > +        - atmel,24cs08
> > +        - atmel,24c16
> > +        - atmel,24cs16
> > +        - atmel,24c32
> > +        - atmel,24cs32
> > +        - atmel,24c64
> > +        - atmel,24cs64
> > +        - atmel,24c128
> > +        - atmel,24c256
> > +        - atmel,24c512
> > +        - atmel,24c1024
> > +        - atmel,24c2048
>
> The previous binding allows more e.g.
>
>         compatible =3D "nxp,spd", "atmel,spd";
>

Ugh, I was thinking about spd and then forgot it anyway. :(

> which is no longer allowed. That might be a problem? The previous binding
> also allows less e.g.
>
>         compatible =3D "atmel,24c00", "renesas,24mac402";
>

Right, but I'm not really sure how to express fallbacks in yaml. Any hint?

Bart

> which of course is nonsense but AFAIU now allowed.
>
> The new formal rules are therefore not "right", and it might be impossibl=
e
> to express the subtleties of this weird binding with the current spec so
> there might be little to do about it? But either way, these issues are no=
t
> mentioned neither in the binding nor the commit message. Should they be
> mentioned?
>
> Cheers,
> Peter
>
> > +
> > +  reg:
> > +    description:
> > +      The I2C slave address of the EEPROM.
> > +    maxItems: 1
> > +
> > +  pagesize:
> > +    description:
> > +      The length of the pagesize for writing. Please consult the
> > +      manual of your device, that value varies a lot. A wrong value
> > +      may result in data loss! If not specified, a safety value of
> > +      '1' is used which will be very slow.
> > +    type: integer
> > +
> > +  read-only:
> > +    description:
> > +      This parameterless property disables writes to the eeprom.
> > +    type: boolean
> > +
> > +  size:
> > +    description:
> > +      Total eeprom size in bytes.
> > +    type: integer
> > +
> > +  no-read-rollover:
> > +    description:
> > +      This parameterless property indicates that the multi-address
> > +      eeprom does not automatically roll over reads to the next slave
> > +      address. Please consult the manual of your device.
> > +    type: boolean
> > +
> > +  wp-gpios:
> > +    description:
> > +      GPIO to which the write-protect pin of the chip is connected.
> > +    maxItems: 1
> > +
> > +  address-width:
> > +    description:
> > +      Number of address bits (one of 8, 16).
> > +    type: integer
> > +
> > +  num-addresses:
> > +    description:
> > +      Total number of i2c slave addresses this device takes.
> > +    type: integer
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    eeprom@52 {
> > +        compatible =3D "microchip,24c32", "atmel,24c32";
> > +        reg =3D <0x52>;
> > +        pagesize =3D <32>;
> > +        wp-gpios =3D <&gpio1 3 0>;
> > +        num-addresses =3D <8>;
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a400af0501c9..3c7ced686966 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2698,7 +2698,7 @@ M:      Bartosz Golaszewski <bgolaszewski@baylibr=
e.com>
> >  L:   linux-i2c@vger.kernel.org
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> >  S:   Maintained
> > -F:   Documentation/devicetree/bindings/eeprom/at24.txt
> > +F:   Documentation/devicetree/bindings/eeprom/at24.yaml
> >  F:   drivers/misc/eeprom/at24.c
> >
> >  ATA OVER ETHERNET (AOE) DRIVER
> >
>
