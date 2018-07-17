From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v12 4/8] i2c: fsi: Add abort and hardware reset procedures
Date: Tue, 17 Jul 2018 10:31:02 -0500
Message-ID: <1531841466-9833-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se, "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>

Add abort procedure for failed transfers. Add engine reset procedure
that is executed during the abort to recover from various fault
conditions.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 1d9e9bf..0f0bc88 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -12,10 +12,12 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/fsi.h>
 #include <linux/i2c.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -128,6 +130,20 @@
 #define I2C_ESTAT_SELF_BUSY	BIT(6)
 #define I2C_ESTAT_VERSION	GENMASK(4, 0)
 
+/* port busy register */
+#define I2C_PORT_BUSY_RESET	BIT(31)
+
+/* wait for command complete or data request */
+#define I2C_CMD_SLEEP_MAX_US	500
+#define I2C_CMD_SLEEP_MIN_US	50
+
+/* wait after reset; choose time from legacy driver */
+#define I2C_RESET_SLEEP_MAX_US	2000
+#define I2C_RESET_SLEEP_MIN_US	1000
+
+/* choose timeout length from legacy driver; it's well tested */
+#define I2C_ABORT_TIMEOUT	msecs_to_jiffies(100)
+
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
@@ -214,6 +230,81 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
 	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
 }
 
+static int fsi_i2c_reset_engine(struct fsi_i2c_master *i2c, u16 port)
+{
+	int rc;
+	u32 mode, dummy = 0;
+
+	/* reset engine */
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
+	if (rc)
+		return rc;
+
+	/* re-init engine */
+	rc = fsi_i2c_dev_init(i2c);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	/* set port; default after reset is 0 */
+	if (port) {
+		mode &= ~I2C_MODE_PORT;
+		mode |= FIELD_PREP(I2C_MODE_PORT, port);
+		rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+		if (rc)
+			return rc;
+	}
+
+	/* reset busy register; hw workaround */
+	dummy = I2C_PORT_BUSY_RESET;
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_PORT_BUSY, &dummy);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
+{
+	int rc;
+	unsigned long start;
+	u32 cmd = I2C_CMD_WITH_STOP;
+	struct fsi_i2c_master *i2c = port->master;
+	struct fsi_device *fsi = i2c->fsi;
+
+	rc = fsi_i2c_reset_engine(i2c, port->port);
+	if (rc)
+		return rc;
+
+	/* skip final stop command for these errors */
+	if (status & (I2C_STAT_PARITY | I2C_STAT_LOST_ARB | I2C_STAT_STOP_ERR))
+		return 0;
+
+	/* write stop command */
+	rc = fsi_i2c_write_reg(fsi, I2C_FSI_CMD, &cmd);
+	if (rc)
+		return rc;
+
+	/* wait until we see command complete in the master */
+	start = jiffies;
+
+	do {
+		rc = fsi_i2c_read_reg(fsi, I2C_FSI_STAT, &status);
+		if (rc)
+			return rc;
+
+		if (status & I2C_STAT_CMD_COMP)
+			return 0;
+
+		usleep_range(I2C_CMD_SLEEP_MIN_US, I2C_CMD_SLEEP_MAX_US);
+	} while (time_after(start + I2C_ABORT_TIMEOUT, jiffies));
+
+	return -ETIMEDOUT;
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
-- 
1.8.3.1
