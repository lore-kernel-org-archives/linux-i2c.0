From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 5/6] i2c: designware: add SLAVE mode functions
Date: Mon, 08 May 2017 19:53:19 +0300
Message-ID: <1494262399.30052.69.camel@linux.intel.com>
References: <cover.1493893241.git.lolivei@synopsys.com>
         <b2accd73182d19927dfb0cd1a57cadf469ae5e9d.1493893241.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b2accd73182d19927dfb0cd1a57cadf469ae5e9d.1493893241.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-05-08 at 11:37 +0100, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
> 
> All the SLAVE flow is added but it is not enabled via platform
> driver.

My comments below.
Overall entire series looks much much better than first version.

> @@ -41,6 +41,7 @@ obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
>  obj-$(CONFIG_I2C_DESIGNWARE_CORE)	+= i2c-designware-core.o
>  i2c-designware-core-objs := i2c-designware-common.o i2c-designware-
> master.o

> +i2c-designware-core-$(CONFIG_I2C_DESIGNWARE_SLAVE) += i2c-designware-
> slave.o

What is your intention here?

AFAIUC it should be like

ifneq ($(CONFIG_I2C_DESIGNWARE_SLAVE),n)
i2c-designware-core-objs += i2c-designware-slave.o
endif

> +/**
> + * i2c_dw_init_slave() - Initialize the designware i2c slave hardware
> + * @dev: device private data
> + *
> + * This functions configures and enables the I2C.

functions -> function
I2C -> I2C in slave mode

> + * This function is called during I2C init function, and in case of
> timeout at
> + * run time.
> + */
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
> +		dev->flags |= ACCESS_SWAP;

> +	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {

GENMASK(15, 0)

> +		/* Configure register access mode 16bit. */
> +		dev->flags |= ACCESS_16BIT;
> +	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
> +		dev_err(dev->dev,
> +			"Unknown Synopsys component type: 0x%08x\n",
> reg);
> +		i2c_dw_release_lock(dev);
> +		return -ENODEV;
> +	}

> +/*
> + * Interrupt service routine. This gets called whenever an I2C slave
> interrupt
> + * occurs.
> + */
> +
> +static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
> +{
> +	u32 raw_stat, stat, enabled;
> +	u8 val, slave_activity;
> +
> +	stat = dw_readl(dev, DW_IC_INTR_STAT);
> +	enabled = dw_readl(dev, DW_IC_ENABLE);
> +	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +	slave_activity = ((dw_readl(dev, DW_IC_STATUS) &
> +		DW_IC_STATUS_SLAVE_ACTIVITY) >> 6);
> +
> +	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
> +		return 0;
> +
> +	dev_dbg(dev->dev,
> +		"%#x SLAVE_ACTV=%#x : RAW_INTR_STAT=%#x :
> INTR_STAT=%#x\n",

SLAVE_ACTV -> STATUS_SLAVE_ACTIVITY

> +		enabled, slave_activity, raw_stat, stat);
> +

> +	if (slave_activity) {
> +		if (stat & DW_IC_INTR_RD_REQ) {

Looking into next condition (stat & DW_IC_INTR_RX_DONE) I would 
exchange these lines

> +			if (stat & DW_IC_INTR_RX_FULL) {
> +				val = dw_readl(dev, DW_IC_DATA_CMD);
> +				if (!i2c_slave_event(dev->slave,
> +				I2C_SLAVE_WRITE_RECEIVED, &val)) {
> +					dev_vdbg(dev->dev, "Byte %X
> acked!",
> +					val);
> +					}
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
> +					I2C_SLAVE_READ_REQUESTED,
> &val))
> +				dw_writel(dev, val, DW_IC_DATA_CMD);
> +		}
> +	}
> +
> +	if (stat & DW_IC_INTR_RX_DONE) {
> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_READ_PROCESSED,
> +			&val))
> +			dw_readl(dev, DW_IC_CLR_RX_DONE);
> +
> +		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
> +		stat = i2c_dw_read_clear_intrbits_slave(dev);
> +		return 1;
> +	}
> +
> +	if (stat & DW_IC_INTR_RX_FULL) {
> +		val = dw_readl(dev, DW_IC_DATA_CMD);
> +		if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_RECEIVED,
> +			&val))
> +			dev_vdbg(dev->dev, "Byte %X acked!", val);
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

> +static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
> +{
> +	struct dw_i2c_dev *dev = dev_id;
> +	int ret;
> +
> +	i2c_dw_read_clear_intrbits_slave(dev);
> +	ret = i2c_dw_irq_handler_slave(dev);

> +

I would remove this line.

> +	if (ret > 0)
> +		complete(&dev->cmd_complete);
> +
> +	return IRQ_RETVAL(ret);
> +}

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
