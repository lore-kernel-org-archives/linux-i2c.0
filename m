From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 16:05:54 +0100
Message-ID: <CAMRc=Mf6e=O_M40Vaq4jygBwPHB8-X6wyDVG8Ee7qw+PjLTXUA@mail.gmail.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
 <1512576272-25563-2-git-send-email-svendev@arcx.com> <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
 <CAGngYiWdnE9Ztu3uGeqAS+Ksag6-W84AORJnWb1Xzc7EMBwZNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGngYiWdnE9Ztu3uGeqAS+Ksag6-W84AORJnWb1Xzc7EMBwZNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-08 15:17 GMT+01:00 Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Bartosz wrote:
>>> +#define AT24_OF_DEVICE_ID(_mfg, _name) \
>>> +       { .compatible = #_mfg "," #_name, .data = &platdata_##_name }
>>
>> I don't like hiding the way the compatible is created here from the
>> user. It doesn't save any code neither. Please make the macro accept
>> the whole compatible string.
>>
>
> If the macro accepts the whole compatible string "mfg,chip-name" (e.g.
> "atmel,24c01")
> then how can I extract chip-name from that string? I need to attach
> chip-name to the
> platdata_ static structures. (e.g. "atmel,24c01" -> .data = platdata_24c01)

Just make it accept two parameters: the string and the data object
name. For example:

AT24_OF_DEVICE_ID("atmel,24c01", 24c01);

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
