From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/5] i2c: i2c-smbus: prevent races on remove when Host Notify is used
Date: Thu, 28 Jul 2016 11:50:39 +0200
Message-ID: <1469699443-22129-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

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
 drivers/i2c/busses/i2c-i801.c | 14 ++++++++++++++
 drivers/i2c/i2c-smbus.c       | 18 ++++++++++++++++++
 include/linux/i2c-smbus.h     |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ef9b73..cde9a7c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -959,6 +959,19 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 	return 0;
 }
 
+static void i801_disable_host_notify(struct i2c_adapter *adapter)
+{
+	struct i801_priv *priv = i2c_get_adapdata(adapter);
+
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return;
+
+	/* disable Host Notify... */
+	outb_p(0, SMBSLVCMD(priv));
+	/* ...and kill the already queued notifications */
+	i2c_cancel_smbus_host_notify(priv->host_notify);
+}
+
 static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
@@ -1648,6 +1661,7 @@ static void i801_remove(struct pci_dev *dev)
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_get_noresume(&dev->dev);
 
+	i801_disable_host_notify(&priv->adapter);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	i801_acpi_remove(priv);
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index b0d2679..60705dd 100644
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
@@ -299,6 +301,22 @@ struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_notify);
 
 /**
+ * i2c_cancel_smbus_host_notify - Terminate any active Host Notification.
+ * @host_notify: the host_notify object to terminate
+ *
+ * Cancel any pending Host Notifcation. Must be called to ensure no races
+ * between the adaptor being removed and the Host Notify process being treated.
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
2.5.5
