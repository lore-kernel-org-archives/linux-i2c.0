From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 5/5] i2c: designware-baytrail: Add support for
 cherrytrail
Date: Mon, 12 Dec 2016 13:42:05 +0200
Message-ID: <1481542925.7188.23.camel@linux.intel.com>
References: <20161210224350.10290-1-hdegoede@redhat.com>
         <20161210224350.10290-5-hdegoede@redhat.com>
         <1481538690.7188.18.camel@linux.intel.com>
         <8b835a2c-a54c-8539-2ffd-28a480459a2b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17763 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbcLLLmK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Dec 2016 06:42:10 -0500
In-Reply-To: <8b835a2c-a54c-8539-2ffd-28a480459a2b@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

On Mon, 2016-12-12 at 11:48 +0100, Hans de Goede wrote:
> Hi,
> 
> On 12-12-16 11:31, Andy Shevchenko wrote:
> > On Sat, 2016-12-10 at 23:43 +0100, Hans de Goede wrote:
> > > The cherrytrail punit has the pmic i2c bus access semaphore at a
> > > different register address.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > > Tested-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > One small nit: you are using CHV abbreviation for CherryTrail, we
> > are
> > consider CHT is a right one, CHV for CherryView.
> 
> I thought that cherryview and cherrytrail where 2 names for
> the same chip ?

TBH, I don't know the difference but it is there, Like SoC -> platform.

In any case, just to be consistent with your code below. Everywhere else
you used cherrytrail.

> 
> Regards,
> 
> Hans
> 
> 
> > 
> > > ---
> > > Changes in v2:
> > > -Adjust for accessor_flags -> flags rename
> > > -Add flags field to struct dw_pci_controller
> > > -Add get_sem_addr() helper replacing MODEL_CHERRYTRAIL flag
> > > checking
> > > in
> > >  PUNIT_SEMAPHORE macro
> > > Changes in v3:
> > > -Add a gap between ACCESS_* and MODEL_* flags as reserved space
> > > for
> > >  future ACCESS_* flags
> > > ---
> > >  drivers/i2c/busses/i2c-designware-baytrail.c | 22
> > > +++++++++++++++++
> > > -----
> > >  drivers/i2c/busses/i2c-designware-core.h     |  2 ++
> > >  drivers/i2c/busses/i2c-designware-pcidrv.c   | 26
> > > +++++++++++++++++++-------
> > >  drivers/i2c/busses/i2c-designware-platdrv.c  |  2 +-
> > >  4 files changed, 39 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> > > b/drivers/i2c/busses/i2c-designware-baytrail.c
> > > index 997d048..456a236 100644
> > > --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> > > +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> > > @@ -24,13 +24,23 @@
> > > 
> > >  #define SEMAPHORE_TIMEOUT	100
> > >  #define PUNIT_SEMAPHORE		0x7
> > > +#define PUNIT_SEMAPHORE_CHV	0x10e
> > >  #define PUNIT_SEMAPHORE_BIT	BIT(0)
> > >  #define PUNIT_SEMAPHORE_ACQUIRE	BIT(1)
> > > 
> > >  static unsigned long acquired;
> > > 
> > > +static u32 get_sem_addr(struct dw_i2c_dev *dev)
> > > +{
> > > +	if (dev->flags & MODEL_CHERRYTRAIL)
> > > +		return PUNIT_SEMAPHORE_CHV;
> > > +	else
> > > +		return PUNIT_SEMAPHORE;
> > > +}
> > > +
> > >  static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
> > >  {
> > > +	u32 addr = get_sem_addr(dev);
> > >  	u32 data;
> > >  	int ret;
> > > 
> > > @@ -41,7 +51,7 @@ static int get_sem(struct dw_i2c_dev *dev, u32
> > > *sem)
> > >  	 */
> > >  	pm_qos_update_request(&dev->pm_qos, 0);
> > > 
> > > -	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > > PUNIT_SEMAPHORE, &data);
> > > +	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr,
> > > &data);
> > >  	if (ret) {
> > >  		dev_err(dev->dev, "iosf failed to read punit
> > > semaphore\n");
> > >  		return ret;
> > > @@ -54,15 +64,16 @@ static int get_sem(struct dw_i2c_dev *dev, u32
> > > *sem)
> > > 
> > >  static void reset_semaphore(struct dw_i2c_dev *dev)
> > >  {
> > > +	u32 addr = get_sem_addr(dev);
> > >  	u32 data;
> > > 
> > > -	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > > PUNIT_SEMAPHORE, &data)) {
> > > +	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr,
> > > &data)) {
> > >  		dev_err(dev->dev, "iosf failed to reset punit
> > > semaphore during read\n");
> > >  		return;
> > >  	}
> > > 
> > >  	data &= ~PUNIT_SEMAPHORE_BIT;
> > > -	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> > > PUNIT_SEMAPHORE, data))
> > > +	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, addr,
> > > data))
> > >  		dev_err(dev->dev, "iosf failed to reset punit
> > > semaphore during write\n");
> > > 
> > >  	pm_qos_update_request(&dev->pm_qos,
> > > PM_QOS_DEFAULT_VALUE);
> > > @@ -70,6 +81,7 @@ static void reset_semaphore(struct dw_i2c_dev
> > > *dev)
> > > 
> > >  static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
> > >  {
> > > +	u32 addr = get_sem_addr(dev);
> > >  	u32 sem = PUNIT_SEMAPHORE_ACQUIRE;
> > >  	int ret;
> > >  	unsigned long start, end;
> > > @@ -83,7 +95,7 @@ static int baytrail_i2c_acquire(struct
> > > dw_i2c_dev
> > > *dev)
> > >  		return 0;
> > > 
> > >  	/* host driver writes to side band semaphore register */
> > > -	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> > > PUNIT_SEMAPHORE, sem);
> > > +	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> > > addr,
> > > sem);
> > >  	if (ret) {
> > >  		dev_err(dev->dev, "iosf punit semaphore request
> > > failed\n");
> > >  		return ret;
> > > @@ -107,7 +119,7 @@ static int baytrail_i2c_acquire(struct
> > > dw_i2c_dev
> > > *dev)
> > >  	dev_err(dev->dev, "punit semaphore timed out,
> > > resetting\n");
> > >  	reset_semaphore(dev);
> > > 
> > > -	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > > PUNIT_SEMAPHORE, &sem);
> > > +	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr,
> > > &sem);
> > >  	if (ret)
> > >  		dev_err(dev->dev, "iosf failed to read punit
> > > semaphore\n");
> > >  	else
> > > diff --git a/drivers/i2c/busses/i2c-designware-core.h
> > > b/drivers/i2c/busses/i2c-designware-core.h
> > > index 47d284c..2db3177 100644
> > > --- a/drivers/i2c/busses/i2c-designware-core.h
> > > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > > @@ -127,6 +127,8 @@ struct dw_i2c_dev {
> > >  #define ACCESS_16BIT		0x00000002
> > >  #define ACCESS_INTR_MASK	0x00000004
> > > 
> > > +#define MODEL_CHERRYTRAIL	0x00000100
> > > +
> > >  extern int i2c_dw_init(struct dw_i2c_dev *dev);
> > >  extern void i2c_dw_disable(struct dw_i2c_dev *dev);
> > >  extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
> > > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > index 96f8230..4e53a9f 100644
> > > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > @@ -45,6 +45,7 @@ enum dw_pci_ctl_id_t {
> > >  	medfield,
> > >  	merrifield,
> > >  	baytrail,
> > > +	cherrytrail,
> > >  	haswell,
> > >  };
> > > 
> > > @@ -63,6 +64,7 @@ struct dw_pci_controller {
> > >  	u32 rx_fifo_depth;
> > >  	u32 clk_khz;
> > >  	u32 functionality;
> > > +	u32 flags;
> > >  	struct dw_scl_sda_cfg *scl_sda_cfg;
> > >  	int (*setup)(struct pci_dev *pdev, struct
> > > dw_pci_controller
> > > *c);
> > >  };
> > > @@ -174,6 +176,15 @@ static struct dw_pci_controller
> > > dw_pci_controllers[] = {
> > >  		.functionality = I2C_FUNC_10BIT_ADDR,
> > >  		.scl_sda_cfg = &hsw_config,
> > >  	},
> > > +	[cherrytrail] = {
> > > +		.bus_num = -1,
> > > +		.bus_cfg = INTEL_MID_STD_CFG |
> > > DW_IC_CON_SPEED_FAST,
> > > +		.tx_fifo_depth = 32,
> > > +		.rx_fifo_depth = 32,
> > > +		.functionality = I2C_FUNC_10BIT_ADDR,
> > > +		.flags = MODEL_CHERRYTRAIL,
> > > +		.scl_sda_cfg = &byt_config,
> > > +	},
> > >  };
> > > 
> > >  #ifdef CONFIG_PM
> > > @@ -241,6 +252,7 @@ static int i2c_dw_pci_probe(struct pci_dev
> > > *pdev,
> > >  	dev->base = pcim_iomap_table(pdev)[0];
> > >  	dev->dev = &pdev->dev;
> > >  	dev->irq = pdev->irq;
> > > +	dev->flags |= controller->flags;
> > > 
> > >  	if (controller->setup) {
> > >  		r = controller->setup(pdev, controller);
> > > @@ -321,13 +333,13 @@ static const struct pci_device_id
> > > i2_designware_pci_ids[] = {
> > >  	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
> > >  	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
> > >  	/* Braswell / Cherrytrail */
> > > -	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail },
> > > -	{ PCI_VDEVICE(INTEL, 0x22C2), baytrail },
> > > -	{ PCI_VDEVICE(INTEL, 0x22C3), baytrail },
> > > -	{ PCI_VDEVICE(INTEL, 0x22C4), baytrail },
> > > -	{ PCI_VDEVICE(INTEL, 0x22C5), baytrail },
> > > -	{ PCI_VDEVICE(INTEL, 0x22C6), baytrail },
> > > -	{ PCI_VDEVICE(INTEL, 0x22C7), baytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C1), cherrytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C2), cherrytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C3), cherrytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C4), cherrytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C5), cherrytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C6), cherrytrail },
> > > +	{ PCI_VDEVICE(INTEL, 0x22C7), cherrytrail },
> > >  	{ 0,}
> > >  };
> > >  MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > index 6d72929..589f07e 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -123,7 +123,7 @@ static const struct acpi_device_id
> > > dw_i2c_acpi_match[] = {
> > >  	{ "INT3432", 0 },
> > >  	{ "INT3433", 0 },
> > >  	{ "80860F41", 0 },
> > > -	{ "808622C1", 0 },
> > > +	{ "808622C1", MODEL_CHERRYTRAIL },
> > >  	{ "AMD0010", ACCESS_INTR_MASK },
> > >  	{ "AMDI0010", ACCESS_INTR_MASK },
> > >  	{ "AMDI0510", 0 },

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
