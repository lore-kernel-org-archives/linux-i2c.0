From: Boszormenyi Zoltan <zboszor-v1d7l9VOqKc@public.gmane.org>
Subject: Re: [PATCH 0/5 v4] Fix sp5100_tco watchdog driver regression
Date: Thu, 6 Jul 2017 09:50:33 +0200
Message-ID: <21338590-400b-e1b3-1787-bd275a30c17c@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170622132134.7200-1-zboszor-v1d7l9VOqKc@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, kernel-i2qG/+7/Q79eoWH0uzbU5w@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org, marc.2377-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cshorler-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

ping for the series.

Adding Greg Kroah-Hartman to the cc: list, both for the USB core
and stable series maintainership.

2017-06-22 15:21 keltezéssel, Zoltán Böszörményi írta:
> This patch series fixes a regression introduced by:
> 
> commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
> Author: Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date:   Thu Nov 19 20:13:48 2015 +0100
> 
>      i2c: piix4: Add support for multiplexed main adapter in SB800
> 
> The regression caused sp5100_tco fail to load:
> 
> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
> sp5100_tco: I/O address 0x0cd6 already in use
> 
> Notable bugzilla links about this issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=170741
> https://bugzilla.redhat.com/show_bug.cgi?id=1369269
> https://bugzilla.redhat.com/show_bug.cgi?id=1406844
> 
> The previous two versions of this patch series introduced
> a common mutex to synchronize access to the I/O port pair
> 0xcd6 / 0xcd7 used by the AMD SB800 USB PCI quirk code and
> the i2c-piix and sp5100_tco drivers. The common mutex was
> criticized because it introduces an inter-dependency between
> drivers.
> 
> This approach modifies the request_muxed_region() semantics and
> modifies the possible use cases.
> 
> The first patch in the series adds a new IORESOURCE_ALLOCATED
> flag that alloc_resource() sets and free_resource() considers.
> The core of __request_region() is factored out into a new function
> that doesn't allocate. With this change, drivers can use the
> pre-existing DEFINE_RES_IO_NAMED() static initialized macro
> to declare struct resource statically (e.g. on the stack)
> and pass the address of it to the new __request_declared_region()
> function. A new macro called request_declared_muxed_region()
> was added to exploit this functionality. Because of the new
> IORESOURCE_ALLOCATED resource flag, release_region() can still
> be called with the old interface (the port region start and
> end values) and it won't attempt to free a non-allocated resource.
> This eliminated one failure case that can come from allocation
> errors.
> 
> The second patch modifies the behaviour of IORESOURCE_MUXED,
> a.k.a. the request_*muxed_region() macros. When these macros
> are called, the caller goes to sleep when there is any conflicting
> regions, even if the conflicting region did not use the
> IORESOURCE_MUXED flag. The kernel logs this inconsistent
> flag usage with KERN_ERR. This change eliminates the second
> failure case for IORESOURCE_MUXED and request_muxed_region()
> can be used like mutex_lock(), i.e. it returns only in case it
> could successfully request the region.
> 
> The last three patches adds proper synchronization between the
> USB PCI quirks code and the i2c-piix and sp5100_tco drivers.
> 
> The result is that the sp5100_tco driver can load and works again:
> 
> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
> sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
> sp5100_tco: Last reboot was not triggered by watchdog.
> sp5100_tco: initialized (0xffffba2f4192db00). heartbeat=60 sec (nowayout=0)
> 
> Signed-off-by: Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-piix4.c | 41 ++++++++++++-------------------------
>   drivers/usb/host/pci-quirks.c  |  4 ++++
>   drivers/watchdog/sp5100_tco.c  | 28 +++++++++++++------------
>   include/linux/ioport.h         | 14 +++++++++++++
>   kernel/resource.c              | 46 ++++++++++++++++++++++++++++++++++++++----
>   5 files changed, 88 insertions(+), 45 deletions(-)
> 
> 

The synchronized access to the SB800 I/O ports seems to also have made a rare
"disabled by hub (EMI?), re-enabling..." report from the kernel disappear.

Can someone review the series?

Thanks in advance,
Zoltán Böszörményi
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
