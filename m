From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 4/6] i2c: free adapters (de)registration from i2c "core_lock" mutex.
Date: Thu,  5 Feb 2009 14:36:11 +0100
Message-ID: <1233840973-13268-5-git-send-email-giometti@linux.it>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
 <1233840973-13268-2-git-send-email-giometti@linux.it>
 <1233840973-13268-3-git-send-email-giometti@linux.it>
 <1233840973-13268-4-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233840973-13268-4-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The adapters (de)registration are now protectd by using a dedicated
mutex instead of using global "core_lock" one. This allow multiple
(and recursive) (de)registration of several adapters (or i2c
multiplexers acting as i2c virtual adapters).

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   57 +++++++++++++++++++++++------------------------
 1 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5d3646f..4b088ef 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -40,6 +40,7 @@
 
 
 static DEFINE_MUTEX(core_lock);
+static DEFINE_MUTEX(idr_adapter_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 
 #define is_newstyle_driver(d) ((d)->probe || (d)->remove || (d)->detect)
@@ -438,7 +439,7 @@ static int i2c_do_add_adapter(struct device_driver *d, void *data)
 
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
-	int res = 0, dummy;
+	int res, dummy;
 
 	/* Can't register until after driver model init */
 	if (unlikely(WARN_ON(!i2c_bus_type.p)))
@@ -448,8 +449,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	mutex_init(&adap->clist_lock);
 	INIT_LIST_HEAD(&adap->clients);
 
-	mutex_lock(&core_lock);
-
 	/* Add the adapter to the driver core.
 	 * If the parent pointer is not set up,
 	 * we add this adapter to the host bus.
@@ -463,8 +462,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.release = &i2c_adapter_dev_release;
 	adap->dev.class = &i2c_adapter_class;
 	res = device_register(&adap->dev);
-	if (res)
-		goto out_list;
+	if (res) {
+		mutex_lock(&idr_adapter_lock);
+		idr_remove(&i2c_adapter_idr, adap->nr);
+		mutex_unlock(&idr_adapter_lock);
+
+		return res;
+	}
 
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
@@ -476,13 +480,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 				 i2c_do_add_adapter);
 
-out_unlock:
-	mutex_unlock(&core_lock);
-	return res;
-
-out_list:
-	idr_remove(&i2c_adapter_idr, adap->nr);
-	goto out_unlock;
+	return 0;
 }
 
 /**
@@ -506,11 +504,11 @@ retry:
 	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
 		return -ENOMEM;
 
-	mutex_lock(&core_lock);
+	mutex_lock(&idr_adapter_lock);
 	/* "above" here means "above or equal to", sigh */
 	res = idr_get_new_above(&i2c_adapter_idr, adapter,
 				__i2c_first_dynamic_bus_num, &id);
-	mutex_unlock(&core_lock);
+	mutex_unlock(&idr_adapter_lock);
 
 	if (res < 0) {
 		if (res == -EAGAIN)
@@ -555,7 +553,7 @@ retry:
 	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
 		return -ENOMEM;
 
-	mutex_lock(&core_lock);
+	mutex_lock(&idr_adapter_lock);
 	/* "above" here means "above or equal to", sigh;
 	 * we need the "equal to" result to force the result
 	 */
@@ -564,7 +562,7 @@ retry:
 		status = -EBUSY;
 		idr_remove(&i2c_adapter_idr, id);
 	}
-	mutex_unlock(&core_lock);
+	mutex_unlock(&idr_adapter_lock);
 	if (status == -EAGAIN)
 		goto retry;
 
@@ -612,19 +610,25 @@ static int i2c_do_del_adapter(struct device_driver *d, void *data)
  */
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
+	struct i2c_adapter *ptr;
 	struct i2c_client *client, *_n;
-	int res = 0, dummy;
+	int dummy;
 
-	mutex_lock(&core_lock);
+	mutex_lock(&idr_adapter_lock);
 
 	/* First make sure that this adapter was ever added */
-	if (idr_find(&i2c_adapter_idr, adap->nr) != adap) {
+	ptr = idr_find(&i2c_adapter_idr, adap->nr);
+	if (ptr != adap) {
 		pr_debug("i2c-core: attempting to delete unregistered "
 			 "adapter [%s]\n", adap->name);
-		res = -EINVAL;
-		goto out_unlock;
+		mutex_unlock(&idr_adapter_lock);
+		return -EINVAL;
 	}
 
+	/* ... then remove adapter ID */
+	idr_remove(&i2c_adapter_idr, adap->nr);
+	mutex_unlock(&idr_adapter_lock);
+
 	/* Tell drivers about this removal */
 	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 			       i2c_do_del_adapter);
@@ -655,18 +659,13 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 	/* wait for sysfs to drop all references */
 	wait_for_completion(&adap->dev_released);
 
-	/* free bus id */
-	idr_remove(&i2c_adapter_idr, adap->nr);
-
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
 	/* Clear the device structure in case this adapter is ever going to be
 	   added again */
 	memset(&adap->dev, 0, sizeof(adap->dev));
 
- out_unlock:
-	mutex_unlock(&core_lock);
-	return res;
+	return 0;
 }
 EXPORT_SYMBOL(i2c_del_adapter);
 
@@ -1497,12 +1496,12 @@ struct i2c_adapter* i2c_get_adapter(int id)
 {
 	struct i2c_adapter *adapter;
 
-	mutex_lock(&core_lock);
+	mutex_lock(&idr_adapter_lock);
 	adapter = (struct i2c_adapter *)idr_find(&i2c_adapter_idr, id);
 	if (adapter && !try_module_get(adapter->owner))
 		adapter = NULL;
 
-	mutex_unlock(&core_lock);
+	mutex_unlock(&idr_adapter_lock);
 	return adapter;
 }
 EXPORT_SYMBOL(i2c_get_adapter);
-- 
1.5.6.3
