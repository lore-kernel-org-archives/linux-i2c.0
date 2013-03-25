From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: i2c_i801: status of use hardware semaphore patch?
Date: Mon, 25 Mar 2013 16:30:52 -0500 (CDT)
Message-ID: <6cccf5d6-b6e7-4dcc-96c3-681aae9b29aa@zimbra>
References: <514B9318.4050902@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <514B9318.4050902-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Cc: Jason Baron <jbaron-JqFfY2XvxFXQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> From: "Martin Mokrejs" <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
> Jason Baron wrote:
> > Hi,
> > 
> > I've also hit the i2c_i801 driver conflicts with ACPI region:
> > 
> > kernel: [73904.044722] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18
> > (level, low) -> IRQ 18
> > kernel: [73904.045573] ACPI: resource 0000:00:1f.3 [io
> >  0xf000-0xf01f]
> > conflicts with ACPI region SMBI [io 0xf000-0xf00f]
> > kernel: [73904.046461] ACPI: If an ACPI driver is available for
> > this
> > device, you should use it instead of the native driver
> > 
> > I tested this patch:
> > http://marc.info/?l=linux-i2c&m=135188429220187&w=2
> > 
> > And it avoids the warning (as we no longer check for acpi
> > conflicts).
> > However, I don't see the patch in any trees. Are there
> > any reservations in applying it?
> 
> 
> Hi Jason,
>   I am getting the resource conflict on my laptop. Would you tell me
> if this kmemleak reported by kernel could be fixed by the patch?
> You say it will shut down the check and warning ... but is that
> meaningful?
> 
> 
> unreferenced object 0xffff88040ac7d690 (size 256):
>   comm "swapper/0", pid 1, jiffies 4294937576 (age 30752.970s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff c8 6f 5e 82 ff ff ff ff  .........o^.....
>   backtrace:
>     [<ffffffff815bad38>] kmemleak_alloc+0x21/0x3e
>     [<ffffffff811105d2>] slab_post_alloc_hook+0x28/0x2a
>     [<ffffffff81112b0a>] __kmalloc+0xf2/0x104
>     [<ffffffff8130542d>] kzalloc.constprop.14+0xe/0x10
>     [<ffffffff8130588e>] device_private_init+0x14/0x63
>     [<ffffffff81307974>] dev_set_drvdata+0x19/0x2f
>     [<ffffffff815cb1c4>] i801_probe+0x5e/0x451
>     [<ffffffff812810c8>] local_pci_probe+0x39/0x61
>     [<ffffffff812821db>] pci_device_probe+0xc6/0xf3
>     [<ffffffff81307f3d>] driver_probe_device+0xa9/0x1c1
>     [<ffffffff813080af>] __driver_attach+0x5a/0x7e
>     [<ffffffff813067d7>] bus_for_each_dev+0x5c/0x88
>     [<ffffffff81307ada>] driver_attach+0x19/0x1b
>     [<ffffffff813076aa>] bus_add_driver+0xa8/0x1fa
>     [<ffffffff81308521>] driver_register+0x8c/0x106
>     [<ffffffff81281dd6>] __pci_register_driver+0x59/0x5d
>
> Thanks,
> Martin

Martin,
At first glance the issue that you describe seems to be unrelated to
the hardware semaphore patch. You see the same kernel log output
that Jason reported?

It seems like your laptop isn't affected by the resource conflict,
since it appears to reach the pci_set_drvdata() call at the end of
the i801_probe() function. If your laptop were experiencing the same
resource conflict that Jason and I are seeing, then the following
test would prevent pci_set_drvdata() from being called at all:

	err = acpi_check_resource_conflict(&dev->resource[SMBBAR]);
	if (err) {
		err = -ENODEV;
		goto exit;
	}

-Aaron
