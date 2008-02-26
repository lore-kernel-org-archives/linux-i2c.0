From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-dev: Split i2cdev_ioctl
Date: Tue, 26 Feb 2008 15:27:14 +0100
Message-ID: <20080226152714.41bb9fe8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Split the handling of the I2C_RDWR and I2C_SMBUS ioctls to their own
functions. This saves one level of indentation and makes the code more
readable.

Originally I did this to limit the stack usage, however gcc cleverly
inlines the split functions anyway so it doesn't help at all. Still, I
think that the change is worth keeping for the increased readability.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |  327 +++++++++++++++++++++++++------------------------
 1 file changed, 167 insertions(+), 160 deletions(-)

--- linux-2.6.25-rc3.orig/drivers/i2c/i2c-dev.c	2008-02-26 14:36:23.000000000 +0100
+++ linux-2.6.25-rc3/drivers/i2c/i2c-dev.c	2008-02-26 14:41:28.000000000 +0100
@@ -200,16 +200,176 @@ static int i2cdev_check_addr(struct i2c_
 	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
 }
 
-static int i2cdev_ioctl(struct inode *inode, struct file *file,
+static int i2cdev_ioctl_rdrw(struct i2c_client *client,
 		unsigned int cmd, unsigned long arg)
 {
-	struct i2c_client *client = (struct i2c_client *)file->private_data;
 	struct i2c_rdwr_ioctl_data rdwr_arg;
-	struct i2c_smbus_ioctl_data data_arg;
-	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
 	u8 __user **data_ptrs;
-	int i,datasize,res;
+	int i, res;
+
+	if (copy_from_user(&rdwr_arg,
+			   (struct i2c_rdwr_ioctl_data __user *)arg,
+			   sizeof(rdwr_arg)))
+		return -EFAULT;
+
+	/* Put an arbitrary limit on the number of messages that can
+	 * be sent at once */
+	if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
+		return -EINVAL;
+
+	rdwr_pa = (struct i2c_msg *)
+		kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
+		GFP_KERNEL);
+	if (!rdwr_pa)
+		return -ENOMEM;
+
+	if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+			   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
+		kfree(rdwr_pa);
+		return -EFAULT;
+	}
+
+	data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
+	if (data_ptrs == NULL) {
+		kfree(rdwr_pa);
+		return -ENOMEM;
+	}
+
+	res = 0;
+	for (i = 0; i < rdwr_arg.nmsgs; i++) {
+		/* Limit the size of the message to a sane amount;
+		 * and don't let length change either. */
+		if ((rdwr_pa[i].len > 8192) ||
+		    (rdwr_pa[i].flags & I2C_M_RECV_LEN)) {
+			res = -EINVAL;
+			break;
+		}
+		data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
+		rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
+		if (rdwr_pa[i].buf == NULL) {
+			res = -ENOMEM;
+			break;
+		}
+		if (copy_from_user(rdwr_pa[i].buf, data_ptrs[i],
+				   rdwr_pa[i].len)) {
+				++i; /* Needs to be kfreed too */
+				res = -EFAULT;
+			break;
+		}
+	}
+	if (res < 0) {
+		int j;
+		for (j = 0; j < i; ++j)
+			kfree(rdwr_pa[j].buf);
+		kfree(data_ptrs);
+		kfree(rdwr_pa);
+		return res;
+	}
+
+	res = i2c_transfer(client->adapter, rdwr_pa, rdwr_arg.nmsgs);
+	while (i-- > 0) {
+		if (res >= 0 && (rdwr_pa[i].flags & I2C_M_RD)) {
+			if (copy_to_user(data_ptrs[i], rdwr_pa[i].buf,
+					 rdwr_pa[i].len))
+				res = -EFAULT;
+		}
+		kfree(rdwr_pa[i].buf);
+	}
+	kfree(data_ptrs);
+	kfree(rdwr_pa);
+	return res;
+}
+
+static int i2cdev_ioctl_smbus(struct i2c_client *client,
+		unsigned int cmd, unsigned long arg)
+{
+	struct i2c_smbus_ioctl_data data_arg;
+	union i2c_smbus_data temp;
+	int datasize, res;
+
+	if (copy_from_user(&data_arg,
+			   (struct i2c_smbus_ioctl_data __user *) arg,
+			   sizeof(struct i2c_smbus_ioctl_data)))
+		return -EFAULT;
+	if ((data_arg.size != I2C_SMBUS_BYTE) &&
+	    (data_arg.size != I2C_SMBUS_QUICK) &&
+	    (data_arg.size != I2C_SMBUS_BYTE_DATA) &&
+	    (data_arg.size != I2C_SMBUS_WORD_DATA) &&
+	    (data_arg.size != I2C_SMBUS_PROC_CALL) &&
+	    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
+	    (data_arg.size != I2C_SMBUS_I2C_BLOCK_BROKEN) &&
+	    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
+	    (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
+		dev_dbg(&client->adapter->dev,
+			"size out of range (%x) in ioctl I2C_SMBUS.\n",
+			data_arg.size);
+		return -EINVAL;
+	}
+	/* Note that I2C_SMBUS_READ and I2C_SMBUS_WRITE are 0 and 1,
+	   so the check is valid if size==I2C_SMBUS_QUICK too. */
+	if ((data_arg.read_write != I2C_SMBUS_READ) &&
+	    (data_arg.read_write != I2C_SMBUS_WRITE)) {
+		dev_dbg(&client->adapter->dev,
+			"read_write out of range (%x) in ioctl I2C_SMBUS.\n",
+			data_arg.read_write);
+		return -EINVAL;
+	}
+
+	/* Note that command values are always valid! */
+
+	if ((data_arg.size == I2C_SMBUS_QUICK) ||
+	    ((data_arg.size == I2C_SMBUS_BYTE) &&
+	    (data_arg.read_write == I2C_SMBUS_WRITE)))
+		/* These are special: we do not use data */
+		return i2c_smbus_xfer(client->adapter, client->addr,
+				      client->flags, data_arg.read_write,
+				      data_arg.command, data_arg.size, NULL);
+
+	if (data_arg.data == NULL) {
+		dev_dbg(&client->adapter->dev,
+			"data is NULL pointer in ioctl I2C_SMBUS.\n");
+		return -EINVAL;
+	}
+
+	if ((data_arg.size == I2C_SMBUS_BYTE_DATA) ||
+	    (data_arg.size == I2C_SMBUS_BYTE))
+		datasize = sizeof(data_arg.data->byte);
+	else if ((data_arg.size == I2C_SMBUS_WORD_DATA) ||
+		 (data_arg.size == I2C_SMBUS_PROC_CALL))
+		datasize = sizeof(data_arg.data->word);
+	else /* size == smbus block, i2c block, or block proc. call */
+		datasize = sizeof(data_arg.data->block);
+
+	if ((data_arg.size == I2C_SMBUS_PROC_CALL) ||
+	    (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) ||
+	    (data_arg.size == I2C_SMBUS_I2C_BLOCK_DATA) ||
+	    (data_arg.read_write == I2C_SMBUS_WRITE)) {
+		if (copy_from_user(&temp, data_arg.data, datasize))
+			return -EFAULT;
+	}
+	if (data_arg.size == I2C_SMBUS_I2C_BLOCK_BROKEN) {
+		/* Convert old I2C block commands to the new
+		   convention. This preserves binary compatibility. */
+		data_arg.size = I2C_SMBUS_I2C_BLOCK_DATA;
+		if (data_arg.read_write == I2C_SMBUS_READ)
+			temp.block[0] = I2C_SMBUS_BLOCK_MAX;
+	}
+	res = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+	      data_arg.read_write, data_arg.command, data_arg.size, &temp);
+	if (!res && ((data_arg.size == I2C_SMBUS_PROC_CALL) ||
+		     (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) ||
+		     (data_arg.read_write == I2C_SMBUS_READ))) {
+		if (copy_to_user(data_arg.data, &temp, datasize))
+			return -EFAULT;
+	}
+	return res;
+}
+
+static int i2cdev_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct i2c_client *client = (struct i2c_client *)file->private_data;
 	unsigned long funcs;
 
 	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
@@ -253,164 +413,11 @@ static int i2cdev_ioctl(struct inode *in
 		return put_user(funcs, (unsigned long __user *)arg);
 
 	case I2C_RDWR:
-		if (copy_from_user(&rdwr_arg,
-				   (struct i2c_rdwr_ioctl_data __user *)arg,
-				   sizeof(rdwr_arg)))
-			return -EFAULT;
-
-		/* Put an arbitrary limit on the number of messages that can
-		 * be sent at once */
-		if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
-			return -EINVAL;
-
-		rdwr_pa = (struct i2c_msg *)
-			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
-			GFP_KERNEL);
-
-		if (rdwr_pa == NULL) return -ENOMEM;
-
-		if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
-				   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
-			kfree(rdwr_pa);
-			return -EFAULT;
-		}
-
-		data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
-		if (data_ptrs == NULL) {
-			kfree(rdwr_pa);
-			return -ENOMEM;
-		}
-
-		res = 0;
-		for( i=0; i<rdwr_arg.nmsgs; i++ ) {
-			/* Limit the size of the message to a sane amount;
-			 * and don't let length change either. */
-			if ((rdwr_pa[i].len > 8192) ||
-			    (rdwr_pa[i].flags & I2C_M_RECV_LEN)) {
-				res = -EINVAL;
-				break;
-			}
-			data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
-			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
-			if(rdwr_pa[i].buf == NULL) {
-				res = -ENOMEM;
-				break;
-			}
-			if(copy_from_user(rdwr_pa[i].buf,
-				data_ptrs[i],
-				rdwr_pa[i].len)) {
-					++i; /* Needs to be kfreed too */
-					res = -EFAULT;
-				break;
-			}
-		}
-		if (res < 0) {
-			int j;
-			for (j = 0; j < i; ++j)
-				kfree(rdwr_pa[j].buf);
-			kfree(data_ptrs);
-			kfree(rdwr_pa);
-			return res;
-		}
-
-		res = i2c_transfer(client->adapter,
-			rdwr_pa,
-			rdwr_arg.nmsgs);
-		while(i-- > 0) {
-			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
-				if(copy_to_user(
-					data_ptrs[i],
-					rdwr_pa[i].buf,
-					rdwr_pa[i].len)) {
-					res = -EFAULT;
-				}
-			}
-			kfree(rdwr_pa[i].buf);
-		}
-		kfree(data_ptrs);
-		kfree(rdwr_pa);
-		return res;
+		return i2cdev_ioctl_rdrw(client, cmd, arg);
 
 	case I2C_SMBUS:
-		if (copy_from_user(&data_arg,
-		                   (struct i2c_smbus_ioctl_data __user *) arg,
-		                   sizeof(struct i2c_smbus_ioctl_data)))
-			return -EFAULT;
-		if ((data_arg.size != I2C_SMBUS_BYTE) &&
-		    (data_arg.size != I2C_SMBUS_QUICK) &&
-		    (data_arg.size != I2C_SMBUS_BYTE_DATA) &&
-		    (data_arg.size != I2C_SMBUS_WORD_DATA) &&
-		    (data_arg.size != I2C_SMBUS_PROC_CALL) &&
-		    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
-		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_BROKEN) &&
-		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
-		    (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
-			dev_dbg(&client->adapter->dev,
-				"size out of range (%x) in ioctl I2C_SMBUS.\n",
-				data_arg.size);
-			return -EINVAL;
-		}
-		/* Note that I2C_SMBUS_READ and I2C_SMBUS_WRITE are 0 and 1,
-		   so the check is valid if size==I2C_SMBUS_QUICK too. */
-		if ((data_arg.read_write != I2C_SMBUS_READ) &&
-		    (data_arg.read_write != I2C_SMBUS_WRITE)) {
-			dev_dbg(&client->adapter->dev,
-				"read_write out of range (%x) in ioctl I2C_SMBUS.\n",
-				data_arg.read_write);
-			return -EINVAL;
-		}
-
-		/* Note that command values are always valid! */
-
-		if ((data_arg.size == I2C_SMBUS_QUICK) ||
-		    ((data_arg.size == I2C_SMBUS_BYTE) &&
-		    (data_arg.read_write == I2C_SMBUS_WRITE)))
-			/* These are special: we do not use data */
-			return i2c_smbus_xfer(client->adapter, client->addr,
-					      client->flags,
-					      data_arg.read_write,
-					      data_arg.command,
-					      data_arg.size, NULL);
-
-		if (data_arg.data == NULL) {
-			dev_dbg(&client->adapter->dev,
-				"data is NULL pointer in ioctl I2C_SMBUS.\n");
-			return -EINVAL;
-		}
+		return i2cdev_ioctl_smbus(client, cmd, arg);
 
-		if ((data_arg.size == I2C_SMBUS_BYTE_DATA) ||
-		    (data_arg.size == I2C_SMBUS_BYTE))
-			datasize = sizeof(data_arg.data->byte);
-		else if ((data_arg.size == I2C_SMBUS_WORD_DATA) ||
-		         (data_arg.size == I2C_SMBUS_PROC_CALL))
-			datasize = sizeof(data_arg.data->word);
-		else /* size == smbus block, i2c block, or block proc. call */
-			datasize = sizeof(data_arg.data->block);
-
-		if ((data_arg.size == I2C_SMBUS_PROC_CALL) ||
-		    (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) ||
-		    (data_arg.size == I2C_SMBUS_I2C_BLOCK_DATA) ||
-		    (data_arg.read_write == I2C_SMBUS_WRITE)) {
-			if (copy_from_user(&temp, data_arg.data, datasize))
-				return -EFAULT;
-		}
-		if (data_arg.size == I2C_SMBUS_I2C_BLOCK_BROKEN) {
-			/* Convert old I2C block commands to the new
-			   convention. This preserves binary compatibility. */
-			data_arg.size = I2C_SMBUS_I2C_BLOCK_DATA;
-			if (data_arg.read_write == I2C_SMBUS_READ)
-				temp.block[0] = I2C_SMBUS_BLOCK_MAX;
-		}
-		res = i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-		      data_arg.read_write,
-		      data_arg.command,data_arg.size,&temp);
-		if (! res && ((data_arg.size == I2C_SMBUS_PROC_CALL) ||
-		              (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) ||
-			      (data_arg.read_write == I2C_SMBUS_READ))) {
-			if (copy_to_user(data_arg.data, &temp, datasize))
-				return -EFAULT;
-		}
-		return res;
 	case I2C_RETRIES:
 		client->adapter->retries = arg;
 		break;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
