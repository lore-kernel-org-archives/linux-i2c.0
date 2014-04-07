From: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Haswell systems & i801 i2c driver
Date: Mon, 07 Apr 2014 14:00:32 -0400
Message-ID: <5342E7C0.4050209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Janet Morgan <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Janet Morgan <jamorgan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When loading the i801 i2c bus driver on an i5-46xx CPU, and this chipset
http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/8-series-chipset-pch-datasheet.pdf

I see the following warning:

i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ACPI: resource 0000:00:1f.3 [io  0xefa0-0xefbf] conflicts with ACPI region SMBI
[io 0xefa0-0xefaf]
ACPI: This conflict may cause random problems and system instability
ACPI: If an ACPI driver is available for this device, you should use it instead
of the native driver

It seems like the BIOS/ACPI defines a region, SMBI, which is defined for the
SMBus to use, but there is no ACPI driver available for the SMBus (at least
AFAICT).

I'm using "acpi_enforce_resources=lax" as a kernel parameter to work around
the issue but was wondering if there was a more robust fix planned for this
problem?  If not -- anyone want to point me in the right direction of a fix?

Thanks,

P.
