From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v6 7/7] drivers/i2c: Add bus recovery for FSI algorithm
Date: Thu, 16 Nov 2017 13:53:52 -0600
Message-ID: <1510862032-12394-8-git-send-email-eajames@linux.vnet.ibm.com>
References: <1510862032-12394-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758467AbdKPTy1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Nov 2017 14:54:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAGJsNiQ002687
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 14:54:26 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e9gwm8xvu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-i2c@vger.kernel.org>; Thu, 16 Nov 2017 14:54:26 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-i2c@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 12:54:24 -0700
In-Reply-To: <1510862032-12394-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, joel@jms.id.au, eajames@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

From: "Edward A. James" <eajames@us.ibm.com>

Bus recovery should reset the engine and force clock the bus 9 times
to recover most situations.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 1751c44..10f693f 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -671,6 +671,27 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 		| I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+static int fsi_i2c_recover_bus(struct i2c_adapter *adap)
+{
+	int rc;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *master = port->master;
+
+	rc = fsi_i2c_lock_master(master, adap->timeout);
+	if (rc)
+		return rc;
+
+	rc = fsi_i2c_reset(master, port->port);
+
+	fsi_i2c_unlock_master(master);
+
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
@@ -715,6 +736,7 @@ static int fsi_i2c_probe(struct device *dev)
 		port->adapter.dev.of_node = np;
 		port->adapter.dev.parent = dev;
 		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.bus_recovery_info = &fsi_i2c_bus_recovery_info;
 		port->adapter.algo_data = port;
 
 		snprintf(port->adapter.name, sizeof(port->adapter.name),
-- 
1.8.3.1
