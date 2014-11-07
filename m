From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH V2] ACPI: Add _DEP(Operation Region Dependencies)
 support to fix battery issue on the Asus T100TA
Date: Fri, 7 Nov 2014 13:05:47 +0200
Message-ID: <20141107110547.GT1618@lahna.fi.intel.com>
References: <1414422584-2638-1-git-send-email-tianyu.lan@intel.com>
 <7320898.JB9z5hUzdG@vostro.rjw.lan>
 <20141106061952.GC1618@lahna.fi.intel.com>
 <1576552.2oedNFkf9R@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1576552.2oedNFkf9R-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 07, 2014 at 12:00:34AM +0100, Rafael J. Wysocki wrote:
> > So if we have a device, like SDHB above (SDIO controller), that needs
> > GPIOs for powering the SDIO card and that is done by using GPIO
> > operation regions how do we ensure that the GPIO controller driver is
> > there?
> > 
> > I think the answer is that we just make sure the the GPIO driver is
> > there before anything that is going to use it. E.g make it
> > subsys_initcall() or so?
> 
> The current approach, which arguably is lame, has been to (1) compile in
> all drivers that *may* be depended on (like all drviers registering operation
> region handlers) and then (2) trick the devices to be registered in the right
> order.

Right, I kind of expected that it be the case :-/
 
> I'd rather have a more robust mechanism than that, but so far no one has
> proposed anything remotely usable.
> 
> As far as _DEP is concerned, it seems that in *practice* it is used to
> reflect functional dependencies between devices rather than the operation
> regions thing only (as specified).  In that case we may decide to follow
> the practice rather than the spec (and move to update the spec to reflect
> the practice at the same time), but that requires some consideration.

Indeed it looks very much that it contains more than just operation
depedencies. In T100 for example there is this PEPD device that does not
have any operation regions and it is still in the _DEP list of the SDIO
controller device.
