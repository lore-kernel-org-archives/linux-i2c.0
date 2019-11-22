From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Fri, 22 Nov 2019 13:47:04 +0100
Message-ID: <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Khouloud Touil <ktouil@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

pt., 22 lis 2019 o 13:41 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> Hi Khouloud,
>
> thanks for your patch!
>
> I just have a semantic comment:
>
> On Wed, Nov 20, 2019 at 3:21 PM Khouloud Touil <ktouil@baylibre.com> wrot=
e:
>
> > Instead of modifying all the memory drivers to check this pin, make
> > the NVMEM subsystem check if the write-protect GPIO being passed
> > through the nvmem_config or defined in the device tree and pull it
> > low whenever writing to the memory.
>
> It is claimed that this should be pulled low to assert it so by
> definition it is active low.
>
> > +  wp-gpios:
> > +    description:
> > +      GPIO to which the write-protect pin of the chip is connected.
> > +    maxItems: 1
>
> Mandate that the flag in the second cell should be GPIO_ACTIVE_LOW
>
> >  patternProperties:
> >    "^.*@[0-9a-f]+$":
> >      type: object
> > @@ -66,6 +71,7 @@ examples:
> >        qfprom: eeprom@700000 {
> >            #address-cells =3D <1>;
> >            #size-cells =3D <1>;
> > +          wp-gpios =3D <&gpio1 3 0>;
>
> #include <dt-bindings/gpio/gpio.h>
> wp-gpios =3D <&gpio1 3 GPIO_ACTIVE_LOW>;
>
> This will in Linux have the semantic effect that you need to
> set the output high with gpio_set_val(d, 1) to assert it
> (drive it low) but that really doesn't matter to the device tree
> bindings, those are OS-agnostic: if the line is active low then
> it should use this flag.
>
> It has the upside that the day you need a write-protect that
> is active high, it is simple to support that use case too.
>

Linus,

what about the existing bindings for at24 that don't mandate the
active-low flag? I'm afraid this would break the support for this
specific chip or lead to code duplication if we had this in both nvmem
and at24 with different logic.

Bartosz

> Yours,
> Linus Walleij
