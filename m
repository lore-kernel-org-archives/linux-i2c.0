From: minyard@acm.org
Subject: [PATCH 5/5] i2c-i801: Remove redundant code and event-drive
Date: Tue, 19 Jan 2016 11:09:37 -0600
Message-ID: <1453223377-20608-6-git-send-email-minyard@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:61026 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960AbcASSKI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:10:08 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173017.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700NWFMC52W50@vms173017.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:09:45 -0600 (CST)
In-reply-to: <1453223377-20608-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

There was a lot of redundant code in the driver, basically one copy
for the polled interface and one for the interrupt-driven interface.
Only use the interrupt-driven interface and use a timer to check
the interface periodically and time things out.

This also adds timeouts when using interrupt, so a failed operation
won't hang forever.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/busses/i2c-i801.c | 582 +++++++++++++++++++++---------------------
 1 file changed, 284 insertions(+), 298 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 840656c..ed528e2 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -100,6 +100,8 @@
 #include <linux/gpio.h>
 #include <linux/i2c-mux-gpio.h>
 #endif
+#include <linux/spinlock.h>
+#include <linux/hrtimer.h>
 
 /* I801 SMBus address offsets */
 #define SMBHSTSTS(p)	(0 + (p)->smba)
@@ -148,6 +150,8 @@
 #define SMBAUXCTL_E32B		2
 
 /* Other settings */
+#define I801_TIMEOUT_NS		250000
+#define I801_TIMEOUT_DELTA_NS	250000
 #define MAX_RETRIES		400
 
 /* I801 command constants */
@@ -227,17 +231,25 @@ struct i801_priv {
 	struct pci_dev *pci_dev;
 	unsigned int features;
 
-	/* isr processing */
+	/* isr/timer processing */
 	wait_queue_head_t waitq;
 	u8 status;
 	u8 xact_extra; /* Used to set INTREN if irqs enabled, and HWPEC */
+	struct hrtimer timer;
+	long timeout;
+	int retries;
+	int done;
+	spinlock_t lock;
 
-	/* Command state used by isr for byte-by-byte block transactions */
+	/* Command state */
 	u8 cmd;
+	u8 xact;
 	bool is_read;
+	int byte_by_byte;
+	int block;
 	int count;
+	int hostc;
 	int len;
-	u8 *data;
 
 #if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
 		defined CONFIG_DMI
@@ -245,6 +257,7 @@ struct i801_priv {
 	struct platform_device *mux_pdev;
 #endif
 	struct platform_device *tco_pdev;
+	union i2c_smbus_data *data;
 };
 
 #define FEATURE_SMBUS_PEC	(1 << 0)
@@ -272,16 +285,76 @@ MODULE_PARM_DESC(disable_features, "Disable selected driver features:\n"
 	"\t\t  0x08  disable the I2C block read functionality\n"
 	"\t\t  0x10  don't use interrupts ");
 
+static void i801_op_done(struct i801_priv *priv);
+
+static void i801_write_block(struct i801_priv *priv, union i2c_smbus_data *data)
+{
+	int i, len;
+
+	len = data->block[0];
+	outb_p(len, SMBHSTDAT0(priv));
+	for (i = 0; i < len; i++)
+		outb_p(data->block[i+1], SMBBLKDAT(priv));
+}
+
+static int i801_read_block(struct i801_priv *priv, union i2c_smbus_data *data)
+{
+	int i, len;
+
+	len = inb_p(SMBHSTDAT0(priv));
+	if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
+		return -EPROTO;
+
+	data->block[0] = len;
+	for (i = 0; i < len; i++)
+		data->block[i + 1] = inb_p(SMBBLKDAT(priv));
+
+	return 0;
+}
+
+static int i801_terminate_transaction(struct i801_priv *priv)
+{
+	int status, ret = 0, i;
+
+	dev_dbg(&priv->pci_dev->dev, "Terminating the current operation\n");
+
+	/* Flush the input buffer */
+	for (i = 0; i < 32; i++)
+		inb_p(SMBBLKDAT(priv));
+
+	status = inb_p(SMBHSTSTS(priv));
+	if (!(status & SMBHSTSTS_HOST_BUSY))
+		return 0;
+
+	outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL, SMBHSTCNT(priv));
+	usleep_range(1000, 2000);
+	outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL), SMBHSTCNT(priv));
+
+	/* Check if it worked */
+	status = inb_p(SMBHSTSTS(priv));
+	if ((status & SMBHSTSTS_HOST_BUSY) || !(status & SMBHSTSTS_FAILED)) {
+		dev_err(&priv->pci_dev->dev,
+			"Failed terminating the transaction\n");
+		ret = -EAGAIN;
+	}
+	outb_p(STATUS_FLAGS, SMBHSTSTS(priv));
+	return ret;
+}
+
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
 static int i801_check_pre(struct i801_priv *priv)
 {
-	int status;
+	int status, ret;
 
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_HOST_BUSY) {
-		dev_err(&priv->pci_dev->dev, "SMBus is busy, can't use it!\n");
-		return -EBUSY;
+		ret = i801_terminate_transaction(priv);
+		if (ret) {
+			dev_err(&priv->pci_dev->dev,
+				"SMBus is busy, can't use it!\n");
+			return -EBUSY;
+		}
 	}
 
 	status &= STATUS_FLAGS;
@@ -306,174 +379,101 @@ static int i801_check_pre(struct i801_priv *priv)
  * Note that status only contains the bits we want to clear, not the
  * actual register value.
  */
-static int i801_check_post(struct i801_priv *priv, int status)
+static int i801_check_post(struct i801_priv *priv)
 {
 	int result = 0;
 
+	hrtimer_cancel(&priv->timer);
+
 	/*
 	 * If the SMBus is still busy, we give up
 	 * Note: This timeout condition only happens when using polling
 	 * transactions.  For interrupt operation, NAK/timeout is indicated by
 	 * DEV_ERR.
 	 */
-	if (unlikely(status < 0)) {
+	if (unlikely(priv->status < 0)) {
 		dev_err(&priv->pci_dev->dev, "Transaction timeout\n");
 		/* try to stop the current command */
-		dev_dbg(&priv->pci_dev->dev, "Terminating the current operation\n");
-		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL,
-		       SMBHSTCNT(priv));
-		usleep_range(1000, 2000);
-		outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL),
-		       SMBHSTCNT(priv));
-
-		/* Check if it worked */
-		status = inb_p(SMBHSTSTS(priv));
-		if ((status & SMBHSTSTS_HOST_BUSY) ||
-		    !(status & SMBHSTSTS_FAILED))
-			dev_err(&priv->pci_dev->dev,
-				"Failed terminating the transaction\n");
-		outb_p(STATUS_FLAGS, SMBHSTSTS(priv));
-		return -ETIMEDOUT;
+		i801_terminate_transaction(priv);
+		result = -ETIMEDOUT;
+		goto out;
 	}
 
-	if (status & SMBHSTSTS_FAILED) {
+	if (priv->status & SMBHSTSTS_FAILED) {
 		result = -EIO;
 		dev_err(&priv->pci_dev->dev, "Transaction failed\n");
 	}
-	if (status & SMBHSTSTS_DEV_ERR) {
+	if (priv->status & SMBHSTSTS_DEV_ERR) {
 		result = -ENXIO;
 		dev_dbg(&priv->pci_dev->dev, "No response\n");
 	}
-	if (status & SMBHSTSTS_BUS_ERR) {
+	if (priv->status & SMBHSTSTS_BUS_ERR) {
 		result = -EAGAIN;
 		dev_dbg(&priv->pci_dev->dev, "Lost arbitration\n");
 	}
 
 	/* Clear status flags except BYTE_DONE, to be cleared by caller */
-	outb_p(status, SMBHSTSTS(priv));
+	outb_p(priv->status, SMBHSTSTS(priv));
 
-	return result;
-}
+	if (!result && priv->block && priv->is_read && !priv->byte_by_byte)
+		result = i801_read_block(priv, priv->data);
 
-/* Wait for BUSY being cleared and either INTR or an error flag being set */
-static int i801_wait_intr(struct i801_priv *priv)
-{
-	int timeout = 0;
-	int status;
-
-	/* We will always wait for a fraction of a second! */
-	do {
-		usleep_range(250, 500);
-		status = inb_p(SMBHSTSTS(priv));
-	} while (((status & SMBHSTSTS_HOST_BUSY) ||
-		  !(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR))) &&
-		 (timeout++ < MAX_RETRIES));
-
-	if (timeout > MAX_RETRIES) {
-		dev_dbg(&priv->pci_dev->dev, "INTR Timeout!\n");
-		return -ETIMEDOUT;
-	}
-	return status & (STATUS_ERROR_FLAGS | SMBHSTSTS_INTR);
-}
+	/*
+	 * Some BIOSes don't like it when PEC is enabled at reboot or resume
+	 * time, so we forcibly disable it after every transaction. Turn off
+	 * E32B for the same reason.
+	 */
+	outb_p(inb_p(SMBAUXCTL(priv)) &
+	       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
-/* Wait for either BYTE_DONE or an error flag being set */
-static int i801_wait_byte_done(struct i801_priv *priv)
-{
-	int timeout = 0;
-	int status;
-
-	/* We will always wait for a fraction of a second! */
-	do {
-		usleep_range(250, 500);
-		status = inb_p(SMBHSTSTS(priv));
-	} while (!(status & (STATUS_ERROR_FLAGS | SMBHSTSTS_BYTE_DONE)) &&
-		 (timeout++ < MAX_RETRIES));
-
-	if (timeout > MAX_RETRIES) {
-		dev_dbg(&priv->pci_dev->dev, "BYTE_DONE Timeout!\n");
-		return -ETIMEDOUT;
+	if (priv->hostc >= 0)
+		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, priv->hostc);
+
+	if (priv->block)
+		goto out;
+	if (result)
+		goto out;
+	if (!priv->is_read || (priv->xact == I801_QUICK))
+		goto out;
+
+	switch (priv->xact & 0x7f) {
+	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
+	case I801_BYTE_DATA:
+		priv->data->byte = inb_p(SMBHSTDAT0(priv));
+		break;
+	case I801_WORD_DATA:
+		priv->data->word = inb_p(SMBHSTDAT0(priv)) +
+			     (inb_p(SMBHSTDAT1(priv)) << 8);
+		break;
 	}
-	return status & STATUS_ERROR_FLAGS;
+out:
+	return result;
 }
 
-static int i801_transaction(struct i801_priv *priv, int xact)
+static void i801_transaction(struct i801_priv *priv, int xact)
 {
-	int status;
-	int result;
-	const struct i2c_adapter *adap = &priv->adapter;
-
 	/*
 	 * the current contents of SMBHSTCNT can be overwritten, since PEC,
 	 * SMBSCMD are passed in xact
 	 */
 	outb_p(xact | priv->xact_extra | SMBHSTCNT_START,  SMBHSTCNT(priv));
-
-	if (priv->features & FEATURE_IRQ) {
-		result = wait_event_timeout(priv->waitq,
-					    (status = priv->status),
-					    adap->timeout);
-		if (!result) {
-			status = -ETIMEDOUT;
-			dev_warn(&priv->pci_dev->dev,
-				 "Timeout waiting for interrupt!\n");
-		}
-		priv->status = 0;
-		return i801_check_post(priv, status);
-	}
-
-	status = i801_wait_intr(priv);
-	return i801_check_post(priv, status);
 }
 
-static void i801_write_block(struct i801_priv *priv, union i2c_smbus_data *data)
+static void i801_block_transaction_by_block(struct i801_priv *priv)
 {
-	int i, len;
-
-	len = data->block[0];
-	outb_p(len, SMBHSTDAT0(priv));
-	for (i = 0; i < len; i++)
-		outb_p(data->block[i+1], SMBBLKDAT(priv));
-}
-
-static int i801_read_block(struct i801_priv *priv, union i2c_smbus_data *data)
-{
-	int i, len;
-
-	len = inb_p(SMBHSTDAT0(priv));
-	if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
-		return -EPROTO;
-
-	data->block[0] = len;
-	for (i = 0; i < len; i++)
-		data->block[i + 1] = inb_p(SMBBLKDAT(priv));
-
-	return 0;
-}
-
-static int i801_block_transaction_by_block(struct i801_priv *priv,
-					   union i2c_smbus_data *data,
-					   char read_write)
-{
-	int result;
-
 	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
 
 	/* Use 32-byte buffer to process this transaction */
-	if (read_write == I2C_SMBUS_WRITE)
-		i801_write_block(priv, data);
-
-	result = i801_transaction(priv, I801_BLOCK_DATA);
-	if (result)
-		return result;
+	if (!priv->is_read)
+		i801_write_block(priv, priv->data);
 
-	if (read_write == I2C_SMBUS_READ)
-		result = i801_read_block(priv, data);
-
-	return result;
+	i801_transaction(priv, I801_BLOCK_DATA);
 }
 
-static void i801_isr_byte_done(struct i801_priv *priv)
+static void i801_byte_done(struct i801_priv *priv)
 {
+	u8 *data = &priv->data->block[1];
+
 	if (priv->is_read) {
 		/* For SMBus block reads, length is received with first byte */
 		if (((priv->cmd & 0x1c) == I801_BLOCK_DATA) &&
@@ -490,12 +490,12 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 					"SMBus block read size is %d\n",
 					priv->len);
 			}
-			priv->data[-1] = priv->len;
+			data[-1] = priv->len;
 		}
 
 		/* Read next byte */
 		if (priv->count < priv->len)
-			priv->data[priv->count++] = inb(SMBBLKDAT(priv));
+			data[priv->count++] = inb(SMBBLKDAT(priv));
 		else
 			dev_dbg(&priv->pci_dev->dev,
 				"Discarding extra byte on block read\n");
@@ -506,13 +506,58 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 			       SMBHSTCNT(priv));
 	} else if (priv->count < priv->len - 1) {
 		/* Write next byte, except for IRQ after last byte */
-		outb_p(priv->data[++priv->count], SMBBLKDAT(priv));
+		outb_p(data[++priv->count], SMBBLKDAT(priv));
 	}
 
 	/* Clear BYTE_DONE to continue with next byte */
 	outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
 }
 
+static int i801_check(struct i801_priv *priv, u8 status)
+{
+	if (status & SMBHSTSTS_BYTE_DONE)
+		i801_byte_done(priv);
+
+	/*
+	 * Clear irq sources and report transaction result.
+	 * ->status must be cleared before the next transaction is started.
+	 */
+	status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
+	if (status) {
+		outb_p(status, SMBHSTSTS(priv));
+		priv->status |= status;
+		i801_op_done(priv);
+		return 1;
+	}
+	return 0;
+}
+
+static enum hrtimer_restart i801_timeout(struct hrtimer *hrtimer)
+{
+	struct i801_priv *priv = container_of(hrtimer, struct i801_priv, timer);
+	u8 status = inb_p(SMBHSTSTS(priv));
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (!priv->done && !i801_check(priv, status)) {
+		priv->retries--;
+		if (priv->retries > 0) {
+			hrtimer_set_expires_range(&priv->timer,
+				ktime_add_ns(ktime_get(), priv->timeout),
+				ns_to_ktime(I801_TIMEOUT_DELTA_NS));
+			ret = HRTIMER_RESTART;
+		} else {
+			dev_dbg(&priv->pci_dev->dev, "timeout, status = %02x\n",
+				status);
+			priv->status = -1;
+			i801_op_done(priv);
+		}
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return ret;
+}
+
 /*
  * There are two kinds of interrupts:
  *
@@ -539,19 +584,9 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	status = inb_p(SMBHSTSTS(priv));
-	if (status & SMBHSTSTS_BYTE_DONE)
-		i801_isr_byte_done(priv);
-
-	/*
-	 * Clear irq sources and report transaction result.
-	 * ->status must be cleared before the next transaction is started.
-	 */
-	status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
-	if (status) {
-		outb_p(status, SMBHSTSTS(priv));
-		priv->status |= status;
-		wake_up(&priv->waitq);
-	}
+	spin_lock(&priv->lock);
+	i801_check(priv, status);
+	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
 }
@@ -561,95 +596,31 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
  *   I2C write uses cmd=I801_BLOCK_DATA, I2C_EN=1
  *   I2C read uses cmd=I801_I2C_BLOCK_DATA
  */
-static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
-					       union i2c_smbus_data *data,
-					       char read_write, int command)
+static void i801_block_transaction_byte_by_byte(struct i801_priv *priv,
+						int command)
 {
-	int i, len;
+	int len;
 	int smbcmd;
-	int status;
-	int result;
-	const struct i2c_adapter *adap = &priv->adapter;
 
-	len = data->block[0];
+	len = priv->data->block[0];
 
-	if (read_write == I2C_SMBUS_WRITE) {
+	if (!priv->is_read) {
 		outb_p(len, SMBHSTDAT0(priv));
-		outb_p(data->block[1], SMBBLKDAT(priv));
+		outb_p(priv->data->block[1], SMBBLKDAT(priv));
 	}
 
-	if (command == I2C_SMBUS_I2C_BLOCK_DATA &&
-	    read_write == I2C_SMBUS_READ)
+	if (command == I2C_SMBUS_I2C_BLOCK_DATA && priv->is_read)
 		smbcmd = I801_I2C_BLOCK_DATA;
 	else
 		smbcmd = I801_BLOCK_DATA;
 
-	if (priv->features & FEATURE_IRQ) {
-		priv->is_read = (read_write == I2C_SMBUS_READ);
-		if (len == 1 && priv->is_read)
-			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		priv->cmd = smbcmd | priv->xact_extra;
-		priv->len = len;
-		priv->count = 0;
-		priv->data = &data->block[1];
-
-		outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
-		result = wait_event_timeout(priv->waitq,
-					    (status = priv->status),
-					    adap->timeout);
-		if (!result) {
-			status = -ETIMEDOUT;
-			dev_warn(&priv->pci_dev->dev,
-				 "Timeout waiting for interrupt!\n");
-		}
-		priv->status = 0;
-		return i801_check_post(priv, status);
-	}
-
-	for (i = 1; i <= len; i++) {
-		if (i == len && read_write == I2C_SMBUS_READ)
-			smbcmd |= SMBHSTCNT_LAST_BYTE;
-		outb_p(smbcmd, SMBHSTCNT(priv));
-
-		if (i == 1)
-			outb_p(inb(SMBHSTCNT(priv)) | SMBHSTCNT_START,
-			       SMBHSTCNT(priv));
-
-		status = i801_wait_byte_done(priv);
-		if (status)
-			goto exit;
-
-		if (i == 1 && read_write == I2C_SMBUS_READ
-		 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
-			len = inb_p(SMBHSTDAT0(priv));
-			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
-				dev_err(&priv->pci_dev->dev,
-					"Illegal SMBus block read size %d\n",
-					len);
-				/* Recover */
-				while (inb_p(SMBHSTSTS(priv)) &
-				       SMBHSTSTS_HOST_BUSY)
-					outb_p(SMBHSTSTS_BYTE_DONE,
-					       SMBHSTSTS(priv));
-				outb_p(SMBHSTSTS_INTR, SMBHSTSTS(priv));
-				return -EPROTO;
-			}
-			data->block[0] = len;
-		}
-
-		/* Retrieve/store value in SMBBLKDAT */
-		if (read_write == I2C_SMBUS_READ)
-			data->block[i] = inb_p(SMBBLKDAT(priv));
-		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
-			outb_p(data->block[i+1], SMBBLKDAT(priv));
-
-		/* signals SMBBLKDAT ready */
-		outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
-	}
+	if (len == 1 && priv->is_read)
+		smbcmd |= SMBHSTCNT_LAST_BYTE;
+	priv->cmd = smbcmd | priv->xact_extra;
+	priv->len = len;
+	priv->count = 0;
 
-	status = i801_wait_intr(priv);
-exit:
-	return i801_check_post(priv, status);
+	outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
 }
 
 static int i801_set_block_buffer_mode(struct i801_priv *priv)
@@ -662,19 +633,17 @@ static int i801_set_block_buffer_mode(struct i801_priv *priv)
 
 /* Block transaction function */
 static int i801_block_transaction(struct i801_priv *priv,
-				  union i2c_smbus_data *data, char read_write,
 				  int command, int hwpec)
 {
 	int result = 0;
 
-	if (read_write == I2C_SMBUS_WRITE
-	 || command == I2C_SMBUS_I2C_BLOCK_DATA) {
-		if (data->block[0] < 1)
-			data->block[0] = 1;
-		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
-			data->block[0] = I2C_SMBUS_BLOCK_MAX;
+	if (!priv->is_read || command == I2C_SMBUS_I2C_BLOCK_DATA) {
+		if (priv->data->block[0] < 1)
+			priv->data->block[0] = 1;
+		if (priv->data->block[0] > I2C_SMBUS_BLOCK_MAX)
+			priv->data->block[0] = I2C_SMBUS_BLOCK_MAX;
 	} else {
-		data->block[0] = 32;	/* max for SMBus block reads */
+		priv->data->block[0] = 32;	/* max for SMBus block reads */
 	}
 
 	/* Experience has shown that the block buffer can only be used for
@@ -691,143 +660,154 @@ static int i801_block_transaction(struct i801_priv *priv,
 			outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
 			       SMBAUXCTL(priv));
 
-		result = i801_block_transaction_by_block(priv, data,
-							 read_write);
+		i801_block_transaction_by_block(priv);
 	} else {
 		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
 		       SMBAUXCTL(priv));
-		result = i801_block_transaction_byte_by_byte(priv, data,
-							     read_write,
-							     command);
+		priv->byte_by_byte = 1;
+		i801_block_transaction_byte_by_byte(priv, command);
 	}
 
-	/*
-	 * Some BIOSes don't like it when PEC is enabled at reboot or resume
-	 * time, so we forcibly disable it after every transaction. Turn off
-	 * E32B for the same reason.
-	 */
-	outb_p(inb_p(SMBAUXCTL(priv)) &
-	       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
-
 	return result;
 }
 
-/* Return negative errno on error. */
-static s32 i801_access(struct i2c_adapter *adap, u16 addr,
-		       unsigned short flags, char read_write, u8 command,
-		       int size, union i2c_smbus_data *data)
+static s32 i801_setup(struct i801_priv *priv, u16 addr, u8 command, int size)
 {
-	int block = 0;
-	int ret, xact = 0;
-	struct i801_priv *priv = i2c_get_adapdata(adap);
-	int result;
-	int hostc = -1;
-
 	switch (size) {
 	case I2C_SMBUS_QUICK:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p(((addr & 0x7f) << 1) | priv->is_read,
 		       SMBHSTADD(priv));
-		xact = I801_QUICK;
+		priv->xact = I801_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p(((addr & 0x7f) << 1) | priv->is_read,
 		       SMBHSTADD(priv));
-		if (read_write == I2C_SMBUS_WRITE)
+		if (!priv->is_read)
 			outb_p(command, SMBHSTCMD(priv));
-		xact = I801_BYTE;
+		priv->xact = I801_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p(((addr & 0x7f) << 1) | priv->is_read,
 		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
-		if (read_write == I2C_SMBUS_WRITE)
-			outb_p(data->byte, SMBHSTDAT0(priv));
-		xact = I801_BYTE_DATA;
+		if (!priv->is_read)
+			outb_p(priv->data->byte, SMBHSTDAT0(priv));
+		priv->xact = I801_BYTE_DATA;
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p(((addr & 0x7f) << 1) | priv->is_read,
 		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
-		if (read_write == I2C_SMBUS_WRITE) {
-			outb_p(data->word & 0xff, SMBHSTDAT0(priv));
-			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1(priv));
+		if (!priv->is_read) {
+			outb_p(priv->data->word & 0xff, SMBHSTDAT0(priv));
+			outb_p((priv->data->word & 0xff00) >> 8,
+			       SMBHSTDAT1(priv));
 		}
-		xact = I801_WORD_DATA;
+		priv->xact = I801_WORD_DATA;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p(((addr & 0x7f) << 1) | priv->is_read,
 		       SMBHSTADD(priv));
 		outb_p(command, SMBHSTCMD(priv));
-		block = 1;
+		priv->block = 1;
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
 		/* NB: page 240 of ICH5 datasheet shows that the R/#W
 		 * bit should be cleared here, even when reading */
 		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
-		if (read_write == I2C_SMBUS_READ) {
+		if (!priv->is_read) {
 			unsigned char thostc;
-			/* NB: page 240 of ICH5 datasheet also shows
-			 * that DATA1 is the cmd field when reading */
-			outb_p(command, SMBHSTDAT1(priv));
+			outb_p(command, SMBHSTCMD(priv));
 			/* set I2C_EN bit in configuration register */
 			pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &thostc);
 			pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
 					      thostc | SMBHSTCFG_I2C_EN);
-			hostc = thostc;
+			priv->hostc = thostc;
 		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
 			dev_err(&priv->pci_dev->dev,
 				"I2C block read is unsupported!\n");
 			return -EOPNOTSUPP;
 		} else
-			outb_p(command, SMBHSTCMD(priv));
-		block = 1;
+			/*
+			 * NB: page 240 of ICH5 datasheet also shows
+			 * that DATA1 is the cmd field when reading
+			 */
+			outb_p(command, SMBHSTDAT1(priv));
+		priv->block = 1;
 		break;
 	default:
 		dev_err(&priv->pci_dev->dev, "Unsupported transaction %d\n",
 			size);
 		return -EOPNOTSUPP;
 	}
+	return 0;
+}
+
+static void i801_op_done(struct i801_priv *priv)
+{
+	priv->done = 1;
+	wake_up(&priv->waitq);
+}
+
+/* Return negative errno on error. */
+static s32 i801_access(struct i2c_adapter *adap, u16 addr,
+		       unsigned short flags, char read_write, u8 command,
+		       int size, union i2c_smbus_data *data)
+{
+	struct i801_priv *priv = i2c_get_adapdata(adap);
+	int result;
+
+	priv->is_read = (read_write == I2C_SMBUS_READ);
+	priv->byte_by_byte = 0;
+	priv->done = 0;
+	priv->block = 0;
+	priv->xact = 0;
+	priv->hostc = -1;
+	priv->data = data;
+	priv->status = 0;
+
+	result = i801_setup(priv, addr, command, size);
+	if (result < 0)
+		return result;
 
 	result = i801_check_pre(priv);
 	if (result < 0)
 		return result;
 
 	priv->xact_extra &= ~SMBHSTCNT_PEC_EN;
-	if (block) {
+	if (priv->block) {
 		int hwpec = (priv->features & FEATURE_SMBUS_PEC) &&
 			(flags & I2C_CLIENT_PEC)
 			&& size != I2C_SMBUS_QUICK
 			&& size != I2C_SMBUS_I2C_BLOCK_DATA;
 
-		ret = i801_block_transaction(priv, data, read_write, size,
-					     hwpec);
+		i801_block_transaction(priv, size, hwpec);
 	} else {
 		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
 		       SMBAUXCTL(priv));
-		ret = i801_transaction(priv, xact);
+		i801_transaction(priv, priv->xact);
 	}
 
-	if (hostc >= 0)
-		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
+	if (priv->features & FEATURE_IRQ) {
+		priv->timeout = I801_TIMEOUT_NS * MAX_RETRIES;
+		priv->retries = 1;
+	} else {
+		priv->timeout = I801_TIMEOUT_NS;
+		priv->retries = MAX_RETRIES;
+	}
 
-	if (block)
-		return ret;
-	if (ret)
-		return ret;
-	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
-		return 0;
+	hrtimer_start_range_ns(&priv->timer,
+			       ktime_add_ns(ktime_get(), priv->timeout),
+			       I801_TIMEOUT_DELTA_NS,
+			       HRTIMER_MODE_ABS);
 
-	switch (xact & 0x7f) {
-	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
-	case I801_BYTE_DATA:
-		data->byte = inb_p(SMBHSTDAT0(priv));
-		break;
-	case I801_WORD_DATA:
-		data->word = inb_p(SMBHSTDAT0(priv)) +
-			     (inb_p(SMBHSTDAT1(priv)) << 8);
-		break;
+	result = wait_event_timeout(priv->waitq, priv->status, adap->timeout);
+	if (!result) {
+		priv->status = -ETIMEDOUT;
+		dev_warn(&priv->pci_dev->dev,
+			 "Timeout waiting for interrupt!\n");
 	}
-	return 0;
+	return i801_check_post(priv);
 }
 
 
@@ -1281,6 +1261,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	priv->adapter.dev.parent = &dev->dev;
 	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
 	priv->adapter.retries = 3;
+	spin_lock_init(&priv->lock);
+	hrtimer_init(&priv->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	priv->timer.function = i801_timeout;
 
 	priv->pci_dev = dev;
 	switch (dev->device) {
@@ -1376,6 +1359,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		outb_p(inb_p(SMBAUXCTL(priv)) &
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
+	init_waitqueue_head(&priv->waitq);
+
 	/* Default timeout in interrupt mode: 200 ms */
 	priv->adapter.timeout = HZ / 5;
 
@@ -1397,7 +1382,6 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	if (priv->features & FEATURE_IRQ) {
 		priv->xact_extra |= SMBHSTCNT_INTREN;
-		init_waitqueue_head(&priv->waitq);
 
 		err = devm_request_irq(&dev->dev, dev->irq, i801_isr,
 				       IRQF_SHARED,
@@ -1440,6 +1424,8 @@ static void i801_remove(struct pci_dev *dev)
 
 	platform_device_unregister(priv->tco_pdev);
 
+	hrtimer_cancel(&priv->timer);
+	kfree(priv);
 	/*
 	 * do not call pci_disable_device(dev) since it can cause hard hangs on
 	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E8010)
-- 
2.5.0
