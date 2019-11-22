From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Fri, 22 Nov 2019 13:53:07 +0100
Message-ID: <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com> <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Khouloud Touil <ktouil@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 22, 2019 at 1:47 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> what about the existing bindings for at24 that don't mandate the
> active-low flag? I'm afraid this would break the support for this
> specific chip or lead to code duplication if we had this in both nvmem
> and at24 with different logic.

Hm yeah I realized this when I read patches 3 & 4.

I would to like this:

1. Add a new generic property
   writeprotect-gpios that mandates to use GPIO_ACTIVE_LOW
   and use this in the new example

2. Deprecate wp-gpios in the binding, keep it around but deprecated.

3. Add a quirk to gpiolib-of in the manner of the other quirks there
   (like for SPI) so that if we are dealing with some EEPROM node
   like at24 and the flag is zero, tag on GPIO_ACTIVE_LOW on
   the descriptor.

The driver will now handle the semantic of both cases
with gpiolib-of providing a quirk for the old binding.

This is how we solved this type of problem before.

Yours,
Linus Walleij
