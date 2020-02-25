From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [regression] nct6775 does not load in 5.4 and 5.5, bisected to
 b84398d6d7f90080
Date: Tue, 25 Feb 2020 14:13:25 +0200
Message-ID: <20200225121325.GX2667@lahna.fi.intel.com>
References: <1bdbac08-86f8-2a57-2b0d-8cd2beb2a1c0@roeck-us.net>
 <CAM1AHpSKFk9ZosQf=k-Rm2=EFqco7y4Lpfb7m07r=j_uJd4T0A@mail.gmail.com>
 <85356d1a-f90d-e94d-16eb-1071d4e94753@roeck-us.net>
 <CAM1AHpSpEFshpUGxKdhLV3XuThQg_XVaPgOWzvrTv6YtzHyO+A@mail.gmail.com>
 <bec1f81c-09a8-ba48-c6c4-5d9b340f7c0b@roeck-us.net>
 <20200224101800.GJ2667@lahna.fi.intel.com>
 <20200224103731.GA10400@smile.fi.intel.com>
 <20200224105121.GK2667@lahna.fi.intel.com>
 <20200224112740.GL2667@lahna.fi.intel.com>
 <CAM1AHpQW_=vvcjXHa8UOrdOohABm0sE2UPr4sfK2AtfWHsm4Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM1AHpQW_=vvcjXHa8UOrdOohABm0sE2UPr4sfK2AtfWHsm4Ag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Volf <martin.volf.42@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 24, 2020 at 06:30:21PM +0100, Martin Volf wrote:
> On Mon, Feb 24, 2020 at 12:27 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Feb 24, 2020 at 12:51:25PM +0200, Mika Westerberg wrote:
> > > > I'm wondering if
> > > >
> > > >             pci_dev_is_present(...);
> > > >
> > > > returns false here.
> > >
> > > Well that might also be the case since lspci shows this:
> > >
> > > 00:1f.0 ISA bridge: Intel Corporation Z390 Chipset LPC/eSPI Controller (rev 10)
> > > 00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
> > > 00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
> > >
> > > PMC is 1f.2 and not present here. However, it may be that the PMC is
> > > still there it just does not "enumerate" because its devid/vendorid are
> > > set to 0xffff. Similar hiding was done for the P2SB bridge.
> >
> > Actually I think this is the case here.
> >
> > I don't know the iTCO_wdt well enough to say if it could live without
> > the ICH_RES_IO_SMI. It looks like this register is used to disable SMI
> > generation but not sure how well it works if it is left to BIOS to
> > configure. I suppose these systems should use WDAT instead.
> >
> > Martin, can you try the below patch?
> >
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> > index ba87305f4332..c16e5ad08641 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -1593,7 +1593,7 @@ i801_add_tco_cnl(struct i801_priv *priv, struct pci_dev *pci_dev,
> >  static void i801_add_tco(struct i801_priv *priv)
> >  {
> >         u32 base_addr, tco_base, tco_ctl, ctrl_val;
> > -       struct pci_dev *pci_dev = priv->pci_dev;
> > +       struct pci_dev *pmc_dev, *pci_dev = priv->pci_dev;
> >         struct resource tco_res[3], *res;
> >         unsigned int devfn;
> >
> > @@ -1620,7 +1620,12 @@ static void i801_add_tco(struct i801_priv *priv)
> >          * Power Management registers.
> >          */
> >         devfn = PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 2);
> > -       pci_bus_read_config_dword(pci_dev->bus, devfn, ACPIBASE, &base_addr);
> > +       pmc_dev = pci_get_slot(pci_dev->bus, devfn);
> > +       if (!pmc_dev) {
> > +               dev_info(&pci_dev->dev, "PMC device disabled, not enabling iTCO\n");
> > +               return;
> > +       }
> > +       pci_read_config_dword(pmc_dev, ACPIBASE, &base_addr);
> >
> >         res = &tco_res[ICH_RES_IO_SMI];
> >         res->start = (base_addr & ~1) + ACPIBASE_SMI_OFF;
> > @@ -1630,15 +1635,17 @@ static void i801_add_tco(struct i801_priv *priv)
> >         /*
> >          * Enable the ACPI I/O space.
> >          */
> > -       pci_bus_read_config_dword(pci_dev->bus, devfn, ACPICTRL, &ctrl_val);
> > +       pci_read_config_dword(pmc_dev, ACPICTRL, &ctrl_val);
> >         ctrl_val |= ACPICTRL_EN;
> > -       pci_bus_write_config_dword(pci_dev->bus, devfn, ACPICTRL, ctrl_val);
> > +       pci_write_config_dword(pmc_dev, ACPICTRL, ctrl_val);
> >
> >         if (priv->features & FEATURE_TCO_CNL)
> >                 priv->tco_pdev = i801_add_tco_cnl(priv, pci_dev, tco_res);
> >         else
> >                 priv->tco_pdev = i801_add_tco_spt(priv, pci_dev, tco_res);
> >
> > +       pci_dev_put(pmc_dev);
> > +
> >         if (IS_ERR(priv->tco_pdev))
> >                 dev_warn(&pci_dev->dev, "failed to create iTCO device\n");
> >  }
> 
> Hello,
> 
> with the patch applied, the sensors are working, dmesg says:
> ...
> [    2.804423] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    2.804478] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [    2.804491] i801_smbus 0000:00:1f.4: PMC device disabled, not enabling iTCO
> ...
> [    2.826373] nct6775: Enabling hardware monitor logical device mappings.
> [    2.826447] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
> ...
> 
> and there is no "002e-0031" line in /proc/ioports.

Great, thanks for testing. I'll make an updated patch as suggested by
Guenter that makes the SMI resource optional and send it to you guys.
