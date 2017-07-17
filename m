From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 3/6] drivers/i2c: Add transfer implementation for FSI algorithm
Date: Mon, 17 Jul 2017 09:35:54 -0500
Message-ID: <1500302157-14670-4-git-send-email-eajames@linux.vnet.ibm.com>
References: <1500302157-14670-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500302157-14670-1-git-send-email-eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, cbostic-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Execute I2C transfers from the FSI-attached I2C master. Use polling
instead of interrupts as we have no hardware IRQ over FSI.

Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-fsi.c | 197 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 4b52147..f86595b 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -13,10 +13,12 @@
 #include <linux/errno.h>
 #include <linux/fsi.h>
 #include <linux/i2c.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/sched.h>
 
 #define FSI_ENGID_I2C		0x7
 
@@ -140,6 +142,7 @@ struct fsi_i2c_port {
 	struct i2c_adapter	adapter;
 	struct fsi_i2c_master	*master;
 	u16			port;
+	u16			xfrd;
 };
 
 static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
@@ -224,17 +227,207 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
 	return rc;
 }
 
+static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			 bool stop)
+{
+	int rc;
+	struct fsi_i2c_master *i2c = port->master;
+	u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
+
+	port->xfrd = 0;
+
+	if (msg->flags & I2C_M_RD)
+		cmd |= I2C_CMD_READ;
+
+	if (stop || msg->flags & I2C_M_STOP)
+		cmd |= I2C_CMD_WITH_STOP;
+
+	cmd = SETFIELD(I2C_CMD_ADDR, cmd, msg->addr >> 1);
+	cmd = SETFIELD(I2C_CMD_LEN, cmd, msg->len);
+
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, &cmd);
+
+	return rc;
+}
+
+static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			      u8 fifo_count)
+{
+	int write;
+	int rc = 0;
+	struct fsi_i2c_master *i2c = port->master;
+	int bytes_to_write = i2c->fifo_size - fifo_count;
+	int bytes_remaining = msg->len - port->xfrd;
+
+	if (bytes_to_write > bytes_remaining)
+		bytes_to_write = bytes_remaining;
+
+	while (bytes_to_write > 0) {
+		write = bytes_to_write;
+		/* fsi limited to max 4 byte aligned ops */
+		if (bytes_to_write > 4)
+			write = 4;
+		else if (write == 3)
+			write = 2;
+
+		rc = fsi_device_write(i2c->fsi, I2C_FSI_FIFO,
+				      &msg->buf[port->xfrd], write);
+		if (rc)
+			return rc;
+
+		port->xfrd += write;
+		bytes_to_write -= write;
+	}
+
+	return rc;
+}
+
+static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			     u8 fifo_count)
+{
+	int read;
+	int rc = 0;
+	struct fsi_i2c_master *i2c = port->master;
+	int xfr_remaining = msg->len - port->xfrd;
+	u32 dummy;
+
+	while (fifo_count) {
+		read = fifo_count;
+		/* fsi limited to max 4 byte aligned ops */
+		if (fifo_count > 4)
+			read = 4;
+		else if (read == 3)
+			read = 2;
+
+		if (xfr_remaining) {
+			if (xfr_remaining < read)
+				read = xfr_remaining;
+
+			rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO,
+					     &msg->buf[port->xfrd], read);
+			if (rc)
+				return rc;
+
+			port->xfrd += read;
+			xfr_remaining -= read;
+		} else {
+			/* no more buffer but data in fifo, need to clear it */
+			rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO, &dummy,
+					     read);
+			if (rc)
+				return rc;
+		}
+
+		fifo_count -= read;
+	}
+
+	return rc;
+}
+
+static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
+				 struct i2c_msg *msg, u32 status)
+{
+	int rc;
+	u8 fifo_count;
+	struct fsi_i2c_master *i2c = port->master;
+	u32 dummy = 0;
+
+	if (status & I2C_STAT_ERR) {
+		rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
+		if (rc)
+			return rc;
+
+		if (status & I2C_STAT_NACK)
+			return -EFAULT;
+
+		return -EIO;
+	}
+
+	if (status & I2C_STAT_DAT_REQ) {
+		fifo_count = GETFIELD(I2C_STAT_FIFO_COUNT, status);
+
+		if (msg->flags & I2C_M_RD)
+			rc = fsi_i2c_read_fifo(port, msg, fifo_count);
+		else
+			rc = fsi_i2c_write_fifo(port, msg, fifo_count);
+
+		return rc;
+	}
+
+	if (status & I2C_STAT_CMD_COMP) {
+		if (port->xfrd < msg->len)
+			rc = -ENODATA;
+		else
+			rc = msg->len;
+
+		return rc;
+	}
+
+	return 0;
+}
+
+static int fsi_i2c_wait(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			unsigned long timeout)
+{
+	const unsigned long local_timeout = 2; /* jiffies */
+	u32 status = 0;
+	int rc;
+
+	do {
+		rc = fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT,
+				      &status);
+		if (rc)
+			return rc;
+
+		if (status & I2C_STAT_ANY_RESP) {
+			rc = fsi_i2c_handle_status(port, msg, status);
+			if (rc < 0)
+				return rc;
+
+			/* cmd complete and all data xfrd */
+			if (rc == msg->len)
+				return 0;
+
+			/* need to xfr more data, but maybe don't need wait */
+			continue;
+		}
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(local_timeout);
+		timeout = (timeout < local_timeout) ? 0 :
+			timeout - local_timeout;
+	} while (timeout);
+
+	return -ETIME;
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
-	int rc;
+	int i, rc;
+	unsigned long start_time;
 	struct fsi_i2c_port *port = adap->algo_data;
+	struct i2c_msg *msg;
 
 	rc = fsi_i2c_set_port(port);
 	if (rc)
 		return rc;
 
-	return -EOPNOTSUPP;
+	for (i = 0; i < num; ++i) {
+		msg = msgs + i;
+		start_time = jiffies;
+
+		rc = fsi_i2c_start(port, msg, i == num - 1);
+		if (rc)
+			return rc;
+
+		rc = fsi_i2c_wait(port, msg,
+				  adap->timeout - (jiffies - start_time));
+		if (rc)
+			return rc;
+	}
+
+	return 0;
 }
 
 static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
