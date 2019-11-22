From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Fri, 22 Nov 2019 13:41:08 +0100
Message-ID: <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120142038.30746-2-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Khouloud,

thanks for your patch!

I just have a semantic comment:

On Wed, Nov 20, 2019 at 3:21 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.

It is claimed that this should be pulled low to assert it so by
definition it is active low.

> +  wp-gpios:
> +    description:
> +      GPIO to which the write-protect pin of the chip is connected.
> +    maxItems: 1

Mandate that the flag in the second cell should be GPIO_ACTIVE_LOW

>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> @@ -66,6 +71,7 @@ examples:
>        qfprom: eeprom@700000 {
>            #address-cells = <1>;
>            #size-cells = <1>;
> +          wp-gpios = <&gpio1 3 0>;

#include <dt-bindings/gpio/gpio.h>
wp-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;

This will in Linux have the semantic effect that you need to
set the output high with gpio_set_val(d, 1) to assert it
(drive it low) but that really doesn't matter to the device tree
bindings, those are OS-agnostic: if the line is active low then
it should use this flag.

It has the upside that the day you need a write-protect that
is active high, it is simple to support that use case too.

Yours,
Linus Walleij
