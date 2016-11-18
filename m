From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 1/5] i2c: designware: Refactoring of the
 i2c-designware core and platform module
Date: Fri, 18 Nov 2016 14:26:29 +0200
Message-ID: <1479471989.22212.19.camel@linux.intel.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
         <263695b745c23f19bc83cbf1f18eca6b8c60cd4c.1479410047.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <263695b745c23f19bc83cbf1f18eca6b8c60cd4c.1479410047.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2016-11-18 at 11:19 +0000, Luis Oliveira wrote:
> - Factor out _master() parts of code to separate functions.
> - Standardize all code relatated to I2C master.
> 
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

Can you shrink Cc list to people who indeed are involved / concerned?

> ---
> Changes V2->V3: (Andy Shevchenko)
> - indentation and style fix
> - nothing else was changed in this patch from v2 

Hmm...

May I add few more comments?

> @@ -87,13 +87,13 @@
>  #define DW_IC_INTR_GEN_CALL	0x800
>  
>  #define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL |
> \
> -					 DW_IC_INTR_TX_EMPTY | \
>  					 DW_IC_INTR_TX_ABRT | \
>  					 DW_IC_INTR_STOP_DET)

> -

Do you need to remove it?

I would leave it...

> +#define DW_IC_INTR_MASTER_MASK		(DW_IC_INTR_DEFAULT_MAS
> K | \
> +					 DW_IC_INTR_TX_EMPTY)

...here.

>  #define DW_IC_STATUS_ACTIVITY		0x1
>  #define DW_IC_STATUS_TFE		BIT(2)
> -#define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
> +#define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
 

> +static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
> +{
> +	/* Configure Tx/Rx FIFO threshold levels */
> +	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
> +	dw_writel(dev, 0, DW_IC_RX_TL);
> +
> +	/* configure the i2c master */
> +	dw_writel(dev, dev->master_cfg, DW_IC_CON);

> +	dw_writel(dev, DW_IC_INTR_MASTER_MASK, DW_IC_INTR_MASK);

So, in the original code there were 3 writes, now 4. Please, put an
explanation into commit message.

> +}

> @@ -442,12 +453,9 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
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

Indentation!

> +		i2c_dw_configure_fifo_master(dev);

> -static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> +static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev)

Perhaps int?

>  {
> -	struct dw_i2c_dev *dev = dev_id;
> -	u32 stat, enabled;
> -
> -	enabled = dw_readl(dev, DW_IC_ENABLE);
> -	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> -	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
> enabled, stat);
> -	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
> -		return IRQ_NONE;
> +	u32 stat;
>  
>  	stat = i2c_dw_read_clear_intrbits(dev);
>  
> @@ -906,7 +907,26 @@ static irqreturn_t i2c_dw_isr(int this_irq, void
> *dev_id)
>  		i2c_dw_disable_int(dev);
>  		dw_writel(dev, stat, DW_IC_INTR_MASK);
>  	}

> +	return true;

Ditto.

And basically I don't see how this would be not true? Are you planning
to add something here later in the series? Please, elaborate in the
commit message.

> +}
> +
> +static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> +{
> +	struct dw_i2c_dev *dev = dev_id;
> +	u32 stat, enabled, mode;
> +

> +	enabled = dw_readl(dev, DW_IC_ENABLE);
> +	mode = dw_readl(dev, DW_IC_CON);
> +	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +
> +	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
> enabled, stat);

For sake of easier review, can we keep same lines same and in the same
order?

	struct dw_i2c_dev *dev = dev_id;
	u32 stat, enabled;

	enabled = dw_readl(dev, DW_IC_ENABLE);
	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
enabled, stat);
	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
		return IRQ_NONE;

Btw, I do not see how mode is used? Do you have a warning?
Please, fix.

> +	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
> +		return IRQ_NONE;


> +static void i2c_dw_configure_master(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> +
> +	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE
> |
> +			  DW_IC_CON_RESTART_EN;
> +

> +	dev->functionality |= I2C_FUNC_10BIT_ADDR;

Where this came from?

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
> +}
> +
>  static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool
> prepare)
>  {
>  	if (IS_ERR(i_dev->clk))
> @@ -222,19 +244,7 @@ static int dw_i2c_plat_probe(struct
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
