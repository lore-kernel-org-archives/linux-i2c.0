From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Wed, 18 Oct 2017 20:51:26 +0200
Message-ID: <CABxcv==yK=_52Z5g1fb+UOM6io=zdGGAha=ZE6=S9Eo=x9enGA@mail.gmail.com>
References: <20171001104948.21663-1-javierm@redhat.com> <20171017214040.kak3kpvh6tunjjfp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017214040.kak3kpvh6tunjjfp@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 17, 2017 at 11:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi,
>
>> +     {
>> +             .compatible = "atmel,spd",
>> +             .data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
>> +                             AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
>> +     },
>
> checkpatch reported this one as un-documented. And come to think of it,
> since this is solely for EEPROMs on RAM modules, I think we can drop a
> DT binding for it. Could you agree? I can do it locally, no need to

As mentioned by Rob, it's already used by a DTS in mainline.

I think the problem is in how the DT binding for this driver is described.

Most DT bindings describes the complete list of compatible strings
supported by a driver and that's what checkpatch expects. But
Documentation/devicetree/bindings/eeprom/eeprom.txt describes it as
the cartesian product of the atmel (and also the deprecated at and
at24) manufacturer and a list of devices. To save you a lookup:

If there is no specific driver for <manufacturer>, a generic
device with <type> and manufacturer "atmel" should be used.
Possible types are:
"24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
"24c128", "24c256", "24c512", "24c1024", "spd"

> resend. I'll do HW testing later, but wanted to check on your opinion
> already.
>

Great, thanks! I hope I got it right this time. Adding a DTS snippet I
can see that the entry .data is correctly used but I don't a device to
check if is working correctly after $SUBJECT.

> Thanks,
>
>    Wolfram
>
