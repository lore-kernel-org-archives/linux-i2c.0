From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v4 2/6] drivers/i2c: Add port structure to FSI algorithm
Date: Mon, 17 Jul 2017 09:35:53 -0500
Message-ID: <1500302157-14670-3-git-send-email-eajames@linux.vnet.ibm.com>
References: <1500302157-14670-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34045 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751403AbdGQOhY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 17 Jul 2017 10:37:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6HEbE3l002872
        for <linux-i2c@vger.kernel.org>; Mon, 17 Jul 2017 10:37:23 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2brq7jn1wv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-i2c@vger.kernel.org>; Mon, 17 Jul 2017 10:37:15 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-i2c@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 17 Jul 2017 08:36:10 -0600
In-Reply-To: <1500302157-14670-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, eajames@linux.vnet.ibm.com, cbostic@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

From: "Edward A. James" <eajames@us.ibm.com>

Add and initialize I2C adapters for each port on the FSI-attached I2C
master. Ports for each master are defined in the devicetree.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index b7f2bc6..4b52147 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -14,7 +14,9 @@
 #include <linux/fsi.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #define FSI_ENGID_I2C		0x7
 
@@ -130,6 +132,14 @@
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
+	struct list_head	ports;
+};
+
+struct fsi_i2c_port {
+	struct list_head	list;
+	struct i2c_adapter	adapter;
+	struct fsi_i2c_master	*master;
+	u16			port;
 };
 
 static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
@@ -186,9 +196,44 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
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
 
@@ -205,13 +250,46 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 static int fsi_i2c_probe(struct device *dev)
 {
 	struct fsi_i2c_master *i2c;
+	struct fsi_i2c_port *port;
+	struct device_node *np;
 	int rc;
+	u32 port_no;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
 	i2c->fsi = to_fsi_dev(dev);
+	INIT_LIST_HEAD(&i2c->ports);
+
+	/* Add adapter for each i2c port of the master. */
+	for_each_available_child_of_node(dev->of_node, np) {
+		rc = of_property_read_u32(np, "reg", &port_no);
+		if (rc || port_no > USHRT_MAX)
+			continue;
+
+		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+		if (!port)
+			return -ENOMEM;
+
+		port->master = i2c;
+		port->port = port_no;
+
+		port->adapter.owner = THIS_MODULE;
+		port->adapter.dev.of_node = np;
+		port->adapter.dev.parent = dev;
+		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.algo_data = port;
+
+		snprintf(port->adapter.name, sizeof(port->adapter.name),
+			 "i2c_bus-%u", port_no);
+
+		rc = i2c_add_adapter(&port->adapter);
+		if (rc < 0)
+			return rc;
+
+		list_add(&port->list, &i2c->ports);
+	}
 
 	rc = fsi_i2c_dev_init(i2c);
 	if (rc)
@@ -222,6 +300,18 @@ static int fsi_i2c_probe(struct device *dev)
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
+	return 0;
+}
+
 static const struct fsi_device_id fsi_i2c_ids[] = {
 	{ FSI_ENGID_I2C, FSI_VERSION_ANY },
 	{ 0 }
@@ -233,6 +323,7 @@ static int fsi_i2c_probe(struct device *dev)
 		.name = "i2c-fsi",
 		.bus = &fsi_bus_type,
 		.probe = fsi_i2c_probe,
+		.remove = fsi_i2c_remove,
 	},
 };
 
-- 
1.8.3.1
