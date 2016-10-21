From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/4] Factor out _master() parts of code and identify
 as much as possible all related with MASTER mode
Date: Fri, 21 Oct 2016 13:37:08 +0300
Message-ID: <1477046228.6423.2.camel@linux.intel.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
         <923d41c5a11538963fe5b49d181cfa8d1fec5756.1476462204.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <923d41c5a11538963fe5b49d181cfa8d1fec5756.1476462204.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2016-10-14 at 17:52 +0100, Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org wrote:
> From: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

This wouldn't be here.

> 

Something wrong with your commit message. Perhaps you were into SVN,
here is a bit different format of the commit messages, i.e.

1. Summary / Subject line — short description
2. Empty line
3. Full description in free form
4. Empty line
5. Tags, such as SoB (Signed-off-by), TB (Tested-by), Fixes, etc.


> @@ -201,6 +203,17 @@ static void dw_writel(struct dw_i2c_dev *dev, u32
> b, int offset)
>  	}
>  }
>  
> +static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
> +{
> +		/* Configure Tx/Rx FIFO threshold levels */
> +		dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
> +		dw_writel(dev, 0, DW_IC_RX_TL);
> +
> +		/* configure the i2c master */

I understand you just moved existing lines, though here is a good chance
to do small style fixes to the comments, i.e. use capital letter.

> +		dw_writel(dev, dev->master_cfg , DW_IC_CON);
> +		dw_writel(dev, DW_IC_INTR_MASTER_MASK,
> DW_IC_INTR_MASK);

Too much indentation. One tab is enough here.

> +}

> @@ -431,12 +444,9 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
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
> +		(dev->master_cfg & DW_IC_CON_SLAVE_DISABLE)) 

Ditto. Align both conditions to be like tabular view.

> +		i2c_dw_configure_fifo_master(dev);
>  
>  	i2c_dw_release_lock(dev);
>  
> @@ -480,7 +490,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
> *dev)
>  		 */
>  		ic_status = dw_readl(dev, DW_IC_STATUS);
>  		if (!dev->dynamic_tar_update_enabled ||
> -		    (ic_status & DW_IC_STATUS_MST_ACTIVITY) ||
> +		    (ic_status & DW_IC_STATUS_MASTER_ACTIVITY) ||
>  		    !(ic_status & DW_IC_STATUS_TFE)) {
>  			__i2c_dw_enable_and_wait(dev, false);
>  			enabled = false;
> @@ -520,7 +530,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
> *dev)
>  
>  	/* Clear and enable interrupts */
>  	dw_readl(dev, DW_IC_CLR_INTR);
> -	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
> +	dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);
>  }
>  
>  /*
> @@ -540,7 +550,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  	u8 *buf = dev->tx_buf;
>  	bool need_restart = false;
>  
> -	intr_mask = DW_IC_INTR_DEFAULT_MASK;
> +	intr_mask = DW_IC_INTR_MASTER_MASK;
>  
>  	for (; dev->msg_write_idx < dev->msgs_num; dev-
> >msg_write_idx++) {
>  		/*
> @@ -839,19 +849,13 @@ static u32 i2c_dw_read_clear_intrbits(struct
> dw_i2c_dev *dev)
>   * Interrupt service routine. This gets called whenever an I2C
> interrupt

Perhaps '...I2C master interrupt occurs.' Or move this comment towards
common handler function.

>   * occurs.
>   */
> -static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> -{
> -	struct dw_i2c_dev *dev = dev_id;
> -	u32 stat, enabled;
> -
> -	enabled = dw_readl(dev, DW_IC_ENABLE);
> -	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> -	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
> enabled, stat);
> -	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
> -		return IRQ_NONE;
>  
> +static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev )
> +{
> +	u32 stat;
> +	
>  	stat = i2c_dw_read_clear_intrbits(dev);

> -
> +	

This change shouldn't be here.

>  	if (stat & DW_IC_INTR_TX_ABRT) {
>  		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
>  		dev->status = STATUS_IDLE;
> @@ -895,7 +899,26 @@ tx_aborted:
>  		i2c_dw_disable_int(dev);
>  		dw_writel(dev, stat, DW_IC_INTR_MASK);
>  	}
> +	return true;
> +}
> +
> +static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> +{
> +	struct dw_i2c_dev *dev = dev_id;
> +	u32 stat, enabled, mode;
> +
> +	enabled = dw_readl(dev, DW_IC_ENABLE);

> +	mode = dw_readl(dev, DW_IC_CON);

Hmm... It's defined but not used?

> +	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +
> +	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
> enabled, stat);
> +	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
> +		return IRQ_NONE;
>  
> +	if(i2c_dw_irq_handler_master(dev))

Keep style — 'if ('.

> +		return IRQ_HANDLED;

> +			

Check for trailing whitespaces. Please, don't add new ones. Good start
is to run checkpatch.pl before send them.


> +	complete(&dev->cmd_complete);

Didn't find removal of the line. Is it new code? Shouldn't be here if
so.

>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0b42a12..d5986c2 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -138,6 +138,29 @@ static inline int dw_i2c_acpi_configure(struct
> platform_device *pdev)
>  }
>  #endif
>  
> +static void i2c_dw_configure_master(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> +	
> +	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE
> |
> +			  DW_IC_CON_RESTART_EN;
> +			  
> +	dev->functionality |= I2C_FUNC_10BIT_ADDR;
> +	dev_info(&pdev->dev, "I am registed as a I2C Master!\n");
> +	
> +	switch (dev->clk_freq) {
> +	case 100000:
> +		dev->master_cfg |= DW_IC_CON_SPEED_STD;
> +		break;
> +	case 3400000:
> +		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
> +		break;
> +	default:
> +		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
> +	}

> +	

Again, trailing white space and moreover redundant entire line since
it's empty and doesn't bring any readability.

> +}
> +
>  static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool
> prepare)
>  {
>  	if (IS_ERR(i_dev->clk))
> @@ -222,19 +245,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  		I2C_FUNC_SMBUS_WORD_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>  
> -	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE
> |
> -			  DW_IC_CON_RESTART_EN;
> -
> -	switch (dev->clk_freq) {
> -	case 100000:
> -		dev->master_cfg |= DW_IC_CON_SPEED_STD;
> -		break;
> -	case 3400000:
> -		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
> -		break;
> -	default:
> -		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
> -	}
> +	i2c_dw_configure_master(pdev);
>  
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (!i2c_dw_plat_prepare_clk(dev, true)) {

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
