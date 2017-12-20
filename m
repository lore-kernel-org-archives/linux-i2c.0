From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v3 1/1] eeprom: at24: convert magic numbers to structs.
Date: Wed, 20 Dec 2017 17:37:51 +0100
Message-ID: <CAMRc=McQThGRYqmbue8jw_uKQPicitQn6rNxZxo9+HYQ3UaYDw@mail.gmail.com>
References: <1513621702-6565-1-git-send-email-svenv@arcx.com>
 <1513621702-6565-2-git-send-email-svenv@arcx.com> <CAMRc=Md0VwJ=OeE_-2uWi2sr4gJ8v9CnmexYgdDGR0pbyXYo_g@mail.gmail.com>
 <CAGngYiVJRVuMtLThnvsXbXMuL-_4ZN=2RkuCkRBzq3cf+W4sPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGngYiVJRVuMtLThnvsXbXMuL-_4ZN=2RkuCkRBzq3cf+W4sPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sven Van Asbroeck <svenv-fuHqz3Nb1YI@public.gmane.org>, Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-20 17:32 GMT+01:00 Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>> +       { .compatible = "atmel,24c00", .data = &at24_data_24c00 },
>>
>> Add tabs here as well, seems like there's enough space in the line.
>
> There's not enough space in the line to line up the 24c1024 entry with
> the others. I'll revert to the formatting style that was there before.

I'm at 77 columns if I add a single tab after '.compatible = "atmel,24c1024"'.

It looks nice like this, so I prefer to keep it.

Thanks,
Bartosz Golaszewski
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
