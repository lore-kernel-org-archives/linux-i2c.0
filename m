From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Tue, 16 Feb 2010 18:29:47 +0100
Message-ID: <20100216182947.61f0e6ff@hyperion.delvare>
References: <4B73DAEE.5080400@compulab.co.il>
	<4B73DB4B.40501@compulab.co.il>
	<20100216100809.GA2935@sortiz.org>
	<43F901BD926A4E43B106BF17856F0755A2D58DB5@orsmsx508.amr.corp.intel.com>
	<20100216164523.5a3e13a5@hyperion.delvare>
	<43F901BD926A4E43B106BF17856F0755A2D58F23@orsmsx508.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43F901BD926A4E43B106BF17856F0755A2D58F23-osO9UTpF0UQ8Ug9VwtkbtrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 16 Feb 2010 09:19:58 -0800, Pan, Jacob jun wrote:
> >That shouldn't be a problem. The PCI device is still present, so
> >sensors-detect will see it. Then it will load the required driver, and
> >that driver will instantiate i2c adapters. The script then probes all
> >i2c adapters regardless of who created them, so the exact driver
> >implementation doesn't matter.
> >
> [[JPAN]] thanks for explaining it, all made sense to me. looking at
> sensors-detect, it will still load isch driver for the same pci id.
> but how would it know it depends on the new lpc driver to set up resources?
> i can't see shared symbols.
> 
> 	}, {
> 		vendid	=> 0x8086,
> 		devid	=> 0x8119,
> 		procid	=> "Intel SCH",
> 		driver	=> "i2c-isch",
> 	},

On systems with udev, I would expect the mfd driver to load
automatically through module aliases, so this should be OK. Actually,
even i2c-isch should load automatically if we setup proper aliases for
the platform devices it instantiates. For other systems, indeed, the
mfd driver won't load in the absence of a shared symbol. Might be worth
adding request_module() call in platform drivers? If this isn't
acceptable for whatever reason, I can certainly hack sensors-detect to
treat this uncommon case properly, but solving this problem at the
application level seems wrong.

-- 
Jean Delvare
