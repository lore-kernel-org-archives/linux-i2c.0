From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [CORRECTED] I2C driver supporting Moorestown and Medfield platform
Date: Mon, 09 Aug 2010 11:59:53 +0100
Message-ID: <4C5FDFA9.60703@fluff.org>
References: <20100803143431.23655.31975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100803143431.23655.31975.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: public-khali-PUYAD+kWke1g9hUCZPvPmw-1dZseelyfdZg9hUCZPvPmw@public.gmane.org, public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-1dZseelyfdZg9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/08/10 15:34, Alan Cox wrote:
> (And the correct patch attached this time)
> 
> From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Initial release of the driver. Updated and verified on hardware.
> 
> Cleaned up as follows
> 
> Alan Cox:
>    Squash down the switches into tables, and use the PCI ident field. We
>    could perhaps take this further and put the platform and port number into
>    this.
>    uint32t -> u32
>    bracketing of case statements
>    spacing and '!' usage
>    Check the speed (which is now 0/1/2) is valid and ignore otherwise.
> 
> Arjan van de Ven:
>    Initial power management hooks
> 
> 
> Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/Kconfig    |    9 
>  drivers/i2c/busses/Makefile   |    1 
>  drivers/i2c/busses/i2c-mrst.c | 1082 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1092 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-mrst.c
> 
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 15a9702..46b9acb 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -420,6 +420,15 @@ config I2C_IXP2000
>  	  This driver is deprecated and will be dropped soon. Use i2c-gpio
>  	  instead.
>  
> +config I2C_MRST
> +	tristate "Intel Moorestown/Medfield Platform I2C controller"
> +	help
> +	  Say Y here if you have an Intel Moorestown/Medfield platform I2C
> +	  controller.
> +
> +	  This support is also available as a module. If so, the module
> +	  will be called i2c-mrst.

I would much prefer this to be called i2c-moorsetown, we have modern
systems which can handle >8 character names.

> diff --git a/drivers/i2c/busses/i2c-mrst.c b/drivers/i2c/busses/i2c-mrst.c
> new file mode 100644
> index 0000000..79f45fb
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mrst.c
> @@ -0,0 +1,1082 @@
> +/*
> + * Support for Moorestown/Medfield I2C chip
> + *
> + * Copyright (c) 2009 Intel Corporation.
> + * Copyright (c) 2009 Synopsys. Inc.

Hmm, if this is a synopsys block, then is it a standard one and if so
can we get some standard support?

> +struct mrst_i2c_private {
> +	struct i2c_adapter adap;
> +	/* Register base address */
> +	void __iomem *base;
> +	/* Speed mode */
> +	int speed;
> +	int pm_state;
> +	struct completion complete;
> +	int abort;
> +	u8 *rx_buf;
> +	int rx_buf_len;
> +	int status;
> +	struct i2c_msg *msg;
> +	enum platform_enum platform;
> +	struct mutex lock;
> +	spinlock_t slock;
> +};
> +

Would have been nice to have some sort of documentatioin

> +static int ctl_num;
> +module_param_array(speed_mode, int, &ctl_num, S_IRUGO);
> +MODULE_PARM_DESC(speed_mode, "Set the speed of the i2c interface (0-2)");
> +
> +static inline u32 mrst_i2c_read(void __iomem *reg)
> +{
> +	return __raw_readl(reg);
> +}

ioremap, but using __raw_read and __raw_write? readl/writel
should be used. if they can't be used, then please explain
why.

> +
> +static inline void mrst_i2c_write(void __iomem *reg, u32 val)
> +{
> +	__raw_writel(val, reg);
> +}
> +

> +/**
> + * mrst_i2c_address_neq - To check if the addresses for different i2c messages
> + * are equal.
> + * @p1: first i2c_msg
> + * @p2: second i2c_msg
> + *
> + * Return Values:
> + * 0	 if addresses are equal
> + * 1	 if not equal
> + *
> + * Within a single transfer, I2C client may need to send its address more
> + * than one time. So a check if the addresses match  is needed.
> + */
> +static inline int mrst_i2c_address_neq(const struct i2c_msg *p1,
> +				       const struct i2c_msg *p2)
> +{
> +	if (p1->addr != p2->addr)
> +		return 1;
> +	if ((p1->flags ^ p2->flags) & I2C_M_TEN)
> +		return 1;
> +	return 0;
> +}

would have been better to return bool.



> +
> +/**
> + * xfer_write - Internal function to implement master write transfer.
> + * @adap: i2c_adapter struct pointer
> + * @buf: buffer in i2c_msg
> + * @length: number of bytes to be read
> + *
> + * Return Values:
> + * 0	if the read transfer succeeds
> + * -ETIMEDOUT	if cannot read the "raw" interrupt register
> + * -EINVAL	if transfer abort occured
> + *
> + * For every byte, a "WRITE" command will be loaded into IC_DATA_CMD prior to
> + * data transfer. The actual "write" operation will be performed when the
> + * RX_FULL interrupt signal occurs.
> + *
> + * Note there may be two interrupt signals captured, one should read
> + * IC_RAW_INTR_STAT to separate between errors and actual data.
> + */
> +static int xfer_write(struct i2c_adapter *adap,
> +		      unsigned char *buf, int length)
> +{
> +	struct mrst_i2c_private *i2c = i2c_get_adapdata(adap);
> +	int i, err;
> +
> +	mrst_i2c_write(i2c->base + IC_INTR_MASK, 0x0050);
> +	mrst_i2c_read(i2c->base + IC_CLR_INTR);
> +
> +	if (length >= 256) {
> +		dev_err(&adap->dev,
> +			"I2C FIFO cannot support larger than 256 bytes\n");
> +		return -EMSGSIZE;
> +	}
> +
> +	INIT_COMPLETION(i2c->complete);
> +	for (i = 0; i < length; i++)
> +		mrst_i2c_write(i2c->base + IC_DATA_CMD,
> +			       (uint16_t)(*(buf + i)));

you say length in bytes, but write u16?
also, would be neater to have a u16 *buf?

> +	i2c->status = STATUS_WRITE_START;
> +	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
> +	if (!err) {
> +		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
> +		mrst_i2c_hwinit(i2c);
> +		return -ETIMEDOUT;
> +	} else {
> +		if (i2c->status == STATUS_WRITE_SUCCESS)
> +			return 0;
> +		else
> +			return -EIO;
> +	}
> +}


> +
> +/**
> + * mrst_i2c_probe - I2C controller initialization routine
> + * @dev: pci device
> + * @id: device id
> + *
> + * Return Values:
> + * 0		success
> + * -ENODEV	If cannot allocate pci resource
> + * -ENOMEM	If the register base remapping failed, or
> + *		if kzalloc failed
> + *
> + * Initialization steps:
> + * 1. Request for PCI resource
> + * 2. Remap the start address of PCI resource to register base
> + * 3. Request for device memory region
> + * 4. Fill in the struct members of mrst_i2c_private
> + * 5. Call mrst_i2c_hwinit() for hardware initialization
> + * 6. Register I2C adapter in i2c-core
> + */
> +static int __devinit mrst_i2c_probe(struct pci_dev *dev,
> +				    const struct pci_device_id *id)
> +{
> +	struct mrst_i2c_private *mrst;
> +	unsigned long start, len;
> +	int err, busnum;
> +	void __iomem *base = NULL;
> +
> +	dev_dbg(&dev->dev, "Get into probe function for I2C\n");
> +	err = pci_enable_device(dev);
> +	if (err) {
> +		dev_err(&dev->dev, "Failed to enable I2C PCI device (%d)\n",
> +			err);
> +		goto exit;
> +	}
> +
> +	/* Determine the address of the I2C area */
> +	start = pci_resource_start(dev, 0);
> +	len = pci_resource_len(dev, 0);
> +	if (!start || len == 0) {
> +		dev_err(&dev->dev, "base address not set\n");
> +		err = -ENODEV;
> +		goto exit;
> +	}
> +	dev_dbg(&dev->dev, "%s i2c resource start 0x%lx, len=%ld\n",
> +		PLATFORM, start, len);
> +
> +	err = pci_request_region(dev, 0, DRIVER_NAME);
> +	if (err) {
> +		dev_err(&dev->dev, "failed to request I2C region "
> +			"0x%lx-0x%lx\n", start,
> +			(unsigned long)pci_resource_end(dev, 0));
> +		goto exit;
> +	}
> +
> +	base = ioremap_nocache(start, len);
> +	if (!base) {
> +		dev_err(&dev->dev, "I/O memory remapping failed\n");
> +		err = -ENOMEM;
> +		goto fail0;
> +	}
> +
> +	/* Allocate the per-device data structure, mrst_i2c_private */
> +	mrst = kzalloc(sizeof(struct mrst_i2c_private), GFP_KERNEL);
> +	if (mrst == NULL) {
> +		dev_err(&dev->dev, "can't allocate interface\n");
> +		err = -ENOMEM;
> +		goto fail1;
> +	}
> +
> +	/* Initialize struct members */
> +	snprintf(mrst->adap.name, sizeof(&mrst->adap.name),
> +		"MRST/Medfield I2C at %lx", start);
> +	mrst->adap.owner = THIS_MODULE;
> +	mrst->adap.algo = &mrst_i2c_algorithm;
> +	mrst->adap.dev.parent = &dev->dev;
> +	mrst->base = base;
> +	mrst->speed = STANDARD;
> +	mrst->pm_state = ACTIVE;
> +	mrst->abort = 0;
> +	mrst->rx_buf_len = 0;
> +	mrst->status = STATUS_IDLE;
> +
> +	pci_set_drvdata(dev, mrst);
> +	i2c_set_adapdata(&mrst->adap, mrst);
> +
> +	mrst->adap.nr = busnum = id->driver_data;
> +	if (dev->device <= 0x0804)
> +		mrst->platform = MOORESTOWN;
> +	else
> +		mrst->platform = MEDFIELD;
> +
> +	dev_dbg(&dev->dev, "I2C%d\n", busnum);
> +
> +	if (ctl_num > busnum) {
> +		if (speed_mode[busnum] < 0 || speed_mode[busnum] >= NUM_SPEEDS)
> +			dev_warn(&dev->dev, "invalid speed %d ignored.\n",
> +							speed_mode[busnum]);
> +		else
> +			mrst->speed = speed_mode[busnum];
> +	}
> +
> +	/* Initialize i2c controller */
> +	err = mrst_i2c_hwinit(mrst);
> +	if (err < 0) {
> +		dev_err(&dev->dev, "I2C interface initialization failed\n");
> +		goto fail2;
> +	}
> +
> +	mutex_init(&mrst->lock);
> +	init_completion(&mrst->complete);
> +	err = request_irq(dev->irq, mrst_i2c_isr, IRQF_DISABLED,
> +			  mrst->adap.name, mrst);

are you sure you want this, IRQF_DISABLED is marked DEPRECATED.

> +	if (err) {
> +		dev_err(&dev->dev, "Failed to request IRQ for I2C controller: "
> +			"%s", mrst->adap.name);
> +		goto fail2;
> +	}

> +static void __devexit mrst_i2c_remove(struct pci_dev *dev)
> +{
> +	struct mrst_i2c_private *mrst = (struct mrst_i2c_private *)
> +					pci_get_drvdata(dev);

no need to cast.

> +	mrst_i2c_disable(&mrst->adap);
> +	if (i2c_del_adapter(&mrst->adap))
> +		dev_err(&dev->dev, "Failed to delete i2c adapter");
> +
> +	free_irq(dev->irq, mrst);
> +	pci_set_drvdata(dev, NULL);
> +	iounmap(mrst->base);
> +	kfree(mrst);
> +	pci_release_region(dev, 0);
> +}
> +
> +static struct pci_device_id mrst_i2c_ids[] = {
> +	/* Moorestown */
> +	{PCI_VDEVICE(INTEL, 0x0802), 0 },
> +	{PCI_VDEVICE(INTEL, 0x0803), 1 },
> +	{PCI_VDEVICE(INTEL, 0x0804), 2 },
> +	/* Medfield */
> +	{PCI_VDEVICE(INTEL, 0x0817), 3,},
> +	{PCI_VDEVICE(INTEL, 0x0818), 4 },
> +	{PCI_VDEVICE(INTEL, 0x0819), 5 },
> +	{PCI_VDEVICE(INTEL, 0x082C), 0 },
> +	{PCI_VDEVICE(INTEL, 0x082D), 1 },
> +	{PCI_VDEVICE(INTEL, 0x082E), 2 },
> +	{0,}

style, "{ "

> +};
> +MODULE_DEVICE_TABLE(pci, mrst_i2c_ids);
