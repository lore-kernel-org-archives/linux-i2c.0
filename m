From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Wed, 24 Nov 2010 22:23:08 +0100
Message-ID: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Right now i2c adapter 5 becomes minor 5 allocated. This is fine as long
as no adapter becomes a number > 256 allocated.
The Sodavile PCI driver uses (devfn << 3 | pci_bar) to come up with an
unique adapter number. So the first i2c adapter has the number 720.
This patch introduces dynamic minor allocation so the minor first
registered i2c adapter will be zero, next one one and so on. The name
which is exported to userland remains the same i.e. /dev/i2c-10 for
adapter number 10 (but its minor number may be zero and not 10).
I don't consider this as an ABI change however if someone does I could
add make this a CONFIG_ option and migrate in a year or so. i2c-tools
for instance abort on adapter number > 255 so we have to change this
in order to get the big numbers working.
Since the minors are not allocated dynamically I lowered the number of
max i2c devices to 32 so I don't waste much memory for the allocation.
If one has more than 32 devices then we could increase this again :)

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |   54 ++++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index cec0f3b..57eda78 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -52,9 +52,10 @@ struct i2c_dev {
 	struct list_head list;
 	struct i2c_adapter *adap;
 	struct device *dev;
+	int minor;
 };
 
-#define I2C_MINORS	256
+#define I2C_MINORS	32
 static LIST_HEAD(i2c_dev_list);
 static DEFINE_SPINLOCK(i2c_dev_list_lock);
 
@@ -64,7 +65,7 @@ static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
 
 	spin_lock(&i2c_dev_list_lock);
 	list_for_each_entry(i2c_dev, &i2c_dev_list, list) {
-		if (i2c_dev->adap->nr == index)
+		if (i2c_dev->minor == index)
 			goto found;
 	}
 	i2c_dev = NULL;
@@ -73,22 +74,46 @@ found:
 	return i2c_dev;
 }
 
-static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
+static struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
 
-	if (adap->nr >= I2C_MINORS) {
-		printk(KERN_ERR "i2c-dev: Out of device minors (%d)\n",
-		       adap->nr);
-		return ERR_PTR(-ENODEV);
+	spin_lock(&i2c_dev_list_lock);
+	list_for_each_entry(i2c_dev, &i2c_dev_list, list) {
+		if (i2c_dev->adap == adap)
+			goto found;
 	}
+	i2c_dev = NULL;
+found:
+	spin_unlock(&i2c_dev_list_lock);
+	return i2c_dev;
+}
+
+static DECLARE_BITMAP(minors, I2C_MINORS);
+
+static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
+{
+	struct i2c_dev *i2c_dev;
+	int minor;
+	int ret = 0;
 
 	i2c_dev = kzalloc(sizeof(*i2c_dev), GFP_KERNEL);
 	if (!i2c_dev)
-		return ERR_PTR(-ENOMEM);
-	i2c_dev->adap = adap;
+		return ERR_PTR(ret);
 
 	spin_lock(&i2c_dev_list_lock);
+	minor = find_first_zero_bit(minors, I2C_MINORS);
+	if (minor >= I2C_MINORS) {
+		spin_unlock(&i2c_dev_list_lock);
+		kfree(i2c_dev);
+		printk(KERN_ERR "i2c-dev: Out of device minors.\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	i2c_dev->adap = adap;
+	i2c_dev->minor = minor;
+	set_bit(minor, minors);
+
 	list_add_tail(&i2c_dev->list, &i2c_dev_list);
 	spin_unlock(&i2c_dev_list_lock);
 	return i2c_dev;
@@ -97,6 +122,7 @@ static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 static void return_i2c_dev(struct i2c_dev *i2c_dev)
 {
 	spin_lock(&i2c_dev_list_lock);
+	clear_bit(i2c_dev->minor, minors);
 	list_del(&i2c_dev->list);
 	spin_unlock(&i2c_dev_list_lock);
 	kfree(i2c_dev);
@@ -541,7 +567,7 @@ static int i2cdev_attach_adapter(struct i2c_adapter *adap)
 
 	/* register this i2c device with the driver core */
 	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
-				     MKDEV(I2C_MAJOR, adap->nr), NULL,
+				     MKDEV(I2C_MAJOR, i2c_dev->minor), NULL,
 				     "i2c-%d", adap->nr);
 	if (IS_ERR(i2c_dev->dev)) {
 		res = PTR_ERR(i2c_dev->dev);
@@ -552,10 +578,10 @@ static int i2cdev_attach_adapter(struct i2c_adapter *adap)
 		goto error_destroy;
 
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
-		 adap->name, adap->nr);
+		 adap->name, i2c_dev->minor);
 	return 0;
 error_destroy:
-	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
+	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, i2c_dev->minor));
 error:
 	return_i2c_dev(i2c_dev);
 	return res;
@@ -565,13 +591,13 @@ static int i2cdev_detach_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
 
-	i2c_dev = i2c_dev_get_by_minor(adap->nr);
+	i2c_dev = i2c_dev_get_by_adapter(adap);
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
 	device_remove_file(i2c_dev->dev, &dev_attr_name);
 	return_i2c_dev(i2c_dev);
-	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
+	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, i2c_dev->minor));
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
-- 
1.7.3.2
