From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: enable High-speed mode for pcidrv
Date: Mon, 12 Oct 2015 11:31:48 +0300
Message-ID: <1444638708.8361.564.camel@linux.intel.com>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
	 <1444380426-17953-2-git-send-email-wangxfdu@gmail.com>
	 <1444383067.8361.517.camel@linux.intel.com>
	 <CACDNBm3wkxAXbgQ4Z15uBFKUrsy9ngYKx3dGY20eV4RbSoJ5mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42350 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbbJLIbx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 04:31:53 -0400
In-Reply-To: <CACDNBm3wkxAXbgQ4Z15uBFKUrsy9ngYKx3dGY20eV4RbSoJ5mg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Xiang Wang <wangxfdu@gmail.com>
Cc: xiang.a.wang@intel.com, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-10-12 at 15:41 +0800, Xiang Wang wrote:
> Hi, Andy
> Thanks for your comments.
> 
> [Andy] Don't see a relationship between PCI driver and this ACPI 
> stuff.
> Although this is a pci driver, we may enumerate the i2c devices from
> DSDT table while i2c controllers are enumerated via PCI. In this
> scenario, in DSDT, there are descriptions of i2c devices as well as
> i2c controllers. The ACPI node of i2c controllers are bond to i2c PCI
> devices via pci-acpi glue.
> So if we want to determine the i2c devices' settings (e.g. bus 
> speed),
> we should leverage ACPI.
> 
> Above is also the reason why the ACPI stuff is put in
> i2c-designware-core: i2c_dw_acpi_setup_speed can be used by both plat
> and pci driver. Thanks

Wait, first of all let's divide parameters to two groups: a) to be
applied to host driver, and b) to be applied to slave devices.

The drivers/i2c/busses/i2c-designware* is about host driver parameters.

Thus, PCI driver comes with hardcoded values since it's enumerated via
PCI, and platform driver utilizes ACPI values.

For slave devices everything is done in i2c-core.c.

So, what exactly you are trying to enhance?

> 
> 2015-10-09 17:31 GMT+08:00 Andy Shevchenko <
> andriy.shevchenko@linux.intel.com>:
> > On Fri, 2015-10-09 at 16:47 +0800, wangxfdu@gmail.com wrote:
> > > From: Xiang Wang <xiang.a.wang@intel.com>
> > > 
> > > 1. Support setting hs_hcnt and hs_lcnt
> > > 2. Get bus speed mode from ACPI companion of the
> > > i2c controller.
> > > 
> > > Signed-off-by: Xiang Wang <xiang.a.wang@intel.com>
> > > ---
> > >  drivers/i2c/busses/i2c-designware-pcidrv.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > index 6643d2d..0f4c0c4 100644
> > > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > @@ -54,8 +54,10 @@ enum dw_pci_ctl_id_t {
> > >  struct dw_scl_sda_cfg {
> > >       u32 ss_hcnt;
> > >       u32 fs_hcnt;
> > > +     u32 hs_hcnt;
> > >       u32 ss_lcnt;
> > >       u32 fs_lcnt;
> > > +     u32 hs_lcnt;
> > >       u32 sda_hold;
> > >  };
> > > 
> > > @@ -237,8 +239,10 @@ static int i2c_dw_pci_probe(struct pci_dev
> > > *pdev,
> > >               cfg = controller->scl_sda_cfg;
> > >               dev->ss_hcnt = cfg->ss_hcnt;
> > >               dev->fs_hcnt = cfg->fs_hcnt;
> > > +             dev->hs_hcnt = cfg->hs_hcnt;
> > >               dev->ss_lcnt = cfg->ss_lcnt;
> > >               dev->fs_lcnt = cfg->fs_lcnt;
> > > +             dev->hs_lcnt = cfg->hs_lcnt;
> > >               dev->sda_hold_time = cfg->sda_hold;
> > >       }
> > > 
> > > @@ -246,6 +250,9 @@ static int i2c_dw_pci_probe(struct pci_dev 
> > > *pdev,
> > > 
> > >       dev->tx_fifo_depth = controller->tx_fifo_depth;
> > >       dev->rx_fifo_depth = controller->rx_fifo_depth;
> > > +
> > > +     i2c_dw_acpi_setup_speed(&pdev->dev, dev);
> > 
> > Don't see a relationship between PCI driver and this ACPI stuff.
> > 
> > > +
> > >       r = i2c_dw_init(dev);
> > >       if (r)
> > >               return r;
> > 
> > --
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Intel Finland Oy
> 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
