From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Need some guidance on i2c-ocores driver
Date: Fri, 17 Apr 2015 08:47:03 -0700
Message-ID: <55312AF7.7070504@freescale.com>
References: <55304D8E.8070204@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55304D8E.8070204-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Julia.Lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Resend to LKML

Lee,

This question is actually more about MFD. Can you point me to the possible
causes for my failure below?

Thanks.

York


On 04/16/2015 05:02 PM, York Sun wrote:
> Julia and other experts,
> 
> I am seeking for help on my device driver.
> 
> I am working on a module driver for a FPGA design with open core I2C controller
> memory-mapped to BAR2. I have searched up and down and found only one driver
> (drivers/mfd/timberdale.c) with similar implementation. Following timberdale
> driver, I am able to load the driver, but blocked by devm_ioremap_resource(). It
> is always in conflict with my BAR2. I wonder if I did something wrong. Here is
> the flow I tracked so far. (By the way, I am using an older kernel 3.12. The new
> 4.0 kernel crashes when booting on my platform. I plan to move to newer kernel
> later).
> 
> mfd_add_devices()
> |
> |--mfd_add_device()
>     |
>     |--platform_device_add()
>         |
>         |--insert_resource()  /* this passed */
>         |   |
>         |   |--insert_resource_conflict()
>         |
>         |--device_add()
>             |
>             |--bus_probe_device()
>                 |
>                 |--devm_ioremap_resource()
>                     |
>                     |--devm_request_mem_region()
>                         |
>                         |--__request_region() /* this always conflicts */
>                             |
>                             |--__request_resource()
> 
> My driver is called RedStone DMA. Here is my debug output
> 
>> root@p1022ds:~# insmod redstone_mfd.ko 
>> RedStone DMA 0002:05:00.0: pci_enable_device() successful
>> RedStone DMA 0002:05:00.0: MSI-X init successful
>> York kernel: Calling devm_ioremap_resource()
>> York kernel kernel/resource.c __request_region 977: conflict=[??? 0xc00080000-0xc00087fff flags 0x80000000]
>> ocores-i2c ocores-i2c: can't request region for resource [mem 0xc00086000-0xc0008601f]
>> ocores-i2c: probe of ocores-i2c failed with error -16
>> RedStone DMA 0002:05:00.0: BAR[0] 0x0000000c00000000-0x0000000c0007ffff flags 0x0014220c, length 524288
>> RedStone DMA 0002:05:00.0: BAR[1] 0x0000000000000000-0x0000000000000000 flags 0x00000000, length 0
>> RedStone DMA 0002:05:00.0: BAR[2] 0x0000000c00080000-0x0000000c00087fff flags 0x00040200, length 32768
>> RedStone DMA 0002:05:00.0: BAR[3] 0x0000000000000000-0x0000000000000000 flags 0x00000000, length 0
>> RedStone DMA 0002:05:00.0: BAR[4] 0x0000000000000000-0x0000000000000000 flags 0x00000000, length 0
>> RedStone DMA 0002:05:00.0: BAR[5] 0x0000000000000000-0x0000000000000000 flags 0x00000000, length 0
>> RedStone DMA 0002:05:00.0: Version 1.4, built on 4-16-15, id 0
>> root@p1022ds:~# 
> 
> Can you shed some light on this?
> 
> Thanks.
> 
> York
> 
