From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-git] i2c: correct some size_t printk formats
Date: Sat, 26 Jul 2008 21:38:27 -0700
Message-ID: <200807262138.27799.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Fix various printk format strings where %zd was passed a size_t;
those should be %zu instead.  (Courtesy of a version of GCC which
warns when these details are wrong.)

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/chips/at24.c |    8 ++++----
 drivers/i2c/i2c-dev.c    |    4 ++--

--- a/drivers/i2c/chips/at24.c	2008-07-26 21:05:14.000000000 -0700
+++ b/drivers/i2c/chips/at24.c	2008-07-26 21:05:26.000000000 -0700
@@ -188,7 +188,7 @@ static ssize_t at24_eeprom_read(struct a
 			count = I2C_SMBUS_BLOCK_MAX;
 		status = i2c_smbus_read_i2c_block_data(client, offset,
 				count, buf);
-		dev_dbg(&client->dev, "smbus read %zd@%d --> %d\n",
+		dev_dbg(&client->dev, "smbus read %zu@%d --> %d\n",
 				count, offset, status);
 		return (status < 0) ? -EIO : status;
 	}
@@ -214,7 +214,7 @@ static ssize_t at24_eeprom_read(struct a
 	msg[1].len = count;
 
 	status = i2c_transfer(client->adapter, msg, 2);
-	dev_dbg(&client->dev, "i2c read %zd@%d --> %d\n",
+	dev_dbg(&client->dev, "i2c read %zu@%d --> %d\n",
 			count, offset, status);
 
 	if (status == 2)
@@ -334,7 +334,7 @@ static ssize_t at24_eeprom_write(struct 
 			if (status == 1)
 				status = count;
 		}
-		dev_dbg(&client->dev, "write %zd@%d --> %zd (%ld)\n",
+		dev_dbg(&client->dev, "write %zu@%d --> %zd (%ld)\n",
 				count, offset, status, jiffies);
 
 		if (status == count)
@@ -512,7 +512,7 @@ static int at24_probe(struct i2c_client 
 
 	i2c_set_clientdata(client, at24);
 
-	dev_info(&client->dev, "%Zd byte %s EEPROM %s\n",
+	dev_info(&client->dev, "%zu byte %s EEPROM %s\n",
 		at24->bin.size, client->name,
 		writable ? "(writable)" : "(read-only)");
 	dev_dbg(&client->dev,
--- a/drivers/i2c/i2c-dev.c	2008-07-26 21:05:14.000000000 -0700
+++ b/drivers/i2c/i2c-dev.c	2008-07-26 21:05:26.000000000 -0700
@@ -147,7 +147,7 @@ static ssize_t i2cdev_read (struct file 
 	if (tmp==NULL)
 		return -ENOMEM;
 
-	pr_debug("i2c-dev: i2c-%d reading %zd bytes.\n",
+	pr_debug("i2c-dev: i2c-%d reading %zu bytes.\n",
 		iminor(file->f_path.dentry->d_inode), count);
 
 	ret = i2c_master_recv(client,tmp,count);
@@ -175,7 +175,7 @@ static ssize_t i2cdev_write (struct file
 		return -EFAULT;
 	}
 
-	pr_debug("i2c-dev: i2c-%d writing %zd bytes.\n",
+	pr_debug("i2c-dev: i2c-%d writing %zu bytes.\n",
 		iminor(file->f_path.dentry->d_inode), count);
 
 	ret = i2c_master_send(client,tmp,count);

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
