From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg-Bxea+6Xhats@public.gmane.org>
Subject: Re: [PATCH v7 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 12 May 2017 09:02:30 +0200
Message-ID: <a6cc137f-8803-d9a8-e426-052f05a44df5@kaod.org>
References: <20170424181818.2754-1-brendanhiggins@google.com>
 <20170424181818.2754-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170424181818.2754-5-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Brendan,

[ ... ]

> +static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> +{
> +	u32 irq_status, status_ack = 0, command = 0;
> +	struct i2c_msg *msg;
> +	u8 recv_byte;
> +
> +	spin_lock(&bus->lock);
> +	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +
> +	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
> +		goto out_complete;
> +	}
> +
> +	/*
> +	 * Either we encountered an interrupt that reports an error, or we are
> +	 * in an invalid state.
> +	 */
> +	if (irq_status & ASPEED_I2CD_INTR_ERROR ||
> +	    (!bus->msgs && bus->master_state != ASPEED_I2C_MASTER_STOP)) {
> +		dev_dbg(bus->dev, "received error interrupt: 0x%08x",
> +			irq_status);
> +		bus->cmd_err = -EIO;
> +		__aspeed_i2c_do_stop(bus);

If I am correct, this will continuously send STOP commands if 
an interrupt error is reported. It might be worth checking for 
this potential issue.

Thanks,

C. 
 
> +		goto out_no_complete;
> +	}
> +	msg = &bus->msgs[bus->msgs_index];
> +
> +	/*
> +	 * START is a special case because we still have to handle a subsequent
> +	 * TX or RX immediately after we handle it, so we handle it here and
> +	 * then update the state and handle the new state below.
> +	 */
> +	if (bus->master_state == ASPEED_I2C_MASTER_START) {
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +			dev_dbg(bus->dev,
> +				"no slave present at %02x", msg->addr);
> +			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +			goto error_and_stop;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +		if (msg->flags & I2C_M_RD)
> +			bus->master_state = ASPEED_I2C_MASTER_RX_FIRST;
> +		else
> +			bus->master_state = ASPEED_I2C_MASTER_TX_FIRST;
> +	}
> +
> +	switch (bus->master_state) {
> +	case ASPEED_I2C_MASTER_TX:
> +		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> +			dev_dbg(bus->dev, "slave NACKed TX");
> +			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +			goto error_and_stop;
> +		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +			dev_err(bus->dev, "slave failed to ACK TX");
> +			goto error_and_stop;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_TX_FIRST:
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state = ASPEED_I2C_MASTER_TX;
> +			writel(msg->buf[bus->buf_index++],
> +			       bus->base + ASPEED_I2C_BYTE_BUF_REG);
> +			writel(ASPEED_I2CD_M_TX_CMD,
> +			       bus->base + ASPEED_I2C_CMD_REG);
> +		} else {
> +			__aspeed_i2c_next_msg_or_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_RX_FIRST:
> +		/* RX may not have completed yet (only address cycle) */
> +		if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
> +			goto out_no_complete;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_RX:
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> +			dev_err(bus->dev, "master failed to RX");
> +			goto error_and_stop;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> +
> +		recv_byte = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
> +		msg->buf[bus->buf_index++] = recv_byte;
> +
> +		if (msg->flags & I2C_M_RECV_LEN) {
> +			if (unlikely(recv_byte > I2C_SMBUS_BLOCK_MAX)) {
> +				bus->cmd_err = -EPROTO;
> +				__aspeed_i2c_do_stop(bus);
> +				goto out_no_complete;
> +			}
> +			msg->len = recv_byte +
> +					((msg->flags & I2C_CLIENT_PEC) ? 2 : 1);
> +			msg->flags &= ~I2C_M_RECV_LEN;
> +		}
> +
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state = ASPEED_I2C_MASTER_RX;
> +			command = ASPEED_I2CD_M_RX_CMD;
> +			if (bus->buf_index + 1 == msg->len)
> +				command |= ASPEED_I2CD_M_S_RX_CMD_LAST;
> +			writel(command, bus->base + ASPEED_I2C_CMD_REG);
> +		} else {
> +			__aspeed_i2c_next_msg_or_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_STOP:
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> +			dev_err(bus->dev, "master failed to STOP");
> +			bus->cmd_err = -EIO;
> +			/* Do not STOP as we have already tried. */
> +		} else {
> +			status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
> +		}
> +
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		goto out_complete;
> +	case ASPEED_I2C_MASTER_INACTIVE:
> +		dev_err(bus->dev,
> +			"master received interrupt 0x%08x, but is inactive",
> +			irq_status);
> +		bus->cmd_err = -EIO;
> +		/* Do not STOP as we should be inactive. */
> +		goto out_complete;
> +	default:
> +		WARN(1, "unknown master state\n");
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		bus->cmd_err = -EIO;
> +		goto out_complete;
> +	}
> +error_and_stop:
> +	bus->cmd_err = -EIO;
> +	__aspeed_i2c_do_stop(bus);
> +	goto out_no_complete;
> +out_complete:
> +	complete(&bus->cmd_complete);
> +out_no_complete:
> +	if (irq_status != status_ack)
> +		dev_err(bus->dev,
> +			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> +			irq_status, status_ack);
> +	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
> +	spin_unlock(&bus->lock);
> +	return !!irq_status;
> +}
> +
> +static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> +{
> +	struct aspeed_i2c_bus *bus = dev_id;
> +
> +	if (aspeed_i2c_master_irq(bus))
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +
> +static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> +				  struct i2c_msg *msgs, int num)
> +{
> +	struct aspeed_i2c_bus *bus = adap->algo_data;
> +	unsigned long time_left, flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	bus->cmd_err = 0;
> +
> +	/* If bus is busy, attempt recovery. We assume a single master
> +	 * environment.
> +	 */
> +	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +		ret = aspeed_i2c_recover_bus(bus);
> +		if (ret)
> +			return ret;
> +		spin_lock_irqsave(&bus->lock, flags);
> +	}
> +
> +	bus->msgs = msgs;
> +	bus->msgs_index = 0;
> +	bus->msgs_count = num;
> +
> +	reinit_completion(&bus->cmd_complete);
> +	__aspeed_i2c_do_start(bus);
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(&bus->cmd_complete,
> +						bus->adap.timeout);
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	bus->msgs = NULL;
> +	if (time_left == 0)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = bus->cmd_err;
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	/* If nothing went wrong, return number of messages transferred. */
> +	if (ret >= 0)
> +		return bus->msgs_index + 1;
> +	else
> +		return ret;
> +}
> +
> +static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm aspeed_i2c_algo = {
> +	.master_xfer	= aspeed_i2c_master_xfer,
> +	.functionality	= aspeed_i2c_functionality,
> +};
> +
> +static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
> +{
> +	u32 base_clk, clk_high, clk_low, tmp;
> +
> +	/*
> +	 * The actual clock frequency of SCL is:
> +	 *	SCL_freq = APB_freq / (base_freq * (SCL_high + SCL_low))
> +	 *		 = APB_freq / divisor
> +	 * where base_freq is a programmable clock divider; its value is
> +	 *	base_freq = 1 << base_clk
> +	 * SCL_high is the number of base_freq clock cycles that SCL stays high
> +	 * and SCL_low is the number of base_freq clock cycles that SCL stays
> +	 * low for a period of SCL.
> +	 * The actual register has a minimum SCL_high and SCL_low minimum of 1;
> +	 * thus, they start counting at zero. So
> +	 *	SCL_high = clk_high + 1
> +	 *	SCL_low	 = clk_low + 1
> +	 * Thus,
> +	 *	SCL_freq = APB_freq /
> +	 *		((1 << base_clk) * (clk_high + 1 + clk_low + 1))
> +	 * The documentation recommends clk_high >= 8 and clk_low >= 7 when
> +	 * possible; this last constraint gives us the following solution:
> +	 */
> +	base_clk = divisor > 33 ? ilog2((divisor - 1) / 32) + 1 : 0;
> +	tmp = divisor / (1 << base_clk);
> +	clk_high = tmp / 2 + tmp % 2;
> +	clk_low = tmp - clk_high;
> +
> +	clk_high -= 1;
> +	clk_low -= 1;
> +
> +	return ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
> +		& ASPEED_I2CD_TIME_SCL_HIGH_MASK)
> +			| ((clk_low << ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
> +			   & ASPEED_I2CD_TIME_SCL_LOW_MASK)
> +			| (base_clk & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
> +}
> +
> +static int __aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
> +				 struct platform_device *pdev)
> +{
> +	u32 clk_freq, divisor, clk_reg_val;
> +	struct clk *pclk;
> +	int ret;
> +
> +	pclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pclk)) {
> +		dev_err(&pdev->dev, "clk_get failed\n");
> +		return PTR_ERR(pclk);
> +	}
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +				   "bus-frequency", &clk_freq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Could not read bus-frequency property\n");
> +		clk_freq = 100000;
> +	}
> +	divisor = clk_get_rate(pclk) / clk_freq;
> +	/* We just need the clock rate, we don't actually use the clk object. */
> +	devm_clk_put(&pdev->dev, pclk);
> +
> +	clk_reg_val = aspeed_i2c_get_clk_reg_val(divisor);
> +	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
> +
> +	/*
> +	 * If the base divisor is non-zero then we do not want to enable high
> +	 * speed mode, otherwise we might as well enable it.
> +	 * For reference, setting high speed mode will make the base divisor
> +	 * zero and corresponds to a minimum SCL frequency of about 1.5MHz.
> +	 */
> +	if (clk_reg_val & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> +		writel(ASPEED_NO_TIMEOUT_CTRL,
> +		       bus->base + ASPEED_I2C_AC_TIMING_REG2);
> +	} else {
> +		writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) |
> +		       ASPEED_I2CD_M_HIGH_SPEED_EN |
> +		       ASPEED_I2CD_M_SDA_DRIVE_1T_EN |
> +		       ASPEED_I2CD_SDA_DRIVE_1T_EN,
> +		       bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +		writel(0x3, bus->base + ASPEED_I2C_AC_TIMING_REG2);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __aspeed_i2c_init(struct aspeed_i2c_bus *bus,
> +			     struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	/* Disable everything. */
> +	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +	ret = __aspeed_i2c_init_clk(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Master Mode */
> +	writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) |
> +	       ASPEED_I2CD_MASTER_EN |
> +	       /* TODO: provide device tree option for multi-master mode. */
> +	       ASPEED_I2CD_MULTI_MASTER_DIS,
> +	       bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +	/* Set interrupt generation of I2C controller */
> +	writel(ASPEED_I2CD_INTR_ALL, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)
> +{
> +	struct platform_device *pdev = to_platform_device(bus->dev);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	/* Disable and quiesce interrupts. */
> +	reinit_completion(&bus->cmd_complete);
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +	/*
> +	 * We need to make sure that there are no interrupts that fired just
> +	 * before we grabbed the lock; if that did not happen, then we are going
> +	 * to timeout and that is okay.
> +	 */
> +	wait_for_completion_timeout(&bus->cmd_complete, bus->adap.timeout);
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	ret = __aspeed_i2c_init(bus, pdev);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int aspeed_i2c_probe_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus;
> +	struct resource *res;
> +	int ret;
> +
> +	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bus->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(bus->base))
> +		return PTR_ERR(bus->base);
> +
> +	/* Initialize the I2C adapter */
> +	spin_lock_init(&bus->lock);
> +	init_completion(&bus->cmd_complete);
> +	bus->adap.owner = THIS_MODULE;
> +	bus->adap.retries = 0;
> +	bus->adap.timeout = 5 * HZ;
> +	bus->adap.algo = &aspeed_i2c_algo;
> +	bus->adap.algo_data = bus;
> +	bus->adap.dev.parent = &pdev->dev;
> +	bus->adap.dev.of_node = pdev->dev.of_node;
> +	snprintf(bus->adap.name, sizeof(bus->adap.name), "Aspeed i2c");
> +
> +	bus->dev = &pdev->dev;
> +
> +	/*
> +	 * No need to quiesce interrupts because there is no interrupt handler
> +	 * installed.
> +	 */
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +	ret = __aspeed_i2c_init(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	bus->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	ret = devm_request_irq(&pdev->dev, bus->irq, aspeed_i2c_bus_irq,
> +			       0, dev_name(&pdev->dev), bus);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_add_adapter(&bus->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, bus);
> +
> +	dev_info(bus->dev, "i2c bus %d registered, irq %d\n",
> +		 bus->adap.nr, bus->irq);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_remove_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus = platform_get_drvdata(pdev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	/* Disable everything. */
> +	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	i2c_del_adapter(&bus->adap);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_i2c_bus_of_table[] = {
> +	{ .compatible = "aspeed,ast2400-i2c-bus", },
> +	{ .compatible = "aspeed,ast2500-i2c-bus", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
> +
> +static struct platform_driver aspeed_i2c_bus_driver = {
> +	.probe		= aspeed_i2c_probe_bus,
> +	.remove		= aspeed_i2c_remove_bus,
> +	.driver		= {
> +		.name		= "aspeed-i2c-bus",
> +		.of_match_table	= aspeed_i2c_bus_of_table,
> +	},
> +};
> +module_platform_driver(aspeed_i2c_bus_driver);
> +
> +MODULE_AUTHOR("Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("Aspeed I2C Bus Driver");
> +MODULE_LICENSE("GPL v2");
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
