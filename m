From: Jan Glauber <jglauber@cavium.com>
Subject: [Resend PATCH 03/10] i2c-octeon: Enable high-level controller and improve on bus contention
Date: Mon, 29 Feb 2016 14:46:10 +0100
Message-ID: <60b9c5e02835237ae1ef9355a245eac3ac863808.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ddaney@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: David Daney <ddaney@caviumnetworks.com>

Use High Level Controller when possible.

i2c-octeon was reacting badly to bus contention: when in
direct-access mode (for transfers > 8 bytes, which cannot use the
high-level controller) some !ACK or arbitration-loss states were
not causing the current transfer to be aborted, and the bus released.

There's one place in i2c protocol that !ACK is an acceptable
response: in the final byte of a read cycle.  In this case the
destination is not saying that the transfer failed, just that it
doesn't want more data.

This enables correct behavior of ACK on final byte of non-final read
msgs too.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 583 ++++++++++++++++++++++++++++++++++------
 1 file changed, 504 insertions(+), 79 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index fa4d439..d48456a 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -113,8 +113,15 @@ struct octeon_i2c {
 	int			sys_freq;
 	void __iomem		*twsi_base;
 	struct device		*dev;
+	bool			hlc_enabled;
 };
 
+static int reset_how;
+
+static int timeout = 2;
+module_param(timeout, int, 0444);
+MODULE_PARM_DESC(timeout, "Low-level device timeout (ms)");
+
 /**
  * octeon_i2c_write_sw - write an I2C core register
  * @i2c: The struct octeon_i2c
@@ -123,7 +130,7 @@ struct octeon_i2c {
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static void octeon_i2c_write_sw(struct octeon_i2c *i2c, u64 eop_reg, u8 data)
+static void octeon_i2c_write_sw(struct octeon_i2c *i2c, u64 eop_reg, u32 data)
 {
 	u64 tmp;
 
@@ -165,7 +172,7 @@ static u64 octeon_i2c_read_sw64(struct octeon_i2c *i2c, u64 eop_reg)
  */
 static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
 {
-	return octeon_i2c_read_sw64(i2c, eop_reg);
+	return (u8) octeon_i2c_read_sw64(i2c, eop_reg);
 }
 
 /**
@@ -198,6 +205,15 @@ static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
 	octeon_i2c_write_int(i2c, TS_INT | ST_INT);
 }
 
+static void octeon_i2c_disable_hlc(struct octeon_i2c *i2c)
+{
+	if (!i2c->hlc_enabled)
+		return;
+
+	i2c->hlc_enabled = false;
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+}
+
 /**
  * bitbang_unblock - unblock the bus
  * @i2c: The struct octeon_i2c
@@ -207,13 +223,18 @@ static void octeon_i2c_int_disable(struct octeon_i2c *i2c)
  */
 static void bitbang_unblock(struct octeon_i2c *i2c)
 {
-	int i;
+	int state, i;
 
+	octeon_i2c_disable_hlc(i2c);
 	dev_dbg(i2c->dev, "%s\n", __func__);
 
+	/* cycle 8+1 clocks with SDA high */
 	for (i = 0; i < 9; i++) {
 		octeon_i2c_write_int(i2c, 0);
 		udelay(5);
+		state = __raw_readq(i2c->twsi_base + TWSI_INT);
+		if (state & (SDA | SCL))
+			break;
 		octeon_i2c_write_int(i2c, SCL_OVR);
 		udelay(5);
 	}
@@ -236,10 +257,14 @@ static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static u64 octeon_i2c_read_ctl(struct octeon_i2c *i2c)
+{
+	return octeon_i2c_read_sw64(i2c, SW_TWSI_EOP_TWSI_CTL);
+}
+
 static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 {
-	return (octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_CTL)
-		& TWSI_CTL_IFLG) != 0;
+	return (octeon_i2c_read_ctl(i2c) & TWSI_CTL_IFLG) != 0;
 }
 
 /**
@@ -263,76 +288,208 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	return 0;
 }
 
-/* send STOP to the bus */
-static void octeon_i2c_stop(struct octeon_i2c *i2c)
+/*
+ * Cleanup low-level state & enable high-level.
+ *
+ * Returns -EAGAIN if low-level state could not be cleaned
+ */
+static int octeon_i2c_enable_hlc(struct octeon_i2c *i2c)
 {
-	u8 data;
+	int try = 0, ret = 0;
+	u64 val;
+
+	if (i2c->hlc_enabled)
+		return 0;
+	else
+		i2c->hlc_enabled = true;
+
+	while (1) {
+		val = octeon_i2c_read_ctl(i2c) & (TWSI_CTL_STA | TWSI_CTL_STP);
+		if (!val)
+			break;
+
+		/* clear _IFLG event */
+		if (val & TWSI_CTL_IFLG)
+			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+					    TWSI_CTL_ENAB);
+
+		if (try++ > 100) {
+			pr_err("%s: giving up\n", __func__);
+			ret = -EAGAIN;
+			break;
+		}
+
+		/* spin until any start/stop has finished */
+		udelay(10);
+	}
 
 	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_ENAB | TWSI_CTL_STP);
+			    TWSI_CTL_CE | TWSI_CTL_AAK | TWSI_CTL_ENAB);
+	return ret;
+}
 
-	data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+static int octeon_i2c_lost_arb(u8 code, int final_read)
+{
+	switch (code) {
+	/* Arbitration lost */
+	case STAT_LOST_ARB_38:
+	case STAT_LOST_ARB_68:
+	case STAT_LOST_ARB_78:
+	case STAT_LOST_ARB_B0:
+		return -EAGAIN;
+
+	/* Being addressed as slave, should back off & listen */
+	case STAT_SLAVE_60:
+	case STAT_SLAVE_70:
+	case STAT_GENDATA_ACK:
+	case STAT_GENDATA_NAK:
+		return -EIO;
+
+	/* Core busy as slave */
+	case STAT_SLAVE_80:
+	case STAT_SLAVE_88:
+	case STAT_SLAVE_A0:
+	case STAT_SLAVE_A8:
+	case STAT_SLAVE_LOST:
+	case STAT_SLAVE_NAK:
+	case STAT_SLAVE_ACK:
+		return -EIO;
+
+	/* ACK allowed on pre-terminal bytes only */
+	case STAT_RXDATA_ACK:
+		if (!final_read)
+			return 0;
+		return -EAGAIN;
 
-	if (data != STAT_IDLE)
-		dev_err(i2c->dev, "%s: bad status(0x%x)\n", __func__, data);
+	/* NAK allowed on terminal byte only */
+	case STAT_RXDATA_NAK:
+		if (final_read)
+			return 0;
+		return -EAGAIN;
+	case STAT_TXDATA_NAK:
+	case STAT_TXADDR_NAK:
+	case STAT_RXADDR_NAK:
+	case STAT_AD2W_NAK:
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+static int check_arb(struct octeon_i2c *i2c, int final_read)
+{
+	return octeon_i2c_lost_arb(octeon_i2c_read_sw(i2c,
+			SW_TWSI_EOP_TWSI_STAT),	final_read);
+}
+
+/* send STOP to the bus */
+static void octeon_i2c_stop(struct octeon_i2c *i2c)
+{
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+			    TWSI_CTL_ENAB | TWSI_CTL_STP);
 }
 
 static int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 {
-	u8 status;
+	u8 status = 0;
 	int tries;
 
-	/* disable high level controller, enable bus access */
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
 	/* reset controller */
 	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_RST, 0);
 
-	for (tries = 10; tries; tries--) {
+	for (tries = 10; tries && status != STAT_IDLE; tries--) {
 		udelay(1);
 		status = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-		if (status == STAT_IDLE)
-			return 0;
 	}
-	dev_err(i2c->dev, "%s: TWSI_RST failed! (0x%x)\n", __func__, status);
-	return -EIO;
+
+	if (status != STAT_IDLE) {
+		dev_err(i2c->dev, "%s: TWSI_RST failed! (0x%x)\n",
+			__func__, status);
+		return -EIO;
+	}
+
+	/* toggle twice to force both teardowns */
+	octeon_i2c_enable_hlc(i2c);
+	octeon_i2c_disable_hlc(i2c);
+	return 0;
+}
+
+/*
+ * TWSI state seems stuck. Not sure if it's TWSI-engine state or something
+ * else on bus. The initial _stop() is always harmless, it just resets state
+ * machine, does not _transmit_ STOP unless engine was active.
+ */
+static int start_unstick(struct octeon_i2c *i2c)
+{
+	octeon_i2c_stop(i2c);
+
+	/*
+	 * Response is escalated over successive calls,
+	 * as EAGAIN provokes retries from i2c/core.
+	 */
+	switch (reset_how++ % 4) {
+	case 0:
+		/* just the stop above */
+		break;
+	case 1:
+		/*
+		 * Controller refused to send start flag. May be a
+		 * client is holding SDA low? Let's try to free it.
+		 */
+		bitbang_unblock(i2c);
+		break;
+	case 2:
+		/* re-init our TWSI hardware */
+		octeon_i2c_initlowlevel(i2c);
+		break;
+	default:
+		/* retry in caller */
+		reset_how = 0;
+		return -EAGAIN;
+	}
+	return 0;
 }
 
 /**
  * octeon_i2c_start - send START to the bus
  * @i2c: The struct octeon_i2c
+ * @first: first msg in combined operation?
  *
  * Returns 0 on success, otherwise a negative errno.
  */
-static int octeon_i2c_start(struct octeon_i2c *i2c)
+static int octeon_i2c_start(struct octeon_i2c *i2c, int first)
 {
 	int result;
 	u8 data;
 
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-			    TWSI_CTL_ENAB | TWSI_CTL_STA);
+	octeon_i2c_disable_hlc(i2c);
 
-	result = octeon_i2c_wait(i2c);
-	if (result) {
-		if (octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT) == STAT_IDLE) {
-			/*
-			 * Controller refused to send start flag May
-			 * be a client is holding SDA low - let's try
-			 * to free it.
-			 */
-			bitbang_unblock(i2c);
-			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB | TWSI_CTL_STA);
-			result = octeon_i2c_wait(i2c);
-		}
-		if (result)
-			return result;
-	}
+	while (1) {
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
+				    TWSI_CTL_ENAB | TWSI_CTL_STA);
 
-	data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-	if ((data != STAT_START) && (data != STAT_RSTART)) {
-		dev_err(i2c->dev, "%s: bad status (0x%x)\n", __func__, data);
-		return -EIO;
+		result = octeon_i2c_wait(i2c);
+		data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+
+		switch (data) {
+		case STAT_START:
+		case STAT_RSTART:
+			if (!first)
+				return -EAGAIN;
+			reset_how = 0;
+			return 0;
+		case STAT_RXADDR_ACK:
+			if (first)
+				return -EAGAIN;
+			return start_unstick(i2c);
+		/*
+		 * case STAT_IDLE:
+		 * case STAT_ERROR:
+		 */
+		default:
+			if (!first)
+				return -EAGAIN;
+			start_unstick(i2c);
+		}
 	}
 	return 0;
 }
@@ -343,18 +500,18 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
  * @target: Target address
  * @data: Pointer to the data to be sent
  * @length: Length of the data
+ * @last: is last msg in combined operation?
  *
  * The address is sent over the bus, then the data.
  *
  * Returns 0 on success, otherwise a negative errno.
  */
 static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
-			    u8 *data, int length)
+			    u8 *data, int length, int first, int last)
 {
 	int result, i;
-	u8 tmp;
 
-	result = octeon_i2c_start(i2c);
+	result = octeon_i2c_start(i2c, first);
 	if (result)
 		return result;
 
@@ -366,14 +523,9 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 		return result;
 
 	for (i = 0; i < length; i++) {
-		tmp = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
-
-		if ((tmp != STAT_TXADDR_ACK) && (tmp != STAT_TXDATA_ACK)) {
-			dev_err(i2c->dev,
-				"%s: bad status before write (0x%x)\n",
-				__func__, tmp);
-			return -EIO;
-		}
+		result = check_arb(i2c, false);
+		if (result)
+			return result;
 
 		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, data[i]);
 		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
@@ -381,6 +533,9 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 		result = octeon_i2c_wait(i2c);
 		if (result)
 			return result;
+		result = check_arb(i2c, false);
+		if (result)
+			return result;
 	}
 
 	return 0;
@@ -392,6 +547,7 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
  * @target: Target address
  * @data: Pointer to the location to store the data
  * @rlength: Length of the data
+ * @phase: which phase of a combined operation.
  * @recv_len: flag for length byte
  *
  * The address is sent over the bus, then the data is read.
@@ -399,8 +555,9 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
  * Returns 0 on success, otherwise a negative errno.
  */
 static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
-			   u16 *rlength, bool recv_len)
+			   u16 *rlength, bool first, bool last, bool recv_len)
 {
+	u8 ctl = TWSI_CTL_ENAB | TWSI_CTL_AAK;
 	int length = *rlength;
 	int i, result;
 	u8 tmp;
@@ -408,37 +565,34 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
 	if (length < 1)
 		return -EINVAL;
 
-	result = octeon_i2c_start(i2c);
+	result = octeon_i2c_start(i2c, first);
 	if (result)
 		return result;
 
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, TWSI_CTL_ENAB);
-	result = octeon_i2c_wait(i2c);
-	if (result)
-		return result;
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, (target<<1) | 1);
 
-	for (i = 0; i < length; i++) {
+	for (i = 0; i < length; ) {
 		tmp = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
+		result = octeon_i2c_lost_arb(tmp, !(ctl & TWSI_CTL_AAK));
+		if (result)
+			return result;
 
-		if ((tmp != STAT_RXDATA_ACK) && (tmp != STAT_RXADDR_ACK)) {
-			dev_err(i2c->dev,
-				"%s: bad status before read (0x%x)\n",
-				__func__, tmp);
-			return -EIO;
+		switch (tmp) {
+		case STAT_RXDATA_ACK:
+		case STAT_RXDATA_NAK:
+			data[i++] = octeon_i2c_read_sw(i2c,
+					SW_TWSI_EOP_TWSI_DATA);
 		}
 
-		if (i + 1 < length)
-			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB | TWSI_CTL_AAK);
-		else
-			octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL,
-					    TWSI_CTL_ENAB);
+		/* NAK last recv'd byte, as a no-more-please */
+		if (last && i == length - 1)
+			ctl &= ~TWSI_CTL_AAK;
 
+		/* clr iflg to allow next event */
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, ctl);
 		result = octeon_i2c_wait(i2c);
 		if (result)
 			return result;
-
-		data[i] = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_DATA);
 		if (recv_len && i == 0) {
 			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
 				dev_err(i2c->dev,
@@ -453,6 +607,253 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
 	return 0;
 }
 
+static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c)
+{
+	u64 val = __raw_readq(i2c->twsi_base + SW_TWSI);
+
+	return (val & SW_TWSI_V) == 0;
+}
+
+static void octeon_i2c_hlc_int_enable(struct octeon_i2c *i2c)
+{
+	octeon_i2c_write_int(i2c, ST_EN);
+}
+
+static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
+{
+	/* clear ST/TS events, listen for neither */
+	octeon_i2c_write_int(i2c, ST_INT | TS_INT);
+}
+
+/**
+ * octeon_i2c_hlc_wait - wait for an HLC operation to complete
+ * @i2c: The struct octeon_i2c
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
+{
+	int result;
+
+	octeon_i2c_hlc_int_enable(i2c);
+	result = wait_event_interruptible_timeout(i2c->queue,
+						  octeon_i2c_hlc_test_ready(i2c),
+						  i2c->adap.timeout);
+	octeon_i2c_int_disable(i2c);
+	if (!result)
+		octeon_i2c_hlc_int_clear(i2c);
+
+	if (result < 0) {
+		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
+		return result;
+	} else if (!result) {
+		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/* high-level-controller pure read of up to 8 bytes */
+static int octeon_i2c_simple_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	int i, j, ret = 0;
+	u64 cmd;
+
+	octeon_i2c_enable_hlc(i2c);
+	cmd = SW_TWSI_V | SW_TWSI_R | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64) (msgs[0].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10;
+	else
+		cmd |= SW_TWSI_OP_7;
+
+	octeon_i2c_hlc_int_clear(i2c);
+	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+
+	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
+		msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
+
+	if (msgs[0].len > 4) {
+		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
+		for (i = 0; i  < msgs[0].len - 4 && i < 4; i++, j--)
+			msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
+	}
+
+err:
+	return ret;
+}
+
+/* high-level-controller pure write of up to 8 bytes */
+static int octeon_i2c_simple_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	int i, j, ret = 0;
+	u64 cmd;
+
+	octeon_i2c_enable_hlc(i2c);
+	octeon_i2c_hlc_int_clear(i2c);
+
+	ret = check_arb(i2c, false);
+	if (ret)
+		goto err;
+
+	cmd = SW_TWSI_V | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64) (msgs[0].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10;
+	else
+		cmd |= SW_TWSI_OP_7;
+
+	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
+		cmd |= (u64)msgs[0].buf[j] << (8 * i);
+
+	if (msgs[0].len > 4) {
+		u64 ext = 0;
+
+		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
+			ext |= (u64) msgs[0].buf[j] << (8 * i);
+		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+	}
+
+	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+
+	ret = check_arb(i2c, false);
+
+err:
+	return ret;
+}
+
+/* high-level-controller composite write+read, msg0=addr, msg1=data */
+static int octeon_i2c_ia_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	int i, j, ret = 0;
+	u64 cmd;
+
+	octeon_i2c_enable_hlc(i2c);
+
+	cmd = SW_TWSI_V | SW_TWSI_R | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64)(msgs[1].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64)(msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10_IA;
+	else
+		cmd |= SW_TWSI_OP_7_IA;
+
+	if (msgs[0].len == 2) {
+		u64 ext = 0;
+
+		cmd |= SW_TWSI_EIA;
+		ext = (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
+		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+	} else
+		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+
+	octeon_i2c_hlc_int_clear(i2c);
+	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+
+	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
+		msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
+
+	if (msgs[1].len > 4) {
+		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
+		for (i = 0; i  < msgs[1].len - 4 && i < 4; i++, j--)
+			msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
+	}
+
+err:
+	return ret;
+}
+
+/* high-level-controller composite write+write, m[0]len<=2, m[1]len<=8 */
+static int octeon_i2c_ia_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
+{
+	bool set_ext = false;
+	int i, j, ret = 0;
+	u64 cmd, ext = 0;
+
+	octeon_i2c_enable_hlc(i2c);
+
+	cmd = SW_TWSI_V | SW_TWSI_SOVR;
+	/* SIZE */
+	cmd |= (u64) (msgs[1].len - 1) << SW_TWSI_SIZE_SHIFT;
+	/* A */
+	cmd |= (u64) (msgs[0].addr & 0x7full) << SW_TWSI_A_SHIFT;
+
+	if (msgs[0].flags & I2C_M_TEN)
+		cmd |= SW_TWSI_OP_10_IA;
+	else
+		cmd |= SW_TWSI_OP_7_IA;
+
+	if (msgs[0].len == 2) {
+		cmd |= SW_TWSI_EIA;
+		ext |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+		set_ext = true;
+		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
+	} else
+		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
+
+	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
+		cmd |= (u64) msgs[1].buf[j] << (8 * i);
+
+	if (msgs[1].len > 4) {
+		for (i = 0; i < msgs[1].len - 4 && i < 4; i++, j--)
+			ext |= (u64)msgs[1].buf[j] << (8 * i);
+		set_ext = true;
+	}
+	if (set_ext)
+		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+
+	octeon_i2c_hlc_int_clear(i2c);
+	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+
+	ret = octeon_i2c_hlc_wait(i2c);
+	if (ret)
+		goto err;
+
+	cmd = octeon_i2c_read_sw64(i2c, SW_TWSI_EOP_TWSI_STAT);
+	if ((cmd & SW_TWSI_R) == 0)
+		return -EAGAIN;
+	ret = octeon_i2c_lost_arb(cmd, false);
+
+err:
+	return ret;
+}
+
 /**
  * octeon_i2c_xfer - The driver's master_xfer function
  * @adap: Pointer to the i2c_adapter structure
@@ -467,8 +868,31 @@ static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 	int i, ret = 0;
 
+	if (num == 1) {
+		if (msgs[0].len > 0 && msgs[0].len <= 8) {
+			if (msgs[0].flags & I2C_M_RD)
+				ret = octeon_i2c_simple_read(i2c, msgs);
+			else
+				ret = octeon_i2c_simple_write(i2c, msgs);
+			goto out;
+		}
+	} else if (num == 2) {
+		if ((msgs[0].flags & I2C_M_RD) == 0 &&
+		    (msgs[1].flags & I2C_M_RECV_LEN) == 0 &&
+		    msgs[0].len > 0 && msgs[0].len <= 2 &&
+		    msgs[1].len > 0 && msgs[1].len <= 8 &&
+		    msgs[0].addr == msgs[1].addr) {
+			if (msgs[1].flags & I2C_M_RD)
+				ret = octeon_i2c_ia_read(i2c, msgs);
+			else
+				ret = octeon_i2c_ia_write(i2c, msgs);
+			goto out;
+		}
+	}
+
 	for (i = 0; ret == 0 && i < num; i++) {
 		struct i2c_msg *pmsg = &msgs[i];
+		bool last = (i == (num - 1));
 
 		dev_dbg(i2c->dev,
 			"Doing %s %d byte(s) to/from 0x%02x - %d of %d messages\n",
@@ -476,14 +900,14 @@ static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			 pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
 			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
-					      &pmsg->len,
+					      &pmsg->len, !i, last,
 					      pmsg->flags & I2C_M_RECV_LEN);
 		else
 			ret = octeon_i2c_write(i2c, pmsg->addr, pmsg->buf,
-					       pmsg->len);
+					       pmsg->len, !i, last);
 	}
 	octeon_i2c_stop(i2c);
-
+out:
 	return ret ? -EAGAIN : num;
 }
 
@@ -614,7 +1038,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	octeon_i2c_setclock(i2c);
 
 	i2c->adap = octeon_i2c_ops;
-	i2c->adap.timeout = msecs_to_jiffies(50);
+	i2c->adap.timeout = msecs_to_jiffies(timeout);
+	i2c->adap.retries = 10;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = node;
 	i2c_set_adapdata(&i2c->adap, i2c);
-- 
1.9.1
