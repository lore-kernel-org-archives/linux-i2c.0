From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC 1/3] dt-bindings: i2c: i2c-gpio: Add support for named gpios
Date: Mon, 18 Sep 2017 11:52:48 -0500
Message-ID: <CAL_JsqKS++33tOr6PVzX1Fifmn5teaZVYeY0UWeNiAfi=nHetA@mail.gmail.com>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
 <1503566474-5335-2-git-send-email-geert+renesas@glider.be>
 <20170831175529.vuchpgvi2aigz2r5@rob-hp-laptop> <CAMuHMdXGm0XuuihG=L_JRBV_WHt2QPtZgdsMFT0PeyDH3ejsNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXGm0XuuihG=L_JRBV_WHt2QPtZgdsMFT0PeyDH3ejsNg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 7, 2017 at 6:42 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Rob,
>
> On Thu, Aug 31, 2017 at 7:55 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Aug 24, 2017 at 11:21:12AM +0200, Geert Uytterhoeven wrote:
>>> The current i2c-gpio DT bindings use a single unnamed "gpios" property
>>> to refer to the SDA and SCL signal lines by index.  This is error-prone
>>> for the casual DT writer and reviewer, as one has to look up the order
>>> in the DT bindings.
>>>
>>> Fix this by amending the DT bindings to use two separate named gpios
>>> properties, and deprecate the old unnamed variant.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>>  Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
>>> index 4f8ec947c6bd9cad..61033f73577dd70e 100644
>>> --- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
>>> @@ -2,8 +2,9 @@ Device-Tree bindings for i2c gpio driver
>>>
>>>  Required properties:
>>>       - compatible = "i2c-gpio";
>>> -     - gpios: sda and scl gpio
>>> -
>>> +     - sda-gpios: gpio used for the sda signal
>>> +     - scl-gpios: gpio used for the scl signal
>>> +     - gpios: sda and scl gpio, alternative for {sda,scl}-gpios (deprecated)
>>>
>>>  Optional properties:
>>>       - i2c-gpio,sda-open-drain: sda as open drain
>>
>> Well, if we're going to change things, we should drop these open-drain
>> properties. We have open-drain flags in gpio cells, so we don't need
>> these I think.
>
> It depends. Some GPIO controllers use #gpio-cells = 1, lacking flags.

We should stop allowing that or at least require that anyone using
i2c-gpio have flags. If they are added this new i2c-gpio binding, then
they can add flags too.

> Furthermore, the gpio-specifiers are controller-specific, and not all GPIO
> controllers supporting flags follow the semi-standard flag definitions in
> <dt-bindings/gpio/gpio.h>.

In theory yes, but reality is pretty much everyone follows it. There's
no other way to specify active high vs. low for example. Furthermore,
if someone wanted to do flags in their own custom way, that would
still work. It is still the controller (or GPIO core) that interprets
the flags, not the client.

This is a new binding, so only new DT will have it and we can apply
new standards.

Rob
