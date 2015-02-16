From: Christian ROSALIE <christian.rosalie-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Issue with USB/i2C
Date: Mon, 16 Feb 2015 17:33:35 +0100
Message-ID: <54E21BDF.9050108@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070409080807060109050605"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--------------070409080807060109050605
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've got an issue with and USB/i2c device when i plug and unplug several 
times the usb device with a user-application using /dev/i2c-* file the 
kernel crashes because the data containing the struct i2c_adapter has 
been dealocated.

In the probe function of my driver, i allocates my resource (an internal 
structure) that contains a struct i2c_adapter with the struct 
i2c_algorithm. In my disconnect function i unregister the i2c adapter 
and then i free the ressource. Take not that i use kref design patern to 
prevent free data that are still used.

I look deeper in the i2c-dev (even on 3.19 release) and i notice that 
the callback function in the struct file_operations use struct 
i2c_client with an reference on a struct i2c_adapter and there is no 
mechanism to be sure that this reference has not be deallocated.

When i unplug my usb-device, i unregister my i2c-adapter but my 
user-space application still hold a file descriptor with a struc 
i2c_client that point to an struct i2c_adapter already freed.


I try to make a lock mechanism by adding a wait queue in the struct 
i2c_dev, to be sure that the adapter is no more used after a call to 
i2c_del_adapter, but it does not work and most of the time put the 
kernel in a dead lock.

To conclude it is not a good solution (not safe) to lock in 
i2c_del_adapter, because if the usb device is plugged again before the 
user-space application use the file descriptor the kernel is locked. A 
thread is holding core_lock mutex calling __process_removed_adapter 
waiting for a call on release to unlock the wait_queue while another 
trying to register the new adapter is locked on core_lock mutex.

I enclose my patch with this mail, knowing that it is a bad solution.
Does anyone with a better knowledge on i2c-core has a working solution 
to this issue?

Christian ROSALIE

--------------070409080807060109050605
Content-Type: text/x-diff; name="i2c-dev_d16-02-2015.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="i2c-dev_d16-02-2015.patch"

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 71c7a39..1754795 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -47,20 +47,32 @@ struct i2c_dev {
 	struct list_head list;
 	struct i2c_adapter *adap;
 	struct device *dev;
+
+	wait_queue_head_t crelease;
+	atomic_t ccount; /* client counter */
+	atomic_t detach; /* detach is pending */
 };
 
 #define I2C_MINORS	256
 static LIST_HEAD(i2c_dev_list);
 static DEFINE_SPINLOCK(i2c_dev_list_lock);
 
-static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
+#define i2c_dev_get_by_minor(index) __i2c_dev_get_by_minor(index, 0)
+
+static struct i2c_dev *__i2c_dev_get_by_minor(unsigned index, unsigned detach)
 {
 	struct i2c_dev *i2c_dev;
 
 	spin_lock(&i2c_dev_list_lock);
 	list_for_each_entry(i2c_dev, &i2c_dev_list, list) {
-		if (i2c_dev->adap->nr == index)
+		if (i2c_dev->adap->nr == index) {
+			if (detach) {
+				/* detach is pending */
+				atomic_set(&i2c_dev->detach, 1);
+			}
+
 			goto found;
+		}
 	}
 	i2c_dev = NULL;
 found:
@@ -82,6 +94,9 @@ static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 	if (!i2c_dev)
 		return ERR_PTR(-ENOMEM);
 	i2c_dev->adap = adap;
+	atomic_set(&i2c_dev->ccount, 0);
+	atomic_set(&i2c_dev->detach, 0);
+	init_waitqueue_head(&i2c_dev->crelease);
 
 	spin_lock(&i2c_dev_list_lock);
 	list_add_tail(&i2c_dev->list, &i2c_dev_list);
@@ -94,6 +109,7 @@ static void return_i2c_dev(struct i2c_dev *i2c_dev)
 	spin_lock(&i2c_dev_list_lock);
 	list_del(&i2c_dev->list);
 	spin_unlock(&i2c_dev_list_lock);
+
 	kfree(i2c_dev);
 }
 
@@ -492,6 +508,15 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	if (!i2c_dev)
 		return -ENODEV;
 
+	/* detach is pending
+	   no more client is allowed */
+	if (atomic_read(&i2c_dev->detach)) {
+		return -ENODEV;
+	}
+
+	atomic_inc(&i2c_dev->ccount);
+
+
 	adap = i2c_get_adapter(i2c_dev->adap->nr);
 	if (!adap)
 		return -ENODEV;
@@ -505,6 +530,7 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	 */
 	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client) {
+		atomic_dec(&i2c_dev->ccount);
 		i2c_put_adapter(adap);
 		return -ENOMEM;
 	}
@@ -513,14 +539,26 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	client->adapter = adap;
 	file->private_data = client;
 
+
 	return 0;
 }
 
 static int i2cdev_release(struct inode *inode, struct file *file)
 {
 	struct i2c_client *client = file->private_data;
+	struct i2c_dev *i2c_dev;
 
 	i2c_put_adapter(client->adapter);
+
+	i2c_dev = i2c_dev_get_by_minor(client->adapter->nr);
+
+	if (i2c_dev) {
+		if (atomic_dec_and_test(&i2c_dev->ccount)) {
+			/* wake up wait queue if necessary */
+			wake_up_interruptible(&i2c_dev->crelease);
+		}
+	}
+
 	kfree(client);
 	file->private_data = NULL;
 
@@ -581,10 +619,17 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 		return 0;
 	adap = to_i2c_adapter(dev);
 
-	i2c_dev = i2c_dev_get_by_minor(adap->nr);
+	i2c_dev = __i2c_dev_get_by_minor(adap->nr, 1);
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
+	device_remove_file(i2c_dev->dev, &dev_attr_name);
+
+	/* wait that every client registered has released
+	   their reference to the adapter */
+	wait_event_interruptible(i2c_dev->crelease,
+				!atomic_read(&i2c_dev->ccount));
+
 	return_i2c_dev(i2c_dev);
 	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 

--------------070409080807060109050605--
