From: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] misc: adds support the FSA9480 USB Switch
Date: Wed, 10 Nov 2010 09:55:34 +0900
Message-ID: <AANLkTi=vTkHJJ2dq5RZHHCwWYEBtY=Y7dPPh=Wzzx95f@mail.gmail.com>
References: <4C7CD95A.5040309@samsung.com>
	<20100917150731.f1f44f3c.akpm@linux-foundation.org>
	<AANLkTim2UhJAhOw1qHvZ9bbctR0tNSMvE61T=sxffHxO@mail.gmail.com>
	<4CB26931.5040105@samsung.com>
	<20101011173649.GC7116@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101011173649.GC7116-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Greg KH,

On 12 October 2010 02:36, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Oct 11, 2010 at 10:32:33AM +0900, Minkyu Kang wrote:
>> The FSA9480 is a USB port accessory detector and switch.
>> This patch adds support the FSA9480 USB Switch.
>>
>> Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> v2:
>> =A0use the threaded irq
>> =A0fix the sysfs
>>
>> =A0drivers/misc/Kconfig =A0 =A0| =A0 =A09 +
>> =A0drivers/misc/Makefile =A0 | =A0 =A01 +
>> =A0drivers/misc/fsa9480.c =A0| =A0544 ++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A0include/linux/fsa9480.h | =A0 40 ++++
>
> Why do you need a .h file here for a single driver?

Because of platform data.

>
> You are creating new sysfs files, so you are required to add a new
> Documentation/ABI file as well, please add that to this patch.

ok.

>
> And why are you exporting symbols from this driver, that should not b=
e
> needed at all.

It's for other drivers.
=46or example.. When USB cable is connected, PMIC driver enable the
power for each device. (USB, uart, audio and so on..)
But if use the manual switch, PMIC driver can't know what device is ena=
bled.
So, this function was exported.

>
>
>> +/*
>> + * fsa9480.c - FSA9480 micro USB switch device driver
>> + *
>> + * Copyright (C) 2010 Samsung Electronics
>> + * Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> + * Wonguk Jeong <wonguk.jeong-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>
> Are you positive about that "any later version" portion of this?

I will update the licence.

>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

Thanks
Minkyu Kang
--=20
from. prom.
www.promsoft.net
