From: York Sun <yorksun@freescale.com>
Subject: Re: Need some guidance on i2c-ocores driver
Date: Mon, 20 Apr 2015 11:31:39 -0700
Message-ID: <5535460B.2060309@freescale.com>
References: <55304D8E.8070204@freescale.com> <55312AF7.7070504@freescale.com> <20150420064231.GE3447@x1> <55352839.70905@freescale.com> <20150420181651.GF3447@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420181651.GF3447@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Julia.Lawall@lip6.fr, linux-i2c@vger.kernel.org, wolfram@the-dreams.de, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 04/20/2015 11:16 AM, Lee Jones wrote:
> On Mon, 20 Apr 2015, York Sun wrote:
> 
>>
>>
>> On 04/19/2015 11:42 PM, Lee Jones wrote:
>>> On Fri, 17 Apr 2015, York Sun wrote:
>>>
>>>> Resend to LKML
>>>>
>>>> Lee,
>>>>
>>>> This question is actually more about MFD. Can you point me to the possible
>>>> causes for my failure below?
>>>
>>> It's hard to tell exactly without code, but it looks like you're
>>> trying to allocate overlapping memory regions.  Double check all of
>>> your addresses.  For DT you need to take a look at your 'reg'
>>> properties, for traditional platform data it's best to grep for
>>> IORESOURCE_MEM.
>>>
>> Lee,
>>
>> It _is_ overlapping. How could it not be? The resource for the I2C is mapped to
>> BAR2. So the resource is overlapping with BAR2. It is alway the case, isn't it?
>> What I don't understand is how MFD works with the resources if it is guaranteed
>> overlapping. Did I get something wrong?
>>
>> Look at the reference code I took, drivers/mfd/timberdale.c, when
>> mfd_add_devices() is called, it uses &dev->resource as the base. So the BAR will
>> be the parent. Check the code in mfd-core.c, mfd_add_device(),
>>
>> if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
>> 	res[r].parent = mem_base;
>> 	res[r].start = mem_base->start + cell->resources[r].start;
>> 	res[r].end = mem_base->start + cell->resources[r].end;
>> }
>>
>> So the MFD resource is within its parent. When later the device driver request a
>> region, will it get conflict with the parent?
> 
> I doubt you'll want to map the same memory area in both the parent and
> the child device drivers.  Only map the registers you plan to use in
> the driver you plan to use them.  If you need multiple devices to
> access the same registers then you need to create an API, complete
> with locking, in the MFD parent device.
> 

Thanks for pointing out. I thought at first the conflict was due to my
pci_ioremap_bar(). I went ahead to remove the mapping but still not working.
Your email inspired me to take a deeper look at my code and I found my error. I
have called pci_request_regions() which reserves all BARs. I think that's my
root cause. Thanks for helping me.

York
