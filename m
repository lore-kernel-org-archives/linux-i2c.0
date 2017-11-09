From: Juergen Fitschen <me@jue.yt>
Subject: [PATCH v2 3/3] i2c: at91: added slave mode support
Date: Thu, 9 Nov 2017 18:22:29 +0100
Message-ID: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
References: <cover.1510247114.git.me@jue.yt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1510247114.git.me@jue.yt>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Slave mode driver is based on the concept of i2c-designware driver.

Signed-off-by: Juergen Fitschen <me@jue.yt>
---
Changes in v2:
 - Squashed commit "take slave mode capabilities of hardware into
   account" into this commit
 - Removed unused feature bit AT91_TWI_SM_HAS_FIFO
 - Added NACK support
 - Reworked interrupt handler:
   - The interrupt handler takes into account that several events can
     occur between two handler calls and thus must be handled in one
     handler run. It caanot be assumed that every events triggers the
     handler individually.
   - Instead of using the states register of the I2c interface, a state
     machine is held in the at91_twi_dev struct. This ensures that no
     state transitions are missed due ti interrupt latency.
 - Added Kconfig option for selection whether slave mode suppurt should
   be included in the driver or not
 - Added example in Documentation/devicetree/bindings/i2c/i2c-at91.txt
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt |  14 ++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   3 +
 drivers/i2c/busses/i2c-at91-core.c                 |  23 ++-
 drivers/i2c/busses/i2c-at91-slave.c                | 216 +++++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h                      |  42 +++-
 6 files changed, 304 insertions(+), 4 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index ef973a0..95c79a8 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -61,3 +61,17 @@ i2c0: i2c@f8034600 {
 		reg = <0x1a>;
 	};
 };
+
+i2c0: i2c@f8028000 {
+	compatible = "atmel,sama5d2-i2c";
+	reg = <0xf8028000 0x100>;
+	interrupts = <29 4 7>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&twi0_clk>;
+
+	eeprom@64 {
+		compatible = "linux,slave-24c02";
+		reg = <0x40000064>;
+	};
+};
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 009345d..41338e8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -380,6 +380,16 @@ config I2C_AT91
 	  the latency to fill the transmission register is too long. If you
 	  are facing this situation, use the i2c-gpio driver.
 
+config I2C_AT91_SLAVE
+	bool "Atmel AT91 I2C Two-Wire interface (TWI) Slave"
+	depends on I2C_AT91 && I2C_SLAVE
+	help
+	  This adds slave mode support to the I2C interface on Atmel AT91
+	  processors.
+
+	  This is not a standalone module and must be compiled together with the
+	  master mode driver.
+
 config I2C_AU1550
 	tristate "Au1550/Au1200/Au1300 SMBus interface"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 2a79c3d..daa2ea4 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -34,6 +34,9 @@ obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
 obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
 obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
 i2c-at91-objs			:= i2c-at91-core.o i2c-at91-master.o
+ifeq ($(CONFIG_I2C_AT91_SLAVE),y)
+	i2c-at91-objs		+= i2c-at91-slave.o
+endif
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index 4fed72d..cba447e 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -60,13 +60,16 @@ void at91_init_twi_bus(struct at91_twi_dev *dev)
 {
 	at91_disable_twi_interrupts(dev);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
-
-	at91_init_twi_bus_master(dev);
+	if (dev->slave_detected)
+		at91_init_twi_bus_slave(dev);
+	else
+		at91_init_twi_bus_master(dev);
 }
 
 static struct at91_twi_pdata at91rm9200_config = {
 	.clk_max_div = 5,
 	.clk_offset = 3,
+	.slave_mode_features = 0,
 	.has_unre_flag = true,
 	.has_alt_cmd = false,
 	.has_hold_field = false,
@@ -75,6 +78,7 @@ static struct at91_twi_pdata at91rm9200_config = {
 static struct at91_twi_pdata at91sam9261_config = {
 	.clk_max_div = 5,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
 	.has_unre_flag = false,
 	.has_alt_cmd = false,
 	.has_hold_field = false,
@@ -83,6 +87,7 @@ static struct at91_twi_pdata at91sam9261_config = {
 static struct at91_twi_pdata at91sam9260_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
 	.has_unre_flag = false,
 	.has_alt_cmd = false,
 	.has_hold_field = false,
@@ -91,6 +96,7 @@ static struct at91_twi_pdata at91sam9260_config = {
 static struct at91_twi_pdata at91sam9g20_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
 	.has_unre_flag = false,
 	.has_alt_cmd = false,
 	.has_hold_field = false,
@@ -99,6 +105,7 @@ static struct at91_twi_pdata at91sam9g20_config = {
 static struct at91_twi_pdata at91sam9g10_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
 	.has_unre_flag = false,
 	.has_alt_cmd = false,
 	.has_hold_field = false,
@@ -129,6 +136,7 @@ static const struct platform_device_id at91_twi_devtypes[] = {
 static struct at91_twi_pdata at91sam9x5_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
 	.has_unre_flag = false,
 	.has_alt_cmd = false,
 	.has_hold_field = false,
@@ -137,6 +145,7 @@ static struct at91_twi_pdata at91sam9x5_config = {
 static struct at91_twi_pdata sama5d4_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
 	.has_unre_flag = false,
 	.has_alt_cmd = false,
 	.has_hold_field = true,
@@ -145,6 +154,7 @@ static struct at91_twi_pdata sama5d4_config = {
 static struct at91_twi_pdata sama5d2_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
+	.slave_mode_features = AT91_TWI_SM_AVAILABLE | AT91_TWI_SM_CAN_NACK,
 	.has_unre_flag = true,
 	.has_alt_cmd = true,
 	.has_hold_field = true,
@@ -217,6 +227,10 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (!dev->pdata)
 		return -ENODEV;
 
+	dev->slave_detected = i2c_detect_slave_mode(&pdev->dev);
+	if (dev->slave_detected && dev->pdata->slave_mode_features == 0)
+		return -EPFNOSUPPORT;
+
 	dev->base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(dev->base))
 		return PTR_ERR(dev->base);
@@ -243,7 +257,10 @@ static int at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node = pdev->dev.of_node;
 
-	rc = at91_twi_probe_master(pdev, phy_addr, dev);
+	if (dev->slave_detected)
+		rc = at91_twi_probe_slave(pdev, phy_addr, dev);
+	else
+		rc = at91_twi_probe_master(pdev, phy_addr, dev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/i2c/busses/i2c-at91-slave.c b/drivers/i2c/busses/i2c-at91-slave.c
new file mode 100644
index 0000000..a5881e9
--- /dev/null
+++ b/drivers/i2c/busses/i2c-at91-slave.c
@@ -0,0 +1,216 @@
+/*
+ *  i2c slave support for Atmel's AT91 Two-Wire Interface (TWI)
+ *
+ *  Copyright (C) 2017 Juergen Fitschen <me@jue.yt>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+
+#include "i2c-at91.h"
+
+static irqreturn_t atmel_twi_interrupt_slave(int irq, void *dev_id)
+{
+	struct at91_twi_dev *dev = dev_id;
+	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
+	const unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
+	u8 value;
+
+	if (!irqstatus)
+		return IRQ_NONE;
+
+	/*
+	 * The order of processing AT91_TWI_TXRDY [a], AT91_TWI_SVACC [b] and
+	 * AT91_TWI_RXRDY [c] status bit is important:
+	 *  + Remote master wants to read data:
+	 *    - AT91_TWI_SVACC IRQ with AT91_TWI_SVREAD unset is raised
+	 *    - I2C_SLAVE_READ_REQUESTED slave event is fired and first byte
+	 *      received from the I2C slave backend
+	 *    - Byte is written to AT91_TWI_THR
+	 *    - AT91_TWI_TXRDY is still set since AT91_TWI_SR isn't reread but
+	 *      AT91_TWI_THR must not be written a second time!
+	 *    --> Check AT91_TWI_TXRDY before AT91_TWI_SVACC
+	 *  + Remote master wants to write data:
+	 *    - AT91_TWI_SVACC IRQ with AT91_TWI_SVREAD set is raised
+	 *    - If the first byte already has been received due to interrupt
+	 *      latency, AT91_TWI_RXRDY is set and AT91_TWI_RHR has to be read
+	 *      in the same IRQ handler run!
+	 *    --> Check AT91_TWI_RXRDY after AT91_TWI_SVACC
+	 */
+
+	/*
+	 * [a] Next byte can be stored into transmit holding register
+	 */
+	if ((dev->state == AT91_TWI_STATE_TX) && (status & AT91_TWI_TXRDY)) {
+		i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &value);
+		writeb_relaxed(value, dev->base + AT91_TWI_THR);
+
+		dev_dbg(dev->dev, "DATA %02x", value);
+	}
+
+	/*
+	 * [b] An I2C transmission has been started and the interface detected
+	 * its slave address.
+	 */
+	if ((dev->state == AT91_TWI_STATE_STOP) && (status & AT91_TWI_SVACC)) {
+		/*
+		 * AT91_TWI_SVREAD indicates whether data should be read from or
+		 * written to the slave. This works flawlessly until the
+		 * transmission has been stopped (i.e. AT91_TWI_EOSACC is set).
+		 * If the interrupt latency is high, a master can start a write
+		 * transmission, write one byte and stop the transmission before
+		 * the IRQ handler is called. In that case AT91_TWI_SVACC,
+		 * AT91_TWI_RXRDY and AT91_TWI_EOSACC are set, but we cannot
+		 * rely on AT91_TWI_SVREAD. That's the reason why the following
+		 * condition looks like it does.
+		 */
+		if (!(status & AT91_TWI_SVREAD) ||
+		    ((status & AT91_TWI_EOSACC) && (status & AT91_TWI_RXRDY))) {
+			i2c_slave_event(dev->slave,
+					I2C_SLAVE_WRITE_REQUESTED, &value);
+
+			at91_twi_write(dev, AT91_TWI_IER,
+				       AT91_TWI_RXRDY | AT91_TWI_EOSACC);
+
+			dev->state = AT91_TWI_STATE_RX;
+
+			dev_dbg(dev->dev, "START LOCAL <- REMOTE");
+		} else {
+			i2c_slave_event(dev->slave,
+					I2C_SLAVE_READ_REQUESTED, &value);
+			writeb_relaxed(value, dev->base + AT91_TWI_THR);
+
+			at91_twi_write(dev, AT91_TWI_IER,
+				       AT91_TWI_TXRDY | AT91_TWI_EOSACC);
+
+			dev->state = AT91_TWI_STATE_TX;
+
+			dev_dbg(dev->dev, "START LOCAL -> REMOTE");
+			dev_dbg(dev->dev, "DATA %02x", value);
+		}
+		at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_SVACC);
+	}
+
+	/*
+	 * [c] Byte can be read from receive holding register
+	 */
+	if ((dev->state == AT91_TWI_STATE_RX) && (status & AT91_TWI_RXRDY)) {
+		int rc;
+
+		value = readb_relaxed(dev->base + AT91_TWI_RHR);
+		rc = i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
+		if ((rc < 0) && (dev->pdata->slave_mode_features & AT91_TWI_SM_CAN_NACK))
+			at91_twi_write(dev, AT91_TWI_SMR, dev->smr | AT91_TWI_SMR_NACKEN);
+		else
+			at91_twi_write(dev, AT91_TWI_SMR, dev->smr);
+
+		dev_dbg(dev->dev, "DATA %02x", value);
+	}
+
+	/*
+	 * Master sent stop
+	 */
+	if ((dev->state != AT91_TWI_STATE_STOP) && (status & AT91_TWI_EOSACC)) {
+		at91_twi_write(dev, AT91_TWI_IDR,
+			       AT91_TWI_TXRDY | AT91_TWI_RXRDY | AT91_TWI_EOSACC);
+		at91_twi_write(dev, AT91_TWI_CR,
+			       AT91_TWI_THRCLR | AT91_TWI_RHRCLR);
+		at91_twi_write(dev, AT91_TWI_IER,
+			       AT91_TWI_SVACC);
+
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &value);
+
+		dev->state = AT91_TWI_STATE_STOP;
+		dev_dbg(dev->dev, "STOP");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int at91_reg_slave(struct i2c_client *slave)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	if (dev->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	/* Make sure twi_clk doesn't get turned off! */
+	pm_runtime_get_sync(dev->dev);
+
+	dev->slave = slave;
+	dev->smr = AT91_TWI_SMR_SADR(slave->addr);
+
+	at91_init_twi_bus(dev);
+
+	dev_info(dev->dev, "entered slave mode (ADR=%d)\n", slave->addr);
+
+	return 0;
+}
+
+static int at91_unreg_slave(struct i2c_client *slave)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	WARN_ON(!dev->slave);
+
+	dev_info(dev->dev, "leaving slave mode\n");
+
+	dev->slave = NULL;
+	dev->smr = 0;
+
+	at91_init_twi_bus(dev);
+
+	pm_runtime_put(dev->dev);
+
+	return 0;
+}
+
+static u32 at91_twi_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SLAVE | I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+}
+
+static const struct i2c_algorithm at91_twi_algorithm_slave = {
+	.reg_slave	= at91_reg_slave,
+	.unreg_slave	= at91_unreg_slave,
+	.functionality	= at91_twi_func,
+};
+
+int at91_twi_probe_slave(struct platform_device *pdev,
+			 u32 phy_addr, struct at91_twi_dev *dev)
+{
+	int rc;
+
+	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt_slave,
+			      0, dev_name(dev->dev), dev);
+	if (rc) {
+		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
+		return rc;
+	}
+
+	dev->adapter.algo = &at91_twi_algorithm_slave;
+
+	return 0;
+}
+
+void at91_init_twi_bus_slave(struct at91_twi_dev *dev)
+{
+	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSDIS);
+	if (dev->smr) {
+		dev->state = AT91_TWI_STATE_STOP;
+		at91_twi_write(dev, AT91_TWI_SMR, dev->smr);
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SVEN);
+		at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_SVACC);
+	}
+}
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index 555b167..e15a99e 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -53,6 +53,11 @@
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
 #define	AT91_TWI_MREAD		BIT(12)	/* Master Read Direction */
 
+#define	AT91_TWI_SMR		0x0008	/* Slave Mode Register */
+#define	AT91_TWI_SMR_NACKEN	BIT(0)	/* NACK value in next ACK cycle */
+#define	AT91_TWI_SMR_SADR_MAX	0x007f
+#define	AT91_TWI_SMR_SADR(x)	(((x) & AT91_TWI_SMR_SADR_MAX) << 16)
+
 #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
 
 #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
@@ -63,13 +68,17 @@
 #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
 #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
 #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
+#define	AT91_TWI_SVACC		BIT(4)	/* Slave Access */
 #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
 #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
+#define	AT91_TWI_EOSACC		BIT(11)	/* End Of Slave Access */
 #define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
 
 #define	AT91_TWI_INT_MASK \
-	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
+	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK \
+	| AT91_TWI_SVACC | AT91_TWI_EOSACC)
 
 #define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
 #define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
@@ -99,9 +108,19 @@
 
 #define	AT91_TWI_VER		0x00fc	/* Version Register */
 
+#define	AT91_TWI_SM_AVAILABLE	BIT(0)	/* Slave mode supported */
+#define	AT91_TWI_SM_CAN_NACK	BIT(1)	/* Can send NACKs in slave mode */
+
+enum at91_twi_state {
+	AT91_TWI_STATE_STOP,
+	AT91_TWI_STATE_TX,
+	AT91_TWI_STATE_RX
+};
+
 struct at91_twi_pdata {
 	unsigned clk_max_div;
 	unsigned clk_offset;
+	unsigned slave_mode_features;
 	bool has_unre_flag;
 	bool has_alt_cmd;
 	bool has_hold_field;
@@ -137,6 +156,12 @@ struct at91_twi_dev {
 	bool recv_len_abort;
 	u32 fifo_size;
 	struct at91_twi_dma dma;
+	bool slave_detected;
+#if IS_ENABLED(CONFIG_I2C_AT91_SLAVE)
+	unsigned smr;
+	enum at91_twi_state state;
+	struct i2c_client *slave;
+#endif
 };
 
 unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg);
@@ -149,3 +174,18 @@ void at91_init_twi_bus(struct at91_twi_dev *dev);
 void at91_init_twi_bus_master(struct at91_twi_dev *dev);
 int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
 			  struct at91_twi_dev *dev);
+
+#if IS_ENABLED(CONFIG_I2C_AT91_SLAVE)
+void at91_init_twi_bus_slave(struct at91_twi_dev *dev);
+int at91_twi_probe_slave(struct platform_device *pdev, u32 phy_addr,
+			 struct at91_twi_dev *dev);
+
+#else
+static inline void at91_init_twi_bus_slave(struct at91_twi_dev *dev) {}
+static inline int at91_twi_probe_slave(struct platform_device *pdev,
+				       u32 phy_addr, struct at91_twi_dev *dev)
+{
+	return -EINVAL;
+}
+
+#endif
-- 
2.7.4
