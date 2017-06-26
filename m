From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 2/6] drivers/i2c: Add port structure to FSI algorithm
Date: Mon, 26 Jun 2017 14:29:31 -0500
Message-ID: <1498505375-1454-3-git-send-email-eajames@linux.vnet.ibm.com>
References: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, eajames@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

Add and initialize I2C adapters for each port on the FSI-attached I2C
master. Ports for each master are defined in the devicetree.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 113 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index f8ea94e..95fe25a 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -30,6 +30,7 @@
 #define SETFIELD(m, v, val)	\
 	(((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
 
+#define I2C_MASTER_NR_OFFSET	100
 #define I2C_DEFAULT_CLK_DIV	6
 
 /* i2c registers */
@@ -131,9 +132,21 @@
 
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
+	int			idx;
 	u8			fifo_size;
+	struct list_head	ports;
+	struct ida		ida;
 };
 
+struct fsi_i2c_port {
+	struct list_head	list;
+	struct i2c_adapter	adapter;
+	struct fsi_i2c_master	*master;
+	u16			port;
+};
+
+static DEFINE_IDA(fsi_i2c_ida);
+
 static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
 			    u32 *data)
 {
@@ -188,9 +201,44 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
 	return rc;
 }
 
+static int fsi_i2c_set_port(struct fsi_i2c_port *port)
+{
+	int rc;
+	struct fsi_device *fsi = port->master->fsi;
+	u32 mode, dummy = 0;
+	u16 old_port;
+
+	rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return rc;
+
+	old_port = GETFIELD(I2C_MODE_PORT, mode);
+
+	if (old_port != port->port) {
+		mode = SETFIELD(I2C_MODE_PORT, mode, port->port);
+		rc = fsi_i2c_write_reg(fsi, I2C_FSI_MODE, &mode);
+		if (rc)
+			return rc;
+
+		/* reset engine when port is changed */
+		rc = fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
+	int rc;
+	struct fsi_i2c_port *port = adap->algo_data;
+
+	rc = fsi_i2c_set_port(port);
+	if (rc)
+		return rc;
+
 	return -EOPNOTSUPP;
 }
 
@@ -207,13 +255,59 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 static int fsi_i2c_probe(struct device *dev)
 {
 	struct fsi_i2c_master *i2c;
-	int rc;
+	struct fsi_i2c_port *port;
+	struct device_node *np;
+	int rc, idx;
+	u32 port_no;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
 	i2c->fsi = to_fsi_dev(dev);
+	i2c->idx = ida_simple_get(&fsi_i2c_ida, 1, INT_MAX, GFP_KERNEL);
+	ida_init(&i2c->ida);
+	INIT_LIST_HEAD(&i2c->ports);
+
+	if (dev->of_node) {
+		/* add adapter for each i2c port of the master */
+		for_each_child_of_node(dev->of_node, np) {
+			rc = of_property_read_u32(np, "port", &port_no);
+			if (rc || port_no > 0xFFFF)
+				continue;
+
+			/* make sure we don't overlap index with a buggy dts */
+			idx = ida_simple_get(&i2c->ida, port_no,
+					     port_no + 1, GFP_KERNEL);
+			if (idx < 0)
+				continue;
+
+			port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+			if (!port)
+				return -ENOMEM;
+
+			port->master = i2c;
+			port->port = (u16)port_no;
+
+			port->adapter.owner = THIS_MODULE;
+			port->adapter.dev.parent = dev;
+			port->adapter.algo = &fsi_i2c_algorithm;
+			port->adapter.algo_data = port;
+			/* number ports uniquely */
+			port->adapter.nr = (i2c->idx * I2C_MASTER_NR_OFFSET) +
+				port_no;
+
+			snprintf(port->adapter.name,
+				 sizeof(port->adapter.name),
+				 "i2cp_fsi-%u", port_no);
+
+			rc = i2c_add_numbered_adapter(&port->adapter);
+			if (rc < 0)
+				return rc;
+
+			list_add(&port->list, &i2c->ports);
+		}
+	}
 
 	rc = fsi_i2c_dev_init(i2c);
 	if (rc)
@@ -224,6 +318,22 @@ static int fsi_i2c_probe(struct device *dev)
 	return 0;
 }
 
+static int fsi_i2c_remove(struct device *dev)
+{
+	struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
+	struct fsi_i2c_port *port;
+
+	list_for_each_entry(port, &i2c->ports, list) {
+		i2c_del_adapter(&port->adapter);
+	}
+
+	ida_destroy(&i2c->ida);
+
+	ida_simple_remove(&fsi_i2c_ida, i2c->idx);
+
+	return 0;
+}
+
 static const struct fsi_device_id fsi_i2c_ids[] = {
 	{ FSI_ENGID_I2C, FSI_VERSION_ANY },
 	{ 0 }
@@ -235,6 +345,7 @@ static int fsi_i2c_probe(struct device *dev)
 		.name = "i2cm-fsi",
 		.bus = &fsi_bus_type,
 		.probe = fsi_i2c_probe,
+		.remove = fsi_i2c_remove,
 	},
 };
 
-- 
1.8.3.1
