From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Need some guidance on i2c-ocores driver
Date: Mon, 20 Apr 2015 09:24:25 -0700
Message-ID: <55352839.70905@freescale.com>
References: <55304D8E.8070204@freescale.com> <55312AF7.7070504@freescale.com> <20150420064231.GE3447@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150420064231.GE3447@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Julia.Lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 04/19/2015 11:42 PM, Lee Jones wrote:
> On Fri, 17 Apr 2015, York Sun wrote:
> 
>> Resend to LKML
>>
>> Lee,
>>
>> This question is actually more about MFD. Can you point me to the possible
>> causes for my failure below?
> 
> It's hard to tell exactly without code, but it looks like you're
> trying to allocate overlapping memory regions.  Double check all of
> your addresses.  For DT you need to take a look at your 'reg'
> properties, for traditional platform data it's best to grep for
> IORESOURCE_MEM.
> 
Lee,

It _is_ overlapping. How could it not be? The resource for the I2C is mapped to
BAR2. So the resource is overlapping with BAR2. It is alway the case, isn't it?
What I don't understand is how MFD works with the resources if it is guaranteed
overlapping. Did I get something wrong?

Look at the reference code I took, drivers/mfd/timberdale.c, when
mfd_add_devices() is called, it uses &dev->resource as the base. So the BAR will
be the parent. Check the code in mfd-core.c, mfd_add_device(),

if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
	res[r].parent = mem_base;
	res[r].start = mem_base->start + cell->resources[r].start;
	res[r].end = mem_base->start + cell->resources[r].end;
}

So the MFD resource is within its parent. When later the device driver request a
region, will it get conflict with the parent?

York
