From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] i2c-core: Fix for lockdep validator
Date: Fri, 7 Sep 2012 22:58:44 +0200
Message-ID: <20120907225844.2c935ac9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If kernel is compiled with CONFIG_PROVE_LOCKING the
validator raises an error when a multiplexer is removed
via sysfs and sub-clients are connected to it. This is a
false positive.
Documentation/lockdep-design.txt recommends to handle this
via calls to mutex_lock_nested().

Based on an earlier fix from Michael Lawnick.

Note that the extra code resolves to nothing unless
CONFIG_DEBUG_LOCK_ALLOC=y.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Note that I still get a complaint from lockdep even with this patch,
but it's a different one... Related to sysfs, not something for me:

=============================================
[ INFO: possible recursive locking detected ]
3.6.0-rc4 #48 Not tainted
---------------------------------------------
bash/13695 is trying to acquire lock:
 (s_active#276){++++.+}, at: [<ffffffff811ed361>] sysfs_addrm_finish+0x31/0x60

but task is already holding lock:
 (s_active#276){++++.+}, at: [<ffffffff811eb7d8>] sysfs_write_file+0xe8/0x170

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(s_active#276);
  lock(s_active#276);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by bash/13695:
 #0:  (&buffer->mutex){+.+.+.}, at: [<ffffffff811eb72f>] sysfs_write_file+0x3f/0x170
 #1:  (s_active#276){++++.+}, at: [<ffffffff811eb7d8>] sysfs_write_file+0xe8/0x170
 #2:  (&adap->userspace_clients_lock){+.+.+.}, at: [<ffffffff81479b7f>] i2c_sysfs_delete_device+0xcf/0x210
 #3:  (&__lockdep_no_validate__){......}, at: [<ffffffff813c7e81>] device_release_driver+0x21/0x40

I guess it's a false positive too, as I did not actually get a deadlock.

 drivers/i2c/i2c-core.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- linux-3.6-rc4.orig/drivers/i2c/i2c-core.c	2012-09-07 17:53:31.851926473 +0200
+++ linux-3.6-rc4/drivers/i2c/i2c-core.c	2012-09-07 18:55:36.562869851 +0200
@@ -636,6 +636,16 @@ static void i2c_adapter_dev_release(stru
 	complete(&adap->dev_released);
 }
 
+static unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
+{
+	unsigned int depth = 0;
+
+	while ((adapter = i2c_parent_is_i2c_adapter(adapter)))
+		depth++;
+
+	return depth;
+}
+
 /*
  * Let users instantiate I2C devices through sysfs. This can be used when
  * platform initialization code doesn't contain the proper data for
@@ -726,7 +736,8 @@ i2c_sysfs_delete_device(struct device *d
 
 	/* Make sure the device was added through sysfs */
 	res = -ENOENT;
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock,
+			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		if (client->addr == addr) {
@@ -1073,7 +1084,8 @@ int i2c_del_adapter(struct i2c_adapter *
 		return res;
 
 	/* Remove devices instantiated from sysfs */
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock,
+			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,

-- 
Jean Delvare
