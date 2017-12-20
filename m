From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v2 0/2] eeprom: at24: write-protect pin support
Date: Wed, 20 Dec 2017 13:41:51 +0100
Message-ID: <CAMRc=Mej4SVZwSNqObgMfzgnc9mOFHi5GLTVKGW4Lp3n_Q-bvA@mail.gmail.com>
References: <20171220082633.32237-1-brgl@bgdev.pl> <CAHp75VfCD=mXvvbMT6PtjhgRznqfOSX_8Y8K3Zr64oJTbKnPeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfCD=mXvvbMT6PtjhgRznqfOSX_8Y8K3Zr64oJTbKnPeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-20 11:21 GMT+01:00 Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Wed, Dec 20, 2017 at 10:26 AM, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org> wrote:
>> AT24 EEPROMs have a write-protect pin, which - when pulled high -
>> inhibits writes to the upper quadrant of memory (although it has been
>> observed that on some chips it disables writing to the entire memory
>> range).
>>
>> On some boards, this pin is connected to a GPIO and pulled high by
>> default, which forces the user to manually change its state before
>> writing. On linux this means that we either need to hog the line all
>> the time, or set the GPIO value before writing from outside of the
>> at24 driver.
>>
>> This series adds support for the write-protect pin split into two
>> parts. The first patch extends the relevant binding document, while
>> the second modifies the at24 code to pull the write-protect GPIO
>> low (if present) during write operations.
>>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> A one totally minor nit: if it possible now to have one line where
> devm_gpiod_get_optional() is called?
> You may ignore this nit anyway.
>

Hi Andy,

I'm afraid I don't understand what you mean here. I do use
devm_gpiod_get_optional() in patch 2/2.

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
