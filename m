From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Thu, 21 Dec 2017 14:28:05 +0100
Message-ID: <CAMRc=MdSzy4=-Z8z2-686hZBQv3c7u78dW4zxFcKT1LYirX8WQ@mail.gmail.com>
References: <20171221130830.16813-1-brgl@bgdev.pl> <20171221130830.16813-2-brgl@bgdev.pl>
 <CABxcv==wt_brqA38P6OA846rW5K5Mjk3HxBpLfqXD-ZSpQ34YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv==wt_brqA38P6OA846rW5K5Mjk3HxBpLfqXD-ZSpQ34YQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-21 14:19 GMT+01:00 Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>:
> Hello Bartosz,
>
> Nice patch.
>
> On Thu, Dec 21, 2017 at 2:08 PM, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org> wrote:
>> Current description of the compatible property for at24 is quite vague.
>>
>> Specify an exact list of accepted compatibles and document the - now
>> deprecated - strings which were previously used in device tree files.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/eeprom/at24.txt | 50 +++++++++++++----------
>>  1 file changed, 28 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
>> index cbc80e194ac6..6ccbd000bfa4 100644
>> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
>> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
>> @@ -2,28 +2,34 @@ EEPROMs (I2C)
>>
>>  Required properties:
>>
>> -  - compatible : should be "<manufacturer>,<type>", like these:
>> -
>> -       "atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
>> -       "atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
>> -       "atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
>> -
>> -       "catalyst,24c32"
>> -
>> -       "microchip,24c128"
>> -
>> -       "ramtron,24c64"
>> -
>> -       "renesas,r1ex24002"
>> -
>> -       The following manufacturers values have been deprecated:
>> -       "at", "at24"
>> -
>> -        If there is no specific driver for <manufacturer>, a generic
>> -        device with <type> and manufacturer "atmel" should be used.
>> -        Possible types are:
>> -        "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
>> -        "24c128", "24c256", "24c512", "24c1024", "spd"
>> +  - compatible: must be one of the following:
>> +
>> +        "atmel,24c00",
>> +        "atmel,24c01",
>> +        "atmel,24c02",
>> +        "atmel,24c04",
>> +        "atmel,24c08",
>> +        "atmel,24c16",
>> +        "atmel,24c32",
>> +        "atmel,24c64",
>> +        "atmel,24c128",
>> +        "atmel,24c256",
>> +        "atmel,24c512",
>> +        "atmel,24c1024"
>> +
>> +  NOTE: old compatible strings, such as:
>> +
>> +        "catalyst,24c32",
>> +        "microchip,24c128",
>> +        "ramtron,24c64",
>> +        "renesas,r1ex24002",
>> +        "at,24c08",
>> +        "at24,24c08"
>> +
>> +  will still work, but are now deprecated.
>> +
>> +  Also: matching by device type alone - while still supported due to
>> +  implementation details in I2C core - is deprecated as well.
>>
>
> I don't think that's correct to mention Linux specific implementation
> details in a Device Tree binding. It's supposed to be OS independent
> and in theory the same DT binding could be used in other OS /
> bootloaders.
>
> With that last paragraph removed, feel free to add:
>
> Reviewed-by: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
>>    - reg : the I2C address of the EEPROM
>>
>
> Best regards,
> Javier

How about I just add the no-vendor string examples to the list of
deprecated compatibles above?

Best regards,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
