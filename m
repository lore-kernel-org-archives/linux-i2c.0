From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Tue,  5 Jul 2016 19:57:07 -0700
Message-ID: <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34852 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcGFC5P (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 22:57:15 -0400
Received: by mail-pf0-f172.google.com with SMTP id c2so75744599pfa.2
        for <linux-i2c@vger.kernel.org>; Tue, 05 Jul 2016 19:57:15 -0700 (PDT)
In-Reply-To: <cover.1467772840.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1467772840.git.viresh.kumar@linaro.org>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

The i2c-dev calls i2c_get_adapter() from the .open() callback, which
doesn't let the adapter device unregister unless the .close() callback
is called.

On some platforms (like Google ARA), this doesn't let the modules
(hardware attached to the phone) eject from the phone as the cleanup
path for the module hasn't finished yet (i2c adapter not removed).

We can't let the userspace block the kernel forever in such cases.

Fix this by calling i2c_get_adapter() from all other file operations,
i.e.  read/write/ioctl, to make sure the adapter doesn't get away while
we are in the middle of a operation, but not otherwise. In .open() we
will release the adapter device before returning and so if there is no
data transfer in progress, then the i2c-dev doesn't block the adapter
from unregistering.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/i2c/i2c-dev.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/i2c.h   |  1 +
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 66f323fd3982..b2562603daa9 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -142,13 +142,25 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
 	int ret;
 
 	struct i2c_client *client = file->private_data;
+	struct i2c_adapter *adap;
+
+	adap = i2c_get_adapter(client->adapter_nr);
+	if (!adap)
+		return -ENODEV;
+
+	if (adap != client->adapter) {
+		ret = -EINVAL;
+		goto put_adapter;
+	}
 
 	if (count > 8192)
 		count = 8192;
 
 	tmp = kmalloc(count, GFP_KERNEL);
-	if (tmp == NULL)
-		return -ENOMEM;
+	if (tmp == NULL) {
+		ret = -ENOMEM;
+		goto put_adapter;
+	}
 
 	pr_debug("i2c-dev: i2c-%d reading %zu bytes.\n",
 		iminor(file_inode(file)), count);
@@ -157,6 +169,9 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
 	if (ret >= 0)
 		ret = copy_to_user(buf, tmp, count) ? -EFAULT : ret;
 	kfree(tmp);
+
+put_adapter:
+	i2c_put_adapter(adap);
 	return ret;
 }
 
@@ -166,19 +181,34 @@ static ssize_t i2cdev_write(struct file *file, const char __user *buf,
 	int ret;
 	char *tmp;
 	struct i2c_client *client = file->private_data;
+	struct i2c_adapter *adap;
+
+	adap = i2c_get_adapter(client->adapter_nr);
+	if (!adap)
+		return -ENODEV;
+
+	if (adap != client->adapter) {
+		ret = -EINVAL;
+		goto put_adapter;
+	}
 
 	if (count > 8192)
 		count = 8192;
 
 	tmp = memdup_user(buf, count);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
+	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
+		goto put_adapter;
+	}
 
 	pr_debug("i2c-dev: i2c-%d writing %zu bytes.\n",
 		iminor(file_inode(file)), count);
 
 	ret = i2c_master_send(client, tmp, count);
 	kfree(tmp);
+
+put_adapter:
+	i2c_put_adapter(adap);
 	return ret;
 }
 
@@ -412,9 +442,9 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
 	return res;
 }
 
-static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long __i2cdev_ioctl(struct i2c_client *client, unsigned int cmd,
+			   unsigned long arg)
 {
-	struct i2c_client *client = file->private_data;
 	unsigned long funcs;
 
 	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
@@ -480,6 +510,28 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
+static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i2c_client *client = file->private_data;
+	struct i2c_adapter *adap;
+	unsigned long ret;
+
+	adap = i2c_get_adapter(client->adapter_nr);
+	if (!adap)
+		return -ENODEV;
+
+	if (adap != client->adapter) {
+		ret = -EINVAL;
+		goto put_adapter;
+	}
+
+	ret = __i2cdev_ioctl(client, cmd, arg);
+
+put_adapter:
+	i2c_put_adapter(adap);
+	return ret;
+}
+
 static int i2cdev_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
@@ -504,9 +556,16 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	}
 	snprintf(client->name, I2C_NAME_SIZE, "i2c-dev %d", adap->nr);
 
+	client->adapter_nr = minor;
 	client->adapter = adap;
 	file->private_data = client;
 
+	/*
+	 * Allow the adapter to unregister while userspace has opened the i2c
+	 * device.
+	 */
+	i2c_put_adapter(client->adapter);
+
 	return 0;
 }
 
@@ -514,7 +573,6 @@ static int i2cdev_release(struct inode *inode, struct file *file)
 {
 	struct i2c_client *client = file->private_data;
 
-	i2c_put_adapter(client->adapter);
 	kfree(client);
 	file->private_data = NULL;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fffdc270ca18..38c8fe8ca681 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -234,6 +234,7 @@ struct i2c_client {
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device		*/
+	int adapter_nr;
 	struct list_head detected;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
-- 
2.7.4
