From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 2/5] dt-bindings: at24: add a missing compatible
Date: Thu, 21 Dec 2017 15:18:32 +0100
Message-ID: <CAMRc=MdkF9tioOqDwWFKWCRU832BZPMD1GjK+BonDbhEH0CCnA@mail.gmail.com>
References: <20171221134842.31287-1-brgl@bgdev.pl> <20171221134842.31287-3-brgl@bgdev.pl>
 <CAHp75VeeLuoPUi=Q9=kSNQh9Dts3FC=SE464gFdcSizwSNdLPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36512 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdLUOSf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 09:18:35 -0500
Received: by mail-oi0-f43.google.com with SMTP id j14so5717649oih.3
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 06:18:34 -0800 (PST)
In-Reply-To: <CAHp75VeeLuoPUi=Q9=kSNQh9Dts3FC=SE464gFdcSizwSNdLPg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-21 15:08 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Thu, Dec 21, 2017 at 3:48 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> "atmel,spd" is reported by checkpatch as undocumented in the device
>> tree bindings. Add it to the list of supported compatible strings.
>
>>          "atmel,24c00",
>>          "atmel,24c01",
>>          "atmel,24c02",
>> +        "atmel,spd",
>>          "atmel,24c04",
>>          "atmel,24c08",
>>          "atmel,24c16",
>
> Sounds alogical to me to make a split by this new record.
> Can you find better line to inject?
>
> --
> With Best Regards,
> Andy Shevchenko

They are actually ordered by memory size. I want to keep it like this
in the driver and I prefer that the DT reflect it.

Thanks,
Bartosz
