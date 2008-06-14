From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/4] i2c-i801: Fix handling of error conditions
Date: Sat, 14 Jun 2008 21:54:30 +0200
Message-ID: <20080614215430.4a0b35bf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Amit Walambe <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move the check of pre-transaction and post-transaction conditions to
separate functions, and adjust them a bit. Having dedicated functions
for that ensures that errors are handled in a consistent way.

Bit HOST_BUSY of the status register is read-only, so writing to it is
certainly not going to clear it. If this bit is set then we simply
don't want to start the transaction, as it means that somebody else
(ACPI, SMM?) is already using the controller.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |  200 ++++++++++++++++++++---------------------
 1 file changed, 102 insertions(+), 98 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-i801.c	2008-06-14 21:41:08.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-i801.c	2008-06-14 21:44:33.000000000 +0200
@@ -4,7 +4,7 @@
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, and Mark D. Studebaker
     <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2007         Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2007, 2008   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -122,6 +122,10 @@
 #define SMBHSTSTS_INTR		0x02
 #define SMBHSTSTS_HOST_BUSY	0x01
 
+#define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | \
+				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
+				 SMBHSTSTS_INTR)
+
 static unsigned long i801_smba;
 static unsigned char i801_original_hstcfg;
 static struct pci_driver i801_driver;
@@ -133,72 +137,114 @@ static struct pci_dev *I801_dev;
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 static unsigned int i801_features;
 
-static int i801_transaction(int xact)
+/* Make sure the SMBus host is ready to start transmitting.
+   Return 0 if it is, -EBUSY if it is not. */
+static int i801_check_pre(void)
 {
 	int status;
-	int result = 0;
-	int timeout = 0;
 
-	/* Make sure the SMBus host is ready to start transmitting */
-	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
-	if ((status = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-		dev_dbg(&I801_dev->dev, "SMBus busy (%02x). Resetting...\n",
+	status = inb_p(SMBHSTSTS);
+	if (status & SMBHSTSTS_HOST_BUSY) {
+		dev_err(&I801_dev->dev, "SMBus is busy, can't use it!\n");
+		return -EBUSY;
+	}
+
+	status &= STATUS_FLAGS;
+	if (status) {
+		dev_dbg(&I801_dev->dev, "Clearing status flags (%02x)\n",
 			status);
 		outb_p(status, SMBHSTSTS);
-		if ((status = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-			dev_dbg(&I801_dev->dev, "Failed! (%02x)\n", status);
+		status = inb_p(SMBHSTSTS) & STATUS_FLAGS;
+		if (status) {
+			dev_err(&I801_dev->dev,
+				"Failed clearing status flags (%02x)\n",
+				status);
 			return -EBUSY;
-		} else {
-			dev_dbg(&I801_dev->dev, "Successful!\n");
 		}
 	}
 
-	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
-	 * INTREN, SMBSCMD are passed in xact */
-	outb_p(xact | I801_START, SMBHSTCNT);
+	return 0;
+}
 
-	/* We will always wait for a fraction of a second! */
-	do {
-		msleep(1);
-		status = inb_p(SMBHSTSTS);
-	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
+/* Convert the status register to an error code, and clear it. */
+static int i801_check_post(int status, int timeout)
+{
+	int result = 0;
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
-		dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
-		result = -ETIMEDOUT;
+	if (timeout) {
+		dev_err(&I801_dev->dev, "Transaction timeout\n");
 		/* try to stop the current command */
 		dev_dbg(&I801_dev->dev, "Terminating the current operation\n");
 		outb_p(inb_p(SMBHSTCNT) | SMBHSTCNT_KILL, SMBHSTCNT);
 		msleep(1);
 		outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL), SMBHSTCNT);
+
+		/* Check if it worked */
+		status = inb_p(SMBHSTSTS);
+		if ((status & SMBHSTSTS_HOST_BUSY) ||
+		    !(status & SMBHSTSTS_FAILED))
+			dev_err(&I801_dev->dev,
+				"Failed terminating the transaction\n");
+		outb_p(STATUS_FLAGS, SMBHSTSTS);
+		return -ETIMEDOUT;
 	}
 
 	if (status & SMBHSTSTS_FAILED) {
 		result = -EIO;
-		dev_dbg(&I801_dev->dev, "Error: Failed bus transaction\n");
+		dev_err(&I801_dev->dev, "Transaction failed\n");
+	}
+	if (status & SMBHSTSTS_DEV_ERR) {
+		result = -ENXIO;
+		dev_dbg(&I801_dev->dev, "No response\n");
 	}
-
 	if (status & SMBHSTSTS_BUS_ERR) {
 		result = -EAGAIN;
 		dev_dbg(&I801_dev->dev, "Lost arbitration\n");
 	}
 
-	if (status & SMBHSTSTS_DEV_ERR) {
-		result = -ENXIO;
-		dev_dbg(&I801_dev->dev, "Error: no response!\n");
+	if (result) {
+		/* Clear error flags */
+		outb_p(status & STATUS_FLAGS, SMBHSTSTS);
+		status = inb_p(SMBHSTSTS) & STATUS_FLAGS;
+		if (status) {
+			dev_warn(&I801_dev->dev, "Failed clearing status "
+				 "flags at end of transaction (%02x)\n",
+				 status);
+		}
 	}
 
-	if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
-		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
-
-	if ((status = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
-			"(%02x)\n", status);
-	}
 	return result;
 }
 
+static int i801_transaction(int xact)
+{
+	int status;
+	int result;
+	int timeout = 0;
+
+	result = i801_check_pre();
+	if (result < 0)
+		return result;
+
+	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
+	 * INTREN, SMBSCMD are passed in xact */
+	outb_p(xact | I801_START, SMBHSTCNT);
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		msleep(1);
+		status = inb_p(SMBHSTSTS);
+	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
+
+	result = i801_check_post(status, timeout >= MAX_TIMEOUT);
+	if (result < 0)
+		return result;
+
+	outb_p(SMBHSTSTS_INTR, SMBHSTSTS);
+	return 0;
+}
+
 /* wait for INTR bit as advised by Intel */
 static void i801_wait_hwpec(void)
 {
@@ -257,9 +303,12 @@ static int i801_block_transaction_byte_b
 	int i, len;
 	int smbcmd;
 	int status;
-	int result = 0;
+	int result;
 	int timeout;
-	unsigned char errmask;
+
+	result = i801_check_pre();
+	if (result < 0)
+		return result;
 
 	len = data->block[0];
 
@@ -283,31 +332,6 @@ static int i801_block_transaction_byte_b
 		}
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
 
-		/* Make sure the SMBus host is ready to start transmitting */
-		status = inb_p(SMBHSTSTS);
-		if (i == 1) {
-			/* Erroneous conditions before transaction:
-			 * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
-			errmask = 0x9f;
-		} else {
-			/* Erroneous conditions during transaction:
-			 * Failed, Bus_Err, Dev_Err, Intr */
-			errmask = 0x1e;
-		}
-		if (status & errmask) {
-			dev_dbg(&I801_dev->dev, "SMBus busy (%02x). "
-				"Resetting...\n", status);
-			outb_p(status, SMBHSTSTS);
-			if (((status = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
-				dev_err(&I801_dev->dev,
-					"Reset failed! (%02x)\n", status);
-				return -EBUSY;
-			}
-			if (i != 1)
-				/* if die in middle of block transaction, fail */
-				return -EIO;
-		}
-
 		if (i == 1)
 			outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);
 
@@ -320,36 +344,23 @@ static int i801_block_transaction_byte_b
 		while ((!(status & SMBHSTSTS_BYTE_DONE))
 		       && (timeout++ < MAX_TIMEOUT));
 
-		/* If the SMBus is still busy, we give up */
-		if (timeout >= MAX_TIMEOUT) {
-			/* try to stop the current command */
-			dev_dbg(&I801_dev->dev, "Terminating the current "
-						"operation\n");
-			outb_p(inb_p(SMBHSTCNT) | SMBHSTCNT_KILL, SMBHSTCNT);
-			msleep(1);
-			outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL),
-				SMBHSTCNT);
-			result = -ETIMEDOUT;
-			dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
-		}
-
-		if (status & SMBHSTSTS_FAILED) {
-			result = -EIO;
-			dev_dbg(&I801_dev->dev,
-				"Error: Failed bus transaction\n");
-		} else if (status & SMBHSTSTS_BUS_ERR) {
-			result = -EAGAIN;
-			dev_dbg(&I801_dev->dev, "Lost arbitration\n");
-		} else if (status & SMBHSTSTS_DEV_ERR) {
-			result = -ENXIO;
-			dev_dbg(&I801_dev->dev, "Error: no response!\n");
-		}
+		result = i801_check_post(status, timeout >= MAX_TIMEOUT);
+		if (result < 0)
+			return result;
 
 		if (i == 1 && read_write == I2C_SMBUS_READ
 		 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
 			len = inb_p(SMBHSTDAT0);
-			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
+			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
+				dev_err(&I801_dev->dev,
+					"Illegal SMBus block read size %d\n",
+					len);
+				/* Recover */
+				while (inb_p(SMBHSTSTS) & SMBHSTSTS_HOST_BUSY)
+					outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS);
+				outb_p(SMBHSTSTS_INTR, SMBHSTSTS);
 				return -EPROTO;
+			}
 			data->block[0] = len;
 		}
 
@@ -358,19 +369,12 @@ static int i801_block_transaction_byte_b
 			data->block[i] = inb_p(SMBBLKDAT);
 		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
 			outb_p(data->block[i+1], SMBBLKDAT);
-		if ((status & 0x9e) != 0x00)
-			outb_p(status, SMBHSTSTS);  /* signals SMBBLKDAT ready */
 
-		if ((status = (0x1e & inb_p(SMBHSTSTS))) != 0x00) {
-			dev_dbg(&I801_dev->dev,
-				"Bad status (%02x) at end of transaction\n",
-				status);
-		}
-
-		if (result < 0)
-			return result;
+		/* signals SMBBLKDAT ready */
+		outb_p(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR, SMBHSTSTS);
 	}
-	return result;
+
+	return 0;
 }
 
 static int i801_set_block_buffer_mode(void)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
