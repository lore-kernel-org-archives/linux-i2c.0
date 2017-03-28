From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v6 5/5] i2c: aspeed: added slave support for Aspeed I2C driver
Date: Mon, 27 Mar 2017 22:12:26 -0700
Message-ID: <20170328051226.21677-6-brendanhiggins@google.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34883 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbdC1FNZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Mar 2017 01:13:25 -0400
Received: by mail-pg0-f47.google.com with SMTP id 81so46905120pgh.2
        for <linux-i2c@vger.kernel.org>; Mon, 27 Mar 2017 22:13:24 -0700 (PDT)
In-Reply-To: <20170328051226.21677-1-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, benh@kernel.crashing.org, Brendan Higgins <brendanhiggins@google.com>

Added slave support for Aspeed I2C controller. Supports fourteen busses
present in AST24XX and AST25XX BMC SoCs by Aspeed.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Added in v6:
  - Pulled slave support out of initial driver commit into its own commit.
  - No longer arbitrarily restrict bus to be slave xor master.
---
 drivers/i2c/busses/i2c-aspeed.c | 186 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 04266acc6c46..a9ee58a2c4e2 100644
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
@@ -115,6 +120,15 @@ enum aspeed_i2c_master_state {
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
@@ -207,6 +221,110 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 	return ret;
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
+	command = aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG);
+	irq_status = aspeed_i2c_read(bus, ASPEED_I2C_INTR_STS_REG);
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
+		value = aspeed_i2c_read(bus, ASPEED_I2C_BYTE_BUF_REG) >> 8;
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
+		aspeed_i2c_write(bus, value, ASPEED_I2C_BYTE_BUF_REG);
+		aspeed_i2c_write(bus, ASPEED_I2CD_S_TX_CMD, ASPEED_I2C_CMD_REG);
+		break;
+	case ASPEED_I2C_SLAVE_READ_PROCESSED:
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
+		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
+			dev_err(bus->dev,
+				"Expected ACK after processed read.\n");
+		i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
+		aspeed_i2c_write(bus, value, ASPEED_I2C_BYTE_BUF_REG);
+		aspeed_i2c_write(bus, ASPEED_I2CD_S_TX_CMD, ASPEED_I2C_CMD_REG);
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
+	aspeed_i2c_write(bus, status_ack, ASPEED_I2C_INTR_STS_REG);
+
+out:
+	spin_unlock(&bus->lock);
+	return irq_handled;
+}
+#endif
+
 static void do_start(struct aspeed_i2c_bus *bus)
 {
 	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
@@ -371,6 +489,14 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	if (aspeed_i2c_slave_irq(bus)) {
+		dev_dbg(bus->dev, "irq handled by slave.\n");
+		return IRQ_HANDLED;
+	}
+#endif
+
+	dev_dbg(bus->dev, "irq handled by master.\n");
 	aspeed_i2c_master_irq(bus);
 	return IRQ_HANDLED;
 }
@@ -426,9 +552,69 @@ static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+static int aspeed_i2c_reg_slave(struct i2c_client *client)
+{
+	u32 addr_reg_val, func_ctrl_reg_val;
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
+	/* Set slave addr. */
+	addr_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_DEV_ADDR_REG);
+	addr_reg_val &= ~ASPEED_I2CD_DEV_ADDR_MASK;
+	addr_reg_val |= client->addr & ASPEED_I2CD_DEV_ADDR_MASK;
+	aspeed_i2c_write(bus, addr_reg_val, ASPEED_I2C_DEV_ADDR_REG);
+
+	/* Turn on slave mode. */
+	func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
+	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
+	aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);
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
+	func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
+	func_ctrl_reg_val &= ~ASPEED_I2CD_SLAVE_EN;
+	aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave = NULL;
+	spin_unlock_irqrestore(&bus->lock, flags);
+
+	return 0;
+}
+#endif
+
 static const struct i2c_algorithm aspeed_i2c_algo = {
 	.master_xfer	= aspeed_i2c_master_xfer,
 	.functionality	= aspeed_i2c_functionality,
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	.reg_slave	= aspeed_i2c_reg_slave,
+	.unreg_slave	= aspeed_i2c_unreg_slave,
+#endif
 };
 
 static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
-- 
2.12.2.564.g063fe858b8-goog
