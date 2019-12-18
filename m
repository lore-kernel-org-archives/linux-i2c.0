From: Khouloud Touil <ktouil@baylibre.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Wed, 18 Dec 2019 12:10:52 +0100
Message-ID: <CALL1Z1xwd5+HeCWWG5DQ8XMph=v=UmpW+P9vG4Lg_vVvzySjiQ@mail.gmail.com>
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-2-ktouil@baylibre.com>
 <CACRpkdZb6OppcdCcaQ9abdkDJMk4escyyEm1TMB75rRxoN5e2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZb6OppcdCcaQ9abdkDJMk4escyyEm1TMB75rRxoN5e2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Le lun. 16 d=C3=A9c. 2019 =C3=A0 09:08, Linus Walleij <linus.walleij@linaro=
.org> a =C3=A9crit :
>
> On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrot=
e:
>
> > +  wp-gpios:
> > +    description:
> > +      GPIO to which the write-protect pin of the chip is connected.
> > +      The write-protect GPIO is asserted, when it's driven high
> > +      (logical '1') to block the write operation. It's deasserted,
> > +      when it's driven low (logical '0') to allow writing.
> > +    maxItems: 1
>
> OK I guess we can't get it less convoluted. This section is consistent.
>
> >  patternProperties:
> >    "^.*@[0-9a-f]+$":
> >      type: object
> > @@ -66,6 +74,7 @@ examples:
> >        qfprom: eeprom@700000 {
> >            #address-cells =3D <1>;
> >            #size-cells =3D <1>;
> > +          wp-gpios =3D <&gpio1 3 0>;
>
> In the example please use the include for GPIO:
>
> #include <dt-bindings/gpio/gpio.h>
>
> wp-gpios =3D <&gpio1 3 GPIO_ACTIVE_HIGH>;
>
> You can just put the #include directive right before the
> example, it should work fine.

Yes sure will fix that.
Thanks for your reviews.

Best regards,
Khouloud
>
> Yours,
> Linus Walleij
