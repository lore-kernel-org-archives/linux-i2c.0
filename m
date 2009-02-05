From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 2/6] i2c: use rwsem instead of mutex.
Date: Thu,  5 Feb 2009 14:36:09 +0100
Message-ID: <1233840973-13268-3-git-send-email-giometti@linux.it>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
 <1233840973-13268-2-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233840973-13268-2-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

By using rwsem we can easily manage recursive calls of
i2c_scan_static_board_info() function without breaking the locking.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/i2c-boardinfo.c |    6 +++---
 drivers/i2c/i2c-core.c      |    4 ++--
 drivers/i2c/i2c-core.h      |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index ffb35f0..981cdd8 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -25,7 +25,7 @@
 /* These symbols are exported ONLY FOR the i2c core.
  * No other users will be supported.
  */
-DEFINE_MUTEX(__i2c_board_lock);
+DECLARE_RWSEM(__i2c_board_lock);
 EXPORT_SYMBOL_GPL(__i2c_board_lock);
 
 LIST_HEAD(__i2c_board_list);
@@ -63,7 +63,7 @@ i2c_register_board_info(int busnum,
 {
 	int status;
 
-	mutex_lock(&__i2c_board_lock);
+	down_write(&__i2c_board_lock);
 
 	/* dynamic bus numbers will be assigned after the last static one */
 	if (busnum >= __i2c_first_dynamic_bus_num)
@@ -84,7 +84,7 @@ i2c_register_board_info(int busnum,
 		list_add_tail(&devinfo->list, &__i2c_board_list);
 	}
 
-	mutex_unlock(&__i2c_board_lock);
+	up_write(&__i2c_board_lock);
 
 	return status;
 }
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3454878..74b89a9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -408,7 +408,7 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 {
 	struct i2c_devinfo	*devinfo;
 
-	mutex_lock(&__i2c_board_lock);
+	down_read(&__i2c_board_lock);
 	list_for_each_entry(devinfo, &__i2c_board_list, list) {
 		if (devinfo->busnum == adapter->nr
 				&& !i2c_new_device(adapter,
@@ -417,7 +417,7 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 				i2c_adapter_id(adapter),
 				devinfo->board_info.addr);
 	}
-	mutex_unlock(&__i2c_board_lock);
+	up_read(&__i2c_board_lock);
 }
 
 static int i2c_do_add_adapter(struct device_driver *d, void *data)
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index cd5bff8..e6af064 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -25,7 +25,7 @@ struct i2c_devinfo {
 /* board_lock protects board_list and first_dynamic_bus_num.
  * only i2c core components are allowed to use these symbols.
  */
-extern struct mutex	__i2c_board_lock;
+extern struct rw_semaphore	__i2c_board_lock;
 extern struct list_head	__i2c_board_list;
 extern int		__i2c_first_dynamic_bus_num;
 
-- 
1.5.6.3
