From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: i2c,designware: add new bindings
Date: Fri, 01 Aug 2014 19:09:41 +0100
Message-ID: <1406916581.30675.3.camel@acox1-desk.ger.corp.intel.com>
References: <1406117217.2895.12.camel@acox1-desk.ger.corp.intel.com>
	 <20140801175230.GD3277@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140801175230.GD3277@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-08-01 at 19:52 +0200, Wolfram Sang wrote:
> Hi Alan,
> 
> On Wed, Jul 23, 2014 at 01:06:57PM +0100, Alan Cox wrote:
> > This may appear as PCI or ACPI depending upon the firmware so we
> > have to list both. All share the same ACPI identifier but not
> > the same PCI identifier.
> > 
> > Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-pcidrv.c  |    9 +++++++++
> >  drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > index 3356f7a..d31d313 100644
> > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > @@ -188,6 +188,7 @@ static struct  dw_pci_controller dw_pci_controllers[] = {
> >  		.scl_sda_cfg = &hsw_config,
> >  	},
> >  };
> > +
> >  static struct i2c_algorithm i2c_dw_algo = {
> >  	.master_xfer	= i2c_dw_xfer,
> >  	.functionality	= i2c_dw_func,
> > @@ -350,6 +351,14 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
> >  	/* Haswell */
> >  	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
> >  	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
> > +	/* Braswell / Cherrytrail */
> > +	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail,},
> > +	{ PCI_VDEVICE(INTEL, 0x22C2), baytrail },
> > +	{ PCI_VDEVICE(INTEL, 0x22C3), baytrail },
> > +	{ PCI_VDEVICE(INTEL, 0x22C4), baytrail },
> > +	{ PCI_VDEVICE(INTEL, 0x22C5), baytrail },
> > +	{ PCI_VDEVICE(INTEL, 0x22C6), baytrail },
> > +	{ PCI_VDEVICE(INTEL, 0x22C7), baytrail },
> >  	{ 0,}
> >  };
> >  MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 402ec39..915ce6c2 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -106,6 +106,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
> >  	{ "INT3432", 0 },
> >  	{ "INT3433", 0 },
> >  	{ "80860F41", 0 },
> > +	{ "808622C1", 0 },
> 
> Why are 22c2 up to 22c7 not added here?


> This may appear as PCI or ACPI depending upon the firmware so we
> > have to list both. All share the same ACPI identifier but not
> > the same PCI identifier.
> > 

In PCI enumeration you have

808622C1, 808622C2, 808622C3 etc

but if ACPI enumerated then

808622C1 #1, 808622C1 #2, 8086 22C1 #3 etc

Hope that makes sense ?

Alan
