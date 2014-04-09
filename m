From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 18:37:32 +0200
Message-ID: <20140409183732.5c8f6355@endymion.delvare>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397060563-30431-1-git-send-email-prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Janet Morgan <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Prarit,

On Wed,  9 Apr 2014 12:22:43 -0400, Prarit Bhargava wrote:
> RFC and a work in progress ... I need to go through and do a bunch of error
> condition checking, more testing, etc.  I'm just throwing this out there to see
> if anyone has any major concerns about doing something like this.
> 
> TODO:
> 
> - decipher error returns from ACPI AML operations (and implement those too)
> - additional error checking from i2c and acpi function calls (this code is
> not robust enough)
> - testing
> 
> P.
> 
> ----8<----
> 
> Some ACPI tables on new systems implement an SBUS device in ACPI.  This results
> in a conflict with the ACPI tables and the i2c-i801 driver over the address
> space.  As a result the i2c-i801 driver will not load.  To workaround this, we
> have users use the kernel parameter "acpi_enforce_resources=lax".  This,
> isn't a good solution as I've seen other conflicts on some systems that are
> also overriden.  I thought about implementing an i2c-core kernel parameter and
> a wrapper function for acpi_check_resource_conflict() but that seems rather
> clunky and doesn't resolve the issue of the shared resource between the ACPI
> and the device.
> 
> There isn't any documentaton on Intel's website about the SBUS device but from
> reading the acpidump it looks like the operations are straightforward.
> 
> SSXB
>      transmit one byte
> SRXB
>      receive one byte
> SWRB
>      write one byte
> SRDB
>      read one byte
> SWRW
>      write one word
> SRDW
>      read one word
> SBLW
>      write block
> SBRW
>      read block
> 
> I've implemented these as an i2c algorithm so that users who cannot load the
> regular i801 i2c driver can at least get the functionality they are looking
> for.

Writing a driver for the ACPI interface to the SMBus is IMHO a very
good idea, thanks for doing that.

However I have two technical concerns with your approach:

1* What you wrote is NOT an "i2c algo". i2c "algorithms" are abstracted
I2C implementations, not correlated with any hardware or BIOS specific
interfaces. If you check other drivers under i2c/algos you'll see they
do NOT call i2c_add_adapter (although they may implement helper
wrappers around that function.) Hardware-specific drivers which build
on top of the algo driver are responsible for that.

What you wrote is much more like i2c/busses/i2c-scmi.c, so it is
actually an i2c _bus_ driver.

2* You are creating a link between i2c-i801 and your driver, where IMHO
there should not be any. Both drivers are independent, and from the
kernel's perspective, they are not even for the same hardware. In your
case the ACPI interface is backed by an i801-like chip, but the same
interface could totally be implemented on top of any other chip.

So I invite you to make your driver an independent i2c bus driver much
like i2c-scmi.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
