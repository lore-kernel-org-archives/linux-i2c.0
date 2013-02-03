From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/62] i2c: convert to idr_alloc()
Date: Sat,  2 Feb 2013 17:20:22 -0800
Message-ID: <1359854463-2538-22-git-send-email-tj@kernel.org>
References: <1359854463-2538-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359854463-2538-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, bfields@fieldses.org, skinsbursky@parallels.com, ebiederm@xmission.com, jmorris@namei.org, axboe@kernel.dk, Tejun Heo <tj@kernel.org>, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Convert to the much saner new idr interface.

Only compile tested.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: linux-i2c@vger.kernel.org
---
This patch depends on an earlier idr changes and I think it would be
best to route these together through -mm.  Please holler if there's
any objection.  Thanks.

 drivers/i2c/i2c-core.c | 45 ++++++++++-----------------------------------
 1 file changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e388590..6868351 100644
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
@@ -984,33 +975,17 @@ EXPORT_SYMBOL(i2c_add_adapter);
 int i2c_add_numbered_adapter(struct i2c_adapter *adap)
 {
 	int	id;
-	int	status;
 
 	if (adap->nr == -1) /* -1 means dynamically assign bus id */
 		return i2c_add_adapter(adap);
-	if (adap->nr & ~MAX_IDR_MASK)
-		return -EINVAL;
-
-retry:
-	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0)
-		return -ENOMEM;
 
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
+	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
-- 
1.8.1
