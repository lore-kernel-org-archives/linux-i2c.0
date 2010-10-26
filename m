From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] I2C driver supporting Moorestown and Medfield platform
Date: Tue, 26 Oct 2010 23:54:12 +0100
Message-ID: <4CC75C14.3000101@fluff.org>
References: <20101022140431.3545.37799.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101022140431.3545.37799.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 22/10/10 15:05, Alan Cox wrote:
> I think this now addresses all the points raised in previous review, as well

I'll go through and have a quick look through this to
see if there is anything else to look at.

> +/* Tables use: 0 Moorestown, 1 Medfield */
> +#define NUM_PLATFORMS	2
> +enum platform_enum {
> +	MOORESTOWN = 0,
> +	MEDFIELD = 1,
> +};
> +
> +struct intel_mid_i2c_private {
> +	struct i2c_adapter adap;
> +	/* Device for power management */
> +	struct device *dev;
> +	/* Register base address */
> +	void __iomem *base;
> +	/* Speed mode */
> +	int speed;
> +	/* Transaction completion wait */
> +	struct completion complete;
> +	/* Saved abort reason */
> +	int abort;
> +	/* Working buffer */
> +	u8 *rx_buf;
> +	int rx_buf_len;
> +	/* Adapter state machine condition */
> +	int status;
> +	/* Message being processed */
> +	struct i2c_msg *msg;
> +	/* Which Intel MID device are we today */
> +	enum platform_enum platform;
> +	/* Serialize transactions */
> +	struct mutex lock;
> +};

would have prefered this as kerneldoc.

> +
> +#define NUM_SPEEDS		3
> +
> +#define ACTIVE			0
> +#define STANDBY			1
> +
> +#define STATUS_IDLE		0
> +#define STATUS_READ_START	1
> +#define STATUS_READ_IN_PROGRESS	2
> +#define STATUS_READ_SUCCESS	3
> +#define STATUS_WRITE_START	4
> +#define STATUS_WRITE_SUCCESS	5
> +#define STATUS_XFER_ABORT	6
> +#define STATUS_STANDBY		7

would have been nicer as an enum.

> +/**
> + * intel_mid_i2c_disable - Disable I2C controller
> + * @adap: struct pointer to i2c_adapter
> + *
> + * Return Value:
> + * 0		success
> + * -EBUSY	if device is busy
> + * -ETIMEDOUT	if i2c cannot be disabled within the given time
> + *
> + * I2C bus state should be checked prior to disabling the hardware. If bus is
> + * not in idle state, an errno is returned. Write "0" to IC_ENABLE to disable
> + * I2C controller.
> + */
> +static int intel_mid_i2c_disable(struct i2c_adapter *adap)
> +{
> +	struct intel_mid_i2c_private *i2c = i2c_get_adapdata(adap);
> +	int err = 0;
> +	int count = 0;
> +	int ret1, ret2;
> +	static const u16 delay[NUM_SPEEDS] = {100, 25, 3};
> +
> +	/* Set IC_ENABLE to 0 */
> +	writel(0, i2c->base + IC_ENABLE);
> +
> +	/* Check if device is busy */
> +	dev_dbg(&adap->dev, "mrst i2c disable\n");
> +	while ((ret1 = readl(i2c->base + IC_ENABLE_STATUS) & 0x1)
> +		|| (ret2 = readl(i2c->base + IC_STATUS) & 0x1)) {
> +		udelay(delay[i2c->speed]);
> +		writel(0, i2c->base + IC_ENABLE);
> +		dev_dbg(&adap->dev, "i2c is busy, count is %d speed %d\n",
> +			count, i2c->speed);
> +		if (count++ > 10) {
> +			err = -ETIMEDOUT;
> +			break;
> +		}
> +	}
> +
> +	/* Clear all interrupts */
> +	readl(i2c->base + IC_CLR_INTR);
> +	readl(i2c->base + IC_CLR_STOP_DET);
> +	readl(i2c->base + IC_CLR_START_DET);
> +	readl(i2c->base + IC_CLR_ACTIVITY);
> +	readl(i2c->base + IC_CLR_TX_ABRT);
> +	readl(i2c->base + IC_CLR_RX_OVER);
> +	readl(i2c->base + IC_CLR_RX_UNDER);
> +	readl(i2c->base + IC_CLR_TX_OVER);
> +	readl(i2c->base + IC_CLR_RX_DONE);
> +	readl(i2c->base + IC_CLR_GEN_CALL);
> +
> +	/* Disable all interupts */
> +	writel(0x0000, i2c->base + IC_INTR_MASK);
> +
> +	return err;
> +}
> +
> +/**
> + * intel_mid_i2c_hwinit - Initialize the I2C hardware registers
> + * @dev: pci device struct pointer
> + *
> + * This function will be called in intel_mid_i2c_probe() before device
> + * registration.
> + *
> + * Return Values:
> + * 0		success
> + * -EBUSY	i2c cannot be disabled
> + * -ETIMEDOUT	i2c cannot be disabled
> + * -EFAULT	If APB data width is not 32-bit wide
> + *
> + * I2C should be disabled prior to other register operation. If failed, an
> + * errno is returned. Mask and Clear all interrpts, this should be done at
> + * first.  Set common registers which will not be modified during normal
> + * transfers, including: controll register, FIFO threshold and clock freq.
> + * Check APB data width at last.
> + */
> +static int intel_mid_i2c_hwinit(struct intel_mid_i2c_private *i2c)
> +{
> +	int err;
> +
> +	static const u16 hcnt[NUM_PLATFORMS][NUM_SPEEDS] = {
> +		{ 0x75,  0x15, 0x07 },
> +		{ 0x04c,  0x10, 0x06 }
> +	};
> +	static const u16 lcnt[NUM_PLATFORMS][NUM_SPEEDS] = {
> +		{ 0x7C,  0x21, 0x0E },
> +		{ 0x053, 0x19, 0x0F }
> +	};
> +
> +	/* Disable i2c first */
> +	err = intel_mid_i2c_disable(&i2c->adap);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Setup clock frequency and speed mode
> +	 * Enable restart condition,
> +	 * enable master FSM, disable slave FSM,
> +	 * use target address when initiating transfer
> +	 */
> +
> +	writel((i2c->speed + 1) << 1 | SLV_DIS | RESTART | MASTER_EN,
> +		i2c->base + IC_CON);
> +	writel(hcnt[i2c->platform][i2c->speed],
> +		i2c->base + (IC_SS_SCL_HCNT + (i2c->speed << 3)));
> +	writel(lcnt[i2c->platform][i2c->speed],
> +		i2c->base + (IC_SS_SCL_LCNT + (i2c->speed << 3)));
> +
> +	/* Set tranmit & receive FIFO threshold to zero */
> +	writel(0x0, i2c->base + IC_RX_TL);
> +	writel(0x0, i2c->base + IC_TX_TL);
> +
> +	return 0;
> +}
> +
> +/**
> + * intel_mid_i2c_func - Return the supported three I2C operations.
> + * @adapter: i2c_adapter struct pointer
> + */
> +static u32 intel_mid_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +/**
> + * intel_mid_i2c_address_neq - To check if the addresses for different i2c messages
> + * are equal.
> + * @p1: first i2c_msg
> + * @p2: second i2c_msg
> + *
> + * Return Values:
> + * 0	 if addresses are equal
> + * 1	 if not equal
> + *
> + * Within a single transfer, the I2C client may need to send its address more
> + * than once. So a check if the addresses match is needed.
> + */
> +static inline bool intel_mid_i2c_address_neq(const struct i2c_msg *p1,
> +				       const struct i2c_msg *p2)
> +{
> +	if (p1->addr != p2->addr)
> +		return 1;
> +	if ((p1->flags ^ p2->flags) & I2C_M_TEN)
> +		return 1;
> +	return 0;
> +}
> +
> +/**
> + * intel_mid_i2c_abort - To handle transfer abortions and print error messages.
> + * @adap: i2c_adapter struct pointer
> + *
> + * By reading register IC_TX_ABRT_SOURCE, various transfer errors can be
> + * distingushed. At present, no circumstances have been found out that
> + * multiple errors would be occured simutaneously, so we simply use the
> + * register value directly.
> + *
> + * At last the error bits are cleared. (Note clear ABRT_SBYTE_NORSTRT bit need
> + * a few extra steps)
> + */
> +static void intel_mid_i2c_abort(struct intel_mid_i2c_private *i2c)
> +{
> +	/* Read about source register */
> +	int abort = i2c->abort;
> +	struct i2c_adapter *adap = &i2c->adap;
> +
> +	/* Single transfer error check:
> +	 * According to databook, TX/RX FIFOs would be flushed when
> +	 * the abort interrupt occured.
> +	 */
> +	if (abort & ABRT_MASTER_DIS)
> +		dev_err(&adap->dev,
> +		"initiate master operation with master mode disabled.\n");
> +	if (abort & ABRT_10B_RD_NORSTRT)
> +		dev_err(&adap->dev,
> +	"RESTART disabled and master sent READ cmd in 10-bit addressing.\n");
> +
> +	if (abort & ABRT_SBYTE_NORSTRT) {
> +		dev_err(&adap->dev,
> +		"RESTART disabled and user is trying to send START byte.\n");
> +		writel(~ABRT_SBYTE_NORSTRT, i2c->base + IC_TX_ABRT_SOURCE);
> +		writel(RESTART, i2c->base + IC_CON);
> +		writel(~IC_TAR_SPECIAL, i2c->base + IC_TAR);
> +	}
> +
> +	if (abort & ABRT_SBYTE_ACKDET)
> +		dev_err(&adap->dev,
> +			"START byte was acknowledged.\n");

surely the start+addr byte has to be acked?

> +	if (abort & ABRT_TXDATA_NOACK)
> +		dev_err(&adap->dev,
> +			"No acknowledgement received from slave.\n");

you'll get a pile of errors if the eeprom driver uses this method
to test for eeprom busy. you may want to push this one back to dev_dbg.

> +	if (abort & ABRT_10ADDR2_NOACK)
> +		dev_dbg(&adap->dev,
> +	"The 2nd address byte of the 10-bit address was not acknowledged.\n");
> +	if (abort & ABRT_10ADDR1_NOACK)
> +		dev_dbg(&adap->dev,
> +	"The 1st address byte of 10-bit address was not acknowledged.\n");
> +	if (abort & ABRT_7B_ADDR_NOACK)
> +		dev_dbg(&adap->dev,
> +			"I2C slave device not acknowledged.\n");

> +	/* Clear TX_ABRT bit */
> +	readl(i2c->base + IC_CLR_TX_ABRT);
> +	i2c->status = STATUS_XFER_ABORT;
> +}
> +
> +/**
> + * xfer_read - Internal function to implement master read transfer.
> + * @adap: i2c_adapter struct pointer
> + * @buf: buffer in i2c_msg
> + * @length: number of bytes to be read
> + *
> + * Return Values:
> + * 0		if the read transfer succeeds
> + * -ETIMEDOUT	if cannot read the "raw" interrupt register
> + * -EINVAL	if a transfer abort occurred
> + *
> + * For every byte, a "READ" command will be loaded into IC_DATA_CMD prior to
> + * data transfer. The actual "read" operation will be performed if an RX_FULL
> + * interrupt occurred.
> + *
> + * Note there may be two interrupt signals captured, one should read
> + * IC_RAW_INTR_STAT to separate between errors and actual data.
> + */
> +static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
> +{
> +	struct intel_mid_i2c_private *i2c = i2c_get_adapdata(adap);
> +	int i = length;
> +	int err;
> +
> +	if (length >= 256) {
> +		dev_err(&adap->dev,
> +			"I2C FIFO cannot support larger than 256 bytes\n");
> +		return -EMSGSIZE;
> +	}
> +
> +	INIT_COMPLETION(i2c->complete);
> +
> +	readl(i2c->base + IC_CLR_INTR);
> +	writel(0x0044, i2c->base + IC_INTR_MASK);
> +
> +	i2c->status = STATUS_READ_START;
> +
> +	while (i--)
> +		writel(IC_RD, i2c->base + IC_DATA_CMD);
> +
> +	i2c->status = STATUS_READ_START;
> +	err = wait_for_completion_interruptible_timeout(&i2c->complete, HZ);
> +	if (!err) {
> +		dev_err(&adap->dev, "Timeout for ACK from I2C slave device\n");
> +		intel_mid_i2c_hwinit(i2c);
> +		return -ETIMEDOUT;
> +	} else {

as a note, you really didn't need the else here, you exit with the
return at the end of the block.

> +		if (i2c->status == STATUS_READ_SUCCESS)
> +			return 0;
> +		else
> +			return -EIO;
> +	}
> +}

> +static int intel_mid_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
> +{
> +	struct intel_mid_i2c_private *i2c = i2c_get_adapdata(adap);
> +	int err;
> +	u32 reg;
> +	u32 bit_mask;
> +	u32 mode;
> +
> +	/* Disable device first */
> +	err = intel_mid_i2c_disable(adap);
> +	if (err) {
> +		dev_err(&adap->dev,
> +			"Cannot disable i2c controller, timeout\n");
> +		return err;
> +	}
> +
> +	mode = (1 + i2c->speed) << 1;
> +	/* set the speed mode */
> +	reg = readl(i2c->base + IC_CON);
> +	if ((reg & 0x06) != mode) {
> +		dev_dbg(&adap->dev, "set mode %d\n", i2c->speed);
> +		writel((reg & ~0x6) | mode, i2c->base + IC_CON);
> +	}
> +
> +	reg = readl(i2c->base + IC_CON);
> +	/* use 7-bit addressing */
> +	if (pmsg->flags & I2C_M_TEN) {
> +		if ((reg & ADDR_10BIT) != ADDR_10BIT) {
> +			dev_dbg(&adap->dev, "set i2c 10 bit address mode\n");
> +			writel(reg | ADDR_10BIT, i2c->base + IC_CON);
> +		}
> +	} else {
> +		if ((reg & ADDR_10BIT) != 0x0) {
> +			dev_dbg(&adap->dev, "set i2c 7 bit address mode\n");
> +			writel(reg & ~ADDR_10BIT, i2c->base + IC_CON);
> +		}
> +	}
> +	/* enable restart conditions */
> +	reg = readl(i2c->base + IC_CON);
> +	if ((reg & RESTART) != RESTART) {
> +		dev_dbg(&adap->dev, "enable restart conditions\n");
> +		writel(reg | RESTART, i2c->base + IC_CON);
> +	}
> +
> +	/* enable master FSM */
> +	reg = readl(i2c->base + IC_CON);
> +	dev_dbg(&adap->dev, "ic_con reg is 0x%x\n", reg);
> +	writel(reg | MASTER_EN, i2c->base + IC_CON);
> +	if ((reg & SLV_DIS) != SLV_DIS) {
> +		dev_dbg(&adap->dev, "enable master FSM\n");
> +		writel(reg | SLV_DIS, i2c->base + IC_CON);
> +		dev_dbg(&adap->dev, "ic_con reg is 0x%x\n", reg);
> +	}
> +
> +	/* use target address when initiating transfer */
> +	reg = readl(i2c->base + IC_TAR);
> +	bit_mask = IC_TAR_SPECIAL | IC_TAR_GC_OR_START;
> +
> +	if ((reg & bit_mask) != 0x0) {
> +		dev_dbg(&adap->dev,
> +	 "WR: use target address when intiating transfer, i2c_tx_target\n");
> +		writel(reg & ~bit_mask, i2c->base + IC_TAR);
> +	}
> +
> +	/* set target address to the I2C slave address */
> +	dev_dbg(&adap->dev,
> +		"set target address to the I2C slave address, addr is %x\n",
> +			pmsg->addr);
> +	writel(pmsg->addr | (pmsg->flags & I2C_M_TEN ? IC_TAR_10BIT_ADDR : 0),
> +		i2c->base + IC_TAR);
> +
> +	/* Enable I2C controller */
> +	writel(ENABLE, i2c->base + IC_ENABLE);
> +
> +	return 0;
> +}
> +
> +/**
> + * intel_mid_i2c_xfer - Main master transfer routine.
> + * @adap: i2c_adapter struct pointer
> + * @pmsg: i2c_msg struct pointer
> + * @num: number of i2c_msg
> + *
> + * Return Values:
> + * +		number of messages transfered
> + * -ETIMEDOUT	If cannot disable I2C controller or read IC_STATUS
> + * -EINVAL	If the address in i2c_msg is invalid
> + *
> + * This function will be registered in i2c-core and exposed to external
> + * I2C clients.
> + * 1. Disable I2C controller
> + * 2. Unmask three interrupts: RX_FULL, TX_EMPTY, TX_ABRT
> + * 3. Check if address in i2c_msg is valid
> + * 4. Enable I2C controller
> + * 5. Perform real transfer (call xfer_read or xfer_write)
> + * 6. Wait until the current transfer is finished (check bus state)
> + * 7. Mask and clear all interrupts
> + */
> +static int intel_mid_i2c_xfer(struct i2c_adapter *adap,
> +			 struct i2c_msg *pmsg,
> +			 int num)
> +{
> +	struct intel_mid_i2c_private *i2c = i2c_get_adapdata(adap);
> +	int i, err;
> +
> +	pm_runtime_get(i2c->dev);
> +
> +	mutex_lock(&i2c->lock);
> +	dev_dbg(&adap->dev, "intel_mid_i2c_xfer, process %d msg(s)\n", num);
> +	dev_dbg(&adap->dev, "slave address is %x\n", pmsg->addr);
> +
> +	if (i2c->status != STATUS_IDLE) {
> +		dev_err(&adap->dev, "Adapter %d in transfer/standby\n",
> +								adap->nr);
> +		mutex_unlock(&i2c->lock);
> +		pm_runtime_put(i2c->dev);
> +		return -1;
> +	}
> +
> +	/* if number of messages equal 0*/
> +	if (num == 0) {
> +		mutex_unlock(&i2c->lock);
> +		pm_runtime_put(i2c->dev);
> +		return 0;
> +	}

you could have moved the check above the pm_runtime_get and avoided a
pile of checks. not necessary to fix though.

> +
> +	for (i = 1; i < num; i++) {
> +		/* Message address equal? */
> +		if (unlikely(intel_mid_i2c_address_neq(&pmsg[0], &pmsg[i]))) {
> +			dev_err(&adap->dev, "Invalid address in msg[%d]\n", i);
> +			mutex_unlock(&i2c->lock);
> +			pm_runtime_put(i2c->dev);
> +			return -EINVAL;
> +		}
> +	}

can you really not support having a different address in one of the
message segments? surely if sending a restart then this should be
possible?

> +	if (intel_mid_i2c_setup(adap, pmsg)) {
> +		mutex_unlock(&i2c->lock);
> +		pm_runtime_put(i2c->dev);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		i2c->msg = pmsg;
> +		i2c->status = STATUS_IDLE;
> +		/* Read or Write */
> +		if (pmsg->flags & I2C_M_RD) {
> +			dev_dbg(&adap->dev, "I2C_M_RD\n");
> +			err = xfer_read(adap, pmsg->buf, pmsg->len);
> +		} else {
> +			dev_dbg(&adap->dev, "I2C_M_WR\n");
> +			err = xfer_write(adap, pmsg->buf, pmsg->len);
> +		}
> +		if (err < 0)
> +			goto err_1;
> +		dev_dbg(&adap->dev, "msg[%d] transfer complete\n", i);
> +		pmsg++;		/* next message */
> +	}
> +	goto exit;
> +
> +err_1:
> +	i = err;

firstly, why assing i=err, you could just return err below.

secondly, given xfer_read and xfer_write return 0 on success
then you can just skip the goto exit stage after the loop.

> +exit:
> +	/* Mask interrupts */
> +	writel(0x0000, i2c->base + IC_INTR_MASK);
> +	/* Clear all interrupts */
> +	readl(i2c->base + IC_CLR_INTR);
> +
> +	i2c->status = STATUS_IDLE;
> +	mutex_unlock(&i2c->lock);
> +	pm_runtime_put(i2c->dev);
> +
> +	return i;
> +}
> +
> +static int intel_mid_i2c_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct intel_mid_i2c_private *i2c =
> +	    (struct intel_mid_i2c_private *)pci_get_drvdata(pdev);

no need to cast here.

> +	struct i2c_adapter *adap = to_i2c_adapter(dev);
> +	int err;
> +
> +	if (i2c->status != STATUS_IDLE)
> +		return -1;
> +
> +	intel_mid_i2c_disable(adap);
> +
> +	err = pci_save_state(pdev);
> +	if (err) {
> +		dev_err(dev, "pci_save_state failed\n");
> +		return err;
> +	}
> +
> +	err = pci_set_power_state(pdev, PCI_D3hot);
> +	if (err) {
> +		dev_err(dev, "pci_set_power_state failed\n");
> +		return err;
> +	}
> +	i2c->status = STATUS_STANDBY;
> +
> +	return 0;
> +}
> +
> +static int intel_mid_i2c_runtime_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct intel_mid_i2c_private *i2c =
> +	    (struct intel_mid_i2c_private *)pci_get_drvdata(pdev);

ditto.

> +	int err;
> +
> +	if (i2c->status != STATUS_STANDBY)
> +		return 0;
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "pci_enable_device failed\n");
> +		return err;
> +	}
> +
> +	i2c->status = STATUS_IDLE;
> +
> +	intel_mid_i2c_hwinit(i2c);
> +	return err;
> +}
> +
> +static void i2c_isr_read(struct intel_mid_i2c_private *i2c)
> +{
> +	struct i2c_msg *msg = i2c->msg;
> +	int rx_num;
> +	u32 len;
> +	u8 *buf;
> +
> +	if (!(msg->flags & I2C_M_RD))
> +		return;
> +
> +	if (i2c->status != STATUS_READ_IN_PROGRESS) {
> +		len = msg->len;
> +		buf = msg->buf;
> +	} else {
> +		len = i2c->rx_buf_len;
> +		buf = i2c->rx_buf;
> +	}
> +
> +	rx_num = readl(i2c->base + IC_RXFLR);
> +
> +	for (; len > 0 && rx_num > 0; len--, rx_num--)
> +		*buf++ = readl(i2c->base + IC_DATA_CMD);
> +
> +	if (len > 0) {
> +		i2c->status = STATUS_READ_IN_PROGRESS;
> +		i2c->rx_buf_len = len;
> +		i2c->rx_buf = buf;
> +	} else
> +		i2c->status = STATUS_READ_SUCCESS;
> +
> +	return;
> +}
> +
> +static irqreturn_t intel_mid_i2c_isr(int this_irq, void *dev)
> +{
> +	struct intel_mid_i2c_private *i2c = dev;
> +	u32 stat = readl(i2c->base + IC_INTR_STAT);
> +
> +	if (!stat)
> +		return IRQ_NONE;
> +
> +	dev_dbg(&i2c->adap.dev, "%s, stat = 0x%x\n", __func__, stat);
> +	stat &= 0x54;
> +
> +	if (i2c->status != STATUS_WRITE_START &&
> +	    i2c->status != STATUS_READ_START &&
> +	    i2c->status != STATUS_READ_IN_PROGRESS)
> +		goto err;
> +
> +	if (stat & TX_ABRT)
> +		i2c->abort = readl(i2c->base + IC_TX_ABRT_SOURCE);
> +
> +	readl(i2c->base + IC_CLR_INTR);
> +
> +	if (stat & TX_ABRT) {
> +		intel_mid_i2c_abort(i2c);
> +		goto exit;
> +	}
> +
> +	if (stat & RX_FULL) {
> +		i2c_isr_read(i2c);
> +		goto exit;
> +	}
> +
> +	if (stat & TX_EMPTY) {
> +		if (readl(i2c->base + IC_STATUS) & 0x4)
> +			i2c->status = STATUS_WRITE_SUCCESS;
> +	}
> +
> +exit:
> +	if (i2c->status == STATUS_READ_SUCCESS ||
> +	    i2c->status == STATUS_WRITE_SUCCESS ||
> +	    i2c->status == STATUS_XFER_ABORT) {
> +		/* Clear all interrupts */
> +		readl(i2c->base + IC_CLR_INTR);
> +		/* Mask interrupts */
> +		writel(0, i2c->base + IC_INTR_MASK);
> +		complete(&i2c->complete);
> +	}
> +err:
> +	return IRQ_HANDLED;
> +}
> +

rest of the driver looks ok.
