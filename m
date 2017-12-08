From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 16:05:01 +0100
Message-ID: <CAMRc=MdER+_+aq+i2YhcXXj2Nar-RGnsDyodz+0Nuin6qH+SoA@mail.gmail.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
 <1512576272-25563-2-git-send-email-svendev@arcx.com> <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
 <CAGngYiXtUBbYocb885CPCaXNM=uckeiHc47FXKghDz_B-WNYrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGngYiXtUBbYocb885CPCaXNM=uckeiHc47FXKghDz_B-WNYrg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-08 15:10 GMT+01:00 Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Bartosz, thanks for the encouragement !
>
> Bartosz wrote:
>> Also: please have the AT24/at24 prefix for symbols in the driver.
>
> These specific symbols are declared static, i.e. they're visible only
> inside at24.c.
> Do you think they should still have an at24 prefix ?
>
> +#define DECLARE_AT24_PLATDATA(_name, _len, _flags) \
> +       static const struct at24_platform_data platdata_##_name = { \
> +               .byte_len = _len, .flags = _flags, \
> +       }

Yes, it's a common pattern in the kernel and it adds to readability.

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
