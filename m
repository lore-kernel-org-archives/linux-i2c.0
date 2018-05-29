From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v7 7/7] drivers/i2c: Add bus recovery for FSI algorithm
Date: Tue, 29 May 2018 17:24:25 -0500
Message-ID: <1527632665-25707-8-git-send-email-eajames@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

Bus recovery should reset the engine and force clock the bus 9 times
to recover most situations.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index f309267..52a662c 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -621,6 +621,24 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 		| I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+static int fsi_i2c_recover_bus(struct i2c_adapter *adap)
+{
+	int rc;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *master = port->master;
+
+	mutex_lock(&master->lock);
+
+	rc = fsi_i2c_reset(master, port->port);
+
+	mutex_unlock(&master->lock);
+	return rc;
+}
+
+static struct i2c_bus_recovery_info fsi_i2c_bus_recovery_info = {
+	.recover_bus = fsi_i2c_recover_bus,
+};
+
 static const struct i2c_algorithm fsi_i2c_algorithm = {
 	.master_xfer = fsi_i2c_xfer,
 	.functionality = fsi_i2c_functionality,
@@ -663,6 +681,7 @@ static int fsi_i2c_probe(struct device *dev)
 		port->adapter.dev.of_node = np;
 		port->adapter.dev.parent = dev;
 		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.bus_recovery_info = &fsi_i2c_bus_recovery_info;
 		port->adapter.algo_data = port;
 
 		snprintf(port->adapter.name, sizeof(port->adapter.name),
-- 
1.8.3.1
