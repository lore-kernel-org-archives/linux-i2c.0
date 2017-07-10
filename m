From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 4/6] drivers/i2c: Add I2C master locking to FSI algorithm
Date: Mon, 10 Jul 2017 13:38:00 -0500
Message-ID: <1499711882-12918-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1499711882-12918-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499711882-12918-1-git-send-email-eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, cbostic-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Since there are many ports per master, each with it's own adapter and
chardev, we need some locking to prevent transfers from changing the\
master state while other transfers are in progress.

Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-fsi.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index f86595b..1c7fcae 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -19,6 +19,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/sched.h>
+#include <linux/semaphore.h>
+#include <linux/wait.h>
 
 #define FSI_ENGID_I2C		0x7
 
@@ -135,6 +137,8 @@ struct fsi_i2c_master {
 	struct fsi_device	*fsi;
 	u8			fifo_size;
 	struct list_head	ports;
+	wait_queue_head_t	wait;
+	struct semaphore	lock;
 };
 
 struct fsi_i2c_port {
@@ -168,6 +172,29 @@ static int fsi_i2c_write_reg(struct fsi_device *fsi, unsigned int reg,
 	return fsi_device_write(fsi, reg, &data_be, sizeof(data_be));
 }
 
+static int fsi_i2c_lock_master(struct fsi_i2c_master *i2c, int timeout)
+{
+	int rc;
+
+	rc = down_trylock(&i2c->lock);
+	if (!rc)
+		return 0;
+
+	rc = wait_event_interruptible_timeout(i2c->wait,
+					      !down_trylock(&i2c->lock),
+					      timeout);
+	if (rc > 0)
+		return 0;
+
+	return -EBUSY;
+}
+
+static void fsi_i2c_unlock_master(struct fsi_i2c_master *i2c)
+{
+	up(&i2c->lock);
+	wake_up(&i2c->wait);
+}
+
 static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
 {
 	int rc;
@@ -409,25 +436,31 @@ static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct fsi_i2c_port *port = adap->algo_data;
 	struct i2c_msg *msg;
 
-	rc = fsi_i2c_set_port(port);
+	rc = fsi_i2c_lock_master(port->master, adap->timeout);
 	if (rc)
 		return rc;
 
+	rc = fsi_i2c_set_port(port);
+	if (rc)
+		goto unlock;
+
 	for (i = 0; i < num; ++i) {
 		msg = msgs + i;
 		start_time = jiffies;
 
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
 
-	return 0;
+unlock:
+	fsi_i2c_unlock_master(port->master);
+	return rc;
 }
 
 static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
@@ -452,6 +485,8 @@ static int fsi_i2c_probe(struct device *dev)
 	if (!i2c)
 		return -ENOMEM;
 
+	init_waitqueue_head(&i2c->wait);
+	sema_init(&i2c->lock, 1);
 	i2c->fsi = to_fsi_dev(dev);
 	INIT_LIST_HEAD(&i2c->ports);
 
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
