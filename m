From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Tue, 5 Feb 2019 13:57:36 -0600
Message-ID: <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
References: <20181226232258.GA23526@syn-yoga530> <20190205120545.GA1045@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205120545.GA1045@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Elie Morisse <syniurge@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 5, 2019 at 6:06 AM Wolfram Sang <wsa@the-dreams.de> wrote:

> > +03:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD] Device
> > +                                                                     15e6
> > +
> > +in your 'lspci -v', then this driver is for your device.
>
> Sidenote: Can't we add something to the pci-ids to make it possible to
> identify it correctly/make it more readable to the user?

Yes, please add the correct info at https://pci-ids.ucw.cz/

> Please remove this debugfs interface. There must be generic ways to read out
> PCI memory?

There are sysfs files that provide access to the raw contents of MMIO
BARs, e.g.,

  /sys/devices/pci0000:00/0000:00:1f.3/resource0

> > +static int amd_mp2_pci_probe(struct pci_dev *pci_dev,
> > +                          const struct pci_device_id *id)
> > +{
> > +     struct amd_mp2_dev *privdata;
> > +     int rc;
> > +     static bool first_probe = true;
> > +
> > +     if (first_probe) {
> > +             pr_info("%s: %s Version: %s\n", DRIVER_NAME,
> > +                     DRIVER_DESC, DRIVER_VER);
> > +             first_probe = false;
> > +     }
> > +
> > +     dev_info(&pci_dev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> > +              pci_dev->vendor, pci_dev->device, pci_dev->revision);
> > +
>
> The kernel prints already too much during boot. So, please remove this.
> It will also get rid of the static variable which is not so good style.

The PCI core already prints the vendor/device ID of everything it
finds.  I don't think it prints the revision.

I doubt the driver name/version is really useful.  Nobody ever updates
the versions anyway, and I think customers will key off the distro
kernel version, which should uniquely identify the driver version.

> > +struct amd_mp2_dev *amd_mp2_find_device(void)
> > +{
> > +     struct device *dev;
> > +     struct pci_dev *pci_dev;
> > +
> > +     dev = driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL,
> > +                              amd_mp2_device_match);
> > +     if (!dev)
> > +             return NULL;
> > +
> > +     pci_dev = to_pci_dev(dev);
> > +     if (!amd_mp2_pci_is_probed(pci_dev))
> > +             return NULL;
> > +     return (struct amd_mp2_dev *)pci_get_drvdata(pci_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(amd_mp2_find_device);
>
> Can't you just share a common flag when the PCI driver is successfully
> probed and let the platform driver defer until this flag is set?
>
> Reading this, I also don't think there should be two seperate Kconfig
> and Makefile entries. You need both to have working I2C, so one Kconfig
> entry should compile both files.

IMHO the split into two drivers is a bit of a mess and doesn't really
correspond with the hardware, as I mentioned at [1].  The PCI device
is the real hardware and the driver should claim that.  AFAICT the
ACPI device exists only to pass some config information to the PCI
driver.  I think the natural approach would be for the PCI driver to
directly search the ACPI namespace for that config information.

The fact that driver_find_device() is essentially unused except for a
few very special cases is a good clue that there's probably a better
way.

Bjorn

[1] https://lkml.kernel.org/r/20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com
