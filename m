From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Haswell systems & i801 i2c driver
Date: Mon, 7 Apr 2014 22:56:20 +0200
Message-ID: <20140407225620.23d52a0c@endymion.delvare>
References: <5342E7C0.4050209@redhat.com>
	<CAErSpo5jjo0HBeQTtTkiLdqk6vg+K51rXSF+qEbkwmM+QY1Acw@mail.gmail.com>
	<1396902638.5276.2.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396902638.5276.2.camel@x230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jamorgan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 7 Apr 2014 20:30:39 +0000, Matthew Garrett wrote:
> > If this is on a shipping BIOS, we might need to figure out some way to
> > handle it.  I don't remember anything in the ACPI spec that talks
> > about issues like this, but maybe we should add something in PCI that
> > notices if there's an ACPI device with the same resources and marks
> > the PCI device to keep us from moving it or assigning a driver (maybe
> > the warning you're seeing already handles the driver part?)
> 
> This is, sadly, pretty typical. SMBus devices are often exposed via PCI
> even though they're accessed directly via AML. The current behaviour
> seems about as good as it gets - we warn the user that this could cause
> problems, and they can pass a kernel parameter that allows them to do it
> anyway.

The proper way to handle it at the BIOS level is to expose the SMBus to
the OS by implementing the ACPI SMBus CMI as supported by the i2c-scmi
driver. Unfortunately most BIOS do not bother implementing that
interface, effectively locking the OS out of the SMBus controller and
everything behind it. This has been a major pain for years :(

-- 
Jean Delvare
SUSE L3 Support
