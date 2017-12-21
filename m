From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: at24: add a missing compatible
Date: Thu, 21 Dec 2017 16:25:21 +0200
Message-ID: <CAHp75Veg5h7v611PiLCOP6n4Ofhm-0+YY651tT_NZoJ-1aSMwA@mail.gmail.com>
References: <20171221134842.31287-1-brgl@bgdev.pl> <20171221134842.31287-3-brgl@bgdev.pl>
 <CAHp75VeeLuoPUi=Q9=kSNQh9Dts3FC=SE464gFdcSizwSNdLPg@mail.gmail.com> <CAMRc=MdkF9tioOqDwWFKWCRU832BZPMD1GjK+BonDbhEH0CCnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMRc=MdkF9tioOqDwWFKWCRU832BZPMD1GjK+BonDbhEH0CCnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 21, 2017 at 4:18 PM, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org> wrote:
> 2017-12-21 15:08 GMT+01:00 Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> On Thu, Dec 21, 2017 at 3:48 PM, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org> wrote:
>>> "atmel,spd" is reported by checkpatch as undocumented in the device
>>> tree bindings. Add it to the list of supported compatible strings.
>>
>>>          "atmel,24c00",
>>>          "atmel,24c01",
>>>          "atmel,24c02",
>>> +        "atmel,spd",
>>>          "atmel,24c04",
>>>          "atmel,24c08",
>>>          "atmel,24c16",
>>
>> Sounds alogical to me to make a split by this new record.
>> Can you find better line to inject?

> They are actually ordered by memory size. I want to keep it like this
> in the driver and I prefer that the DT reflect it.

So, I just disagree on the above. Rationale I described at one of the comment.

At the end it's your call, but from my p.o.v. it makes life harder to
read and catch the chips which are (un)supported.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
