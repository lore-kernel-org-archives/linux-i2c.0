From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RESEND] i2c: add sc18is600 driver
Date: Sun, 18 Jun 2017 17:17:27 +0300
Message-ID: <CAHp75Vd_eHdkXk23HFwOK_3ciZaSKZAFrPtYzKgnBpuGaCo2-g@mail.gmail.com>
References: <20170613154748.7018-1-sre@kernel.org> <CAHp75VexRjTZ+kbrPvD=RWy+_OBSnKAYj1-TX8aO5QgyOsn7nA@mail.gmail.com>
 <20170618140228.lmrvlgmp5vwnbblv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33052 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbdFROR2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 18 Jun 2017 10:17:28 -0400
In-Reply-To: <20170618140228.lmrvlgmp5vwnbblv@earth>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jun 18, 2017 at 5:02 PM, Sebastian Reichel <sre@kernel.org> wrote:

> Thanks for your feedback.

You're welcome!

> On Sat, Jun 17, 2017 at 09:13:32PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 13, 2017 at 6:47 PM, Sebastian Reichel <sre@kernel.org> wrote:

>> > +       snprintf(dev->adapter.name, sizeof(dev->adapter.name),
>>
>> > +                "SC18IS600 at SPI %02d device %02d",
>>
>> Isn't too much for adapter name?
>> I don't remember if it's part of ABI, in that case it's even worse.
>
> Well, it's displayed by "i2cdetect -l". Here are the names from some
> other drivers, which I used as reference:
>
> i2c-tiny-usb at bus %03d device %03d
> i2c-diolan-u2c at bus %03d device %03d
> OSIF at bus %03d device %03d
> SMBus Via Pro adapter at %04x
> SMBus SIS5595 adapter at %04x

Ah, okay.

-- 
With Best Regards,
Andy Shevchenko
