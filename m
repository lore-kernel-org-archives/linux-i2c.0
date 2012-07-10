From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3 v4] i2c-i801: Enable IRQ for byte_by_byte transactions
Date: Tue, 10 Jul 2012 15:01:32 +0200
Message-ID: <20120710150132.3c503576@endymion.delvare>
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

Byte-by-byte transactions are used primarily for accessing I2C devices
with an SMBus controller.  For these transactions, for each byte that is
read or written, the SMBus controller generates a BYTE_DONE IRQ.  The isr
reads/writes the next byte, and clears the IRQ flag to start the next byte.
On the penultimate IRQ, the isr also sets the LAST_BYTE flag.

There is no locking around the cmd/len/count/data variables, since the
I2C adapter lock ensures there is never multiple simultaneous transactions
for the same device, and the driver thread never accesses these variables
while interrupts might be occurring.

The end result is faster I2C block read and write transactions.

Note: This patch has only been tested and verified by doing I2C read and
write block transfers on Cougar Point 6 Series PCH, as well as I2C read
block transfers on ICH5.

Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   85 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 7 deletions(-)

--- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-i801.c	2012-07-07 21:40:03.000000000 +0200
+++ linux-3.5-rc5/drivers/i2c/busses/i2c-i801.c	2012-07-08 15:18:53.278760438 +0200
@@ -166,6 +166,13 @@ struct i801_priv {
 	/* isr processing */
 	wait_queue_head_t waitq;
 	u8 status;
+
+	/* Command state used by isr for byte-by-byte block transactions */
+	u8 cmd;
+	bool is_read;
+	int count;
+	int len;
+	u8 *data;
 };
 
 static struct pci_driver i801_driver;
@@ -373,14 +380,60 @@ static int i801_block_transaction_by_blo
 	return 0;
 }
 
+static void i801_isr_byte_done(struct i801_priv *priv)
+{
+	if (priv->is_read) {
+		/* For SMBus block reads, length is received with first byte */
+		if (((priv->cmd & 0x1c) == I801_BLOCK_DATA) &&
+		    (priv->count == 0)) {
+			priv->len = inb_p(SMBHSTDAT0(priv));
+			if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX) {
+				dev_err(&priv->pci_dev->dev,
+					"Illegal SMBus block read size %d\n",
+					priv->len);
+				/* FIXME: Recover */
+				priv->len = I2C_SMBUS_BLOCK_MAX;
+			} else {
+				dev_dbg(&priv->pci_dev->dev,
+					"SMBus block read size is %d\n",
+					priv->len);
+			}
+			priv->data[-1] = priv->len;
+		}
+
+		/* Read next byte */
+		if (priv->count < priv->len)
+			priv->data[priv->count++] = inb(SMBBLKDAT(priv));
+		else
+			dev_dbg(&priv->pci_dev->dev,
+				"Discarding extra byte on block read\n");
+
+		/* Set LAST_BYTE for last byte of read transaction */
+		if (priv->count == priv->len - 1)
+			outb_p(priv->cmd | SMBHSTCNT_LAST_BYTE,
+			       SMBHSTCNT(priv));
+	} else if (priv->count < priv->len - 1) {
+		/* Write next byte, except for IRQ after last byte */
+		outb_p(priv->data[++priv->count], SMBBLKDAT(priv));
+	}
+
+	/* Clear BYTE_DONE to continue with next byte */
+	outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
+}
+
 /*
- * i801 signals transaction completion with one of these interrupts:
- *   INTR - Success
- *   DEV_ERR - Invalid command, NAK or communication timeout
- *   BUS_ERR - SMI# transaction collision
- *   FAILED - transaction was canceled due to a KILL request
- * When any of these occur, update ->status and wake up the waitq.
- * ->status must be cleared before kicking off the next transaction.
+ * There are two kinds of interrupts:
+ *
+ * 1) i801 signals transaction completion with one of these interrupts:
+ *      INTR - Success
+ *      DEV_ERR - Invalid command, NAK or communication timeout
+ *      BUS_ERR - SMI# transaction collision
+ *      FAILED - transaction was canceled due to a KILL request
+ *    When any of these occur, update ->status and wake up the waitq.
+ *    ->status must be cleared before kicking off the next transaction.
+ *
+ * 2) For byte-by-byte (I2C read/write) transactions, one BYTE_DONE interrupt
+ *    occurs for each byte of a byte-by-byte to prepare the next byte.
  */
 static irqreturn_t i801_isr(int irq, void *dev_id)
 {
@@ -396,6 +449,9 @@ static irqreturn_t i801_isr(int irq, voi
 	status = inb_p(SMBHSTSTS(priv));
 	dev_dbg(&priv->pci_dev->dev, "irq: status = %02x\n", status);
 
+	if (status & SMBHSTSTS_BYTE_DONE)
+		i801_isr_byte_done(priv);
+
 	/*
 	 * Clear irq sources and report transaction result.
 	 * ->status must be cleared before the next transaction is started.
@@ -442,6 +498,21 @@ static int i801_block_transaction_byte_b
 	else
 		smbcmd = I801_BLOCK_DATA;
 
+	if (priv->features & FEATURE_IRQ) {
+		priv->is_read = (read_write == I2C_SMBUS_READ);
+		if (len == 1 && priv->is_read)
+			smbcmd |= SMBHSTCNT_LAST_BYTE;
+		priv->cmd = smbcmd | SMBHSTCNT_INTREN;
+		priv->len = len;
+		priv->count = 0;
+		priv->data = &data->block[1];
+
+		outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
+		wait_event(priv->waitq, (status = priv->status));
+		priv->status = 0;
+		return i801_check_post(priv, status);
+	}
+
 	for (i = 1; i <= len; i++) {
 		if (i == len && read_write == I2C_SMBUS_READ)
 			smbcmd |= SMBHSTCNT_LAST_BYTE;

-- 
Jean Delvare
