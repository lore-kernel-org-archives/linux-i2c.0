From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/4] Added I2C_SLAVE as a dependency to
 I2C_DESIGNWARE_CORE Enable _slave() mode Review of the pm_runtime...()
 methods and cleaning
Date: Fri, 21 Oct 2016 13:52:23 +0300
Message-ID: <1477047143.6423.4.camel@linux.intel.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
         <ffbbaeace295a28ade33aafde7f287c6bcc901eb.1476462204.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ffbbaeace295a28ade33aafde7f287c6bcc901eb.1476462204.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis.Oliveira@synopsys.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Fri, 2016-10-14 at 17:52 +0100, Luis.Oliveira@synopsys.com wrote:
> From: Luis Oliveira <lolivei@synopsys.com>
> 

Same style issues here and in the code itself. Check all your patches
before submitting.

More comments below.

> @@ -785,9 +817,59 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
>  	return dev->functionality;
>  }
>  
> +static int i2c_dw_reg_slave(struct i2c_client *slave)
> +{
> +	struct dw_i2c_dev *dev =  i2c_get_adapdata(slave->adapter);

Just '...dev = i2c...'.

> +

> +	if(dev->slave)
> +		return -EBUSY;

Hmm... Is it possible that function be called twice?

> +	if(slave->flags & I2C_CLIENT_TEN)
> +		return -EAFNOSUPPORT;
> +		/* set slave address in the IC_SAR register, 
> +		* the address to which the DW_apb_i2c responds */
> +
> +	__i2c_dw_enable(dev, false);
> +	
> +	dw_writel(dev, slave->addr, DW_IC_SAR);
> +
> +	pm_runtime_get_sync(dev->dev);
> +	

> +	dev->slave = slave;

So, you are using this variable to serialize the calls. Assume it's
possible that upper layer calls several time the function how you
protect the potential race here?

No need runtime PM for this line as well.

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

I'm not sure it's needed. Consider together with comment regarding
_reg_slave().

> +
> +	i2c_dw_disable_int(dev);
> +	i2c_dw_disable(dev);
> +

> +	dev->slave =  NULL;

Same comments as for _reg_slave().

> +
> +	pm_runtime_put(dev->dev);
> +
> +	return 0;
> +}
> +
>  static struct i2c_algorithm i2c_dw_algo = {
>  	.master_xfer	= i2c_dw_xfer,
>  	.functionality	= i2c_dw_func,
> +	.reg_slave	= i2c_dw_reg_slave,
> +	.unreg_slave	= i2c_dw_unreg_slave,
>  };
>  
>  static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
> @@ -821,8 +903,6 @@ static u32 i2c_dw_read_clear_intrbits(struct
> dw_i2c_dev *dev)
>  		dw_readl(dev, DW_IC_CLR_RX_OVER);
>  	if (stat & DW_IC_INTR_TX_OVER)
>  		dw_readl(dev, DW_IC_CLR_TX_OVER);
> -	if (stat & DW_IC_INTR_RD_REQ)
> -		dw_readl(dev, DW_IC_CLR_RD_REQ);
>  	if (stat & DW_IC_INTR_TX_ABRT) {
>  		/*
>  		 * The IC_TX_ABRT_SOURCE register is cleared whenever
> @@ -849,6 +929,84 @@ static u32 i2c_dw_read_clear_intrbits(struct
> dw_i2c_dev *dev)
>   * Interrupt service routine. This gets called whenever an I2C
> interrupt
>   * occurs.
>   */
> + 
> +static bool i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev )
> +{
> +	u32 raw_stat, stat, enabled;
> +	u8 val, slave_activity;
> +	
> +	stat = dw_readl(dev, DW_IC_INTR_STAT);
> +	enabled = dw_readl(dev, DW_IC_ENABLE);
> +	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +	slave_activity = ((dw_readl(dev,DW_IC_STATUS) & 
> +	DW_IC_STATUS_SLAVE_ACTIVITY)>>6);
> +		
> +	dev_dbg(dev->dev, 
> +	"%s: %#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x :
> INTR_STAT=%#x\n", 
> +	 __func__, enabled, slave_activity, raw_stat, stat); 
> +
> +	if (stat & DW_IC_INTR_START_DET)
> +		dw_readl(dev, DW_IC_CLR_START_DET);
> +		
> +	if (stat & DW_IC_INTR_ACTIVITY)
> +		dw_readl(dev, DW_IC_CLR_ACTIVITY);
> +
> +	if (stat & DW_IC_INTR_RX_OVER)
> +		dw_readl(dev, DW_IC_CLR_RX_OVER);
> +	
> +       if ((stat & DW_IC_INTR_RX_FULL) && (stat &
> DW_IC_INTR_STOP_DET)) 
> +		i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_REQUESTED, &val);
> +	
> +	if (slave_activity) {     
> +		if (stat & DW_IC_INTR_RD_REQ) {                 
> +			if (stat & DW_IC_INTR_RX_FULL) {
> +				val = dw_readl(dev, DW_IC_DATA_CMD);
> +				if (!i2c_slave_event(dev->slave, 
> +					I2C_SLAVE_WRITE_RECEIVED,
> &val)) {
> +					dev_dbg(dev->dev, "Byte %X
> acked! ",val);
> +				}
> +				dw_readl(dev, DW_IC_CLR_RD_REQ);
> +				stat =
> i2c_dw_read_clear_intrbits(dev);

> +			}
> +			else {

Style is '} else {'.

> +				dw_readl(dev, DW_IC_CLR_RD_REQ);
> +				dw_readl(dev, DW_IC_CLR_RX_UNDER);
> +				stat =
> i2c_dw_read_clear_intrbits(dev);
> +			}     
> +			if (!i2c_slave_event(dev->slave, 
> +					I2C_SLAVE_READ_REQUESTED,
> &val))
> +				dw_writel(dev, val, DW_IC_DATA_CMD);
> +		}
> +	}        
> +	
> +	if (stat & DW_IC_INTR_RX_DONE) {
> +		
> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_READ_PROCESSED, &val)) 
> +			dw_readl(dev, DW_IC_CLR_RX_DONE);
> +		
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP , &val);
> +		stat = i2c_dw_read_clear_intrbits(dev);
> +
> +		return true;
> +	}
> +        
> +	if (stat & DW_IC_INTR_RX_FULL) { 
> +		val = dw_readl(dev, DW_IC_DATA_CMD);
> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_RECEIVED, &val))
> +			dev_dbg(dev->dev, "Byte %X acked! ",val);
> +	} 
> +	else {
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP , &val);
> +		stat = i2c_dw_read_clear_intrbits(dev);
> +	}
> +
> +	if (stat & DW_IC_INTR_TX_OVER) {		
> +		dw_readl(dev, DW_IC_CLR_TX_OVER);
> +		return true;
> +	}
> +
> +	return true;
> +}
>  
>  static bool i2c_dw_irq_handler_master(struct dw_i2c_dev *dev )
>  {
> @@ -910,14 +1068,20 @@ static irqreturn_t i2c_dw_isr(int this_irq,
> void *dev_id)
>  	enabled = dw_readl(dev, DW_IC_ENABLE);
>  	mode = dw_readl(dev, DW_IC_CON);
>  	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> -
> +	

Shouldn't be here.

>  	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
> enabled, stat);
>  	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
>  		return IRQ_NONE;
> -
> +	

Ditto.

> +	if (!(mode & DW_IC_CON_MASTER) && !(mode &
> DW_IC_CON_SLAVE_DISABLE)) {
> +		stat = i2c_dw_read_clear_intrbits(dev);
> +		if (!i2c_dw_irq_handler_slave(dev))
> +			return IRQ_NONE;
> +	} else {
>  	if(i2c_dw_irq_handler_master(dev))
>  		return IRQ_HANDLED;

> -			

> +	}

> +

Ditto.

>  	complete(&dev->cmd_complete);
>  	return IRQ_HANDLED;
>  }
> @@ -984,7 +1148,9 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>  	adap->dev.parent = dev->dev;
>  	i2c_set_adapdata(adap, dev);
>  
> -	i2c_dw_disable_int(dev);
> +	if (!i2c_check_functionality(adap,I2C_FUNC_SLAVE)) 
> +		i2c_dw_disable_int(dev);
> +
>  	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
>  			     IRQF_SHARED | IRQF_COND_SUSPEND,
>  			     dev_name(dev->dev), dev);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h
> b/drivers/i2c/busses/i2c-designware-core.h
> index 0d44d2a..de5e4a0 100644
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

Is it possible to split your approach to something like:
1. Add necessary definitions (not actual code).
2. Enable slave.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
