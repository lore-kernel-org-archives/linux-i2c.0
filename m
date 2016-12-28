From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 5/7] i2c: designware: add SLAVE mode functions
Date: Wed, 28 Dec 2016 17:36:09 +0200
Message-ID: <1482939369.9552.162.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <15538bd29b3ab62608a4e9153af6ee5d4bdc79e2.1482934380.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19021 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbcL1Phq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Dec 2016 10:37:46 -0500
In-Reply-To: <15538bd29b3ab62608a4e9153af6ee5d4bdc79e2.1482934380.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile it all
> 
> All the SLAVE flow is added but it is not enabled via platform
> driver.

> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -30,6 +30,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +
>  #include "i2c-designware-core.h"
>  
>  static char *abort_sources[] = {
> @@ -42,7 +43,7 @@ static char *abort_sources[] = {
>  	[ABRT_TXDATA_NOACK] =
>  		"data not acknowledged",
>  	[ABRT_GCALL_NOACK] =
> -		"no acknowledgement for a general call",
> +		"no acknowledgment for a general call",

So, what's the point after your confirmation that both variants are
okay?


> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>

> +#include <linux/delay.h>
> +#include <linux/module.h>

Alphabetical order?

> +int i2c_dw_init_slave(struct dw_i2c_dev *dev)
> +{
> +	u32 sda_falling_time, scl_falling_time;
> +	u32 reg, comp_param1;
> +	u32 hcnt, lcnt;
> +	int ret;
> +
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return ret;
> +
> +	reg = dw_readl(dev, DW_IC_COMP_TYPE);
> +	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> +		/* Configure register endianness access. */
> +		dev->accessor_flags |= ACCESS_SWAP;
> +	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
> +		/* Configure register access mode 16bit. */
> +		dev->accessor_flags |= ACCESS_16BIT;
> +	} else if (reg != DW_IC_COMP_TYPE_VALUE) {

> +		dev_err(dev->dev,
> +			 "Unknown Synopsys component type: 0x%08x\n",
> reg);

Is it correct indentation?

> +		i2c_dw_release_lock(dev);
> +		return -ENODEV;
> +	}
> +
> +	comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
> +
> +	/* Disable the adapter. */
> +	__i2c_dw_enable_and_wait(dev, false);
> +
> +	/* Set standard and fast speed deviders for high/low periods.
> */
> +	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
> +	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
> +
> +	/* Set SCL timing parameters for standard-mode. */
> +	if (dev->ss_hcnt && dev->ss_lcnt) {
> +		hcnt = dev->ss_hcnt;
> +		lcnt = dev->ss_lcnt;
> +	} else {
> +		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> +					4000,	/* tHD;STA =
> tHIGH = 4.0 us */
> +					sda_falling_time,
> +					0,	/* 0: DW default,
> 1: Ideal */
> +					0);	/* No offset */
> +		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> +					4700,	/* tLOW = 4.7 us
> */
> +					scl_falling_time,
> +					0);	/* No offset */
> +	}
> +	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
> +	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
> +	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt,
> lcnt);
> +
> +	/* Set SCL timing parameters for fast-mode or fast-mode plus.
> */
> +	if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev-
> >fp_lcnt) {
> +		hcnt = dev->fp_hcnt;
> +		lcnt = dev->fp_lcnt;
> +	} else if (dev->fs_hcnt && dev->fs_lcnt) {
> +		hcnt = dev->fs_hcnt;
> +		lcnt = dev->fs_lcnt;
> +	} else {
> +		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> +					600,	/* tHD;STA =
> tHIGH = 0.6 us */
> +					sda_falling_time,
> +					0,	/* 0: DW default,
> 1: Ideal */
> +					0);	/* No offset */
> +		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> +					1300,	/* tLOW = 1.3 us
> */
> +					scl_falling_time,
> +					0);	/* No offset */
> +	}
> +	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
> +	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
> +	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt,
> lcnt);
> +
> +	if ((dev->slave_cfg & DW_IC_CON_SPEED_MASK) ==
> +		DW_IC_CON_SPEED_HIGH) {
> +		if ((comp_param1 &
> DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
> +			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
> +			dev_err(dev->dev, "High Speed not
> supported!\n");
> +			dev->slave_cfg &= ~DW_IC_CON_SPEED_MASK;
> +			dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
> +		} else if (dev->hs_hcnt && dev->hs_lcnt) {
> +			hcnt = dev->hs_hcnt;
> +			lcnt = dev->hs_lcnt;
> +			dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
> +			dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
> +			dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT =
> %d:%d\n",
> +				hcnt, lcnt);
> +		}
> +	}
> +
> +	/* Configure SDA Hold Time if required. */
> +	reg = dw_readl(dev, DW_IC_COMP_VERSION);
> +	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
> +		if (!dev->sda_hold_time) {
> +			/* Keep previous hold time setting if no one
> set it. */
> +			dev->sda_hold_time = dw_readl(dev,
> DW_IC_SDA_HOLD);
> +		}
> +		/*
> +		 * Workaround for avoiding TX arbitration lost in
> case I2C
> +		 * slave pulls SDA down "too quickly" after falling
> egde of
> +		 * SCL by enabling non-zero SDA RX hold.
> Specification says it
> +		 * extends incoming SDA low to high transition while
> SCL is
> +		 * high but it apprears to help also above issue.
> +		 */
> +		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
> +			dev->sda_hold_time |= 1 <<
> DW_IC_SDA_HOLD_RX_SHIFT;
> +		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
> +	} else {
> +		dev_warn(dev->dev,
> +			"Hardware too old to adjust SDA hold
> time.\n");
> +	}
> +
> +	i2c_dw_configure_fifo_slave(dev);
> +	i2c_dw_release_lock(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_dw_init_slave);

Can we introduce ops structure for those? (private callbacks)

You increase noise in namespace by several i2c_dw_*() functions.
Introduction of ops will keep everything private.


> +
> +int i2c_dw_reg_slave(struct i2c_client *slave)
> +{
> +	struct dw_i2c_dev *dev = i2c_get_adapdata(slave->adapter);
> +
> +	if (dev->slave)
> +		return -EBUSY;
> +	if (slave->flags & I2C_CLIENT_TEN)
> +		return -EAFNOSUPPORT;

> +		/*
> +		 * Set slave address in the IC_SAR register,
> +		 * the address to which the DW_apb_i2c responds.
> +		 */

Wrong indentation?

> +
> +	__i2c_dw_enable(dev, false);
> +	dw_writel(dev, slave->addr, DW_IC_SAR);
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
> +	i2c_dw_disable_int_slave(dev);
> +	i2c_dw_disable_slave(dev);

> +	dev->slave =  NULL;

Extra spaces, remove.

> +
> +	return 0;
> +}
> 

> +static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
> +{
> +	u32 raw_stat, stat, enabled;
> +	u8 val, slave_activity;
> +
> +	stat = dw_readl(dev, DW_IC_INTR_STAT);
> +	enabled = dw_readl(dev, DW_IC_ENABLE);
> +	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +	slave_activity = ((dw_readl(dev, DW_IC_STATUS) &
> +		 DW_IC_STATUS_SLAVE_ACTIVITY) >> 6);
> +
> +	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
> +		return 0;
> +
> +	dev_dbg(dev->dev,
> +	 "%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x :
> INTR_STAT=%#x\n",
> +	 __func__, enabled, slave_activity, raw_stat, stat);

__func__ is redundant.

> +
> +	if (stat & DW_IC_INTR_RESTART_DET)
> +		dw_readl(dev, DW_IC_CLR_RESTART_DET);
> +	if (stat & DW_IC_INTR_START_DET)
> +		dw_readl(dev, DW_IC_CLR_START_DET);
> +	if (stat & DW_IC_INTR_ACTIVITY)
> +		dw_readl(dev, DW_IC_CLR_ACTIVITY);
> +	if (stat & DW_IC_INTR_RX_OVER)
> +		dw_readl(dev, DW_IC_CLR_RX_OVER);
> +	if ((stat & DW_IC_INTR_RX_FULL) && (stat &
> DW_IC_INTR_STOP_DET))
> +		i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_REQUESTED, &val);
> +
> +	if (slave_activity) {
> +		if (stat & DW_IC_INTR_RD_REQ) {
> +			if (stat & DW_IC_INTR_RX_FULL) {
> +				val = dw_readl(dev, DW_IC_DATA_CMD);
> +				if (!i2c_slave_event(dev->slave,
> +				 I2C_SLAVE_WRITE_RECEIVED, &val)) {
> +					dev_dbg(dev->dev, "Byte %X
> acked!",
> +					 val);

Perhaps dev_vdbg() ?

> +				}
> +				dw_readl(dev, DW_IC_CLR_RD_REQ);
> +				stat =
> i2c_dw_read_clear_intrbits_slave(dev);
> +			} else {
> +				dw_readl(dev, DW_IC_CLR_RD_REQ);
> +				dw_readl(dev, DW_IC_CLR_RX_UNDER);
> +				stat =
> i2c_dw_read_clear_intrbits_slave(dev);
> +			}
> +			if (!i2c_slave_event(dev->slave,
> +					 I2C_SLAVE_READ_REQUESTED,
> &val))
> +				dw_writel(dev, val, DW_IC_DATA_CMD);
> +		}
> +	}
> +
> +	if (stat & DW_IC_INTR_RX_DONE) {
> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_READ_PROCESSED,
> +		 &val))
> +			dw_readl(dev, DW_IC_CLR_RX_DONE);
> +
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
> +		stat = i2c_dw_read_clear_intrbits_slave(dev);

> +		return true;

Mistype of value. Should be 1?

> +	}
> +
> +	if (stat & DW_IC_INTR_RX_FULL) {
> +		val = dw_readl(dev, DW_IC_DATA_CMD);
> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_RECEIVED,
> +		 &val))
> +			dev_dbg(dev->dev, "Byte %X acked!", val);

dev_vdbg() ?

> +	} else {
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
> +		stat = i2c_dw_read_clear_intrbits_slave(dev);
> +	}
> +
> +	if (stat & DW_IC_INTR_TX_OVER)
> +		dw_readl(dev, DW_IC_CLR_TX_OVER);
> +
> +	return 1;
> +}
> +
> +static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
> +{
> +	struct dw_i2c_dev *dev = dev_id;
> +	int ret;
> +
> +	i2c_dw_read_clear_intrbits_slave(dev);
> 

> +	ret = i2c_dw_irq_handler_slave(dev);
> +

Swap these lines.

> +	if (ret > 0)
> +		complete(&dev->cmd_complete);
> +
> +	return IRQ_RETVAL(ret);
> +}


> +
> +int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
> +{
> +	struct i2c_adapter *adap = &dev->adapter;
> +	int ret;
> +
> +	init_completion(&dev->cmd_complete);
> +
> +	ret = i2c_dw_init_slave(dev);
> +	if (ret)
> +		return ret;
> +
> 

> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return ret;

I'm not sure you need this in slave code.

> +
> +	i2c_dw_release_lock(dev);
> +	snprintf(adap->name, sizeof(adap->name),
> +		 "Synopsys DesignWare I2C Slave adapter");
> +	adap->retries = 3;
> +	adap->algo = &i2c_dw_algo;
> +	adap->dev.parent = dev->dev;
> +	i2c_set_adapdata(adap, dev);
> +
> +	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr_slave,
> +			     IRQF_SHARED, dev_name(dev->dev), dev);
> +	if (ret) {
> +		dev_err(dev->dev, "failure requesting irq %i: %d\n",
> +			dev->irq, ret);
> +		return ret;
> +	}

> +	/*
> +	 * Increment PM usage count during adapter registration in
> order to
> +	 * avoid possible spurious runtime suspend when adapter
> device is
> +	 * registered to the device core and immediate resume in case
> bus has
> +	 * registered I2C slaves that do I2C transfers in their
> probe.
> +	 */
> +	pm_runtime_get_noresume(dev->dev);

Looks like you blindly copied this from master code. This is about slave
enumeration. How does it related to slave mode?

> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret)
> +		dev_err(dev->dev, "failure adding adapter: %d\n",
> ret);
> +	pm_runtime_put_noidle(dev->dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i2c_dw_probe_slave);


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
