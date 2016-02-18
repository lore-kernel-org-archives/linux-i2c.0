From: Jan Glauber <jglauber@cavium.com>
Subject: [RFC PATCH 1/8] i2c-octeon: Cleanup i2c-octeon driver
Date: Thu, 18 Feb 2016 09:22:23 +0100
Message-ID: <4b342427bdf6d7dc7cf9ded9172deadd24a53650.1455782324.git.jglauber@cavium.com>
References: <cover.1455782324.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455782324.git.jglauber@cavium.com>
In-Reply-To: <cover.1455782324.git.jglauber@cavium.com>
References: <cover.1455782324.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Cleanup only without functional change.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-octeon.c | 442 +++++++++++++++++++++-------------------
 1 file changed, 230 insertions(+), 212 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 32914ab..1f14094 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -2,7 +2,7 @@
  * (C) Copyright 2009-2010
  * Nokia Siemens Networks, michael.lawnick.ext@nsn.com
  *
- * Portions Copyright (C) 2010, 2011 Cavium Networks, Inc.
+ * Portions Copyright (C) 2010 - 2016 Cavium, Inc.
  *
  * This is a driver for the i2c adapter in Cavium Networks' OCTEON processors.
  *
@@ -24,99 +24,154 @@
 
 #include <asm/octeon/octeon.h>
 
-#define DRV_NAME "i2c-octeon"
+#define DRV_NAME		"i2c-octeon"
 
-/* The previous out-of-tree version was implicitly version 1.0. */
-#define DRV_VERSION	"2.0"
+/* Register offsets */
+#define SW_TWSI			0x00
+#define TWSI_INT		0x10
+#define SW_TWSI_EXT		0x18
 
-/* register offsets */
-#define SW_TWSI	 0x00
-#define TWSI_INT 0x10
+#define INT_ENA_ST		0x1
+#define INT_ENA_TS		0x2
+#define INT_ENA_CORE		0x4
 
 /* Controller command patterns */
-#define SW_TWSI_V               0x8000000000000000ull
-#define SW_TWSI_EOP_TWSI_DATA   0x0C00000100000000ull
-#define SW_TWSI_EOP_TWSI_CTL    0x0C00000200000000ull
-#define SW_TWSI_EOP_TWSI_CLKCTL 0x0C00000300000000ull
-#define SW_TWSI_EOP_TWSI_STAT   0x0C00000300000000ull
-#define SW_TWSI_EOP_TWSI_RST    0x0C00000700000000ull
-#define SW_TWSI_OP_TWSI_CLK     0x0800000000000000ull
-#define SW_TWSI_R               0x0100000000000000ull
+#define SW_TWSI_V		(1ULL << 63)
+#define SW_TWSI_EIA		(1ULL << 61)
+#define SW_TWSI_R		(1ULL << 56)
+#define SW_TWSI_SOVR		(1ULL << 55)
+#define SW_TWSI_OP_7		(0ULL << 57)
+#define SW_TWSI_OP_7_IA		(1ULL << 57)
+#define SW_TWSI_OP_10		(2ULL << 57)
+#define SW_TWSI_OP_10_IA	(3ULL << 57)
+#define SW_TWSI_OP_TWSI_CLK	(1ULL << 59)
+#define SW_TWSI_SIZE_SHIFT	52
+#define SW_TWSI_A_SHIFT		40
+#define SW_TWSI_IA_SHIFT	32
+#define SW_TWSI_EOP_TWSI_DATA	0x0C00000100000000ULL
+#define SW_TWSI_EOP_TWSI_CTL	0x0C00000200000000ULL
+#define SW_TWSI_EOP_TWSI_CLKCTL	0x0C00000300000000ULL
+#define SW_TWSI_EOP_TWSI_STAT	0x0C00000300000000ULL
+#define SW_TWSI_EOP_TWSI_RST	0x0C00000700000000ULL
 
 /* Controller command and status bits */
-#define TWSI_CTL_CE   0x80
-#define TWSI_CTL_ENAB 0x40
-#define TWSI_CTL_STA  0x20
-#define TWSI_CTL_STP  0x10
-#define TWSI_CTL_IFLG 0x08
-#define TWSI_CTL_AAK  0x04
+#define TWSI_CTL_CE		0x80	/* High level controller enable */
+#define TWSI_CTL_ENAB		0x40	/* Bus enable */
+#define TWSI_CTL_STA		0x20	/* Master-mode start, HW clears when done */
+#define TWSI_CTL_STP		0x10	/* Master-mode stop, HW clears when done */
+#define TWSI_CTL_IFLG		0x08	/* HW event, SW writes 0 to ACK */
+#define TWSI_CTL_AAK		0x04	/* Assert ACK */
 
 /* Some status values */
-#define STAT_START      0x08
-#define STAT_RSTART     0x10
-#define STAT_TXADDR_ACK 0x18
-#define STAT_TXDATA_ACK 0x28
-#define STAT_RXADDR_ACK 0x40
-#define STAT_RXDATA_ACK 0x50
-#define STAT_IDLE       0xF8
+#define STAT_ERROR		0x00
+#define STAT_START		0x08
+#define STAT_RSTART		0x10
+#define STAT_TXADDR_ACK		0x18
+#define STAT_TXADDR_NAK		0x20
+#define STAT_TXDATA_ACK		0x28
+#define STAT_TXDATA_NAK		0x30
+#define STAT_LOST_ARB_38	0x38
+#define STAT_RXADDR_ACK		0x40
+#define STAT_RXADDR_NAK		0x48
+#define STAT_RXDATA_ACK		0x50
+#define STAT_RXDATA_NAK		0x58
+#define STAT_SLAVE_60		0x60
+#define STAT_LOST_ARB_68	0x68
+#define STAT_SLAVE_70		0x70
+#define STAT_LOST_ARB_78	0x78
+#define STAT_SLAVE_80		0x80
+#define STAT_SLAVE_88		0x88
+#define STAT_GENDATA_ACK	0x90
+#define STAT_GENDATA_NAK	0x98
+#define STAT_SLAVE_A0		0xA0
+#define STAT_SLAVE_A8		0xA8
+#define STAT_LOST_ARB_B0	0xB0
+#define STAT_SLAVE_LOST		0xB8
+#define STAT_SLAVE_NAK		0xC0
+#define STAT_SLAVE_ACK		0xC8
+#define STAT_AD2W_ACK		0xD0
+#define STAT_AD2W_NAK		0xD8
+#define STAT_IDLE		0xF8
+
+/* TWSI_INT values */
+#define ST_INT			0x01
+#define TS_INT			0x02
+#define CORE_INT		0x04
+#define ST_EN			0x10
+#define TS_EN			0x20
+#define CORE_EN			0x40
+#define SDA_OVR			0x100
+#define SCL_OVR			0x200
+#define SDA			0x400
+#define SCL			0x800
 
 struct octeon_i2c {
-	wait_queue_head_t queue;
-	struct i2c_adapter adap;
-	int irq;
-	u32 twsi_freq;
-	int sys_freq;
-	resource_size_t twsi_phys;
-	void __iomem *twsi_base;
-	resource_size_t regsize;
-	struct device *dev;
+	wait_queue_head_t	queue;
+	struct i2c_adapter	adap;
+	int			irq;
+	u32			twsi_freq;
+	int			sys_freq;
+	void __iomem		*twsi_base;
+	struct device		*dev;
 };
 
 /**
- * octeon_i2c_write_sw - write an I2C core register.
- * @i2c: The struct octeon_i2c.
- * @eop_reg: Register selector.
- * @data: Value to be written.
+ * octeon_i2c_write_sw - write an I2C core register
+ * @i2c: The struct octeon_i2c
+ * @eop_reg: Register selector
+ * @data: Value to be written
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static void octeon_i2c_write_sw(struct octeon_i2c *i2c,
-				u64 eop_reg,
-				u8 data)
+static void octeon_i2c_write_sw(struct octeon_i2c *i2c, u64 eop_reg, u8 data)
 {
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI);
-	do {
+	do
 		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
-	} while ((tmp & SW_TWSI_V) != 0);
+	while ((tmp & SW_TWSI_V) != 0);
 }
 
 /**
- * octeon_i2c_read_sw - write an I2C core register.
- * @i2c: The struct octeon_i2c.
- * @eop_reg: Register selector.
+ * octeon_i2c_read_sw64 - read an I2C core register
+ * @i2c: The struct octeon_i2c
+ * @eop_reg: Register selector
  *
  * Returns the data.
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
+static u64 octeon_i2c_read_sw64(struct octeon_i2c *i2c, u64 eop_reg)
 {
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI);
-	do {
+	do
 		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
-	} while ((tmp & SW_TWSI_V) != 0);
+	while ((tmp & SW_TWSI_V) != 0);
 
-	return tmp & 0xFF;
+	return tmp;
+}
+
+/**
+ * octeon_i2c_read_sw - read lower bits of an I2C core register
+ * @i2c: The struct octeon_i2c
+ * @eop_reg: Register selector
+ *
+ * Returns the data.
+ *
+ * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
+ */
+static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
+{
+	return octeon_i2c_read_sw64(i2c, eop_reg);
 }
 
 /**
  * octeon_i2c_write_int - write the TWSI_INT register
- * @i2c: The struct octeon_i2c.
- * @data: Value to be written.
+ * @i2c: The struct octeon_i2c
+ * @data: Value to be written
  */
 static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
@@ -125,57 +180,52 @@ static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 }
 
 /**
- * octeon_i2c_int_enable - enable the TS interrupt.
- * @i2c: The struct octeon_i2c.
+ * octeon_i2c_int_enable - enable the CORE interrupt
+ * @i2c: The struct octeon_i2c
  *
- * The interrupt will be asserted when there is non-STAT_IDLE state in
- * the SW_TWSI_EOP_TWSI_STAT register.
+ * The interrupt will be asserted when there is non-STAT_IDLE state in the
+ * SW_TWSI_EOP_TWSI_STAT register.
  */
 static void octeon_i2c_int_enable(struct octeon_i2c *i2c)
 {
-	octeon_i2c_write_int(i2c, 0x40);
+	octeon_i2c_write_int(i2c, CORE_EN);
 }
 
-/**
- * octeon_i2c_int_disable - disable the TS interrupt.
- * @i2c: The struct octeon_i2c.
- */
+/* disable the CORE interrupt */
 static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
 {
-	octeon_i2c_write_int(i2c, 0);
+	/* clear TS/ST/IFLG events */
+	octeon_i2c_write_int(i2c, TS_INT | ST_INT);
 }
 
 /**
- * octeon_i2c_unblock - unblock the bus.
- * @i2c: The struct octeon_i2c.
+ * bitbang_unblock - unblock the bus
+ * @i2c: The struct octeon_i2c
  *
- * If there was a reset while a device was driving 0 to bus,
- * bus is blocked. We toggle it free manually by some clock
- * cycles and send a stop.
+ * If there was a reset while a device was driving 0 to bus, bus is blocked.
+ * We toggle it free manually by some clock cycles and send a stop.
  */
-static void octeon_i2c_unblock(struct octeon_i2c *i2c)
+static void bitbang_unblock(struct octeon_i2c *i2c)
 {
 	int i;
 
 	dev_dbg(i2c->dev, "%s\n", __func__);
+
 	for (i = 0; i < 9; i++) {
-		octeon_i2c_write_int(i2c, 0x0);
+		octeon_i2c_write_int(i2c, 0);
 		udelay(5);
-		octeon_i2c_write_int(i2c, 0x200);
+		octeon_i2c_write_int(i2c, SCL_OVR);
 		udelay(5);
 	}
-	octeon_i2c_write_int(i2c, 0x300);
+	/* hand-crank a STOP */
+	octeon_i2c_write_int(i2c, SDA_OVR | SCL_OVR);
 	udelay(5);
-	octeon_i2c_write_int(i2c, 0x100);
+	octeon_i2c_write_int(i2c, SDA_OVR);
 	udelay(5);
-	octeon_i2c_write_int(i2c, 0x0);
+	octeon_i2c_write_int(i2c, 0);
 }
 
-/**
- * octeon_i2c_isr - the interrupt service routine.
- * @int: The irq, unused.
- * @dev_id: Our struct octeon_i2c.
- */
+/* interrupt service routine */
 static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 {
 	struct octeon_i2c *i2c = dev_id;
@@ -186,15 +236,15 @@ static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-
 static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 {
-	return (octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_CTL) & TWSI_CTL_IFLG) != 0;
+	return (octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_CTL)
+		& TWSI_CTL_IFLG) != 0;
 }
 
 /**
- * octeon_i2c_wait - wait for the IFLG to be set.
- * @i2c: The struct octeon_i2c.
+ * octeon_i2c_wait - wait for the IFLG to be set
+ * @i2c: The struct octeon_i2c
  *
  * Returns 0 on success, otherwise a negative errno.
  */
@@ -203,34 +253,64 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	long result;
 
 	octeon_i2c_int_enable(i2c);
-
-	result = wait_event_timeout(i2c->queue,
-					octeon_i2c_test_iflg(i2c),
-					i2c->adap.timeout);
-
+	result = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
+				    i2c->adap.timeout);
 	octeon_i2c_int_disable(i2c);
-
-	if (result == 0) {
+	if (!result) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
 	}
-
 	return 0;
 }
 
+/* send STOP to the bus */
+static void octeon_i2c_stop(struct octeon_i2c *i2c)
+{
+	u8 data;
+
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+			    TWSI_CTL_ENAB | TWSI_CTL_STP);
+
+	data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+
+	if (data != STAT_IDLE)
+		dev_err(i2c->dev, "%s: bad status(0x%x)\n", __func__, data);
+}
+
+static int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
+{
+	u8 status;
+	int tries;
+
+	/* disable high level controller, enable bus access */
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+
+	/* reset controller */
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+
+	for (tries = 10; tries; tries--) {
+		udelay(1);
+		status = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+		if (status == STAT_IDLE)
+			return 0;
+	}
+	dev_err(i2c->dev, "%s: TWSI_RST failed! (0x%x)\n", __func__, status);
+	return -EIO;
+}
+
 /**
- * octeon_i2c_start - send START to the bus.
- * @i2c: The struct octeon_i2c.
+ * octeon_i2c_start - send START to the bus
+ * @i2c: The struct octeon_i2c
  *
  * Returns 0 on success, otherwise a negative errno.
  */
 static int octeon_i2c_start(struct octeon_i2c *i2c)
 {
-	u8 data;
 	int result;
+	u8 data;
 
 	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-				TWSI_CTL_ENAB | TWSI_CTL_STA);
+			    TWSI_CTL_ENAB | TWSI_CTL_STA);
 
 	result = octeon_i2c_wait(i2c);
 	if (result) {
@@ -240,10 +320,9 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
 			 * be a client is holding SDA low - let's try
 			 * to free it.
 			 */
-			octeon_i2c_unblock(i2c);
+			bitbang_unblock(i2c);
 			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
 					    TWSI_CTL_ENAB | TWSI_CTL_STA);
-
 			result = octeon_i2c_wait(i2c);
 		}
 		if (result)
@@ -255,47 +334,24 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
 		dev_err(i2c->dev, "%s: bad status (0x%x)\n", __func__, data);
 		return -EIO;
 	}
-
-	return 0;
-}
-
-/**
- * octeon_i2c_stop - send STOP to the bus.
- * @i2c: The struct octeon_i2c.
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_stop(struct octeon_i2c *i2c)
-{
-	u8 data;
-
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_ENAB | TWSI_CTL_STP);
-
-	data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-
-	if (data != STAT_IDLE) {
-		dev_err(i2c->dev, "%s: bad status(0x%x)\n", __func__, data);
-		return -EIO;
-	}
 	return 0;
 }
 
 /**
- * octeon_i2c_write - send data to the bus.
- * @i2c: The struct octeon_i2c.
- * @target: Target address.
- * @data: Pointer to the data to be sent.
- * @length: Length of the data.
+ * octeon_i2c_write - send data to the bus via low-level controller
+ * @i2c: The struct octeon_i2c
+ * @target: Target address
+ * @data: Pointer to the data to be sent
+ * @length: Length of the data
  *
  * The address is sent over the bus, then the data.
  *
  * Returns 0 on success, otherwise a negative errno.
  */
 static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
-			    const u8 *data, int length)
+			    u8 *data, int length)
 {
-	int i, result;
+	int result, i;
 	u8 tmp;
 
 	result = octeon_i2c_start(i2c);
@@ -311,6 +367,7 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 
 	for (i = 0; i < length; i++) {
 		tmp = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+
 		if ((tmp != STAT_TXADDR_ACK) && (tmp != STAT_TXDATA_ACK)) {
 			dev_err(i2c->dev,
 				"%s: bad status before write (0x%x)\n",
@@ -330,19 +387,20 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 }
 
 /**
- * octeon_i2c_read - receive data from the bus.
- * @i2c: The struct octeon_i2c.
- * @target: Target address.
- * @data: Pointer to the location to store the datae .
- * @length: Length of the data.
+ * octeon_i2c_read - receive data from the bus via low-level controller
+ * @i2c: The struct octeon_i2c
+ * @target: Target address
+ * @data: Pointer to the location to store the data
+ * @rlength: Length of the data
  *
  * The address is sent over the bus, then the data is read.
  *
  * Returns 0 on success, otherwise a negative errno.
  */
-static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
-			   u8 *data, int length)
+static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
+			   u16 *rlength)
 {
+	int length = *rlength;
 	int i, result;
 	u8 tmp;
 
@@ -353,15 +411,14 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 	if (result)
 		return result;
 
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, (target<<1) | 1);
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, TWSI_CTL_ENAB);
 	result = octeon_i2c_wait(i2c);
 	if (result)
 		return result;
 
 	for (i = 0; i < length; i++) {
 		tmp = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+
 		if ((tmp != STAT_RXDATA_ACK) && (tmp != STAT_RXADDR_ACK)) {
 			dev_err(i2c->dev,
 				"%s: bad status before read (0x%x)\n",
@@ -369,12 +426,12 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 			return -EIO;
 		}
 
-		if (i+1 < length)
+		if (i + 1 < length)
 			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-						TWSI_CTL_ENAB | TWSI_CTL_AAK);
+					    TWSI_CTL_ENAB | TWSI_CTL_AAK);
 		else
 			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-						TWSI_CTL_ENAB);
+					    TWSI_CTL_ENAB);
 
 		result = octeon_i2c_wait(i2c);
 		if (result)
@@ -382,43 +439,41 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 
 		data[i] = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_DATA);
 	}
+	*rlength = length;
 	return 0;
 }
 
 /**
- * octeon_i2c_xfer - The driver's master_xfer function.
- * @adap: Pointer to the i2c_adapter structure.
- * @msgs: Pointer to the messages to be processed.
- * @num: Length of the MSGS array.
+ * octeon_i2c_xfer - The driver's master_xfer function
+ * @adap: Pointer to the i2c_adapter structure
+ * @msgs: Pointer to the messages to be processed
+ * @num: Length of the MSGS array
  *
- * Returns the number of messages processed, or a negative errno on
- * failure.
+ * Returns the number of messages processed, or a negative errno on failure.
  */
-static int octeon_i2c_xfer(struct i2c_adapter *adap,
-			   struct i2c_msg *msgs,
+static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   int num)
 {
-	struct i2c_msg *pmsg;
-	int i;
-	int ret = 0;
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
+	int i, ret = 0;
 
 	for (i = 0; ret == 0 && i < num; i++) {
-		pmsg = &msgs[i];
+		struct i2c_msg *pmsg = &msgs[i];
+
 		dev_dbg(i2c->dev,
 			"Doing %s %d byte(s) to/from 0x%02x - %d of %d messages\n",
 			 pmsg->flags & I2C_M_RD ? "read" : "write",
 			 pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
 			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
-						pmsg->len);
+					      &pmsg->len);
 		else
 			ret = octeon_i2c_write(i2c, pmsg->addr, pmsg->buf,
-						pmsg->len);
+					       pmsg->len);
 	}
 	octeon_i2c_stop(i2c);
 
-	return (ret != 0) ? ret : num;
+	return ret ? -EAGAIN : num;
 }
 
 static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
@@ -435,13 +490,10 @@ static struct i2c_adapter octeon_i2c_ops = {
 	.owner = THIS_MODULE,
 	.name = "OCTEON adapter",
 	.algo = &octeon_i2c_algo,
-	.timeout = HZ / 50,
 };
 
-/**
- * octeon_i2c_setclock - Calculate and set clock divisors.
- */
-static int octeon_i2c_setclock(struct octeon_i2c *i2c)
+/* calculate and set clock divisors */
+static void octeon_i2c_setclock(struct octeon_i2c *i2c)
 {
 	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
 	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
@@ -449,8 +501,7 @@ static int octeon_i2c_setclock(struct octeon_i2c *i2c)
 	for (ndiv_idx = 0; ndiv_idx < 8 && delta_hz != 0; ndiv_idx++) {
 		/*
 		 * An mdiv value of less than 2 seems to not work well
-		 * with ds1337 RTCs, so we constrain it to larger
-		 * values.
+		 * with ds1337 RTCs, so we constrain it to larger values.
 		 */
 		for (mdiv_idx = 15; mdiv_idx >= 2 && delta_hz != 0; mdiv_idx--) {
 			/*
@@ -460,6 +511,7 @@ static int octeon_i2c_setclock(struct octeon_i2c *i2c)
 			tclk = i2c->twsi_freq * (mdiv_idx + 1) * 10;
 			tclk *= (1 << ndiv_idx);
 			thp_base = (i2c->sys_freq / (tclk * 2)) - 1;
+
 			for (inc = 0; inc <= 1; inc++) {
 				thp_idx = thp_base + inc;
 				if (thp_idx < 5 || thp_idx > 0xff)
@@ -480,36 +532,14 @@ static int octeon_i2c_setclock(struct octeon_i2c *i2c)
 	}
 	octeon_i2c_write_sw(i2c, SW_TWSI_OP_TWSI_CLK, thp);
 	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CLKCTL, (mdiv << 3) | ndiv);
-
-	return 0;
-}
-
-static int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
-{
-	u8 status;
-	int tries;
-
-	/* disable high level controller, enable bus access */
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
-	/* reset controller */
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_RST, 0);
-
-	for (tries = 10; tries; tries--) {
-		udelay(1);
-		status = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-		if (status == STAT_IDLE)
-			return 0;
-	}
-	dev_err(i2c->dev, "%s: TWSI_RST failed! (0x%x)\n", __func__, status);
-	return -EIO;
 }
 
 static int octeon_i2c_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	int irq, result = 0;
-	struct octeon_i2c *i2c;
 	struct resource *res_mem;
+	struct octeon_i2c *i2c;
 
 	/* All adaptors have an irq.  */
 	irq = platform_get_irq(pdev, 0);
@@ -518,7 +548,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c) {
-		dev_err(&pdev->dev, "kzalloc failed\n");
 		result = -ENOMEM;
 		goto out;
 	}
@@ -531,18 +560,14 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 		result = -ENXIO;
 		goto out;
 	}
-	i2c->twsi_phys = res_mem->start;
-	i2c->regsize = resource_size(res_mem);
 
 	/*
 	 * "clock-rate" is a legacy binding, the official binding is
 	 * "clock-frequency".  Try the official one first and then
 	 * fall back if it doesn't exist.
 	 */
-	if (of_property_read_u32(pdev->dev.of_node,
-				 "clock-frequency", &i2c->twsi_freq) &&
-	    of_property_read_u32(pdev->dev.of_node,
-				 "clock-rate", &i2c->twsi_freq)) {
+	if (of_property_read_u32(node, "clock-frequency", &i2c->twsi_freq) &&
+	    of_property_read_u32(node, "clock-rate", &i2c->twsi_freq)) {
 		dev_err(i2c->dev,
 			"no I2C 'clock-rate' or 'clock-frequency' property\n");
 		result = -ENXIO;
@@ -551,15 +576,15 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 
 	i2c->sys_freq = octeon_get_io_clock_rate();
 
-	if (!devm_request_mem_region(&pdev->dev, i2c->twsi_phys, i2c->regsize,
-				      res_mem->name)) {
+	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
+				     resource_size(res_mem), res_mem->name)) {
 		dev_err(i2c->dev, "request_mem_region failed\n");
 		goto out;
 	}
-	i2c->twsi_base = devm_ioremap(&pdev->dev, i2c->twsi_phys, i2c->regsize);
 
+	i2c->twsi_base = devm_ioremap(&pdev->dev, res_mem->start,
+				      resource_size(res_mem));
 	init_waitqueue_head(&i2c->queue);
-
 	i2c->irq = irq;
 
 	result = devm_request_irq(&pdev->dev, i2c->irq,
@@ -575,15 +600,12 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 		goto  out;
 	}
 
-	result = octeon_i2c_setclock(i2c);
-	if (result) {
-		dev_err(i2c->dev, "clock init failed\n");
-		goto  out;
-	}
+	octeon_i2c_setclock(i2c);
 
 	i2c->adap = octeon_i2c_ops;
+	i2c->adap.timeout = msecs_to_jiffies(50);
 	i2c->adap.dev.parent = &pdev->dev;
-	i2c->adap.dev.of_node = pdev->dev.of_node;
+	i2c->adap.dev.of_node = node;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	platform_set_drvdata(pdev, i2c);
 
@@ -592,8 +614,7 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 		dev_err(i2c->dev, "failed to add adapter\n");
 		goto out;
 	}
-	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
-
+	dev_info(i2c->dev, "probed\n");
 	return 0;
 
 out:
@@ -608,10 +629,8 @@ static int octeon_i2c_remove(struct platform_device *pdev)
 	return 0;
 };
 
-static struct of_device_id octeon_i2c_match[] = {
-	{
-		.compatible = "cavium,octeon-3860-twsi",
-	},
+static const struct of_device_id octeon_i2c_match[] = {
+	{	.compatible = "cavium,octeon-3860-twsi",	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, octeon_i2c_match);
@@ -630,4 +649,3 @@ module_platform_driver(octeon_i2c_driver);
 MODULE_AUTHOR("Michael Lawnick <michael.lawnick.ext@nsn.com>");
 MODULE_DESCRIPTION("I2C-Bus adapter for Cavium OCTEON processors");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
-- 
1.9.1
