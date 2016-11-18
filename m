From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/5] i2c: designware: Add slave mode as separated
 driver
Date: Fri, 18 Nov 2016 14:49:48 +0200
Message-ID: <1479473388.22212.26.camel@linux.intel.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
         <36abadc931ab0814019c9b2214886bcb4e4ce5c1.1479410047.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932211AbcKRMwx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 07:52:53 -0500
In-Reply-To: <36abadc931ab0814019c9b2214886bcb4e4ce5c1.1479410047.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Fri, 2016-11-18 at 11:19 +0000, Luis Oliveira wrote:
>  - Slave mode selected by compatibility string in platform module
>  - Changes in Makefile to compile i2c-designware-core with slave
> functions


> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -160,6 +160,30 @@ static void i2c_dw_configure_master(struct
> platform_device *pdev)
>  	}
>  }
>  
> +static void i2c_dw_configure_slave(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> +
> +	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
> +			 DW_IC_CON_RESTART_EN |
> DW_IC_CON_STOP_DET_IFADDRESSED |
> +			 DW_IC_CON_SPEED_FAST;
> +
> +	dev->functionality |= I2C_FUNC_SLAVE;
> +	dev->functionality &= ~I2C_FUNC_10BIT_ADDR;

> +	dev_info(&pdev->dev, "I am registed as a I2C Slave!\n");

Not for production. 

> @@ -244,7 +268,11 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  		I2C_FUNC_SMBUS_WORD_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>  
> -	i2c_dw_configure_master(pdev);
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +		 "snps,designware-i2c-slave"))

No.

We don't use of_property_*() anymore in general. Instead find
appropriate device_property_*() one. Besides, remind about comment
regarding to the property itself.

> +		i2c_dw_configure_slave(pdev);
> +	else
> +		i2c_dw_configure_master(pdev);

I would go then switch case here, where third variant prints an error
that mode X doesn't supported / invalid and bails out.

> @@ -257,7 +285,13 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	}
>  
>  	if (!dev->tx_fifo_depth) {
> -		u32 param1 = i2c_dw_read_comp_param(dev);
> +		u32 param1;
> +

> +		if (of_device_is_compatible(pdev->dev.of_node,
> +			 "snps,designware-i2c-slave"))

Cache it in local variable if needed.

> +			param1 = i2c_dw_read_comp_param_slave(dev);
> +		else
> +			param1 = i2c_dw_read_comp_param(dev);

Shouldn't it have a _master suffix?

>  
>  		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
>  		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
> @@ -278,8 +312,12 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  		pm_runtime_set_active(&pdev->dev);
>  		pm_runtime_enable(&pdev->dev);
>  	}
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +		 "snps,designware-i2c-slave"))
> +		r = i2c_dw_probe_slave(dev);
> +	else
> +		r = i2c_dw_probe(dev);

Ditto.

> @@ -291,10 +329,13 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
>  	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
>  
>  	pm_runtime_get_sync(&pdev->dev);

> -

Doesn't belong to the patch.

>  	i2c_del_adapter(&dev->adapter);
>  
> -	i2c_dw_disable(dev);
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +		 "snps,designware-i2c-slave"))
> +		i2c_dw_disable_slave(dev);
> +	else
> +		i2c_dw_disable(dev);

_master?

>  
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
> @@ -307,6 +348,9 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id dw_i2c_of_match[] = {
>  	{ .compatible = "snps,designware-i2c", },
> +#ifndef CONFIG_ACPI

No, no, no.

> +	{ .compatible = "snps,designware-i2c-slave", },
> +#endif
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> @@ -334,7 +378,11 @@ static int dw_i2c_plat_suspend(struct device
> *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>  
> -	i2c_dw_disable(i_dev);
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +		 "snps,designware-i2c-slave"))
> +		i2c_dw_disable_slave(i_dev);
> +	else
> +		i2c_dw_disable(i_dev);

Same comments as above.

>  	i2c_dw_plat_prepare_clk(i_dev, false);
>  
>  	return 0;
> @@ -347,8 +395,13 @@ static int dw_i2c_plat_resume(struct device *dev)
>  
>  	i2c_dw_plat_prepare_clk(i_dev, true);
>  
> -	if (!i_dev->pm_runtime_disabled)
> -		i2c_dw_init(i_dev);
> +	if (!i_dev->pm_runtime_disabled) {
> +		if (of_device_is_compatible(pdev->dev.of_node,
> +			 "snps,designware-i2c-slave"))
> +			i2c_dw_init_slave(i_dev);
> +		else
> +			i2c_dw_init(i_dev);

Ditto.

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-slave.c

Slave...

> @@ -0,0 +1,445 @@
> +/*
> + * Synopsys DesignWare I2C adapter driver (master only).

Master...

> + *
> + * Based on the TI DAVINCI I2C adapter driver.
> + *
+ * Copyright (C) 2006 Texas Instruments.
> + * Copyright (C) 2007 MontaVista Software Inc.
> + * Copyright (C) 2009 Provigent Ltd.

Are you sure about these lines?


> +#include <linux/export.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>

+ empty line.

> +#include "i2c-designware-core.h"
> +


> +/**
> + * i2c_dw_init_slave() - initialize the designware i2c slave hardware
> + * @dev: device private data
> + *
> + * This functions configures and enables the I2C.
> + * This function is called during I2C init function, and in case of
> timeout at
> + * run time.
> + */
> +int i2c_dw_init_slave(struct dw_i2c_dev *dev)
> +{
> +	u32 hcnt, lcnt;
> +	u32 reg, comp_param1;
> +	u32 sda_falling_time, scl_falling_time;

Reversed tree, pls.

> +	int ret;
> +
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return ret;
> +
> +	reg = dw_readl(dev, DW_IC_COMP_TYPE);
> +	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> +		/* Configure register endianness access */
> +		dev->accessor_flags |= ACCESS_SWAP;
> +	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
> +		/* Configure register access mode 16bit */
> +		dev->accessor_flags |= ACCESS_16BIT;
> +	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
> 

> +		dev_err(dev->dev, "Unknown Synopsys component type: "
> +			"0x%08x\n", reg);

Don't break literals.

Choose one that fits.

dev_err(dev->dev, "Unknown Synopsys component type: "0x%08x\n",
	reg);

dev_err(dev->dev,
	"Unknown Synopsys component type: "0x%08x\n", reg);

dev_err(dev->dev,
	"Unknown Synopsys component type: "0x%08x\n",
	
reg);

> +		i2c_dw_release_lock(dev);
> +		return -ENODEV;
> +	}
> +
> +	comp_param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
> +
> 

> +	/* Disable the adapter */

Useless.

> +	__i2c_dw_enable_and_wait(dev, false);
> +
> +	/* set standard and fast speed deviders for high/low periods
> */

Capital letter!

> +	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
> +	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
> +
> +	/* Set SCL timing parameters for standard-mode */
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
> +	/* Set SCL timing parameters for fast-mode or fast-mode plus
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
> +	/* Configure SDA Hold Time if required */
> +	reg = dw_readl(dev, DW_IC_COMP_VERSION);
> +	reg = dw_readl(dev, DW_IC_COMP_VERSION);
> +	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
> +		if (!dev->sda_hold_time) {
> +			/* Keep previous hold time setting if no one
> set it */
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

So, don't make a noise in exported name space. When we need two sets of
functions make an ops structure and assign it where appropriate.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
