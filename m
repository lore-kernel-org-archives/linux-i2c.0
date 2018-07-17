From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v12 7/8] i2c: fsi: Add bus recovery
Date: Tue, 17 Jul 2018 10:31:05 -0500
Message-ID: <1531841466-9833-8-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se, "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>

Bus recovery should reset the bus with the standard i2c recovery
procedure. Populate the necessary fields so that the standard procedure
can perform the reset.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 27d74a9..1e2be22 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -326,6 +326,115 @@ static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
 	return 0;
 }
 
+static int fsi_i2c_get_scl(struct i2c_adapter *adap)
+{
+	u32 stat = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+
+	return !!(stat & I2C_STAT_SCL_IN);
+}
+
+static void fsi_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	u32 dummy = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	if (val)
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
+	else
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
+}
+
+static int fsi_i2c_get_sda(struct i2c_adapter *adap)
+{
+	u32 stat = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+
+	return !!(stat & I2C_STAT_SDA_IN);
+}
+
+static void fsi_i2c_set_sda(struct i2c_adapter *adap, int val)
+{
+	u32 dummy = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	if (val)
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SDA, &dummy);
+	else
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SDA, &dummy);
+}
+
+static void fsi_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	int rc;
+	u32 mode;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return;
+
+	mode |= I2C_MODE_DIAG;
+	fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+}
+
+static void fsi_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	int rc;
+	u32 mode;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return;
+
+	mode &= ~I2C_MODE_DIAG;
+	fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+}
+
+static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c,
+			     struct fsi_i2c_port *port)
+{
+	int rc;
+	u32 stat, dummy = 0;
+
+	/* force bus reset, ignore errors */
+	i2c_recover_bus(&port->adapter);
+
+	/* reset errors */
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
+	if (rc)
+		return rc;
+
+	/* wait for command complete */
+	usleep_range(I2C_RESET_SLEEP_MIN_US, I2C_RESET_SLEEP_MAX_US);
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+	if (rc)
+		return rc;
+
+	if (stat & I2C_STAT_CMD_COMP)
+		return 0;
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
 static int fsi_i2c_reset_engine(struct fsi_i2c_master *i2c, u16 port)
 {
 	int rc;
@@ -368,6 +477,7 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	int rc;
 	unsigned long start;
 	u32 cmd = I2C_CMD_WITH_STOP;
+	u32 stat;
 	struct fsi_i2c_master *i2c = port->master;
 	struct fsi_device *fsi = i2c->fsi;
 
@@ -375,6 +485,17 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	if (rc)
 		return rc;
 
+	rc = fsi_i2c_read_reg(fsi, I2C_FSI_STAT, &stat);
+	if (rc)
+		return rc;
+
+	/* if sda is low, peform full bus reset */
+	if (!(stat & I2C_STAT_SDA_IN)) {
+		rc = fsi_i2c_reset_bus(i2c, port);
+		if (rc)
+			return rc;
+	}
+
 	/* skip final stop command for these errors */
 	if (status & (I2C_STAT_PARITY | I2C_STAT_LOST_ARB | I2C_STAT_STOP_ERR))
 		return 0;
@@ -522,6 +643,16 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 		I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+static struct i2c_bus_recovery_info fsi_i2c_bus_recovery_info = {
+	.recover_bus = i2c_generic_scl_recovery,
+	.get_scl = fsi_i2c_get_scl,
+	.set_scl = fsi_i2c_set_scl,
+	.get_sda = fsi_i2c_get_sda,
+	.set_sda = fsi_i2c_set_sda,
+	.prepare_recovery = fsi_i2c_prepare_recovery,
+	.unprepare_recovery = fsi_i2c_unprepare_recovery,
+};
+
 static const struct i2c_algorithm fsi_i2c_algorithm = {
 	.master_xfer = fsi_i2c_xfer,
 	.functionality = fsi_i2c_functionality,
@@ -564,6 +695,7 @@ static int fsi_i2c_probe(struct device *dev)
 		port->adapter.dev.of_node = np;
 		port->adapter.dev.parent = dev;
 		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.bus_recovery_info = &fsi_i2c_bus_recovery_info;
 		port->adapter.algo_data = port;
 
 		snprintf(port->adapter.name, sizeof(port->adapter.name),
-- 
1.8.3.1
