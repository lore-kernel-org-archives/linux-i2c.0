From: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Haswell systems & i801 i2c driver
Date: Wed, 09 Apr 2014 12:21:40 -0400
Message-ID: <53457394.1020404@redhat.com>
References: <5342E7C0.4050209@redhat.com> <CAErSpo5jjo0HBeQTtTkiLdqk6vg+K51rXSF+qEbkwmM+QY1Acw@mail.gmail.com> <1396902638.5276.2.camel@x230> <20140407225620.23d52a0c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407225620.23d52a0c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jamorgan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 04/07/2014 04:56 PM, Jean Delvare wrote:
> On Mon, 7 Apr 2014 20:30:39 +0000, Matthew Garrett wrote:
>>> If this is on a shipping BIOS, we might need to figure out some way to
>>> handle it.  I don't remember anything in the ACPI spec that talks
>>> about issues like this, but maybe we should add something in PCI that
>>> notices if there's an ACPI device with the same resources and marks
>>> the PCI device to keep us from moving it or assigning a driver (maybe
>>> the warning you're seeing already handles the driver part?)
>>
>> This is, sadly, pretty typical. SMBus devices are often exposed via PCI
>> even though they're accessed directly via AML. The current behaviour
>> seems about as good as it gets - we warn the user that this could cause
>> problems, and they can pass a kernel parameter that allows them to do it
>> anyway.
> 
> The proper way to handle it at the BIOS level is to expose the SMBus to
> the OS by implementing the ACPI SMBus CMI as supported by the i2c-scmi
> driver. Unfortunately most BIOS do not bother implementing that
> interface, effectively locking the OS out of the SMBus controller and
> everything behind it. This has been a major pain for years :(

Hey Jean, Thanks for the info.

I'm about to RFC an algorithm patch for the i801 ACPI SBUS.  I dunno if it is
really a good thing to do outside of Intel or if we should wait for a CMI.  OTOH
it seems to work and your comment that "This has been a major pain for years"
worries me that we'll never see a solution.

P.
> 
