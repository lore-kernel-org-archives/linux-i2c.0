From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH V2] eeprom: at24: support second page of M24M01
Date: Tue, 30 Jan 2018 16:00:04 +0100
Message-ID: <CAMRc=MdiNRmRo7FHM5s-1gAWVE0s9sNQTtKswHVzUg=eC_-deA@mail.gmail.com>
References: <20180125134016.GA21654@ppcx2.izt.loc> <CAMRc=MdvhkZaMnR_G8UERdRgDa_8GchrrVUgwEE04aMMHtBOAw@mail.gmail.com>
 <7c3a9b70-a04b-464e-2632-b0d757f780e1@izt-labs.de> <CAMRc=Me8M3P4vKeZgnr0wyqPTnZEyJxUQ0LyqQoyHQyK_gMGLg@mail.gmail.com>
 <20180130141031.36e6x6fb5svtub4i@pp184.izt.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:40117 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeA3PAF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 Jan 2018 10:00:05 -0500
Received: by mail-ot0-f172.google.com with SMTP id x4so10190724otg.7
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jan 2018 07:00:05 -0800 (PST)
In-Reply-To: <20180130141031.36e6x6fb5svtub4i@pp184.izt.loc>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: johannes <johannes@izt.loc>
Cc: =?UTF-8?Q?Johannes_P=C3=B6hlmann?= <johannes.poehlmann@izt-labs.de>, linux-i2c <linux-i2c@vger.kernel.org>

2018-01-30 15:14 GMT+01:00 johannes <johannes@izt.loc>:
> On Mon, Jan 29, 2018 at 04:39:15PM +0100, Bartosz Golaszewski wrote:
>
>> >> What EEPROM model do you need that for? Is it not covered by all the
>> >> standard types we already support in the driver?
>
>> > I need this for a M24M01-D* eeprom.
>> > (http://www.st.com/content/ccc/resource/technical/document/datasheet/group0/cb/91/ba/7d/0b/c1/4d/f6/CD00147128/files/CD00147128.pdf/jcr:content/translations/en.CD00147128.pdf)
>
>> > It is 1 Mbit sized and has 2 byte addresses.
>
>> > Under another I2C address it offers a additional write lockable page
>> > of 256 Byte, but with _2 byte addresses_. I could not correctly read
>> > this "second eeprom" with one of the standard eeprom at24* models.
>> > [ .. ]
>
>> This model is compatible with at24cm01. We don't support it yet, but
>> instead of a new DT property, just add a new supported model with
>> compatible = 'atmel,at24cm01' and AT24_FLAG_ADDR16 to the driver code.
>
> Hi Bartosz,
>
> I did the patch as you recommended with a new supported model.
> The diff is much smaller now.
>
> See more info and a question about naming in the patch attached.
>
>

Please send patches using git send-mail. Patchwork didn't even pick that one up.

Thanks,
Bartosz
