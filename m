From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 16:32:33 +0100
Message-ID: <CAMRc=Mc1tJO6EhNQ=SiA3uUPL6u3x-1otiCX4ohwZ5mX=g5qGQ@mail.gmail.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
 <1512576272-25563-2-git-send-email-svendev@arcx.com> <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
 <CAGngYiWdnE9Ztu3uGeqAS+Ksag6-W84AORJnWb1Xzc7EMBwZNg@mail.gmail.com>
 <CAMRc=Mf6e=O_M40Vaq4jygBwPHB8-X6wyDVG8Ee7qw+PjLTXUA@mail.gmail.com> <CAGngYiWmnBgjufeEUW5LYA8Ci7Rwt2m=FLCDX3RjrdWrxY97aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGngYiWmnBgjufeEUW5LYA8Ci7Rwt2m=FLCDX3RjrdWrxY97aw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-08 16:25 GMT+01:00 Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Bartosz wrote:
>>
>> Just make it accept two parameters: the string and the data object
>> name. For example:
>>
>>
> AT24_OF_DEVICE_ID("atmel,24c01", 24c01);
>>
>
> I don't want to do too much bikeshedding,
> but one last comment.
>
> Is it a good idea to have duplicated information?
> Do you think the risk of a typo mismatch is acceptable? E.g.
> AT24_OF_DEVICE_ID("atmel,24c01", 24c0
> 2
> );
> At least the original syntax is not susceptible to this problem,
> but of course as you say, it hides the of_ compatible string:
> AT24_OF_DEVICE_ID(atmel, 24c01);
> /* hides 'atmel,24c01' */
>
> Pros and cons. Pick one.

Nah, there aren't like two thousand compatible chips so that a mistake
would go unnoticed.

Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
