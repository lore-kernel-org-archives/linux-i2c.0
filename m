From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: Haswell systems & i801 i2c driver
Date: Mon, 7 Apr 2014 14:25:56 -0600
Message-ID: <CAErSpo5jjo0HBeQTtTkiLdqk6vg+K51rXSF+qEbkwmM+QY1Acw@mail.gmail.com>
References: <5342E7C0.4050209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5342E7C0.4050209-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Janet Morgan <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Janet Morgan <jamorgan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

[+cc Rafael, Matthew, linux-acpi]

Hi Prarit,

On Mon, Apr 7, 2014 at 12:00 PM, Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> When loading the i801 i2c bus driver on an i5-46xx CPU, and this chipset
> http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/8-series-chipset-pch-datasheet.pdf
>
> I see the following warning:
>
> i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
> ACPI: resource 0000:00:1f.3 [io  0xefa0-0xefbf] conflicts with ACPI region SMBI
> [io 0xefa0-0xefaf]
> ACPI: This conflict may cause random problems and system instability
> ACPI: If an ACPI driver is available for this device, you should use it instead
> of the native driver
>
> It seems like the BIOS/ACPI defines a region, SMBI, which is defined for the
> SMBus to use, but there is no ACPI driver available for the SMBus (at least
> AFAICT).

Is this on a production BIOS?  It seems like a BIOS bug to expose a
PCI device with resources that are used by ACPI.  The spec you pointed
to does mention an "SMBus Disable" bit (sec 10.1.54) that claims to
disable PCI config space for this device.  Maybe the BIOS forgot to
set that?

If we (the Linux PCI core) discovered this device (00:1f.3), we
believe we own it and can assign a driver to it and potentially change
the resources assigned to it.

Changing the [io  0xefa0-0xefbf] BAR would likely break the SMBI
opregion because the AML using it wouldn't know about the change.

Assigning a driver, e.g., i801_smbus, seems likely to cause conflicts
with the AML that uses the SMBI opregion.  These could be difficult to
reproduce and debug.

If this is on a shipping BIOS, we might need to figure out some way to
handle it.  I don't remember anything in the ACPI spec that talks
about issues like this, but maybe we should add something in PCI that
notices if there's an ACPI device with the same resources and marks
the PCI device to keep us from moving it or assigning a driver (maybe
the warning you're seeing already handles the driver part?)

Bjorn
