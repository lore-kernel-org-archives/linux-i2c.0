From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Fri, 22 Nov 2019 14:04:03 +0100
Message-ID: <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
 <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com> <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Khouloud Touil <ktouil@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

pt., 22 lis 2019 o 13:53 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Fri, Nov 22, 2019 at 1:47 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>
> > what about the existing bindings for at24 that don't mandate the
> > active-low flag? I'm afraid this would break the support for this
> > specific chip or lead to code duplication if we had this in both nvmem
> > and at24 with different logic.
>
> Hm yeah I realized this when I read patches 3 & 4.
>
> I would to like this:
>
> 1. Add a new generic property
>    writeprotect-gpios that mandates to use GPIO_ACTIVE_LOW
>    and use this in the new example
>
> 2. Deprecate wp-gpios in the binding, keep it around but deprecated.

This is a pretty standard property though - for instance it is
documented in the main mmc binding and doesn't mandate GPIO_ACTIVE_LOW
either. I think this is because nobody says that the write-protect
line must always be driver low to be asserted - this is highly
implementation-specific.

Bartosz

>
> 3. Add a quirk to gpiolib-of in the manner of the other quirks there
>    (like for SPI) so that if we are dealing with some EEPROM node
>    like at24 and the flag is zero, tag on GPIO_ACTIVE_LOW on
>    the descriptor.
>
> The driver will now handle the semantic of both cases
> with gpiolib-of providing a quirk for the old binding.
>
> This is how we solved this type of problem before.
>
> Yours,
> Linus Walleij
