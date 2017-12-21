From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 2/5] dt-bindings: at24: add a missing compatible
Date: Thu, 21 Dec 2017 15:58:54 +0100
Message-ID: <CAMRc=MfrcGrXpRcLE3tf=AnKwtZxNk9J5TpoiuLvy8Vt0Fd5Lw@mail.gmail.com>
References: <20171221134842.31287-1-brgl@bgdev.pl> <20171221134842.31287-3-brgl@bgdev.pl>
 <CAHp75VeeLuoPUi=Q9=kSNQh9Dts3FC=SE464gFdcSizwSNdLPg@mail.gmail.com>
 <CAMRc=MdkF9tioOqDwWFKWCRU832BZPMD1GjK+BonDbhEH0CCnA@mail.gmail.com> <CAHp75Veg5h7v611PiLCOP6n4Ofhm-0+YY651tT_NZoJ-1aSMwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Veg5h7v611PiLCOP6n4Ofhm-0+YY651tT_NZoJ-1aSMwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-21 15:25 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Thu, Dec 21, 2017 at 4:18 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2017-12-21 15:08 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>>> On Thu, Dec 21, 2017 at 3:48 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>> "atmel,spd" is reported by checkpatch as undocumented in the device
>>>> tree bindings. Add it to the list of supported compatible strings.
>>>
>>>>          "atmel,24c00",
>>>>          "atmel,24c01",
>>>>          "atmel,24c02",
>>>> +        "atmel,spd",
>>>>          "atmel,24c04",
>>>>          "atmel,24c08",
>>>>          "atmel,24c16",
>>>
>>> Sounds alogical to me to make a split by this new record.
>>> Can you find better line to inject?
>
>> They are actually ordered by memory size. I want to keep it like this
>> in the driver and I prefer that the DT reflect it.
>
> So, I just disagree on the above. Rationale I described at one of the comment.
>
> At the end it's your call, but from my p.o.v. it makes life harder to
> read and catch the chips which are (un)supported.
>
> --
> With Best Regards,
> Andy Shevchenko

Yes, I prefer this version. Another reason to keep it like this is to
group chip variants together. E.g: atmel,24cs02, atmel,spd,
atmel,24mac402, atmel,24mac602 are all variants of atmel,24c02.

Thanks,
Bartosz
