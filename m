From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 4/5] i2c: pca-platform: use device managed allocations
Date: Wed, 28 Jun 2017 13:54:25 +0300
Message-ID: <CAHp75VdykSnkyOpaAkaubnS+s32XW10ZHOYk2SRr6ORsYV7y_A@mail.gmail.com>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz> <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfE=gCO3EDvadxar=qdnqMHKAZg2TSvXBtYebx+Y_agEw@mail.gmail.com> <20170628093844.vmstyotgjaotbsnh@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34219 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdF1Kyg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 06:54:36 -0400
In-Reply-To: <20170628093844.vmstyotgjaotbsnh@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 28, 2017 at 12:38 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> >         if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
>> > -               ret = -ENODEV;
>> > -               goto e_adapt;
>> > +               return -ENODEV;
>>
>> This is still shadows the actual error code.
>
> Nice catch. But since it fixes a seperate issue, I'd prefer an
> incremental change here.

Agreed.

-- 
With Best Regards,
Andy Shevchenko
