From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 01/10] i2c: i2c-smbus: prevent races on remove when Host Notify is used
Date: Wed, 28 Sep 2016 10:15:40 +0200
Message-ID: <1475050549-25542-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbcI1IPz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 04:15:55 -0400
In-Reply-To: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

struct host_notify contains its own workqueue, so there is a race when
the adapter gets removed:
- the adapter schedules a notification
- the notification is on hold
- the adapter gets removed and all its children too
- the worker fires and access illegal memory

Add an API to actually kill the workqueue and prevent it to access such
illegal memory. I couldn't find a reliable way of automatically calling
this, so it's the responsibility of the adapter driver to clean up after
itself.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

changes in v2:
- changed i801_disable_host_notify() parameter
- changed the comments to actually match the behavior
---
 drivers/i2c/busses/i2c-i801.c | 13 +++++++++++++
 drivers/i2c/i2c-smbus.c       | 19 +++++++++++++++++++
 include/linux/i2c-smbus.h     |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 22a0ed4..b494a85 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -959,6 +959,18 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 	return 0;
 }
 
+static void i801_disable_host_notify(struct i801_priv *priv)
+{
+
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return;
+
+	/* disable Host Notify... */
+	outb_p(0, SMBSLVCMD(priv));
+	/* ...and process the already queued notifications */
+	i2c_cancel_smbus_host_notify(priv->host_notify);
+}
+
 static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
@@ -1647,6 +1659,7 @@ static void i801_remove(struct pci_dev *dev)
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_get_noresume(&dev->dev);
 
+	i801_disable_host_notify(priv);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	i801_acpi_remove(priv);
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index b0d2679..35e4f1a 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -279,6 +279,8 @@ static void smbus_host_notify_work(struct work_struct *work)
  * Returns a struct smbus_host_notify pointer on success, and NULL on failure.
  * The resulting smbus_host_notify must not be freed afterwards, it is a
  * managed resource already.
+ * To prevent races on remove, the caller needs to stop the embedded worker
+ * by calling i2c_cancel_smbus_host_notify().
  */
 struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
 {
@@ -299,6 +301,23 @@ struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_notify);
 
 /**
+ * i2c_cancel_smbus_host_notify - Terminate any active Host Notification.
+ * @host_notify: the host_notify object to terminate
+ *
+ * Process any pending Host Notifcation and prevent new ones to be added.
+ * Must be called to ensure no races between the adaptor being removed and
+ * the Host Notification being processed.
+ */
+void i2c_cancel_smbus_host_notify(struct smbus_host_notify *host_notify)
+{
+	if (!host_notify)
+		return;
+
+	cancel_work_sync(&host_notify->work);
+}
+EXPORT_SYMBOL_GPL(i2c_cancel_smbus_host_notify);
+
+/**
  * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
  * I2C client.
  * @host_notify: the struct host_notify attached to the relevant adapter
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index c2e3324..ac02827 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -76,5 +76,6 @@ struct smbus_host_notify {
 struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap);
 int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
 				 unsigned short addr, unsigned int data);
+void i2c_cancel_smbus_host_notify(struct smbus_host_notify *host_notify);
 
 #endif /* _LINUX_I2C_SMBUS_H */
-- 
2.7.4
