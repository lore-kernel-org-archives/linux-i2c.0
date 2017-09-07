From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/3] dt-bindings: i2c: i2c-gpio: Add support for named gpios
Date: Thu, 7 Sep 2017 13:42:17 +0200
Message-ID: <CAMuHMdXGm0XuuihG=L_JRBV_WHt2QPtZgdsMFT0PeyDH3ejsNg@mail.gmail.com>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
 <1503566474-5335-2-git-send-email-geert+renesas@glider.be> <20170831175529.vuchpgvi2aigz2r5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33890 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755169AbdIGLmS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Sep 2017 07:42:18 -0400
In-Reply-To: <20170831175529.vuchpgvi2aigz2r5@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Rob,

On Thu, Aug 31, 2017 at 7:55 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Aug 24, 2017 at 11:21:12AM +0200, Geert Uytterhoeven wrote:
>> The current i2c-gpio DT bindings use a single unnamed "gpios" property
>> to refer to the SDA and SCL signal lines by index.  This is error-prone
>> for the casual DT writer and reviewer, as one has to look up the order
>> in the DT bindings.
>>
>> Fix this by amending the DT bindings to use two separate named gpios
>> properties, and deprecate the old unnamed variant.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
>> index 4f8ec947c6bd9cad..61033f73577dd70e 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
>> @@ -2,8 +2,9 @@ Device-Tree bindings for i2c gpio driver
>>
>>  Required properties:
>>       - compatible = "i2c-gpio";
>> -     - gpios: sda and scl gpio
>> -
>> +     - sda-gpios: gpio used for the sda signal
>> +     - scl-gpios: gpio used for the scl signal
>> +     - gpios: sda and scl gpio, alternative for {sda,scl}-gpios (deprecated)
>>
>>  Optional properties:
>>       - i2c-gpio,sda-open-drain: sda as open drain
>
> Well, if we're going to change things, we should drop these open-drain
> properties. We have open-drain flags in gpio cells, so we don't need
> these I think.

It depends. Some GPIO controllers use #gpio-cells = 1, lacking flags.
Furthermore, the gpio-specifiers are controller-specific, and not all GPIO
controllers supporting flags follow the semi-standard flag definitions in
<dt-bindings/gpio/gpio.h>.

See Documentation/devicetree/bindings/gpio/gpio.txt.

Gr{oetje,eeting}s,

                        Geert
