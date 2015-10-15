From: Xiang Wang <wangxfdu@gmail.com>
Subject: Re: [PATCH 2/2] i2c: designware: enable High-speed mode for pcidrv
Date: Thu, 15 Oct 2015 13:46:42 +0800
Message-ID: <CACDNBm38bC+tP2S3WgUJJVRUppYF3=aUXvRtWfqfpM=BHapN9A@mail.gmail.com>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
	<1444380426-17953-2-git-send-email-wangxfdu@gmail.com>
	<1444383067.8361.517.camel@linux.intel.com>
	<CACDNBm3wkxAXbgQ4Z15uBFKUrsy9ngYKx3dGY20eV4RbSoJ5mg@mail.gmail.com>
	<1444638708.8361.564.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36556 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbbJOFqn (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Oct 2015 01:46:43 -0400
In-Reply-To: <1444638708.8361.564.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: xiang.a.wang@intel.com, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2015-10-12 16:31 GMT+08:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Mon, 2015-10-12 at 15:41 +0800, Xiang Wang wrote:
>> Hi, Andy
>> Thanks for your comments.
>>
>> [Andy] Don't see a relationship between PCI driver and this ACPI
>> stuff.
>> Although this is a pci driver, we may enumerate the i2c devices from
>> DSDT table while i2c controllers are enumerated via PCI. In this
>> scenario, in DSDT, there are descriptions of i2c devices as well as
>> i2c controllers. The ACPI node of i2c controllers are bond to i2c PCI
>> devices via pci-acpi glue.
>> So if we want to determine the i2c devices' settings (e.g. bus
>> speed),
>> we should leverage ACPI.
>>
>> Above is also the reason why the ACPI stuff is put in
>> i2c-designware-core: i2c_dw_acpi_setup_speed can be used by both plat
>> and pci driver. Thanks
>
> Wait, first of all let's divide parameters to two groups: a) to be
> applied to host driver, and b) to be applied to slave devices.
>
> The drivers/i2c/busses/i2c-designware* is about host driver parameters.
>
> Thus, PCI driver comes with hardcoded values since it's enumerated via
> PCI, and platform driver utilizes ACPI values.
>
> For slave devices everything is done in i2c-core.c.
>
> So, what exactly you are trying to enhance?
Agree on your analysis. The bus speed mode is a "host controller"
parameter. We can hardcode it in PCI driver.
However,
1. "bus speed mode" is a bit different from other parameters. Actually
it can be determined by the speed setting of "i2c devices" in ACPI
(I2CSerialBus). E.g. If i2c device uses 3MHz, we use High-speed mode
for this i2c bus.
2. If we hardcode speed setting in pci driver, we lose the
flexibility. A high-speed device may be connected to this i2c bus on
this board, but may be connected to another i2c bus on another board
design.

In this patch, we enumerate the i2c device in ACPI table to determine
the frequency setting. Then we set corresponding speed mode for this
i2c controller. The ACPI stuff is common for pci and plat driver. If
board design changes, we only change BIOS.

In conclusion, we have 2 solutions to set the i2c controller speed
mode (pci driver):
1) use hardcode value in pci driver
2) use frequency setting of "i2c device" in ACPI table (more flexible,
but looks a bit strange)

Do you have any preference/suggestions for above solutions? Thanks
>
>>
>> 2015-10-09 17:31 GMT+08:00 Andy Shevchenko <
>> andriy.shevchenko@linux.intel.com>:
>> > On Fri, 2015-10-09 at 16:47 +0800, wangxfdu@gmail.com wrote:
>> > > From: Xiang Wang <xiang.a.wang@intel.com>
>> > >
>> > > 1. Support setting hs_hcnt and hs_lcnt
>> > > 2. Get bus speed mode from ACPI companion of the
>> > > i2c controller.
>> > >
>> > > Signed-off-by: Xiang Wang <xiang.a.wang@intel.com>
>> > > ---
>> > >  drivers/i2c/busses/i2c-designware-pcidrv.c | 7 +++++++
>> > >  1 file changed, 7 insertions(+)
>> > >
>> > > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
>> > > b/drivers/i2c/busses/i2c-designware-pcidrv.c
>> > > index 6643d2d..0f4c0c4 100644
>> > > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
>> > > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
>> > > @@ -54,8 +54,10 @@ enum dw_pci_ctl_id_t {
>> > >  struct dw_scl_sda_cfg {
>> > >       u32 ss_hcnt;
>> > >       u32 fs_hcnt;
>> > > +     u32 hs_hcnt;
>> > >       u32 ss_lcnt;
>> > >       u32 fs_lcnt;
>> > > +     u32 hs_lcnt;
>> > >       u32 sda_hold;
>> > >  };
>> > >
>> > > @@ -237,8 +239,10 @@ static int i2c_dw_pci_probe(struct pci_dev
>> > > *pdev,
>> > >               cfg = controller->scl_sda_cfg;
>> > >               dev->ss_hcnt = cfg->ss_hcnt;
>> > >               dev->fs_hcnt = cfg->fs_hcnt;
>> > > +             dev->hs_hcnt = cfg->hs_hcnt;
>> > >               dev->ss_lcnt = cfg->ss_lcnt;
>> > >               dev->fs_lcnt = cfg->fs_lcnt;
>> > > +             dev->hs_lcnt = cfg->hs_lcnt;
>> > >               dev->sda_hold_time = cfg->sda_hold;
>> > >       }
>> > >
>> > > @@ -246,6 +250,9 @@ static int i2c_dw_pci_probe(struct pci_dev
>> > > *pdev,
>> > >
>> > >       dev->tx_fifo_depth = controller->tx_fifo_depth;
>> > >       dev->rx_fifo_depth = controller->rx_fifo_depth;
>> > > +
>> > > +     i2c_dw_acpi_setup_speed(&pdev->dev, dev);
>> >
>> > Don't see a relationship between PCI driver and this ACPI stuff.
>> >
>> > > +
>> > >       r = i2c_dw_init(dev);
>> > >       if (r)
>> > >               return r;
>> >
>> > --
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > Intel Finland Oy
>>
>>
>>
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy



-- 
Regards,
Xiang
