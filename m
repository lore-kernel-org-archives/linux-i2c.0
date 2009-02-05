From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 3/6] i2c: ignore active clients detaching during adapter removal.
Date: Thu,  5 Feb 2009 14:36:10 +0100
Message-ID: <1233840973-13268-4-git-send-email-giometti@linux.it>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
 <1233840973-13268-2-git-send-email-giometti@linux.it>
 <1233840973-13268-3-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233840973-13268-3-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When we are removing an adapter we decide to ignore any active client
detaching faults for two reasons:

1) one (or more) active client may be switched off, so it cannot
   replay to the "adapter removed" event.

2) it shouldn't happen, and even if it happens it may be due a bus
   fault which can be resolved by resetting the adapter (most of them
   can be resetted simply by rmmod and then insmod the module again).

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 74b89a9..5d3646f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -593,11 +593,13 @@ static int i2c_do_del_adapter(struct device_driver *d, void *data)
 
 	if (!driver->detach_adapter)
 		return 0;
+
+	/* We ignore the return code; if it fails, too bad */
 	res = driver->detach_adapter(adapter);
 	if (res)
 		dev_err(&adapter->dev, "detach_adapter failed (%d) "
 			"for driver [%s]\n", res, driver->driver.name);
-	return res;
+	return 0;
 }
 
 /**
@@ -611,7 +613,7 @@ static int i2c_do_del_adapter(struct device_driver *d, void *data)
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_client *client, *_n;
-	int res = 0;
+	int res = 0, dummy;
 
 	mutex_lock(&core_lock);
 
@@ -624,13 +626,10 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 	}
 
 	/* Tell drivers about this removal */
-	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
+	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 			       i2c_do_del_adapter);
-	if (res)
-		goto out_unlock;
 
-	/* detach any active clients. This must be done first, because
-	 * it can fail; in which case we give up. */
+	/* Detach any active clients */
 	list_for_each_entry_safe_reverse(client, _n, &adap->clients, list) {
 		struct i2c_driver	*driver;
 
@@ -643,12 +642,10 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 		}
 
 		/* legacy drivers create and remove clients themselves */
-		if ((res = driver->detach_client(client))) {
+		if (driver->detach_client(client))
 			dev_err(&adap->dev, "detach_client failed for client "
 				"[%s] at address 0x%02x\n", client->name,
 				client->addr);
-			goto out_unlock;
-		}
 	}
 
 	/* clean up the sysfs representation */
-- 
1.5.6.3
