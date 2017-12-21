From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Thu, 21 Dec 2017 21:27:20 +0100
Message-ID: <CABxcv=kZk+Yrt9uj9uV7UVC+Tca7NCECfyZXmKkqHdopm5EZTg@mail.gmail.com>
References: <20171221134842.31287-1-brgl@bgdev.pl> <20171221134842.31287-2-brgl@bgdev.pl>
 <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hello Peter,

On Thu, Dec 21, 2017 at 5:20 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2017-12-21 14:48, Bartosz Golaszewski wrote:
>> Current description of the compatible property for at24 is quite vague.
>>
>> Specify an exact list of accepted compatibles and document the - now
>> deprecated - strings which were previously used in device tree files.
>
> Why is it suddenly deprecated to correctly specify what hardware you
> have, e.g. "nxp,24c32". In this case the manufacturer is nxp, damnit.

Sorry but I disagree.

When you specify a compatible string, you are not specifying a
particular hardware but a device programming model.

It's very common to use a compatible string that doesn't match exactly
the specific hardware used. That's why it's called _compatible_ BTW.

For example when a DTS define a UART node with an ns16550 compatible,
they don't really mean that have a UART IC manufactured by National
Semiconductor.

> Sure, it happens to be compatible with "atmel,24c32", but that is
> supposed to be written with a fallback as
>
>         "nxp,24c32", "atmel,24c32"

This isn't a requirement really, systems integrators are free to use
more than one <manufacturer,model> tuple in the compatible string if
they want the DTB to be future proof, just in case there's a need for
a more specific driver or if the programming model happened to not be
the same at the end. This is usually done for the boards compatible
string as an example, even when there isn't a struct machine_desc for
the specific board compatible and only for the SoC family.

So it's OK if you want to define the compatible as "nxp,24c32",
"atmel,24c32", but that's a general OF concept and not something
related to the at24 eeprom driver so I'm not sure if it should be
mentioned in the at24 DT binding doc.

> if I understand correctly. So, why is that deprecated in this case?
>
> What if (a few years down the line) it is discovered that some weird
> quirk is needed that is only appropriate for nxp chips?
>
> nxp is of course just an example, pick any manufacturer of eeproms
> (supposedly) compatible with the atmel interface.
>

That's indeed a possibility and the reason why most DT nodes have a
more specific <manufacturer,model> before the generic one matched by
drivers. I really doubt that in the future it will be found that a
more specific compatible string is needed for one manufacturer in this
case, specially since the driver didn't even care about the
manufacturers until recently.

So I think that makes no sense for a driver to support all possible
manufacturers as possible compatible strings if all the devices have
the same exact programming model.

> Cheers,
> Peter

Best regards,
Javier
