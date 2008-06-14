From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/4] i2c-i801: Rename local variable temp to status
Date: Sat, 14 Jun 2008 21:53:35 +0200
Message-ID: <20080614215335.14a0f431@hyperion.delvare>
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

"temp" isn't a terribly well chosen name for a local variable.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   66 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/i2c/busses/i2c-i801.c	2008-06-14 21:05:13.000000000 +0200
+++ linux-2.6.26-rc5/drivers/i2c/busses/i2c-i801.c	2008-06-14 21:06:01.000000000 +0200
@@ -135,18 +135,18 @@ static unsigned int i801_features;
 
 static int i801_transaction(int xact)
 {
-	int temp;
+	int status;
 	int result = 0;
 	int timeout = 0;
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
-	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
+	if ((status = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
 		dev_dbg(&I801_dev->dev, "SMBus busy (%02x). Resetting...\n",
-			temp);
-		outb_p(temp, SMBHSTSTS);
-		if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-			dev_dbg(&I801_dev->dev, "Failed! (%02x)\n", temp);
+			status);
+		outb_p(status, SMBHSTSTS);
+		if ((status = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
+			dev_dbg(&I801_dev->dev, "Failed! (%02x)\n", status);
 			return -EBUSY;
 		} else {
 			dev_dbg(&I801_dev->dev, "Successful!\n");
@@ -160,8 +160,8 @@ static int i801_transaction(int xact)
 	/* We will always wait for a fraction of a second! */
 	do {
 		msleep(1);
-		temp = inb_p(SMBHSTSTS);
-	} while ((temp & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
+		status = inb_p(SMBHSTSTS);
+	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
@@ -174,17 +174,17 @@ static int i801_transaction(int xact)
 		outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL), SMBHSTCNT);
 	}
 
-	if (temp & SMBHSTSTS_FAILED) {
+	if (status & SMBHSTSTS_FAILED) {
 		result = -EIO;
 		dev_dbg(&I801_dev->dev, "Error: Failed bus transaction\n");
 	}
 
-	if (temp & SMBHSTSTS_BUS_ERR) {
+	if (status & SMBHSTSTS_BUS_ERR) {
 		result = -EAGAIN;
 		dev_dbg(&I801_dev->dev, "Lost arbitration\n");
 	}
 
-	if (temp & SMBHSTSTS_DEV_ERR) {
+	if (status & SMBHSTSTS_DEV_ERR) {
 		result = -ENXIO;
 		dev_dbg(&I801_dev->dev, "Error: no response!\n");
 	}
@@ -192,9 +192,9 @@ static int i801_transaction(int xact)
 	if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
+	if ((status = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
 		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
-			"(%02x)\n", temp);
+			"(%02x)\n", status);
 	}
 	return result;
 }
@@ -203,18 +203,18 @@ static int i801_transaction(int xact)
 static void i801_wait_hwpec(void)
 {
 	int timeout = 0;
-	int temp;
+	int status;
 
 	do {
 		msleep(1);
-		temp = inb_p(SMBHSTSTS);
-	} while ((!(temp & SMBHSTSTS_INTR))
+		status = inb_p(SMBHSTSTS);
+	} while ((!(status & SMBHSTSTS_INTR))
 		 && (timeout++ < MAX_TIMEOUT));
 
 	if (timeout >= MAX_TIMEOUT) {
 		dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
 	}
-	outb_p(temp, SMBHSTSTS);
+	outb_p(status, SMBHSTSTS);
 }
 
 static int i801_block_transaction_by_block(union i2c_smbus_data *data,
@@ -256,7 +256,7 @@ static int i801_block_transaction_byte_b
 {
 	int i, len;
 	int smbcmd;
-	int temp;
+	int status;
 	int result = 0;
 	int timeout;
 	unsigned char errmask;
@@ -284,7 +284,7 @@ static int i801_block_transaction_byte_b
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
 
 		/* Make sure the SMBus host is ready to start transmitting */
-		temp = inb_p(SMBHSTSTS);
+		status = inb_p(SMBHSTSTS);
 		if (i == 1) {
 			/* Erroneous conditions before transaction:
 			 * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
@@ -294,13 +294,13 @@ static int i801_block_transaction_byte_b
 			 * Failed, Bus_Err, Dev_Err, Intr */
 			errmask = 0x1e;
 		}
-		if (temp & errmask) {
+		if (status & errmask) {
 			dev_dbg(&I801_dev->dev, "SMBus busy (%02x). "
-				"Resetting...\n", temp);
-			outb_p(temp, SMBHSTSTS);
-			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
+				"Resetting...\n", status);
+			outb_p(status, SMBHSTSTS);
+			if (((status = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
 				dev_err(&I801_dev->dev,
-					"Reset failed! (%02x)\n", temp);
+					"Reset failed! (%02x)\n", status);
 				return -EBUSY;
 			}
 			if (i != 1)
@@ -315,9 +315,9 @@ static int i801_block_transaction_byte_b
 		timeout = 0;
 		do {
 			msleep(1);
-			temp = inb_p(SMBHSTSTS);
+			status = inb_p(SMBHSTSTS);
 		}
-		while ((!(temp & SMBHSTSTS_BYTE_DONE))
+		while ((!(status & SMBHSTSTS_BYTE_DONE))
 		       && (timeout++ < MAX_TIMEOUT));
 
 		/* If the SMBus is still busy, we give up */
@@ -333,14 +333,14 @@ static int i801_block_transaction_byte_b
 			dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
 		}
 
-		if (temp & SMBHSTSTS_FAILED) {
+		if (status & SMBHSTSTS_FAILED) {
 			result = -EIO;
 			dev_dbg(&I801_dev->dev,
 				"Error: Failed bus transaction\n");
-		} else if (temp & SMBHSTSTS_BUS_ERR) {
+		} else if (status & SMBHSTSTS_BUS_ERR) {
 			result = -EAGAIN;
 			dev_dbg(&I801_dev->dev, "Lost arbitration\n");
-		} else if (temp & SMBHSTSTS_DEV_ERR) {
+		} else if (status & SMBHSTSTS_DEV_ERR) {
 			result = -ENXIO;
 			dev_dbg(&I801_dev->dev, "Error: no response!\n");
 		}
@@ -358,13 +358,13 @@ static int i801_block_transaction_byte_b
 			data->block[i] = inb_p(SMBBLKDAT);
 		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
 			outb_p(data->block[i+1], SMBBLKDAT);
-		if ((temp & 0x9e) != 0x00)
-			outb_p(temp, SMBHSTSTS);  /* signals SMBBLKDAT ready */
+		if ((status & 0x9e) != 0x00)
+			outb_p(status, SMBHSTSTS);  /* signals SMBBLKDAT ready */
 
-		if ((temp = (0x1e & inb_p(SMBHSTSTS))) != 0x00) {
+		if ((status = (0x1e & inb_p(SMBHSTSTS))) != 0x00) {
 			dev_dbg(&I801_dev->dev,
 				"Bad status (%02x) at end of transaction\n",
-				temp);
+				status);
 		}
 
 		if (result < 0)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
