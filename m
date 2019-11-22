From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Fri, 22 Nov 2019 14:46:36 +0100
Message-ID: <CACRpkdaPQKxfC66yhG=xdmCOGGd9PjDVCwZquKb+4HmuS_=kNA@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
 <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
 <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com> <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Khouloud Touil <ktouil@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 22, 2019 at 2:04 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> > I would to like this:
> >
> > 1. Add a new generic property
> >    writeprotect-gpios that mandates to use GPIO_ACTIVE_LOW
> >    and use this in the new example
> >
> > 2. Deprecate wp-gpios in the binding, keep it around but deprecated.
>
> This is a pretty standard property though - for instance it is
> documented in the main mmc binding and doesn't mandate GPIO_ACTIVE_LOW
> either. I think this is because nobody says that the write-protect
> line must always be driver low to be asserted - this is highly
> implementation-specific.

The MMC case is actually especially convoluted. It has always
respected the GPIO_ACTIVE_LOW flag, and that is used if
present. At the same time it *also* supported a bool
wp-inverted flag, with the specified semantic that if both
were specified (ACTIVE_LOW and wp-inverted) the result
would be nothing as it is a double logical inversion.

So that is why the quirk looks like this:

       /*
         * Handle MMC "cd-inverted" and "wp-inverted" semantics.
         */
        if (IS_ENABLED(CONFIG_MMC)) {
                /*
                 * Active low is the default according to the
                 * SDHCI specification and the device tree
                 * bindings. However the code in the current
                 * kernel was written such that the phandle
                 * flags were always respected, and "cd-inverted"
                 * would invert the flag from the device phandle.
                 */
                if (!strcmp(propname, "cd-gpios")) {
                        if (of_property_read_bool(np, "cd-inverted"))
                                *flags ^= OF_GPIO_ACTIVE_LOW;
                }
                if (!strcmp(propname, "wp-gpios")) {
                        if (of_property_read_bool(np, "wp-inverted"))
                                *flags ^= OF_GPIO_ACTIVE_LOW;
                }
        }

Nevermind MMC though.

The current code for at24 has an ambiguousness issue: if
the gpios cell 2 is specified as GPIO_ACTIVE_LOW
(which is in some sense correct) then the effect will be
that it is driven high to assert the wp, which is  ... rather
counterintuitive.

I could think of a compromise like this:

1. Keep "wp-gpios"

2. Add a quirk to gpiolib-of.c that will force that as active
   low no matter what flag is specified to the GPIO descriptor.

3. If some other flag that GPIO_ACTIVE_LOW is specified,
  print a warning and say the the (default) GPIO_ACTIVE_HIGH
  i.e. 0 is gonna be ignored and we forced the line to be
  active low.

4. The code still need to be modified to set the value
   to "1" to assert the line since the gpiolib now handles
   the inversion semantics.

5. Hope that no system with an active high wp ever comes
  into existence because then we are screwed and will have
  to create a new binding and deprecate the old binding
  anyway.

Yours,
Linus Walleij
