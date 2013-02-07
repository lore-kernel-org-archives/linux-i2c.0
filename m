From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] i2c: convert to idr_alloc()
Date: Thu, 7 Feb 2013 08:55:47 -0800
Message-ID: <20130207165547.GO2875@htj.dyndns.org>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
 <1360179649-22465-38-git-send-email-tj@kernel.org>
 <20130207152831.GA14797@sirena.org.uk>
 <20130207163247.GL2875@htj.dyndns.org>
 <20130207163958.GY4720@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130207163958.GY4720-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Convert to the much saner new idr interface.

Only compile tested.

v2: The original conversion accidentally dropped a call to
    i2c_register_adapter() in i2c_add_numbered_adapter() leaving @adap
    uninitialized and unregistered.  Reported by Mark Brown.  Fix it.

Signed-off-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reported-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
Heh, this is embarrassing.  I got too focused on the id allocation
itself and missed moving i2c_register_adapter() call.

I think this should fix the problem you're seeing.  Can you please
test this?

Thank you.

 drivers/i2c/i2c-core.c |   43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -935,25 +935,16 @@ out_list:
  */
 int i2c_add_adapter(struct i2c_adapter *adapter)
 {
-	int	id, res = 0;
-
-retry:
-	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
-		return -ENOMEM;
+	int res;
 
 	mutex_lock(&core_lock);
-	/* "above" here means "above or equal to", sigh */
-	res = idr_get_new_above(&i2c_adapter_idr, adapter,
-				__i2c_first_dynamic_bus_num, &id);
+	res = idr_alloc(&i2c_adapter_idr, adapter,
+			__i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
-
-	if (res < 0) {
-		if (res == -EAGAIN)
-			goto retry;
+	if (res < 0)
 		return res;
-	}
 
-	adapter->nr = id;
+	adapter->nr = res;
 	return i2c_register_adapter(adapter);
 }
 EXPORT_SYMBOL(i2c_add_adapter);
@@ -984,33 +975,19 @@ EXPORT_SYMBOL(i2c_add_adapter);
 int i2c_add_numbered_adapter(struct i2c_adapter *adap)
 {
 	int	id;
-	int	status;
 
 	if (adap->nr == -1) /* -1 means dynamically assign bus id */
 		return i2c_add_adapter(adap);
 	if (adap->nr & ~MAX_IDR_MASK)
 		return -EINVAL;
 
-retry:
-	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
-		return -ENOMEM;
-
 	mutex_lock(&core_lock);
-	/* "above" here means "above or equal to", sigh;
-	 * we need the "equal to" result to force the result
-	 */
-	status = idr_get_new_above(&i2c_adapter_idr, adap, adap->nr, &id);
-	if (status == 0 && id != adap->nr) {
-		status = -EBUSY;
-		idr_remove(&i2c_adapter_idr, id);
-	}
+	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1,
+		       GFP_KERNEL);
 	mutex_unlock(&core_lock);
-	if (status == -EAGAIN)
-		goto retry;
-
-	if (status == 0)
-		status = i2c_register_adapter(adap);
-	return status;
+	if (id < 0)
+		return id == -ENOSPC ? -EBUSY : id;
+	return i2c_register_adapter(adap);
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
