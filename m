From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 2/2] MAINTAINERS: add DT binding docs for AT24
Date: Wed, 29 Nov 2017 16:55:54 +0100
Message-ID: <CAMRc=MfR+U3=vhQJBs90HpOvKDbwpECxY=1pqBb6esi0=g_Q=w@mail.gmail.com>
References: <20171129090442.2865-1-wsa@the-dreams.de> <20171129090442.2865-3-wsa@the-dreams.de>
 <CAMRc=Mduv+Ecu69Dkj5aB-+YHfu9q6A1=0k=1Va_i1CX=gPBng@mail.gmail.com> <20171129153016.gkduedzytmxylvau@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40414 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbdK2P4N (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 10:56:13 -0500
Received: by mail-ot0-f194.google.com with SMTP id e74so3408792ote.7
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 07:56:13 -0800 (PST)
In-Reply-To: <20171129153016.gkduedzytmxylvau@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>

2017-11-29 16:30 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Nov 29, 2017 at 10:27:22AM +0100, Bartosz Golaszewski wrote:
>> 2017-11-29 10:04 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>> > The driver gaines DT support recently, so we should add the binding docs
>> > in the MAINTAINERS file.
>> >
>> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> > ---
>> >  MAINTAINERS | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index aa71ab52fd76d1..c870f329613d04 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -2262,6 +2262,7 @@ AT24 EEPROM DRIVER
>> >  M:     Bartosz Golaszewski <brgl@bgdev.pl>
>> >  L:     linux-i2c@vger.kernel.org
>> >  S:     Maintained
>> > +F:     Documentation/devicetree/bindings/eeprom/at24.txt
>> >  F:     drivers/misc/eeprom/at24.c
>> >  F:     include/linux/platform_data/at24.h
>> >
>> > --
>> > 2.11.0
>> >
>>
>> Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> I'd think both patches should go via your tree because they deal with
> at24. If you'd prefer my tree, let me know and I'll apply them with your
> ack. Thanks!
>

Sure, I'll apply them as soon as we get an Ack from Rob Herring on the dt patch.

Thanks,
Bartosz
