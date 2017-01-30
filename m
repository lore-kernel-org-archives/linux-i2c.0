From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] i2c: piix4: Fix request_region size
Date: Mon, 30 Jan 2017 02:11:47 +0100
Message-ID: <CAPybu_3prZYuGcHKx-ppm9_viKVm-VzgR6ou=O7vPiA0ocX16g@mail.gmail.com>
References: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
 <1485592582.4916.1.camel@suse.de> <20170128110021.GA1604@katana> <20170128121346.1e530c1c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35092 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdA3BMK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 29 Jan 2017 20:12:10 -0500
In-Reply-To: <20170128121346.1e530c1c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Jean and Wolfram



On Sat, Jan 28, 2017 at 12:13 PM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Wolfram,
>
> On Sat, 28 Jan 2017 12:00:21 +0100, Wolfram Sang wrote:
>>
>> > >  /* count for request_region */
>> > > -#define SMBIOSIZE        8
>> > > +#define SMBIOSIZE        9
>> >
>> > Are you certain that all supported devices have this extra register?
>>
>> Isn't it better to have a potentially unused register mapped than a
>> potentially used register unmapped

We have been  "lucky" that it is a ioport and not a mmap region,
otherwise we would have seen a nice oops :).

>
> My concern is that the region request could fail due to a conflict with
> another device, if the physical I/O region is only 8 and we try to
> request 9.

I do not think that this is the case, if you check the top of the file
you can see how there are many other definitions for registers. I
expect that SMBIOSIZE=8 is just the original author being
conservative.

Of course I cannot say that there is one platform where one extra
ioport can cause a conflict, but I believe that we must request all
the ports that we will use.


Regards!
>
> --
> Jean Delvare
> SUSE L3 Support



-- 
Ricardo Ribalda
