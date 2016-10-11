From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Add slave mode to Synopsys I2C driver
Date: Tue, 11 Oct 2016 15:45:09 +0300
Message-ID: <1476189909.11323.415.camel@linux.intel.com>
References: <95e8074bcdf85c11db2497a2bf5218ce66446051.1476187036.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95e8074bcdf85c11db2497a2bf5218ce66446051.1476187036.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis.Oliveira@synopsys.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 2016-10-11 at 13:18 +0100, Luis.Oliveira@synopsys.com wrote:
> From: Luis Oliveira <lolivei@synopsys.com>
> 
> Add support in existing I2C Synopsys Designware Core driver for I2C
> slave mode.

My comments below.

> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -21,6 +21,7 @@
>   * ------------------------------------------------------------------
> ----------
>   *
>   */
> +

Doesn't belong this patch (let's call it indent fix).

>  #include <linux/export.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>


> @@ -85,15 +87,27 @@
>  #define DW_IC_INTR_STOP_DET	0x200
>  #define DW_IC_INTR_START_DET	0x400
>  #define DW_IC_INTR_GEN_CALL	0x800
> -
> -#define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL |
> \
> -					 DW_IC_INTR_TX_EMPTY | \
> -					 DW_IC_INTR_TX_ABRT | \
> -					 DW_IC_INTR_STOP_DET)
> +#define DW_IC_INTR_RESTART_DET	0x1000
> +
> +#define DW_IC_INTR_MST_DEFAULT_MASK		(DW_IC_INTR_RX_FUL
> L | \
> +				    DW_IC_INTR_TX_EMPTY | \
> +				    DW_IC_INTR_TX_ABRT | \
> +				    DW_IC_INTR_STOP_DET | \
> +				    DW_IC_INTR_RX_DONE | \
> +				    DW_IC_INTR_RX_UNDER | \
> +				    DW_IC_INTR_RD_REQ)
> +
> + #define DW_IC_INTR_SLV_DEFAULT_MASK		(DW_IC_INTR_RX_FU
> LL | \
> +				    DW_IC_INTR_STOP_DET | \

It would be better to keep list in the same order as in other set above.

> +				    DW_IC_INTR_TX_ABRT | \
> +				    DW_IC_INTR_RX_DONE | \
> +				    DW_IC_INTR_RX_UNDER | \
> +				    DW_IC_INTR_RD_REQ)
>  

Or even split common part with previous name.

> @@ -107,7 +121,7 @@
>   */
>  #define STATUS_IDLE			0x0
>  #define STATUS_WRITE_IN_PROGRESS	0x1
> -#define STATUS_READ_IN_PROGRESS		0x2
> +#define STATUS_READ_IN_PROGRESS	0x2

Indent fix. Not here.

> @@ -128,6 +142,9 @@
>  #define ABRT_10B_RD_NORSTRT	10
>  #define ABRT_MASTER_DIS		11
>  #define ARB_LOST		12
> +#define ABRT_SLVFLUSH_TXFIFO    13
> +#define ABRT_SLV_ARBLOST        14
> +#define ABRT_SLVRD_INTX         15

Can we use _SLAVE_ instead? It would be in align with _MASTER_.
Same to above MASK definition.

> @@ -140,6 +157,9 @@
>  #define DW_IC_TX_ABRT_10B_RD_NORSTRT	(1UL <<
> ABRT_10B_RD_NORSTRT)
>  #define DW_IC_TX_ABRT_MASTER_DIS	(1UL << ABRT_MASTER_DIS)
>  #define DW_IC_TX_ARB_LOST		(1UL << ARB_LOST)
> +#define DW_IC_RX_ABRT_SLVRD_INTX        (1UL << ABRT_SLVRD_INTX)
> +#define DW_IC_RX_ABRT_SLV_ARBLOST       (1UL << ABRT_SLV_ARBLOST)
> +#define DW_IC_RX_ABRT_SLVFLUSH_TXFIFO   (1UL << ABRT_SLVFLUSH_TXFIFO)

Ditto.

> @@ -343,8 +369,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  		/* Configure register access mode 16bit */
>  		dev->accessor_flags |= ACCESS_16BIT;
>  	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
> -		dev_err(dev->dev, "Unknown Synopsys component type: "
> -			"0x%08x\n", reg);
> +		dev_err(dev->dev, "Unknown Synopsys component type:
> 0x%08x\n",
> +			reg);

Indent fix. Not here.

> @@ -431,12 +457,30 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  			"Hardware too old to adjust SDA hold
> time.\n");
>  	}
>  
> -	/* Configure Tx/Rx FIFO threshold levels */
> -	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
> -	dw_writel(dev, 0, DW_IC_RX_TL);
> -
> -	/* configure the i2c master */
> -	dw_writel(dev, dev->master_cfg , DW_IC_CON);
> +	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
> +		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) {
> +		/* IF master */
> +
> +		/* Configure Tx/Rx FIFO threshold levels */
> +		dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
> +		dw_writel(dev, 0, DW_IC_RX_TL);
> +
> +		/* configure the i2c master */
> +		dw_writel(dev, dev->master_cfg, DW_IC_CON);
> +		dw_writel(dev, DW_IC_INTR_MST_DEFAULT_MASK,
> DW_IC_INTR_MASK);
> +	} else if (!(dev->master_cfg & DW_IC_CON_MASTER) &&
> +		!(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) {
> +		/*IF slave */
> +
> +		/* Configure Tx/Rx FIFO threshold levels */
> +		dw_writel(dev, 0, DW_IC_TX_TL);
> +		dw_writel(dev, 0, DW_IC_RX_TL);
> +
> +		/* configure the i2c slave */
> +		dw_writel(dev, dev->slave_cfg, DW_IC_CON);
> +		dw_writel(dev, DW_IC_INTR_SLV_DEFAULT_MASK,
> DW_IC_INTR_MASK);
> +	} else
> +		return -EAGAIN;

Regarding to such blocks. Perhaps you may refactor code first to split
*_master() functions out of existing ones and add *_slave() in sequent
patch?

Same to all similar pieces in the patch.

> @@ -772,12 +816,64 @@ done_nolock:
>  static u32 i2c_dw_func(struct i2c_adapter *adap)
>  {
>  	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
> +

Indent fix. Not here.

>  	return dev->functionality;
>  }
> 


>  
> +static int i2c_dw_reg_slave(struct i2c_client *slave)
> +{
> +	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);
> +
> +	if (dev->slave)
> +		return -EBUSY;

+ empty line.

> +	if (slave->flags & I2C_CLIENT_TEN)
> +		return -EAFNOSUPPORT;

> +		/* set slave address in the IC_SAR register,
> +		* the address to which the DW_apb_i2c responds
> +		*/

No, multi-line comment style is different and please indent it
correctly.

> +
> +	__i2c_dw_enable(dev, false);
> +
> +	dw_writel(dev, slave->addr, DW_IC_SAR);
> +
> +	pm_runtime_forbid(dev->dev);

Why? Add a comment and how it recovers (returns back) from this.

> +
> +	dev->slave = slave;
> +
> +	__i2c_dw_enable(dev, true);
> +
> +	dev->cmd_err = 0;
> +	dev->msg_write_idx = 0;
> +	dev->msg_read_idx = 0;
> +	dev->msg_err = 0;
> +	dev->status = STATUS_IDLE;
> +	dev->abort_source = 0;
> +	dev->rx_outstanding = 0;
> +
> +	return 0;
> +}
> +
> +static int i2c_dw_unreg_slave(struct i2c_client *slave)
> +{
> +	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);
> +
> +	WARN_ON(!dev->slave);

I doubt i2c core will allow such. Same to above.

> +
> +	i2c_dw_disable_int(dev);
> +	i2c_dw_disable(dev);
> +
> +	dev->slave =  NULL;
> +
> +	pm_runtime_allow(dev->dev);
> +
> +	return 0;
> +}
> +
>  static struct i2c_algorithm i2c_dw_algo = {
>  	.master_xfer	= i2c_dw_xfer,
>  	.functionality	= i2c_dw_func,
> +	.reg_slave	= i2c_dw_reg_slave,
> +	.unreg_slave	= i2c_dw_unreg_slave,

> @@ -839,19 +933,129 @@ static u32 i2c_dw_read_clear_intrbits(struct
> dw_i2c_dev *dev)
>   * Interrupt service routine. This gets called whenever an I2C
> interrupt
>   * occurs.
>   */
> +
> +static bool i2c_dw_slave_irq_handler(struct dw_i2c_dev *dev)

_irq_handler_slave()

> +{
> +	u32 raw_stat, stat, enabled;
> +	u8 val;
> +	u8 slv_act;

Reversed tree. slv -> slave.

> +
> +	stat     = dw_readl(dev, DW_IC_INTR_STAT);
> +	enabled  = dw_readl(dev, DW_IC_ENABLE);
> +	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +
> +	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))

(!(enabled && (raw_stat & ~DW_IC...))) ?

> +		return false;

> +
> +	slv_act = ((dw_readl(dev, DW_IC_STATUS) &
> +		DW_IC_STATUS_SLV_ACTIVITY)>>6);
> +
> +	dev_dbg(dev->dev,
> +	 "%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x :
> INTR_STAT=%#x\n",
> +	 __func__, enabled, slv_act, raw_stat, stat);

Indent lines properly.

> +	if ((stat & DW_IC_INTR_RX_FULL) && (stat &
> DW_IC_INTR_STOP_DET)) {

> +		dev_dbg(dev->dev, "First write\n");

Is this useful?

> +		i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_REQUESTED, &val);
> +	}
> +
> +	if (slv_act) {
> +		dev_dbg(dev->dev, "I2C GET\n");

Or this?

> +
> +		if (stat & DW_IC_INTR_RD_REQ) {
> +			if (stat & DW_IC_INTR_RX_FULL) {
> +				val = dw_readl(dev, DW_IC_DATA_CMD);
> +				if (!i2c_slave_event(dev->slave,
> +					I2C_SLAVE_WRITE_RECEIVED,
> &val)) {
> +					dev_dbg(dev->dev, "Byte %X
> acked! ", val);
> 

> +					;

What's that?

> +				}
> +				dev_dbg(dev->dev, "I2C GET + add");
> +				dw_readl(dev, DW_IC_CLR_RD_REQ);
> +				stat =
> i2c_dw_read_clear_intrbits(dev);
> +			} else {
> +				dev_dbg(dev->dev, "I2C GET + 0x00");
> +				dw_readl(dev, DW_IC_CLR_RD_REQ);
> +				dw_readl(dev, DW_IC_CLR_RX_UNDER);
> +				stat =
> i2c_dw_read_clear_intrbits(dev);
> +			}
> +			if (!i2c_slave_event(dev->slave,
> +					I2C_SLAVE_READ_REQUESTED,
> &val))
> +				dw_writel(dev, (0x0 << 8 | val), 

0 << (x) == 0. What the intention?

> DW_IC_DATA_CMD);
> +		}
> +	}
> +	if (stat & DW_IC_INTR_RX_DONE) {
> 

> +

Redundant.

> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_READ_PROCESSED, &val))
> +			dw_readl(dev, DW_IC_CLR_RX_DONE);
> +
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
> +		dev_dbg(dev->dev, "Transmission Complete.");
> +		stat = i2c_dw_read_clear_intrbits(dev);
> +
> +		goto done;
> +	}
> +
> +	if (stat & DW_IC_INTR_RX_FULL) {
> +		dev_dbg(dev->dev, "I2C SET");
> +		val = dw_readl(dev, DW_IC_DATA_CMD);
> +		if (!i2c_slave_event(dev->slave,
> +			I2C_SLAVE_WRITE_RECEIVED, &val)) {
> +			dev_dbg(dev->dev, "Byte %X acked! ", val);
> +			;
> +		}
> +	} else {
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
> +		dev_dbg(dev->dev, "Transmission Complete.");
> +		stat = i2c_dw_read_clear_intrbits(dev);
> +	}
> +
> +	if (stat & DW_IC_INTR_TX_OVER) {
> +		dw_readl(dev, DW_IC_CLR_TX_OVER);
> +		return true;
> +	}
> 

> +done:

Useless label. Return directly.


> +	return true;
> +}

The function might need a refactoring.

> +
>  static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
>  {
>  	struct dw_i2c_dev *dev = dev_id;
> -	u32 stat, enabled;
> +	u32 stat, enabled, mode;
>  
>  	enabled = dw_readl(dev, DW_IC_ENABLE);
> +	mode = dw_readl(dev, DW_IC_CON);
>  	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> -	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
> enabled, stat);
> +
> +	stat = i2c_dw_read_clear_intrbits(dev);
> +
> +	dev_dbg(dev->dev,
> +		"%s: enabled=%#x stat=%#x\n", __func__, enabled,
> stat);
> +
>  	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
>  		return IRQ_NONE;
>  
>  	stat = i2c_dw_read_clear_intrbits(dev);
>  
> +	if (!(mode & DW_IC_CON_MASTER) && !(mode &
> DW_IC_CON_SLAVE_DISABLE)) {
> +
> 

> +		/* slave  mode*/

Hmm... Besides style does it really help?

> +		if (!i2c_dw_slave_irq_handler(dev))
> +			return IRQ_NONE;
> +
> +		complete(&dev->cmd_complete);
> +		return IRQ_HANDLED;
> +	}
> +


> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -28,9 +28,13 @@
>  #define DW_IC_CON_SPEED_FAST		0x4
>  #define DW_IC_CON_SPEED_HIGH		0x6
>  #define DW_IC_CON_SPEED_MASK		0x6
> +#define DW_IC_CON_10BITADDR_SLAVE       0x8
>  #define DW_IC_CON_10BITADDR_MASTER	0x10
>  #define DW_IC_CON_RESTART_EN		0x20
>  #define DW_IC_CON_SLAVE_DISABLE		0x40
> +#define DW_IC_CON_STOP_DET_IFADDRESSED  0x80
> +#define DW_IC_CON_TX_EMPTY_CTRL		0x100
> +#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL	0x200
>  
>  
>  /**
> @@ -80,7 +84,8 @@ struct dw_i2c_dev {
>  	void __iomem		*base;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> -	u32			(*get_clk_rate_khz) (struct
> dw_i2c_dev *dev);
> +	struct i2c_client		*slave;
> 

> +	u32			(*get_clk_rate_khz)(struct
> dw_i2c_dev *dev);

What happened to this member? Indentation fix? Not here.

> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -21,6 +21,7 @@
>   * ------------------------------------------------------------------
> ----------
>   *
>   */
> +

Ditto.

>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>

> @@ -158,6 +159,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	struct resource *mem;
>  	int irq, r;
>  	u32 acpi_speed, ht = 0;
> +	bool isslave = false;

isslave -> is_slave.

>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -190,6 +192,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  					 &dev->scl_falling_time);
>  		device_property_read_u32(&pdev->dev, "clock-
> frequency",
>  					 &dev->clk_freq);
> +		isslave = device_property_read_bool(&pdev->dev,
> "isslave");

This needs a separate patch against device bindings.
Moreover, check if:
- there is already standard property for such functionality
- it can/can't be discovered automatically
- consequences of use this on ACPI-enabled platforms

> @@ -216,24 +219,46 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  
>  	dev->functionality =
>  		I2C_FUNC_I2C |
> -		I2C_FUNC_10BIT_ADDR |
>  		I2C_FUNC_SMBUS_BYTE |
>  		I2C_FUNC_SMBUS_BYTE_DATA |
>  		I2C_FUNC_SMBUS_WORD_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>  
> -	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE
> |
> +	if (!isslave) {
> +		dev->master_cfg = DW_IC_CON_MASTER |
> DW_IC_CON_SLAVE_DISABLE |
>  			  DW_IC_CON_RESTART_EN;
> +		dev->functionality |= I2C_FUNC_10BIT_ADDR;
> +		dev_info(&pdev->dev, "I am registed as a I2C
> Master!\n");
> +		switch (dev->clk_freq) {
> +		case 100000:
> +			dev->master_cfg |= DW_IC_CON_SPEED_STD;
> +			break;
> +		case 3400000:
> +			dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
> +			break;
> +		default:
> +			dev->master_cfg |= DW_IC_CON_SPEED_FAST;
> +		}
> +	} else {
> +		dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
> +			  DW_IC_CON_RESTART_EN |
> DW_IC_CON_STOP_DET_IFADDRESSED |
> +			  DW_IC_CON_SPEED_FAST;
> +
> +		dev->functionality |= I2C_FUNC_SLAVE;
> +		dev->functionality &= ~I2C_FUNC_10BIT_ADDR;
> +		dev_info(&pdev->dev, "I am registed as a I2C
> Slave!\n");
> +
> +		switch (dev->clk_freq) {
> +		case 100000:
> +			dev->slave_cfg |= DW_IC_CON_SPEED_STD;
> +
> +		case 3400000:
> +			dev->slave_cfg |= DW_IC_CON_SPEED_HIGH;
> +			break;
> +		default:
> +			dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
>  
> -	switch (dev->clk_freq) {
> -	case 100000:
> -		dev->master_cfg |= DW_IC_CON_SPEED_STD;
> -		break;
> -	case 3400000:
> -		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
> -		break;
> -	default:
> -		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
> +		}

Factor out _master() part first.

In summary I see 4 patches here:
- factor out _master() parts
- enable slave
- device bindings
- indentation fix

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
