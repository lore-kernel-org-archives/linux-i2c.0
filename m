From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 31 Mar 2017 18:33:30 +1100
Message-ID: <1490945610.3177.229.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328051226.21677-5-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Allright, I finally found some time for reviewing some of this
after splitting the ftgmac100 patch into 54 smaller ones :)

On Mon, 2017-03-27 at 22:12 -0700, Brendan Higgins wrote:

 .../...

> +struct aspeed_i2c_bus {
> +	struct i2c_adapter		adap;
> +	struct device			*dev;
> +	void __iomem			*base;
> +	/* Synchronizes I/O mem access to base. */
> +	spinlock_t			lock;

I am not entirely convinced we need that lock. The i2c core will
take a mutex protecting all operations on the bus. So we only need
to synchronize between our "xfer" code and our interrupt handler.

This probably be done without a lock if we are careful. Not a huge
deal though as Aspeed SoC are currently not SMP so the lock compiles
down to not much unless you have all the debug crap enabled :-)

> +	struct completion		cmd_complete;
> +	int				irq;
> +	/* Transaction state. */
> +	enum aspeed_i2c_master_state	master_state;
> +	struct i2c_msg			*msgs;
> +	size_t				buf_index;
> +	size_t				msgs_index;
> +	size_t				msgs_size;
> +	bool				send_stop;
> +	int				cmd_err;
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	struct i2c_client		*slave;
> +	enum aspeed_i2c_slave_state	slave_state;
> +#endif
> +};

Minor nit but the above should probably be in the slave patch no ?

> +static inline void aspeed_i2c_write(struct aspeed_i2c_bus *bus, u32
> val,
> +				    u32 reg)
> +{
> +	writel(val, bus->base + reg);
> +}
> +
> +static inline u32 aspeed_i2c_read(struct aspeed_i2c_bus *bus, u32
> reg)
> +{
> +	return readl(bus->base + reg);
> +}

Another very minor nit, I'm not certain those accessors are a big
win in code size and/or readability but keep them if you want.

> +static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
> +{
> +	unsigned long time_left, flags;
> +	int ret = 0;
> +	u32 command;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	command = aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG);
> +
> +	if (command & ASPEED_I2CD_SDA_LINE_STS) {
> +		/* Bus is idle: no recovery needed. */
> +		if (command & ASPEED_I2CD_SCL_LINE_STS)
> +			goto out;
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
> +			command);
> +
> +		aspeed_i2c_write(bus, ASPEED_I2CD_M_STOP_CMD,
> +				 ASPEED_I2C_CMD_REG);
> +		reinit_completion(&bus->cmd_complete);
> +		spin_unlock_irqrestore(&bus->lock, flags);

See my comment further down in master_xfer, do the reinit before sending
the command, even if currently the lock protects you, it's cleaner.

Now, I don't completely get how your interrupt handler deals with these
"message-less" completions. See the review of the interrupt handler.

> +
> +		time_left = wait_for_completion_timeout(
> +				&bus->cmd_complete, bus->adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left == 0)
> +			ret = -ETIMEDOUT;
> +		else if (bus->cmd_err)
> +			ret = -EIO;
> +	/* Bus error. */
> +	} else {
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
> +			command);
> +
> +		aspeed_i2c_write(bus, ASPEED_I2CD_BUS_RECOVER_CMD,
> +				 ASPEED_I2C_CMD_REG);
> +		reinit_completion(&bus->cmd_complete);

Same comments as above.

> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left = wait_for_completion_timeout(
> +				&bus->cmd_complete, bus->adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left == 0)
> +			ret = -ETIMEDOUT;
> +		else if (bus->cmd_err)
> +			ret = -EIO;
> +		/* Recovery failed. */
> +		else if (!(aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG) &
> +			   ASPEED_I2CD_SDA_LINE_STS))
> +			ret = -EIO;
> +	}

Some of those error states probably also warrant a reset of the controller,
I think aspeed does that in the SDK.

> +out:
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void do_start(struct aspeed_i2c_bus *bus)
> +{
> +	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
> +	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
> +	u8 slave_addr = msg->addr << 1;
> +
> +	bus->master_state = ASPEED_I2C_MASTER_START;
> +	bus->buf_index = 0;
> +
> +	if (msg->flags & I2C_M_RD) {
> +		slave_addr |= 1;
> +		command |= ASPEED_I2CD_M_RX_CMD;
> +		/* Need to let the hardware know to NACK after RX. */
> +		if (msg->len == 1 && !(msg->flags & I2C_M_RECV_LEN))
> +			command |= ASPEED_I2CD_M_S_RX_CMD_LAST;
> +	}


What about I2C_M_NOSTART ? 

Not that I've ever seen it used... ;-)

> +	aspeed_i2c_write(bus, slave_addr, ASPEED_I2C_BYTE_BUF_REG);
> +	aspeed_i2c_write(bus, command, ASPEED_I2C_CMD_REG);
> +}
> +
> +static void do_stop(struct aspeed_i2c_bus *bus)
> +{
> +	bus->master_state = ASPEED_I2C_MASTER_STOP;
> +	aspeed_i2c_write(bus, ASPEED_I2CD_M_STOP_CMD,
> +			 ASPEED_I2C_CMD_REG);
> +}
> +
> +static void aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> +{
> +	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
> +	u32 irq_status, status_ack = 0, command = 0;
> +	u8 recv_byte;

If your lock means anything you should probably capture bus->msgs[..]
with the lock held. That said, see my previous comment about the
lock possibly not being terribly useful.

Additionally, if you are doing a bus recovery, won't you be messing
around with a stale or NULL bus->msgs ?

I would at the very least make it

	msg = bus->msgs ? &bus->msgs[bus->msgs_index] : NULL;

That way msg is NULL in the recovery case rather than a random
crap pointer.

> +	spin_lock(&bus->lock);
> +	irq_status = aspeed_i2c_read(bus, ASPEED_I2C_INTR_STS_REG);
>

I would "ack" (write back to INTR_STS_REG) immediately. Otherwise
you have a race between status bits set as a result of what happened
before the interrupt handler vs. as a result of what you did.

For example, take TX. You get the TX bit in irq_status. You start
a new character transmission bcs there's more to send *then* you ack
the TX bit. That's racy. If that new transmission is fast enough,
you'll end up acking the wrong one. Again this is extremely unlikely
but code should be written in a way that is completely fool proof
from such races. They can happen for stupid reasons, such as huge
bus delays caused by a peripheral, FIQ going bonkers etc...

In general, you always ACK all interrupts first. Then you handle
the bits you have harvested.

> +	if (irq_status & ASPEED_I2CD_INTR_ERROR ||
> +	    (!bus->msgs && bus->master_state != ASPEED_I2C_MASTER_STOP)) {

What happen with recovery completion here ?

Won't we hit !bus->msgs && master state != stop ? Especially
if we hit a timeout where we haven't cleaned up any of our state.

> +		dev_dbg(bus->dev, "received error interrupt: 0x%08x",
> +			irq_status);

This is confusing too in the case of master_state != stop ... any
interrupt will trigger that. I think it would be worthwhile either
commenting a bit more here or having clearer messages depending
on the condition.

> +		bus->cmd_err = -EIO;
> +		do_stop(bus);
> +		goto out_no_complete;
> +	}
> +
> +	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
> +		goto out_complete;
> +	}

I would set master_state to "RECOVERY" (new state ?) and ensure
those things are caught if they happen outside of a recovery.

> +	if (bus->master_state == ASPEED_I2C_MASTER_START) {

Here a comment would be handy as to why you do this before the
switch/case. I understand why but it makes reading the code by
somebody else easier.

> +		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK)) {

Minor nit:

		if (unlikely(error case)) {
			...
			goto out;
		}
		...

Ie, you don't need the "else", and you make it clear that this
is an error case, allowing the compiler to potentially optimize
the likely branch.

In fact, I would have that on all the error cases above too.

I understand now why you have that 'status_ack'. You are trying
to catch the bits that may be set that shouldn't be.

I think you should still "ack early". However, you could have
status_ack called status_handled or something like that and
at the end, still catch "spurrious" bits.

That said, I notice a lot of duplication in your state machine.

You basically have each state starting with

	if (didn't get the bit I wanted) {
		error
	}

You are also not very consistent as to whether you generate a
stop as a result or not.

I would happily simplify that state machine by just completing
with an error and letting master_xfer() do a stop when done but
if you like to keep it the way it is, you could have a common
goto label that handle error + stop.

> +			dev_dbg(bus->dev,
> +				"no slave present at %02x", msg->addr);
> +			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +			bus->cmd_err = -EIO;
> +			do_stop(bus);
> +			goto out_no_complete;
> +		} else {
> +			status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +			if (msg->flags & I2C_M_RD)
> +				bus->master_state = ASPEED_I2C_MASTER_RX;
> +			else
> +				bus->master_state = ASPEED_I2C_MASTER_TX_FIRST;

What about the SMBUS_QUICK case ? (0-len transfer). Do we need
to handle this here ? A quick look at the TX_FIRST case makes
me think we are ok there but I'm not sure about the RX case.

I'm not sure the RX case is tight also. What completion does the
HW give you for the address cycle ? Won't you get that before it
has received the first character ? IE. You fall through to
the read case of the state machine with the read potentially
not complete yet no ?

> +		}
> +	}
> +
> +	switch (bus->master_state) {
> +	case ASPEED_I2C_MASTER_TX:
> +		if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
> +			dev_dbg(bus->dev, "slave NACKed TX");
> +			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +			bus->cmd_err = -EIO;
> +			do_stop(bus);
> +			goto out_no_complete;

As I said earlier, I would factor all the error cases. I would also
not worry too much about checking that the status bits meet expectation
in the error path.

> +		} else if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
> {
> +			dev_err(bus->dev, "slave failed to ACK TX");
> +			goto out_complete;

You should still stop.

> +		}
> +		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_TX_FIRST:
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state = ASPEED_I2C_MASTER_TX;
> +			aspeed_i2c_write(bus, msg->buf[bus->buf_index++],
> +					 ASPEED_I2C_BYTE_BUF_REG);
> +			aspeed_i2c_write(bus, ASPEED_I2CD_M_TX_CMD,
> +					 ASPEED_I2C_CMD_REG);
> +		} else if (bus->msgs_index + 1 < bus->msgs_size) {
> +			bus->msgs_index++;
> +			do_start(bus);
> +		} else {
> +			do_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_RX:
> +		if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE)) {
> +			dev_err(bus->dev, "master failed to RX");
> +			goto out_complete;
> +		}

See my comment above for a bog standard i2c_read. Aren't you getting
the completion for the address before the read is even started ?

> +		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> +
> +		recv_byte = aspeed_i2c_read(bus, ASPEED_I2C_BYTE_BUF_REG) >> 8;
> +		msg->buf[bus->buf_index++] = recv_byte;
> +
> +		if (msg->flags & I2C_M_RECV_LEN &&
> +		    recv_byte <= I2C_SMBUS_BLOCK_MAX) {
> +			msg->len = recv_byte +
> +					((msg->flags & I2C_CLIENT_PEC) ? 2 : 1);
> +			msg->flags &= ~I2C_M_RECV_LEN;
> +		}

You need to error out with -EPROTO if the size is too large.

> +
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state = ASPEED_I2C_MASTER_RX;
> +			command = ASPEED_I2CD_M_RX_CMD;
> +			if (bus->buf_index + 1 == msg->len)
> +				command |= ASPEED_I2CD_M_S_RX_CMD_LAST;
> +			aspeed_i2c_write(bus, command, ASPEED_I2C_CMD_REG);
> +		} else if (bus->msgs_index + 1 < bus->msgs_size) {
> +			bus->msgs_index++;
> +			do_start(bus);
> +		} else {
> +			do_stop(bus);
> +		}

You have some duplication. You could have your "completed message,
switch to the next one" be either a helper or another goto statement.

I would do a little helper that check the index and calls stop or
start.

> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_STOP:
> +		if (!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP)) {
> +			dev_err(bus->dev, "master failed to STOP");
> +			bus->cmd_err = -EIO;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
> +
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		goto out_complete;
> +	case ASPEED_I2C_MASTER_INACTIVE:
> +		dev_err(bus->dev,
> +			"master received interrupt 0x%08x, but is inactive",
> +			irq_status);
> +		bus->cmd_err = -EIO;
> +		goto out_complete;
> +	default:
> +		WARN(1, "unknown master state\n");
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		bus->cmd_err = -EIO;
> +		goto out_complete;
> +	}
> +
> +out_complete:
> +	complete(&bus->cmd_complete);
> +out_no_complete:
> +	if (irq_status != status_ack)
> +		dev_err(bus->dev,
> +			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> +			irq_status, status_ack);
> +	aspeed_i2c_write(bus, irq_status, ASPEED_I2C_INTR_STS_REG);
> +	spin_unlock(&bus->lock);
> +}
> +
> +static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> +{
> +	struct aspeed_i2c_bus *bus = dev_id;
> +
> +	aspeed_i2c_master_irq(bus);
> +	return IRQ_HANDLED;
> +}

In theory you want to only return IRQ_HANDLED if you indeed has at
least one IRQ status bit set... Not a huge deal here but it would
be cleaner.

> +static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> +				  struct i2c_msg *msgs, int num)
> +{
> +	struct aspeed_i2c_bus *bus = adap->algo_data;
> +	unsigned long time_left, flags;
> +	int ret = 0;
> +
> +	bus->cmd_err = 0;
> +
> +	/* If bus is busy, attempt recovery. We assume a single master
> +	 * environment.
> +	 */
> +	if (aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG) &
> +	    ASPEED_I2CD_BUS_BUSY_STS) {
> +		ret = aspeed_i2c_recover_bus(bus);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	spin_lock_irqsave(&bus->lock, flags);

See previous comment about the lock.

I would also cleanup all the interrupts before we even start a transfer
(ie write all 1's to the interrupt status reg).

> +	bus->msgs = msgs;
> +	bus->msgs_index = 0;
> +	bus->msgs_size = num;

Minor nit: msgs_count rather than size ?

> +	do_start(bus);
> +	reinit_completion(&bus->cmd_complete);

The reinit_completion call should probably be before do_start.

Currently the spinlock avoids this being a real issue but if as I
suggest you take out the lock, then it will be racy (probably
impossible to hit in practice but still .. :-)
 
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

If we timed out we may want to sanitize the HW state. I would suggest
resetting the master. We should also sanitize master_state. I would
suggest adding a reset function that cleans everything up.

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
> +	 *	SCL_freq = base_freq * (SCL_high + SCL_low)
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
> +	 *	SCL_freq = (1 << base_clk) * (clk_high + 1 + clk_low + 1)
> +	 * The documentation recommends clk_high >= 8 and clk_low >= 7 when
> +	 * possible; this last constraint gives us the following solution:
> +	 */
> +	base_clk = divisor > 32 ? ilog2(divisor / 16 - 1) : 0;
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

As I think I mentioned earlier, the AST2500 has a slightly different
register layout which support larger values for high and low, thus
allowing a finer granularity.

BTW. In case you haven't, I would suggest you copy/paste the above in
a userspace app and run it for all frequency divisors and see if your
results match the aspeed table :)

> +static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
> +			       struct platform_device *pdev)
> +{
> +	u32 clk_freq, divisor;
> +	struct clk *pclk;
> +	int ret;
> +
> +	pclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pclk)) {
> +		dev_err(&pdev->dev, "clk_get failed\n");
> +		return PTR_ERR(pclk);
> +	}
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +				   "clock-frequency", &clk_freq);

See my previous comment about calling that 'bus-frequency' rather
than 'clock-frequency'.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Could not read clock-frequency property\n");
> +		clk_freq = 100000;
> +	}
> +	divisor = clk_get_rate(pclk) / clk_freq;
> +	/* We just need the clock rate, we don't actually use the clk object. */
> +	devm_clk_put(&pdev->dev, pclk);
> +
> +	/* Set AC Timing */
> +	if (clk_freq / 1000 > 1000) {
> +		aspeed_i2c_write(bus, aspeed_i2c_read(bus,
> +						      ASPEED_I2C_FUN_CTRL_REG) |
> +				ASPEED_I2CD_M_HIGH_SPEED_EN |
> +				ASPEED_I2CD_M_SDA_DRIVE_1T_EN |
> +				ASPEED_I2CD_SDA_DRIVE_1T_EN,
> +				ASPEED_I2C_FUN_CTRL_REG);
> +
> +		aspeed_i2c_write(bus, 0x3, ASPEED_I2C_AC_TIMING_REG2);
> +		aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divisor),
> +				 ASPEED_I2C_AC_TIMING_REG1);

I already discussed by doubts about the above. I can try to scope
it with the EVB if you don't get to it. For now I'd rather take the
code out.

We should ask aspeed from what frequency the "1T" stuff is useful.

> +	} else {
> +		aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divisor),
> +				 ASPEED_I2C_AC_TIMING_REG1);
> +		aspeed_i2c_write(bus, ASPEED_NO_TIMEOUT_CTRL,
> +				 ASPEED_I2C_AC_TIMING_REG2);
> +	}
> +
> +	return 0;
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
> +	if (IS_ERR(bus->base)) {
> +		dev_err(&pdev->dev, "failed to devm_ioremap_resource\n");
> +		return PTR_ERR(bus->base);
> +	}
> +
> +	bus->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	ret = devm_request_irq(&pdev->dev, bus->irq, aspeed_i2c_bus_irq,
> +			       IRQF_SHARED, dev_name(&pdev->dev), bus);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request interrupt\n");
> +		return ret;
> +	}

Again, out of paranoia, make sure the HW is reset and interrupt
off *before* you register the interrupt handler, or a HW left in
a funny state (by uboot for example) might shoot interrupts before
you are ready to take them. I would move the reset you do below
to before devm_request_irq.

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

Another trivial one, should we put some kind of bus number
in that string ?

> +	bus->dev = &pdev->dev;
> +
> +	/* reset device: disable master & slave functions */
> +	aspeed_i2c_write(bus, 0, ASPEED_I2C_FUN_CTRL_REG);
> +
> +	ret = aspeed_i2c_init_clk(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Master Mode */
> +	aspeed_i2c_write(bus, aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG) |
> +		      ASPEED_I2CD_MASTER_EN |
> +		      ASPEED_I2CD_MULTI_MASTER_DIS, ASPEED_I2C_FUN_CTRL_REG);
> +
> +	/* Set interrupt generation of I2C controller */
> +	aspeed_i2c_write(bus, ASPEED_I2CD_INTR_ALL, ASPEED_I2C_INTR_CTRL_REG);
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
> +
> +	i2c_del_adapter(&bus->adap);

Out of paranoia, should we turn off the function and mask the
interrupts here just in case ?

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
> +		.name		= "ast-i2c-bus",
> +		.of_match_table	= aspeed_i2c_bus_of_table,
> +	},
> +};
> +module_platform_driver(aspeed_i2c_bus_driver);
> +
> +MODULE_AUTHOR("Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("Aspeed I2C Bus Driver");
> +MODULE_LICENSE("GPL v2");
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
