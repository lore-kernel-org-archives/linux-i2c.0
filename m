From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3 v4] i2c-i801: Enable IRQ for SMBus transactions
Date: Tue, 10 Jul 2012 14:56:06 +0200
Message-ID: <20120710145606.070181cf@endymion.delvare>
References: <20120710145156.306e611d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120710145156.306e611d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Add a new 'feature' to i2c-i801 to enable using PCI interrupts.
When the feature is enabled, then an isr is installed for the device's
PCI IRQ.

An I2C/SMBus transaction is always terminated by one of the following
interrupt sources: FAILED, BUS_ERR, DEV_ERR, or on success: INTR.

When the isr fires for one of these cases, it sets the ->status variable
and wakes up the waitq.  The waitq then saves off the status code, and
clears ->status (in preparation for some future transaction).
The SMBus controller generates an INTR irq at the end of each
transaction where INTREN was set in the HST_CNT register.

No locking is needed around accesses to priv->status since all writes to
it are serialized: it is only ever set once in the isr at the end of a
transaction, and cleared while no interrupts can occur.  In addition, the
I2C adapter lock guarantees that entire I2C transactions for a single
adapter are always serialized.

For this patch, the INTREN bit is set only for SMBus block, byte and word
transactions, but not for I2C reads or writes.  The use of the DS
(BYTE_DONE) interrupt with byte-by-byte I2C transactions is implemented in
a subsequent patch.

The interrupt feature has only been enabled for COUGARPOINT hardware.
In addition, it is disabled if SMBus is using the SMI# interrupt.

Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
I updated the documentation too.

 Documentation/i2c/busses/i2c-i801 |   13 +++-
 drivers/i2c/busses/i2c-i801.c     |   98 +++++++++++++++++++++++++++++++++++--
 2 files changed, 104 insertions(+), 7 deletions(-)

--- linux-3.5-rc6.orig/drivers/i2c/busses/i2c-i801.c	2012-07-10 11:58:01.766298677 +0200
+++ linux-3.5-rc6/drivers/i2c/busses/i2c-i801.c	2012-07-10 13:50:38.083239548 +0200
@@ -60,10 +60,12 @@
   Block process call transaction   no
   I2C block read transaction       yes  (doesn't use the block buffer)
   Slave mode                       no
+  Interrupt processing             yes
 
   See the file Documentation/i2c/busses/i2c-i801 for details.
 */
 
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -76,6 +78,7 @@
 #include <linux/io.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/wait.h>
 
 /* I801 SMBus address offsets */
 #define SMBHSTSTS(p)	(0 + (p)->smba)
@@ -91,8 +94,12 @@
 
 /* PCI Address Constants */
 #define SMBBAR		4
+#define SMBPCISTS	0x006
 #define SMBHSTCFG	0x040
 
+/* Host status bits for SMBPCISTS */
+#define SMBPCISTS_INTS		0x08
+
 /* Host configuration bits for SMBHSTCFG */
 #define SMBHSTCFG_HST_EN	1
 #define SMBHSTCFG_SMB_SMI_EN	2
@@ -155,6 +162,10 @@ struct i801_priv {
 	unsigned char original_hstcfg;
 	struct pci_dev *pci_dev;
 	unsigned int features;
+
+	/* isr processing */
+	wait_queue_head_t waitq;
+	u8 status;
 };
 
 static struct pci_driver i801_driver;
@@ -163,6 +174,7 @@ static struct pci_driver i801_driver;
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
+#define FEATURE_IRQ		(1 << 4)
 /* Not really a feature, but it's convenient to handle it as such */
 #define FEATURE_IDF		(1 << 15)
 
@@ -171,6 +183,7 @@ static const char *i801_feature_names[]
 	"Block buffer",
 	"Block process call",
 	"I2C block read",
+	"Interrupt",
 };
 
 static unsigned int disable_features;
@@ -215,7 +228,12 @@ static int i801_check_post(struct i801_p
 {
 	int result = 0;
 
-	/* If the SMBus is still busy, we give up */
+	/*
+	 * If the SMBus is still busy, we give up
+	 * Note: This timeout condition only happens when using polling
+	 * transactions.  For interrupt operation, NAK/timeout is indicated by
+	 * DEV_ERR.
+	 */
 	if (unlikely(status < 0)) {
 		dev_err(&priv->pci_dev->dev, "Transaction timeout\n");
 		/* try to stop the current command */
@@ -305,6 +323,14 @@ static int i801_transaction(struct i801_
 	if (result < 0)
 		return result;
 
+	if (priv->features & FEATURE_IRQ) {
+		outb_p(xact | SMBHSTCNT_INTREN | SMBHSTCNT_START,
+		       SMBHSTCNT(priv));
+		wait_event(priv->waitq, (status = priv->status));
+		priv->status = 0;
+		return i801_check_post(priv, status);
+	}
+
 	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
 	 * SMBSCMD are passed in xact */
 	outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
@@ -348,6 +374,43 @@ static int i801_block_transaction_by_blo
 }
 
 /*
+ * i801 signals transaction completion with one of these interrupts:
+ *   INTR - Success
+ *   DEV_ERR - Invalid command, NAK or communication timeout
+ *   BUS_ERR - SMI# transaction collision
+ *   FAILED - transaction was canceled due to a KILL request
+ * When any of these occur, update ->status and wake up the waitq.
+ * ->status must be cleared before kicking off the next transaction.
+ */
+static irqreturn_t i801_isr(int irq, void *dev_id)
+{
+	struct i801_priv *priv = dev_id;
+	u16 pcists;
+	u8 status;
+
+	/* Confirm this is our interrupt */
+	pci_read_config_word(priv->pci_dev, SMBPCISTS, &pcists);
+	if (!(pcists & SMBPCISTS_INTS))
+		return IRQ_NONE;
+
+	status = inb_p(SMBHSTSTS(priv));
+	dev_dbg(&priv->pci_dev->dev, "irq: status = %02x\n", status);
+
+	/*
+	 * Clear irq sources and report transaction result.
+	 * ->status must be cleared before the next transaction is started.
+	 */
+	status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
+	if (status) {
+		outb_p(status, SMBHSTSTS(priv));
+		priv->status |= status;
+		wake_up(&priv->waitq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
  * For "byte-by-byte" block transactions:
  *   I2C write uses cmd=I801_BLOCK_DATA, I2C_EN=1
  *   I2C read uses cmd=I801_I2C_BLOCK_DATA
@@ -799,6 +862,10 @@ static int __devinit i801_probe(struct p
 		break;
 	}
 
+	/* IRQ processing only tested on CougarPoint PCH */
+	if (dev->device == PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS)
+		priv->features |= FEATURE_IRQ;
+
 	/* Disable features on user request */
 	for (i = 0; i < ARRAY_SIZE(i801_feature_names); i++) {
 		if (priv->features & disable_features & (1 << i))
@@ -846,16 +913,31 @@ static int __devinit i801_probe(struct p
 	}
 	pci_write_config_byte(priv->pci_dev, SMBHSTCFG, temp);
 
-	if (temp & SMBHSTCFG_SMB_SMI_EN)
+	if (temp & SMBHSTCFG_SMB_SMI_EN) {
 		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
-	else
+		/* Disable SMBus interrupt feature if SMBus using SMI# */
+		priv->features &= ~FEATURE_IRQ;
+	} else {
 		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
+	}
 
 	/* Clear special mode bits */
 	if (priv->features & (FEATURE_SMBUS_PEC | FEATURE_BLOCK_BUFFER))
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	if (priv->features & FEATURE_IRQ) {
+		init_waitqueue_head(&priv->waitq);
+
+		err = request_irq(dev->irq, i801_isr, IRQF_SHARED,
+				  i801_driver.name, priv);
+		if (err) {
+			dev_err(&dev->dev, "Failed to allocate irq %d: %d\n",
+				dev->irq, err);
+			goto exit_release;
+		}
+	}
+
 	/* set up the sysfs linkage to our parent device */
 	priv->adapter.dev.parent = &dev->dev;
 
@@ -867,14 +949,18 @@ static int __devinit i801_probe(struct p
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
 		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
-		goto exit_release;
+		goto exit_free_irq;
 	}
 
 	i801_probe_optional_slaves(priv);
 
 	pci_set_drvdata(dev, priv);
+
 	return 0;
 
+exit_free_irq:
+	if (priv->features & FEATURE_IRQ)
+		free_irq(dev->irq, priv);
 exit_release:
 	pci_release_region(dev, SMBBAR);
 exit:
@@ -888,7 +974,11 @@ static void __devexit i801_remove(struct
 
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
+
+	if (priv->features & FEATURE_IRQ)
+		free_irq(dev->irq, priv);
 	pci_release_region(dev, SMBBAR);
+
 	pci_set_drvdata(dev, NULL);
 	kfree(priv);
 	/*
--- linux-3.5-rc6.orig/Documentation/i2c/busses/i2c-i801	2012-05-27 22:55:43.000000000 +0200
+++ linux-3.5-rc6/Documentation/i2c/busses/i2c-i801	2012-07-10 13:57:25.414254138 +0200
@@ -38,9 +38,10 @@ Module Parameters
 Disable selected features normally supported by the device. This makes it
 possible to work around possible driver or hardware bugs if the feature in
 question doesn't work as intended for whatever reason. Bit values:
-  1  disable SMBus PEC
-  2  disable the block buffer
-  8  disable the I2C block read functionality
+ 0x01  disable SMBus PEC
+ 0x02  disable the block buffer
+ 0x08  disable the I2C block read functionality
+ 0x10  don't use interrupts
 
 
 Description
@@ -86,6 +87,12 @@ SMBus 2.0 Support
 The 82801DB (ICH4) and later chips support several SMBus 2.0 features.
 
 
+Interrupt Support
+-----------------
+
+PCI interrupt support is supported on the 82801EB (ICH5) and later chips.
+
+
 Hidden ICH SMBus
 ----------------
 

-- 
Jean Delvare
