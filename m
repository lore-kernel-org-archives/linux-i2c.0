From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Thu, 21 Dec 2017 14:29:55 +0100
Message-ID: <CABxcv==7eA=c2DHZ2iLKFBq7oe9=EcKzP=1WX+m4WmyLo03jzw@mail.gmail.com>
References: <20171221130830.16813-1-brgl@bgdev.pl> <20171221130830.16813-2-brgl@bgdev.pl>
 <CABxcv==wt_brqA38P6OA846rW5K5Mjk3HxBpLfqXD-ZSpQ34YQ@mail.gmail.com> <CAMRc=MdSzy4=-Z8z2-686hZBQv3c7u78dW4zxFcKT1LYirX8WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:32773 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdLUN34 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:29:56 -0500
Received: by mail-io0-f194.google.com with SMTP id t196so21035984iof.0
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:29:56 -0800 (PST)
In-Reply-To: <CAMRc=MdSzy4=-Z8z2-686hZBQv3c7u78dW4zxFcKT1LYirX8WQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Dec 21, 2017 at 2:28 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2017-12-21 14:19 GMT+01:00 Javier Martinez Canillas <javier@dowhile0.org>:
>> Hello Bartosz,
>>
>> Nice patch.
>>
>> On Thu, Dec 21, 2017 at 2:08 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> Current description of the compatible property for at24 is quite vague.
>>>
>>> Specify an exact list of accepted compatibles and document the - now
>>> deprecated - strings which were previously used in device tree files.
>>>
>>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>>> ---
>>>  Documentation/devicetree/bindings/eeprom/at24.txt | 50 +++++++++++++----------
>>>  1 file changed, 28 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
>>> index cbc80e194ac6..6ccbd000bfa4 100644
>>> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
>>> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
>>> @@ -2,28 +2,34 @@ EEPROMs (I2C)
>>>
>>>  Required properties:
>>>
>>> -  - compatible : should be "<manufacturer>,<type>", like these:
>>> -
>>> -       "atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
>>> -       "atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
>>> -       "atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
>>> -
>>> -       "catalyst,24c32"
>>> -
>>> -       "microchip,24c128"
>>> -
>>> -       "ramtron,24c64"
>>> -
>>> -       "renesas,r1ex24002"
>>> -
>>> -       The following manufacturers values have been deprecated:
>>> -       "at", "at24"
>>> -
>>> -        If there is no specific driver for <manufacturer>, a generic
>>> -        device with <type> and manufacturer "atmel" should be used.
>>> -        Possible types are:
>>> -        "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
>>> -        "24c128", "24c256", "24c512", "24c1024", "spd"
>>> +  - compatible: must be one of the following:
>>> +
>>> +        "atmel,24c00",
>>> +        "atmel,24c01",
>>> +        "atmel,24c02",
>>> +        "atmel,24c04",
>>> +        "atmel,24c08",
>>> +        "atmel,24c16",
>>> +        "atmel,24c32",
>>> +        "atmel,24c64",
>>> +        "atmel,24c128",
>>> +        "atmel,24c256",
>>> +        "atmel,24c512",
>>> +        "atmel,24c1024"
>>> +
>>> +  NOTE: old compatible strings, such as:
>>> +
>>> +        "catalyst,24c32",
>>> +        "microchip,24c128",
>>> +        "ramtron,24c64",
>>> +        "renesas,r1ex24002",
>>> +        "at,24c08",
>>> +        "at24,24c08"
>>> +
>>> +  will still work, but are now deprecated.
>>> +
>>> +  Also: matching by device type alone - while still supported due to
>>> +  implementation details in I2C core - is deprecated as well.
>>>
>>
>> I don't think that's correct to mention Linux specific implementation
>> details in a Device Tree binding. It's supposed to be OS independent
>> and in theory the same DT binding could be used in other OS /
>> bootloaders.
>>
>> With that last paragraph removed, feel free to add:
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>>>    - reg : the I2C address of the EEPROM
>>>
>>
>> Best regards,
>> Javier
>
> How about I just add the no-vendor string examples to the list of
> deprecated compatibles above?
>

yes, that's a good idea.

> Best regards,
> Bartosz

Best regards,
Javier
