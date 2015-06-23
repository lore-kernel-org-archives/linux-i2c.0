From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] i2c: i801: add support of Host Notify
Date: Tue, 23 Jun 2015 14:58:19 -0400
Message-ID: <1435085899-11017-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435085899-11017-1-git-send-email-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf

Implement .toggle_smbus_host_notify() and rely on .alert() to notify
the actual client that it has a notification.

With a T440s and a Synaptics touchpad that implements Host Notify, the
payload data is always 0x0000, so I am not sure if the device actually
sends the payload or if there is a problem regarding the implementation.

Part of this code is inspired by i2c-smbus.c.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c | 223 +++++++++++++++++++++++++++++++++---------
 drivers/i2c/i2c-core.c        |  34 +++++++
 drivers/i2c/i2c-smbus.c       |  17 +---
 include/linux/i2c.h           |   3 +
 4 files changed, 217 insertions(+), 60 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ecbb3f..22a3218 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -20,46 +20,46 @@
 /*
  * Supports the following Intel I/O Controller Hubs (ICH):
  *
- *					I/O			Block	I2C
- *					region	SMBus	Block	proc.	block
- * Chip name			PCI ID	size	PEC	buffer	call	read
- * ---------------------------------------------------------------------------
- * 82801AA (ICH)		0x2413	16	no	no	no	no
- * 82801AB (ICH0)		0x2423	16	no	no	no	no
- * 82801BA (ICH2)		0x2443	16	no	no	no	no
- * 82801CA (ICH3)		0x2483	32	soft	no	no	no
- * 82801DB (ICH4)		0x24c3	32	hard	yes	no	no
- * 82801E (ICH5)		0x24d3	32	hard	yes	yes	yes
- * 6300ESB			0x25a4	32	hard	yes	yes	yes
- * 82801F (ICH6)		0x266a	32	hard	yes	yes	yes
- * 6310ESB/6320ESB		0x269b	32	hard	yes	yes	yes
- * 82801G (ICH7)		0x27da	32	hard	yes	yes	yes
- * 82801H (ICH8)		0x283e	32	hard	yes	yes	yes
- * 82801I (ICH9)		0x2930	32	hard	yes	yes	yes
- * EP80579 (Tolapai)		0x5032	32	hard	yes	yes	yes
- * ICH10			0x3a30	32	hard	yes	yes	yes
- * ICH10			0x3a60	32	hard	yes	yes	yes
- * 5/3400 Series (PCH)		0x3b30	32	hard	yes	yes	yes
- * 6 Series (PCH)		0x1c22	32	hard	yes	yes	yes
- * Patsburg (PCH)		0x1d22	32	hard	yes	yes	yes
- * Patsburg (PCH) IDF		0x1d70	32	hard	yes	yes	yes
- * Patsburg (PCH) IDF		0x1d71	32	hard	yes	yes	yes
- * Patsburg (PCH) IDF		0x1d72	32	hard	yes	yes	yes
- * DH89xxCC (PCH)		0x2330	32	hard	yes	yes	yes
- * Panther Point (PCH)		0x1e22	32	hard	yes	yes	yes
- * Lynx Point (PCH)		0x8c22	32	hard	yes	yes	yes
- * Lynx Point-LP (PCH)		0x9c22	32	hard	yes	yes	yes
- * Avoton (SOC)			0x1f3c	32	hard	yes	yes	yes
- * Wellsburg (PCH)		0x8d22	32	hard	yes	yes	yes
- * Wellsburg (PCH) MS		0x8d7d	32	hard	yes	yes	yes
- * Wellsburg (PCH) MS		0x8d7e	32	hard	yes	yes	yes
- * Wellsburg (PCH) MS		0x8d7f	32	hard	yes	yes	yes
- * Coleto Creek (PCH)		0x23b0	32	hard	yes	yes	yes
- * Wildcat Point (PCH)		0x8ca2	32	hard	yes	yes	yes
- * Wildcat Point-LP (PCH)	0x9ca2	32	hard	yes	yes	yes
- * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
- * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
- * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
+ *					I/O		SMBus	Block	I2C
+ *					region	Slave	Host	SMBus	Block	proc.	block
+ * Chip name			PCI ID	size	mode	notify	PEC	buffer	call	read
+ * ------------------------------------------------------------------------------------------
+ * 82801AA (ICH)		0x2413	16	no	no	no	no	no	no
+ * 82801AB (ICH0)		0x2423	16	no	no	no	no	no	no
+ * 82801BA (ICH2)		0x2443	16	yes	no	no	no	no	no
+ * 82801CA (ICH3)		0x2483	32	yes	yes	soft	no	no	no
+ * 82801DB (ICH4)		0x24c3	32	yes	yes	hard	yes	no	no
+ * 82801E (ICH5)		0x24d3	32	yes	yes	hard	yes	yes	yes
+ * 6300ESB			0x25a4	32	yes	yes	hard	yes	yes	yes
+ * 82801F (ICH6)		0x266a	32	yes	yes	hard	yes	yes	yes
+ * 6310ESB/6320ESB		0x269b	32	yes	yes	hard	yes	yes	yes
+ * 82801G (ICH7)		0x27da	32	yes	yes	hard	yes	yes	yes
+ * 82801H (ICH8)		0x283e	32	yes	yes	hard	yes	yes	yes
+ * 82801I (ICH9)		0x2930	32	yes	yes	hard	yes	yes	yes
+ * EP80579 (Tolapai)		0x5032	32	yes	yes	hard	yes	yes	yes
+ * ICH10			0x3a30	32	yes	yes	hard	yes	yes	yes
+ * ICH10			0x3a60	32	yes	yes	hard	yes	yes	yes
+ * 5/3400 Series (PCH)		0x3b30	32	yes	yes	hard	yes	yes	yes
+ * 6 Series (PCH)		0x1c22	32	yes	yes	hard	yes	yes	yes
+ * Patsburg (PCH)		0x1d22	32	yes	yes	hard	yes	yes	yes
+ * Patsburg (PCH) IDF		0x1d70	32	yes	yes	hard	yes	yes	yes
+ * Patsburg (PCH) IDF		0x1d71	32	yes	yes	hard	yes	yes	yes
+ * Patsburg (PCH) IDF		0x1d72	32	yes	yes	hard	yes	yes	yes
+ * DH89xxCC (PCH)		0x2330	32	yes	yes	hard	yes	yes	yes
+ * Panther Point (PCH)		0x1e22	32	yes	yes	hard	yes	yes	yes
+ * Lynx Point (PCH)		0x8c22	32	yes	yes	hard	yes	yes	yes
+ * Lynx Point-LP (PCH)		0x9c22	32	yes	yes	hard	yes	yes	yes
+ * Avoton (SOC)			0x1f3c	32	yes	yes	hard	yes	yes	yes
+ * Wellsburg (PCH)		0x8d22	32	yes	yes	hard	yes	yes	yes
+ * Wellsburg (PCH) MS		0x8d7d	32	yes	yes	hard	yes	yes	yes
+ * Wellsburg (PCH) MS		0x8d7e	32	yes	yes	hard	yes	yes	yes
+ * Wellsburg (PCH) MS		0x8d7f	32	yes	yes	hard	yes	yes	yes
+ * Coleto Creek (PCH)		0x23b0	32	yes	yes	hard	yes	yes	yes
+ * Wildcat Point (PCH)		0x8ca2	32	yes	yes	hard	yes	yes	yes
+ * Wildcat Point-LP (PCH)	0x9ca2	32	yes	yes	hard	yes	yes	yes
+ * BayTrail (SOC)		0x0f12	32	yes	yes	hard	yes	yes	yes
+ * Sunrise Point-H (PCH)	0xa123  32	yes	yes	hard	yes	yes	yes
+ * Sunrise Point-LP (PCH)	0x9d23	32	yes	yes	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -68,6 +68,7 @@
  * Block process call transaction	no
  * I2C block read transaction		yes (doesn't use the block buffer)
  * Slave mode				no
+ * SMBus Host Notify			yes
  * Interrupt processing			yes
  *
  * See the file Documentation/i2c/busses/i2c-i801 for details.
@@ -84,6 +85,7 @@
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -107,6 +109,10 @@
 #define SMBPEC(p)	(8 + (p)->smba)		/* ICH3 and later */
 #define SMBAUXSTS(p)	(12 + (p)->smba)	/* ICH4 and later */
 #define SMBAUXCTL(p)	(13 + (p)->smba)	/* ICH4 and later */
+#define SMBSLVSTS(p)	(16 + (p)->smba)	/* ICH3 and later */
+#define SMBSLVCMD(p)	(17 + (p)->smba)	/* ICH3 and later */
+#define SMBNTFDADD(p)	(20 + (p)->smba)	/* ICH3 and later */
+#define SMBNTFDDAT(p)	(22 + (p)->smba)	/* ICH3 and later */
 
 /* PCI Address Constants */
 #define SMBBAR		4
@@ -158,6 +164,12 @@
 #define SMBHSTSTS_INTR		0x02
 #define SMBHSTSTS_HOST_BUSY	0x01
 
+/* Host Notify Status registers bits */
+#define SMBSLVSTS_HST_NTFY_STS	1
+
+/* Host Notify Command registers bits */
+#define SMBSLVCMD_HST_NTFY_INTREN	0x01
+
 #define STATUS_ERROR_FLAGS	(SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
 				 SMBHSTSTS_DEV_ERR)
 
@@ -221,6 +233,17 @@ struct i801_priv {
 	const struct i801_mux_config *mux_drvdata;
 	struct platform_device *mux_pdev;
 #endif
+
+	bool host_notify_requested;
+	struct work_struct host_notify;
+	struct kfifo host_notify_fifo;
+};
+
+#define SMBHSTNTFY_SIZE		8
+
+struct smbus_host_notify_data {
+	u8 addr;
+	u16 payload;
 };
 
 #define FEATURE_SMBUS_PEC	(1 << 0)
@@ -228,6 +251,7 @@ struct i801_priv {
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 #define FEATURE_IRQ		(1 << 4)
+#define FEATURE_HOST_NOTIFY	(1 << 5)
 /* Not really a feature, but it's convenient to handle it as such */
 #define FEATURE_IDF		(1 << 15)
 
@@ -237,6 +261,7 @@ static const char *i801_feature_names[] = {
 	"Block process call",
 	"I2C block read",
 	"Interrupt",
+	"SMBus Host Notify",
 };
 
 static unsigned int disable_features;
@@ -245,7 +270,8 @@ MODULE_PARM_DESC(disable_features, "Disable selected driver features:\n"
 	"\t\t  0x01  disable SMBus PEC\n"
 	"\t\t  0x02  disable the block buffer\n"
 	"\t\t  0x08  disable the I2C block read functionality\n"
-	"\t\t  0x10  don't use interrupts ");
+	"\t\t  0x10  don't use interrupts\n"
+	"\t\t  0x20  disable SMBus Host Notify ");
 
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
@@ -479,8 +505,67 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 	outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
 }
 
+/* If this is the alerting device, notify its driver */
+static int i801_do_host_notify(struct device *dev, void *datap)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct smbus_host_notify_data *data = datap;
+
+	if (!client || client->addr != data->addr)
+		return 0;
+	if (client->flags & I2C_CLIENT_TEN)
+		return 0;
+
+	if (i2c_alert(client, data->payload))
+		return 0;
+
+	/* Stop iterating after we find the device */
+	return -EBUSY;
+}
+
 /*
- * There are two kinds of interrupts:
+ * The alert IRQ handler needs to hand work off to a task which can issue
+ * SMBus calls, because those sleeping calls can't be made in IRQ context.
+ */
+static void i801_host_notify(struct work_struct *work)
+{
+	struct i801_priv *priv;
+	struct smbus_host_notify_data data;
+	int count;
+
+	priv = container_of(work, struct i801_priv, host_notify);
+
+	count = kfifo_out(&priv->host_notify_fifo, &data,
+			  sizeof(struct smbus_host_notify_data));
+
+	if (count != sizeof(struct smbus_host_notify_data)) {
+		dev_err(&priv->pci_dev->dev,
+			"Host Notification triggered without data\n");
+		return;
+	}
+
+	device_for_each_child(&priv->adapter.dev, &data, i801_do_host_notify);
+}
+
+static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
+{
+	struct smbus_host_notify_data data;
+
+	data.addr = inb_p(SMBNTFDADD(priv)) >> 1;
+	data.payload = inb_p(SMBNTFDDAT(priv)) |
+		      (inb_p(SMBNTFDDAT(priv) + 1) << 8);
+
+	kfifo_in(&priv->host_notify_fifo, &data,
+		 sizeof(struct smbus_host_notify_data));
+	schedule_work(&priv->host_notify);
+
+	/* clear Host Notify bit and return */
+	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
+	return IRQ_HANDLED;
+}
+
+/*
+ * There are three kinds of interrupts:
  *
  * 1) i801 signals transaction completion with one of these interrupts:
  *      INTR - Success
@@ -492,6 +577,8 @@ static void i801_isr_byte_done(struct i801_priv *priv)
  *
  * 2) For byte-by-byte (I2C read/write) transactions, one BYTE_DONE interrupt
  *    occurs for each byte of a byte-by-byte to prepare the next byte.
+ *
+ * 3) Host Notify interrupts
  */
 static irqreturn_t i801_isr(int irq, void *dev_id)
 {
@@ -504,6 +591,12 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
 	if (!(pcists & SMBPCISTS_INTS))
 		return IRQ_NONE;
 
+	if (priv->host_notify_requested) {
+		status = inb_p(SMBSLVSTS(priv));
+		if (status & SMBSLVSTS_HST_NTFY_STS)
+			return i801_host_notify_isr(priv);
+	}
+
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_BYTE_DONE)
 		i801_isr_byte_done(priv);
@@ -801,12 +894,35 @@ static u32 i801_func(struct i2c_adapter *adapter)
 	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
 	       ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
 	       ((priv->features & FEATURE_I2C_BLOCK_READ) ?
-		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
+		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) |
+	       ((priv->features & FEATURE_HOST_NOTIFY) ?
+		I2C_FUNC_SMBUS_HOST_NOTIFY : 0);
+}
+
+static int i801_toggle_host_ntfy(struct i2c_adapter *adapter, bool state)
+{
+	struct i801_priv *priv = i2c_get_adapdata(adapter);
+
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return -EOPNOTSUPP;
+
+	if (state) {
+		outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
+		/* clear Host Notify bit to allow a new notification */
+		outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
+	} else {
+		outb_p(0, SMBSLVCMD(priv));
+	}
+
+	priv->host_notify_requested = state;
+
+	return 0;
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
-	.smbus_xfer	= i801_access,
-	.functionality	= i801_func,
+	.smbus_xfer			= i801_access,
+	.functionality			= i801_func,
+	.toggle_smbus_host_notify	= i801_toggle_host_ntfy,
 };
 
 static const struct pci_device_id i801_ids[] = {
@@ -1166,6 +1282,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		priv->features |= FEATURE_BLOCK_BUFFER;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801CA_3:
+		priv->features |= FEATURE_HOST_NOTIFY;
 	case PCI_DEVICE_ID_INTEL_82801BA_2:
 	case PCI_DEVICE_ID_INTEL_82801AB_3:
 	case PCI_DEVICE_ID_INTEL_82801AA_3:
@@ -1250,6 +1367,15 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		}
 	}
 
+	INIT_WORK(&priv->host_notify, i801_host_notify);
+	if (kfifo_alloc(&priv->host_notify_fifo,
+			SMBHSTNTFY_SIZE * sizeof(struct smbus_host_notify_data),
+			GFP_KERNEL)) {
+		dev_err(&dev->dev,
+			"%s:failed allocating host_notify_fifo\n", __func__);
+		return -ENOMEM;
+	}
+
 	if (priv->features & FEATURE_IRQ) {
 		init_waitqueue_head(&priv->waitq);
 
@@ -1292,6 +1418,9 @@ static void i801_remove(struct pci_dev *dev)
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
+	cancel_work_sync(&priv->host_notify);
+	kfifo_free(&priv->host_notify_fifo);
+
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
@@ -1315,8 +1444,12 @@ static int i801_suspend(struct pci_dev *dev, pm_message_t mesg)
 
 static int i801_resume(struct pci_dev *dev)
 {
+	struct i801_priv *priv = pci_get_drvdata(dev);
+
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
+	if (priv->host_notify_requested)
+		i801_toggle_host_ntfy(&priv->adapter, true);
 	return 0;
 }
 #else
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index eaaf5b0..87904ec 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2145,6 +2145,40 @@ int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
 EXPORT_SYMBOL(i2c_master_send);
 
 /**
+ * i2c_alert - call an alert for the given i2c_client.
+ * @client: Handle to slave device
+ * @data: Payload data that will be sent to the slave
+ *
+ * Returns negative errno, or 0.
+ */
+int i2c_alert(struct i2c_client *client, unsigned int data)
+{
+	struct i2c_driver *driver;
+
+	if (!client)
+		return -EINVAL;
+
+	/*
+	 * Drivers should either disable alerts, or provide at least
+	 * a minimal handler.  Lock so the driver won't change.
+	 */
+	device_lock(&client->adapter->dev);
+	if (client->dev.driver) {
+		driver = to_i2c_driver(client->dev.driver);
+		if (driver->alert)
+			driver->alert(client, data);
+		else
+			dev_warn(&client->dev, "no driver alert()!\n");
+	} else
+		dev_dbg(&client->dev, "alert with no driver\n");
+	device_unlock(&client->adapter->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_alert);
+
+
+/**
  * i2c_master_recv - issue a single I2C message in master receive mode
  * @client: Handle to slave device
  * @buf: Where to store data read from slave
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 9ebf9cb..26439a8 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -41,27 +41,14 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 {
 	struct i2c_client *client = i2c_verify_client(dev);
 	struct alert_data *data = addrp;
-	struct i2c_driver *driver;
 
 	if (!client || client->addr != data->addr)
 		return 0;
 	if (client->flags & I2C_CLIENT_TEN)
 		return 0;
 
-	/*
-	 * Drivers should either disable alerts, or provide at least
-	 * a minimal handler.  Lock so the driver won't change.
-	 */
-	device_lock(dev);
-	if (client->dev.driver) {
-		driver = to_i2c_driver(client->dev.driver);
-		if (driver->alert)
-			driver->alert(client, data->flag);
-		else
-			dev_warn(&client->dev, "no driver alert()!\n");
-	} else
-		dev_dbg(&client->dev, "alert with no driver\n");
-	device_unlock(dev);
+	if (i2c_alert(client, data->flag))
+		return 0;
 
 	/* Stop iterating after we find the device */
 	return -EBUSY;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 7ffc970..fbca48a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -72,6 +72,9 @@ extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			  int num);
 
+/* call an alert. */
+extern int i2c_alert(struct i2c_client *client, unsigned int data);
+
 /* This is the very generalized SMBus access routine. You probably do not
    want to use this, though; one of the functions below may be much easier,
    and probably just as fast.
-- 
2.4.3
