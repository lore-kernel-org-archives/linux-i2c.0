From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v11 6/8] i2c: fsi: Add I2C master locking
Date: Thu,  5 Jul 2018 13:40:28 -0500
Message-ID: <1530816030-13010-7-git-send-email-eajames@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se, Eddie James <eajames@linux.vnet.ibm.com>
List-Id: linux-i2c@vger.kernel.org

Since there are many ports per master, each with it's own adapter and
chardev, we need some locking to prevent transfers from changing the
master state while other transfers are in progress.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/i2c/busses/i2c-fsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 6cb4602..5520251 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 
@@ -148,6 +149,7 @@ struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
 	struct list_head	ports;
+	struct mutex		lock;
 };
 
 struct fsi_i2c_port {
@@ -486,11 +488,14 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	int i, rc;
 	unsigned long start_time;
 	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *master = port->master;
 	struct i2c_msg *msg;
 
+	mutex_lock(&master->lock);
+
 	rc = fsi_i2c_set_port(port);
 	if (rc)
-		return rc;
+		goto unlock;
 
 	for (i = 0; i < num; i++) {
 		msg = msgs + i;
@@ -498,15 +503,17 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		rc = fsi_i2c_start(port, msg, i == num - 1);
 		if (rc)
-			return rc;
+			goto unlock;
 
 		rc = fsi_i2c_wait(port, msg,
 				  adap->timeout - (jiffies - start_time));
 		if (rc)
-			return rc;
+			goto unlock;
 	}
 
-	return num;
+unlock:
+	mutex_unlock(&master->lock);
+	return rc ? : num;
 }
 
 static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
@@ -533,6 +540,7 @@ static int fsi_i2c_probe(struct device *dev)
 	if (!i2c)
 		return -ENOMEM;
 
+	mutex_init(&i2c->lock);
 	i2c->fsi = to_fsi_dev(dev);
 	INIT_LIST_HEAD(&i2c->ports);
 
-- 
1.8.3.1
