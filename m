From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Fwd: Hid over I2C and ACPI interaction
Date: Fri, 6 Jul 2012 08:52:34 +0300
Message-ID: <20120706055234.GC2237@intel.com>
References: <CAN+gG=GnMX8Gu6w9za2QrjoVrmORncFgq-+hhmHvxtOPEB=nDw@mail.gmail.com>
 <4FF52C70.9010601@intel.com>
 <1341471717.1682.125.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341471717.1682.125.camel-fuY85erJQUO75v1z/vFq2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, chatty-rXV5z7KbLFk@public.gmane.org, jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 05, 2012 at 03:01:57PM +0800, Zhang Rui wrote:
> +Note that although these are ACPI devices, we prefer to use PnP drivers
> for them,
> +this is because:
> +1. all the non-ACPI-predefined Devices are exported as PnP devices as
> well
> +2. PnP bus is a well designed bus. Probing via PnP layer saves a lot of
> work
> +   for the device driver, e.g. getting & parsing ACPI resources.

(Nice BKM, thanks for sharing)

I have few questions about using PnP drivers instead of pure ACPI drivers.

ACPI 5.0 defined some new resources, for example "Fixed DMA descriptor"
that has information about the request line + channel for the device to
use. Hovewer, PnP drivers pass resources as 'struct resource', which
basically only has start and end - how do you represent all this new stuff
using 'struct resource'?

Or should we use acpi_walk_resources() where 'struct resource' is not
suitable?
