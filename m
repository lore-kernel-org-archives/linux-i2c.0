From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/3] i2c: i801: add support of Host Notify
Date: Thu,  9 Jul 2015 13:30:52 -0400
Message-ID: <1436463052-6944-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1436463052-6944-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436463052-6944-1-git-send-email-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf

Enable the functionality unconditionally and propagate the alert
on each notification.

With a T440s and a Synaptics touchpad that implements Host Notify, the
payload data is always 0x0000, so I am not sure if the device actually
sends the payload or if there is a problem regarding the implementation.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

Changes in v2:
- removed the description of the Slave functionality support in the chip table
  (the table shows what is supported, not what the hardware is capable of)
- use i2c-smbus to forward the notification
- remove the fifo, and directly retrieve the address and payload in the worker
- do not check for Host Notification is the feature is not enabled
- use inw_p() to read the payload instead of 2 inb_p() calls
- add /* fall-through */ comment
- unconditionally enable Host Notify if the hardware supports it (can be
  disabled by the user)

 drivers/i2c/busses/i2c-i801.c | 172 +++++++++++++++++++++++++++++++-----------
 1 file changed, 129 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ecbb3f..f65f955 100644
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
+ *					I/O	SMBus	Block	I2C
+ *					region	Host	SMBus	Block	proc.	block
+ * Chip name			PCI ID	size	notify	PEC	buffer	call	read
+ * ----------------------------------------------------------------------------------
+ * 82801AA (ICH)		0x2413	16	no	no	no	no	no
+ * 82801AB (ICH0)		0x2423	16	no	no	no	no	no
+ * 82801BA (ICH2)		0x2443	16	no	no	no	no	no
+ * 82801CA (ICH3)		0x2483	32	yes	soft	no	no	no
+ * 82801DB (ICH4)		0x24c3	32	yes	hard	yes	no	no
+ * 82801E (ICH5)		0x24d3	32	yes	hard	yes	yes	yes
+ * 6300ESB			0x25a4	32	yes	hard	yes	yes	yes
+ * 82801F (ICH6)		0x266a	32	yes	hard	yes	yes	yes
+ * 6310ESB/6320ESB		0x269b	32	yes	hard	yes	yes	yes
+ * 82801G (ICH7)		0x27da	32	yes	hard	yes	yes	yes
+ * 82801H (ICH8)		0x283e	32	yes	hard	yes	yes	yes
+ * 82801I (ICH9)		0x2930	32	yes	hard	yes	yes	yes
+ * EP80579 (Tolapai)		0x5032	32	yes	hard	yes	yes	yes
+ * ICH10			0x3a30	32	yes	hard	yes	yes	yes
+ * ICH10			0x3a60	32	yes	hard	yes	yes	yes
+ * 5/3400 Series (PCH)		0x3b30	32	yes	hard	yes	yes	yes
+ * 6 Series (PCH)		0x1c22	32	yes	hard	yes	yes	yes
+ * Patsburg (PCH)		0x1d22	32	yes	hard	yes	yes	yes
+ * Patsburg (PCH) IDF		0x1d70	32	yes	hard	yes	yes	yes
+ * Patsburg (PCH) IDF		0x1d71	32	yes	hard	yes	yes	yes
+ * Patsburg (PCH) IDF		0x1d72	32	yes	hard	yes	yes	yes
+ * DH89xxCC (PCH)		0x2330	32	yes	hard	yes	yes	yes
+ * Panther Point (PCH)		0x1e22	32	yes	hard	yes	yes	yes
+ * Lynx Point (PCH)		0x8c22	32	yes	hard	yes	yes	yes
+ * Lynx Point-LP (PCH)		0x9c22	32	yes	hard	yes	yes	yes
+ * Avoton (SOC)			0x1f3c	32	yes	hard	yes	yes	yes
+ * Wellsburg (PCH)		0x8d22	32	yes	hard	yes	yes	yes
+ * Wellsburg (PCH) MS		0x8d7d	32	yes	hard	yes	yes	yes
+ * Wellsburg (PCH) MS		0x8d7e	32	yes	hard	yes	yes	yes
+ * Wellsburg (PCH) MS		0x8d7f	32	yes	hard	yes	yes	yes
+ * Coleto Creek (PCH)		0x23b0	32	yes	hard	yes	yes	yes
+ * Wildcat Point (PCH)		0x8ca2	32	yes	hard	yes	yes	yes
+ * Wildcat Point-LP (PCH)	0x9ca2	32	yes	hard	yes	yes	yes
+ * BayTrail (SOC)		0x0f12	32	yes	hard	yes	yes	yes
+ * Sunrise Point-H (PCH)	0xa123  32	yes	hard	yes	yes	yes
+ * Sunrise Point-LP (PCH)	0x9d23	32	yes	hard	yes	yes	yes
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
@@ -82,6 +83,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/dmi.h>
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
 
@@ -221,13 +233,18 @@ struct i801_priv {
 	const struct i801_mux_config *mux_drvdata;
 	struct platform_device *mux_pdev;
 #endif
+
+	struct work_struct host_notify;
 };
 
+#define SMBHSTNTFY_SIZE		8
+
 #define FEATURE_SMBUS_PEC	(1 << 0)
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 #define FEATURE_IRQ		(1 << 4)
+#define FEATURE_HOST_NOTIFY	(1 << 5)
 /* Not really a feature, but it's convenient to handle it as such */
 #define FEATURE_IDF		(1 << 15)
 
@@ -237,6 +254,7 @@ static const char *i801_feature_names[] = {
 	"Block process call",
 	"I2C block read",
 	"Interrupt",
+	"SMBus Host Notify",
 };
 
 static unsigned int disable_features;
@@ -245,7 +263,8 @@ MODULE_PARM_DESC(disable_features, "Disable selected driver features:\n"
 	"\t\t  0x01  disable SMBus PEC\n"
 	"\t\t  0x02  disable the block buffer\n"
 	"\t\t  0x08  disable the I2C block read functionality\n"
-	"\t\t  0x10  don't use interrupts ");
+	"\t\t  0x10  don't use interrupts\n"
+	"\t\t  0x20  disable SMBus Host Notify ");
 
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
@@ -480,7 +499,36 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 }
 
 /*
- * There are two kinds of interrupts:
+ * The Host Notify IRQ handler needs to hand work off to a task which can
+ * sleep, because i2c_propagate_smbus_host_notify() can't be called in IRQ
+ * context.
+ */
+static void i801_host_notify(struct work_struct *work)
+{
+	struct i801_priv *priv;
+	unsigned short addr;
+	unsigned int data;
+
+	priv = container_of(work, struct i801_priv, host_notify);
+
+	addr = inb_p(SMBNTFDADD(priv)) >> 1;
+	data = inw_p(SMBNTFDDAT(priv));
+
+	/* clear Host Notify bit to allow a new interrupt */
+	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
+
+	i2c_propagate_smbus_host_notify(&priv->adapter, addr, data);
+}
+
+static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
+{
+	schedule_work(&priv->host_notify);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * There are three kinds of interrupts:
  *
  * 1) i801 signals transaction completion with one of these interrupts:
  *      INTR - Success
@@ -492,6 +540,8 @@ static void i801_isr_byte_done(struct i801_priv *priv)
  *
  * 2) For byte-by-byte (I2C read/write) transactions, one BYTE_DONE interrupt
  *    occurs for each byte of a byte-by-byte to prepare the next byte.
+ *
+ * 3) Host Notify interrupts
  */
 static irqreturn_t i801_isr(int irq, void *dev_id)
 {
@@ -504,6 +554,12 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
 	if (!(pcists & SMBPCISTS_INTS))
 		return IRQ_NONE;
 
+	if (priv->features & FEATURE_HOST_NOTIFY) {
+		status = inb_p(SMBSLVSTS(priv));
+		if (status & SMBSLVSTS_HST_NTFY_STS)
+			return i801_host_notify_isr(priv);
+	}
+
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_BYTE_DONE)
 		i801_isr_byte_done(priv);
@@ -801,7 +857,21 @@ static u32 i801_func(struct i2c_adapter *adapter)
 	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
 	       ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
 	       ((priv->features & FEATURE_I2C_BLOCK_READ) ?
-		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
+		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) |
+	       ((priv->features & FEATURE_HOST_NOTIFY) ?
+		I2C_FUNC_SMBUS_HOST_NOTIFY : 0);
+}
+
+static void i801_enable_host_notify(struct i2c_adapter *adapter)
+{
+	struct i801_priv *priv = i2c_get_adapdata(adapter);
+
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return;
+
+	outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
+	/* clear Host Notify bit to allow a new notification */
+	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
@@ -1166,6 +1236,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		priv->features |= FEATURE_BLOCK_BUFFER;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801CA_3:
+		priv->features |= FEATURE_HOST_NOTIFY;
+		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801BA_2:
 	case PCI_DEVICE_ID_INTEL_82801AB_3:
 	case PCI_DEVICE_ID_INTEL_82801AA_3:
@@ -1250,6 +1322,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		}
 	}
 
+	INIT_WORK(&priv->host_notify, i801_host_notify);
+
 	if (priv->features & FEATURE_IRQ) {
 		init_waitqueue_head(&priv->waitq);
 
@@ -1279,6 +1353,13 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return err;
 	}
 
+	/*
+	 * Enable Host Notify for chips that supports it.
+	 * It is done after i2c_add_adapter() so that we are sure the work queue
+	 * is not used if i2c_add_adapter() fails.
+	 */
+	i801_enable_host_notify(&priv->adapter);
+
 	i801_probe_optional_slaves(priv);
 	/* We ignore errors - multiplexing is optional */
 	i801_add_mux(priv);
@@ -1292,6 +1373,8 @@ static void i801_remove(struct pci_dev *dev)
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
+	cancel_work_sync(&priv->host_notify);
+
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
@@ -1315,8 +1398,11 @@ static int i801_suspend(struct pci_dev *dev, pm_message_t mesg)
 
 static int i801_resume(struct pci_dev *dev)
 {
+	struct i801_priv *priv = pci_get_drvdata(dev);
+
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
+	i801_enable_host_notify(&priv->adapter);
 	return 0;
 }
 #else
-- 
2.4.3
