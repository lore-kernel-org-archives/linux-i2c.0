From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 5/5] i2c: aspeed: added slave support for Aspeed I2C driver
Date: Wed, 24 May 2017 23:49:25 -0700
Message-ID: <20170525064925.16867-6-brendanhiggins@google.com>
References: <20170525064925.16867-1-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170525064925.16867-1-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added slave support for Aspeed I2C controller. Supports fourteen busses
present in AST24XX and AST25XX BMC SoCs by Aspeed.

Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
Added in v6:
  - Pulled slave support out of initial driver commit into its own commit.
  - No longer arbitrarily restrict bus to be slave xor master.
Changes for v7:
  - Added hardware reset function
  - Marked functions that need to be called with the lock held as "unlocked"
  - Did some cleanup
Changes for v8:
  - None
---
 drivers/i2c/busses/i2c-aspeed.c | 202 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 3eb1252442d7..0ab29f5029fb 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -49,6 +49,7 @@
 #define ASPEED_I2CD_SDA_DRIVE_1T_EN			BIT(8)
 #define ASPEED_I2CD_M_SDA_DRIVE_1T_EN			BIT(7)
 #define ASPEED_I2CD_M_HIGH_SPEED_EN			BIT(6)
+#define ASPEED_I2CD_SLAVE_EN				BIT(1)
 #define ASPEED_I2CD_MASTER_EN				BIT(0)
 
 /* 0x04 : I2CD Clock and AC Timing Control Register #1 */
@@ -69,6 +70,7 @@
  */
 #define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT			BIT(14)
 #define ASPEED_I2CD_INTR_BUS_RECOVER_DONE		BIT(13)
+#define ASPEED_I2CD_INTR_SLAVE_MATCH			BIT(7)
 #define ASPEED_I2CD_INTR_SCL_TIMEOUT			BIT(6)
 #define ASPEED_I2CD_INTR_ABNORMAL			BIT(5)
 #define ASPEED_I2CD_INTR_NORMAL_STOP			BIT(4)
@@ -106,6 +108,9 @@
 #define ASPEED_I2CD_M_TX_CMD				BIT(1)
 #define ASPEED_I2CD_M_START_CMD				BIT(0)
 
+/* 0x18 : I2CD Slave Device Address Register   */
+#define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
+
 enum aspeed_i2c_master_state {
 	ASPEED_I2C_MASTER_START,
 	ASPEED_I2C_MASTER_TX_FIRST,
@@ -116,6 +121,15 @@ enum aspeed_i2c_master_state {
 	ASPEED_I2C_MASTER_INACTIVE,
 };
 
+enum aspeed_i2c_slave_state {
+	ASPEED_I2C_SLAVE_START,
+	ASPEED_I2C_SLAVE_READ_REQUESTED,
+	ASPEED_I2C_SLAVE_READ_PROCESSED,
+	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
+	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
+	ASPEED_I2C_SLAVE_STOP,
+};
+
 struct aspeed_i2c_bus {
 	struct i2c_adapter		adap;
 	struct device			*dev;
@@ -132,6 +146,10 @@ struct aspeed_i2c_bus {
 	size_t				msgs_count;
 	bool				send_stop;
 	int				cmd_err;
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	struct i2c_client		*slave;
+	enum aspeed_i2c_slave_state	slave_state;
+#endif /* CONFIG_I2C_SLAVE */
 };
 
 static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
@@ -203,6 +221,110 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 	return aspeed_i2c_reset(bus);
 }
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
+{
+	u32 command, irq_status, status_ack = 0;
+	struct i2c_client *slave = bus->slave;
+	bool irq_handled = true;
+	u8 value;
+
+	spin_lock(&bus->lock);
+	if (!slave) {
+		irq_handled = false;
+		goto out;
+	}
+
+	command = readl(bus->base + ASPEED_I2C_CMD_REG);
+	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+
+	/* Slave was requested, restart state machine. */
+	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
+		status_ack |= ASPEED_I2CD_INTR_SLAVE_MATCH;
+		bus->slave_state = ASPEED_I2C_SLAVE_START;
+	}
+
+	/* Slave is not currently active, irq was for someone else. */
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
+		irq_handled = false;
+		goto out;
+	}
+
+	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
+		irq_status, command);
+
+	/* Slave was sent something. */
+	if (irq_status & ASPEED_I2CD_INTR_RX_DONE) {
+		value = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
+		/* Handle address frame. */
+		if (bus->slave_state == ASPEED_I2C_SLAVE_START) {
+			if (value & 0x1)
+				bus->slave_state =
+						ASPEED_I2C_SLAVE_READ_REQUESTED;
+			else
+				bus->slave_state =
+						ASPEED_I2C_SLAVE_WRITE_REQUESTED;
+		}
+		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
+	}
+
+	/* Slave was asked to stop. */
+	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
+		status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	}
+	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
+		status_ack |= ASPEED_I2CD_INTR_TX_NAK;
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	}
+
+	switch (bus->slave_state) {
+	case ASPEED_I2C_SLAVE_READ_REQUESTED:
+		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
+			dev_err(bus->dev, "Unexpected ACK on read request.\n");
+		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
+
+		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
+		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
+		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
+		break;
+	case ASPEED_I2C_SLAVE_READ_PROCESSED:
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
+		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
+			dev_err(bus->dev,
+				"Expected ACK after processed read.\n");
+		i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
+		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
+		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
+		break;
+	case ASPEED_I2C_SLAVE_WRITE_REQUESTED:
+		bus->slave_state = ASPEED_I2C_SLAVE_WRITE_RECEIVED;
+		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+		break;
+	case ASPEED_I2C_SLAVE_WRITE_RECEIVED:
+		i2c_slave_event(slave, I2C_SLAVE_WRITE_RECEIVED, &value);
+		break;
+	case ASPEED_I2C_SLAVE_STOP:
+		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		break;
+	default:
+		dev_err(bus->dev, "unhandled slave_state: %d\n",
+			bus->slave_state);
+		break;
+	}
+
+	if (status_ack != irq_status)
+		dev_err(bus->dev,
+			"irq handled != irq. expected %x, but was %x\n",
+			irq_status, status_ack);
+	writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
+
+out:
+	spin_unlock(&bus->lock);
+	return irq_handled;
+}
+#endif /* CONFIG_I2C_SLAVE */
+
 /* precondition: bus.lock has been acquired. */
 static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 {
@@ -408,6 +530,13 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	if (aspeed_i2c_slave_irq(bus)) {
+		dev_dbg(bus->dev, "irq handled by slave.\n");
+		return IRQ_HANDLED;
+	}
+#endif /* CONFIG_I2C_SLAVE */
+
 	if (aspeed_i2c_master_irq(bus))
 		return IRQ_HANDLED;
 	else
@@ -466,9 +595,76 @@ static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+/* precondition: bus.lock has been acquired. */
+static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
+{
+	u32 addr_reg_val, func_ctrl_reg_val;
+
+	/* Set slave addr. */
+	addr_reg_val = readl(bus->base + ASPEED_I2C_DEV_ADDR_REG);
+	addr_reg_val &= ~ASPEED_I2CD_DEV_ADDR_MASK;
+	addr_reg_val |= slave_addr & ASPEED_I2CD_DEV_ADDR_MASK;
+	writel(addr_reg_val, bus->base + ASPEED_I2C_DEV_ADDR_REG);
+
+	/* Turn on slave mode. */
+	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
+	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
+	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+}
+
+static int aspeed_i2c_reg_slave(struct i2c_client *client)
+{
+	struct aspeed_i2c_bus *bus;
+	unsigned long flags;
+
+	bus = client->adapter->algo_data;
+	spin_lock_irqsave(&bus->lock, flags);
+	if (bus->slave) {
+		spin_unlock_irqrestore(&bus->lock, flags);
+		return -EINVAL;
+	}
+
+	__aspeed_i2c_reg_slave(bus, client->addr);
+
+	bus->slave = client;
+	bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	spin_unlock_irqrestore(&bus->lock, flags);
+
+	return 0;
+}
+
+static int aspeed_i2c_unreg_slave(struct i2c_client *client)
+{
+	struct aspeed_i2c_bus *bus = client->adapter->algo_data;
+	u32 func_ctrl_reg_val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bus->lock, flags);
+	if (!bus->slave) {
+		spin_unlock_irqrestore(&bus->lock, flags);
+		return -EINVAL;
+	}
+
+	/* Turn off slave mode. */
+	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
+	func_ctrl_reg_val &= ~ASPEED_I2CD_SLAVE_EN;
+	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave = NULL;
+	spin_unlock_irqrestore(&bus->lock, flags);
+
+	return 0;
+}
+#endif /* CONFIG_I2C_SLAVE */
+
 static const struct i2c_algorithm aspeed_i2c_algo = {
 	.master_xfer	= aspeed_i2c_master_xfer,
 	.functionality	= aspeed_i2c_functionality,
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	.reg_slave	= aspeed_i2c_reg_slave,
+	.unreg_slave	= aspeed_i2c_unreg_slave,
+#endif /* CONFIG_I2C_SLAVE */
 };
 
 static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
@@ -561,6 +757,12 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) | fun_ctrl_reg,
 	       bus->base + ASPEED_I2C_FUN_CTRL_REG);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	/* If slave has already been registered, re-enable it. */
+	if (bus->slave)
+		__aspeed_i2c_reg_slave(bus, bus->slave->addr);
+#endif /* CONFIG_I2C_SLAVE */
+
 	/* Set interrupt generation of I2C controller */
 	writel(ASPEED_I2CD_INTR_ALL, bus->base + ASPEED_I2C_INTR_CTRL_REG);
 
-- 
2.13.0.219.gdb65acc882-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
