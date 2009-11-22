From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Fix userspace_device list corruption
Date: Sun, 22 Nov 2009 15:12:16 +0100
Message-ID: <20091122151216.3c990e44@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Fix userspace_device list corruption. The corruption was caused by
clients not being removed when adapters with such clients were
themselves removed. Something like the following would trigger it
(assuming i2c-stub gets adapter number 3):

# modprobe i2c-stub chip_addr=0x50
# echo 24c08 0x50 > /sys/bus/i2c/devices/i2c-3/new_device 
# rmmod i2c-stub
# modprobe i2c-stub chip_addr=0x50
# echo 24c08 0x50 > /sys/bus/i2c/devices/i2c-3/new_device 

For the records, the stack trace in the kernel logs look like this:

kernel: WARNING: at lib/list_debug.c:30 __list_add+0x8b/0x90()
kernel: Hardware name: (...)
kernel: list_add corruption. prev->next should be next (c137fc84), but was (null). (prev=f57111b8).
kernel: Modules linked in: (...)
kernel: Pid: 4669, comm: bash Not tainted 2.6.32-rc8 #259
kernel: Call Trace:
kernel:  [<c111eb8b>] ? __list_add+0x8b/0x90
kernel:  [<c111eb8b>] ? __list_add+0x8b/0x90
kernel:  [<c103265c>] warn_slowpath_common+0x6c/0xc0
kernel:  [<c111eb8b>] ? __list_add+0x8b/0x90
kernel:  [<c10326f6>] warn_slowpath_fmt+0x26/0x30
kernel:  [<c111eb8b>] __list_add+0x8b/0x90
kernel:  [<c11ba165>] i2c_sysfs_new_device+0x1c5/0x250
kernel:  [<c10861be>] ? might_fault+0x2e/0x80
kernel:  [<c11b9fa0>] ? i2c_sysfs_new_device+0x0/0x250
kernel:  [<c118c625>] dev_attr_store+0x25/0x30
kernel:  [<c10e305c>] sysfs_write_file+0x9c/0xf0
kernel:  [<c109d35c>] vfs_write+0x9c/0x160
kernel:  [<c10e2fc0>] ? sysfs_write_file+0x0/0xf0
kernel:  [<c109d4dd>] sys_write+0x3d/0x70
kernel:  [<c1002ed8>] sysenter_do_call+0x12/0x36

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.32-rc8.orig/drivers/i2c/i2c-core.c	2009-11-19 13:05:47.000000000 +0100
+++ linux-2.6.32-rc8/drivers/i2c/i2c-core.c	2009-11-22 14:45:53.000000000 +0100
@@ -762,6 +762,7 @@ int i2c_del_adapter(struct i2c_adapter *
 {
 	int res = 0;
 	struct i2c_adapter *found;
+	struct i2c_client *client, *next;
 
 	/* First make sure that this adapter was ever added */
 	mutex_lock(&core_lock);
@@ -781,6 +782,16 @@ int i2c_del_adapter(struct i2c_adapter *
 	if (res)
 		return res;
 
+	/* Remove devices instantiated from sysfs */
+	list_for_each_entry_safe(client, next, &userspace_devices, detected) {
+		if (client->adapter == adap) {
+			dev_dbg(&adap->dev, "Removing %s at 0x%x\n",
+				client->name, client->addr);
+			list_del(&client->detected);
+			i2c_unregister_device(client);
+		}
+	}
+
 	/* Detach any active clients. This can't fail, thus we do not
 	   checking the returned value. */
 	res = device_for_each_child(&adap->dev, NULL, __unregister_client);


-- 
Jean Delvare
