From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] Allow mixed endianness accesses
Date: Fri, 15 Jan 2010 09:04:29 -0500
Message-ID: <4B5075ED.8020307@octasic.com>
References: <20100113193224.753273000@octasic.com> <20100113193421.212989000@octasic.com> <4B4FB03E.1070708@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B4FB03E.1070708-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Shinya Kuribayashi wrote:
> Jean-Hugues Deschenes wrote:
>> Allows CPUs of a given endianness to access a dw controller of a 
>> different
>> endianness. Endianncess difference is detected at run time through 
>> the dw
>> component type register.
>>
>> ---
>>  drivers/i2c/busses/i2c-designware.c |   17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
>> ===================================================================
>> --- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
>> +++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/io.h>
>> +#include <linux/swab.h>
>>
>>  /*
>>   * Registers offset
>
> I'm working on 2.6.27 MIPS kernel
> so I'm not sure it works or not there.
> I hope this works with the latest LMO tree.
I'll download a MIPS toolchain and give it a try.
> Now I understand the background of the patch, so my question is,
> is this worth run-time probed?  In this case, DW IP's endian is
> different from CPU endian, and which can not be resolved via io/swab
> settings in any way, that's fine.
>
> Then I wonder is there any way to statically optimize them?
Humm... Configuration options (controlling #ifdefs) are a possibility, 
although I must admit I'm not so fond of this option, because it's error 
prone.

I believe the problem is not with the automatic detection per se (which 
is done at init, where performance is not so much an issue), but with 
the extra IFs at each memory access... There, the other option I can 
think of is having 2 sets of accessors, 
dw_readl_[bl]e()/dw_writel_[bl]e() and have them accessed via function 
pointers (set at init, following the auto-detection). But I'm not sure 
that loosing the option of inlining the accessor funtion (since they 
would now have to be accessed via function pointers) would really result 
in a performance gain...

jh
