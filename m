From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v7 4/7] drivers/i2c: Add abort and hardware reset procedures
Date: Tue, 29 May 2018 17:24:22 -0500
Message-ID: <1527632665-25707-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

Add abort procedure for failed transfers. Add engine and bus reset
procedures to recover from as many faults as possible.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 4ad5d68..c0b17df 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -9,10 +9,12 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/fsi.h>
 #include <linux/i2c.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -129,6 +131,14 @@
 #define I2C_ESTAT_SELF_BUSY	0x00000040
 #define I2C_ESTAT_VERSION	0x0000001f
 
+#define I2C_PORT_BUSY_RESET	0x80000000
+
+#define I2C_LOCAL_SLEEP_MAX_US	500
+#define I2C_LOCAL_SLEEP_MIN_US	50
+
+/* choose timeout length from legacy driver; it's well tested */
+#define I2C_ABORT_TIMEOUT	msecs_to_jiffies(100)
+
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
@@ -224,6 +234,168 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
 	return rc;
 }
 
+static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c)
+{
+	int i, rc;
+	u32 mode, stat, ext, dummy = 0;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	mode |= I2C_MODE_DIAG;
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < 9; ++i) {
+		rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
+		if (rc)
+			return rc;
+
+		rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
+		if (rc)
+			return rc;
+	}
+
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SDA, &dummy);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SDA, &dummy);
+	if (rc)
+		return rc;
+
+	mode &= ~I2C_MODE_DIAG;
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+	if (rc)
+		return rc;
+
+	/* check for hardware fault */
+	if (!(stat & I2C_STAT_SCL_IN) || !(stat & I2C_STAT_SDA_IN)) {
+		rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_ESTAT, &ext);
+		if (rc)
+			return rc;
+
+		dev_err(&i2c->fsi->dev, "bus stuck status[%08X] ext[%08X]\n",
+			stat, ext);
+	}
+
+	return 0;
+}
+
+static int fsi_i2c_reset(struct fsi_i2c_master *i2c, u16 port)
+{
+	int rc;
+	u32 mode, stat, dummy = 0;
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
+		mode = SETFIELD(I2C_MODE_PORT, mode, port);
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
+	/* force bus reset */
+	rc = fsi_i2c_reset_bus(i2c);
+	if (rc)
+		return rc;
+
+	/* reset errors */
+	dummy = 0;
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
+	if (rc)
+		return rc;
+
+	/* wait for command complete; time from legacy driver */
+	msleep(1);
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+	if (rc)
+		return rc;
+
+	if (stat & I2C_STAT_CMD_COMP)
+		return rc;
+
+	/* failed to get command complete; reset engine again */
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
+	if (rc)
+		return rc;
+
+	/* re-init engine again */
+	return fsi_i2c_dev_init(i2c);
+}
+
+static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
+{
+	int rc;
+	unsigned long start;
+	u32 cmd = I2C_CMD_WITH_STOP;
+	struct fsi_device *fsi = port->master->fsi;
+
+	rc = fsi_i2c_reset(port->master, port->port);
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
+		usleep_range(I2C_LOCAL_SLEEP_MIN_US, I2C_LOCAL_SLEEP_MAX_US);
+	} while (time_after(start + I2C_ABORT_TIMEOUT, jiffies));
+
+	return -ETIME;
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
-- 
1.8.3.1
