From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Thu, 1 May 2008 20:46:07 -0700
Message-ID: <200805012046.07885.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Tighten error paths used by various other i2c adapters so they
return real fault/errno codes instead of a literal "-1" (which
is most often interpreted as "-EPERM").  Build tested.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
NOTE there are many other adapter drivers to audit and update; and
they're not just within the drivers/i2c tree.  This patch is a PC
oriented start on some bottom-up improvement of fault reporting.
The i2c-gpio code looks be good too.

 drivers/i2c/algos/i2c-algo-bit.c      |   11 +++++---
 drivers/i2c/busses/i2c-ali1535.c      |   22 +++++++---------
 drivers/i2c/busses/i2c-ali1563.c      |    4 +--
 drivers/i2c/busses/i2c-ali15x3.c      |   19 +++++++-------
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 +--
 drivers/i2c/busses/i2c-amd756.c       |   18 +++++++------
 drivers/i2c/busses/i2c-amd8111.c      |   44 +++++++++++++++++++++------------
 drivers/i2c/busses/i2c-i801.c         |   45 +++++++++++++++++-----------------
 drivers/i2c/busses/i2c-nforce2.c      |   25 +++++++++---------
 drivers/i2c/busses/i2c-piix4.c        |   20 ++++++++-------
 drivers/i2c/busses/i2c-sis5595.c      |   19 ++++++++------
 drivers/i2c/busses/i2c-sis630.c       |   43 ++++++++++++++++++--------------
 drivers/i2c/busses/i2c-sis96x.c       |   20 ++++++++-------
 drivers/i2c/busses/i2c-stub.c         |    4 +--
 drivers/i2c/busses/i2c-viapro.c       |   20 ++++++++-------
 15 files changed, 176 insertions(+), 142 deletions(-)

--- g26.orig/drivers/i2c/algos/i2c-algo-bit.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/algos/i2c-algo-bit.c	2008-05-01 16:02:58.000000000 -0700
@@ -317,10 +317,10 @@ bailout:
  * -x transmission error
  */
 static int try_address(struct i2c_adapter *i2c_adap,
-		       unsigned char addr, int retries)
+		       unsigned char addr, unsigned retries)
 {
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-	int i, ret = -1;
+	int i, ret;
 
 	for (i = 0; i <= retries; i++) {
 		ret = i2c_outb(i2c_adap, addr);
@@ -465,9 +465,12 @@ static int bit_doAddress(struct i2c_adap
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	unsigned char addr;
-	int ret, retries;
+	int ret;
+	unsigned retries;
 
-	retries = nak_ok ? 0 : i2c_adap->retries;
+	retries = (nak_ok || i2c_adap->retries < 0)
+			? 0
+			: i2c_adap->retries;
 
 	if (flags & I2C_M_TEN) {
 		/* a ten bit address */
--- g26.orig/drivers/i2c/busses/i2c-ali1535.c	2008-05-01 16:01:39.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-ali1535.c	2008-05-01 16:02:58.000000000 -0700
@@ -259,7 +259,7 @@ static int ali1535_transaction(struct i2
 			dev_err(&adap->dev,
 				"SMBus reset failed! (0x%02x) - controller or "
 				"device on bus is probably hung\n", temp);
-			return -1;
+			return -EBUSY;
 		}
 	} else {
 		/* check and clear done bit */
@@ -281,12 +281,12 @@ static int ali1535_transaction(struct i2
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		result = -1;
+		result = -ETIMEDOUT;
 		dev_err(&adap->dev, "SMBus Timeout!\n");
 	}
 
 	if (temp & ALI1535_STS_FAIL) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
 	}
 
@@ -295,7 +295,7 @@ static int ali1535_transaction(struct i2
 	 * do a printk.  This means that bus collisions go unreported.
 	 */
 	if (temp & ALI1535_STS_BUSERR) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&adap->dev,
 			"Error: no response or bus collision ADD=%02x\n",
 			inb_p(SMBHSTADD));
@@ -303,13 +303,13 @@ static int ali1535_transaction(struct i2
 
 	/* haven't ever seen this */
 	if (temp & ALI1535_STS_DEV) {
-		result = -1;
+		result = -EIO;
 		dev_err(&adap->dev, "Error: device error\n");
 	}
 
 	/* check to see if the "command complete" indication is set */
 	if (!(temp & ALI1535_STS_DONE)) {
-		result = -1;
+		result = -EIO;
 		dev_err(&adap->dev, "Error: command never completed\n");
 	}
 
@@ -332,7 +332,7 @@ static int ali1535_transaction(struct i2
 	return result;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 ali1535_access(struct i2c_adapter *adap, u16 addr,
 			  unsigned short flags, char read_write, u8 command,
 			  int size, union i2c_smbus_data *data)
@@ -359,7 +359,7 @@ static s32 ali1535_access(struct i2c_ada
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
 		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		result = -1;
+		result = -EOPNOTSUPP;
 		goto EXIT;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -420,11 +420,9 @@ static s32 ali1535_access(struct i2c_ada
 		break;
 	}
 
-	if (ali1535_transaction(adap)) {
-		/* Error in transaction */
-		result = -1;
+	result = ali1535_transaction(adap);
+	if (result)
 		goto EXIT;
-	}
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == ALI1535_QUICK)) {
 		result = 0;
--- g26.orig/drivers/i2c/busses/i2c-ali1563.c	2008-05-01 16:01:39.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-ali1563.c	2008-05-01 16:02:58.000000000 -0700
@@ -122,7 +122,7 @@ static int ali1563_transaction(struct i2
 		outb_p(0x0,SMB_HST_CNTL2);
 	}
 
-	return -1;
+	return -EIO;
 }
 
 static int ali1563_block_start(struct i2c_adapter * a)
@@ -170,7 +170,7 @@ static int ali1563_block_start(struct i2
 		data & HST_STS_BUSERR ? "No response or Bus Collision " : "",
 		data & HST_STS_DEVERR ? "Device Error " : "",
 		!(data & HST_STS_DONE) ? "Transaction Never Finished " : "");
-	return -1;
+	return -EIO;
 }
 
 static int ali1563_block(struct i2c_adapter * a, union i2c_smbus_data * data, u8 rw)
--- g26.orig/drivers/i2c/busses/i2c-ali15x3.c	2008-05-01 16:01:39.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-ali15x3.c	2008-05-01 16:02:58.000000000 -0700
@@ -282,7 +282,7 @@ static int ali15x3_transaction(struct i2
 			dev_err(&adap->dev, "SMBus reset failed! (0x%02x) - "
 				"controller or device on bus is probably hung\n",
 				temp);
-			return -1;
+			return -EBUSY;
 		}
 	} else {
 		/* check and clear done bit */
@@ -304,12 +304,12 @@ static int ali15x3_transaction(struct i2
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		result = -1;
+		result = -ETIMEDOUT;
 		dev_err(&adap->dev, "SMBus Timeout!\n");
 	}
 
 	if (temp & ALI15X3_STS_TERM) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
 	}
 
@@ -320,7 +320,7 @@ static int ali15x3_transaction(struct i2
 	  This means that bus collisions go unreported.
 	*/
 	if (temp & ALI15X3_STS_COLL) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&adap->dev,
 			"Error: no response or bus collision ADD=%02x\n",
 			inb_p(SMBHSTADD));
@@ -328,7 +328,7 @@ static int ali15x3_transaction(struct i2
 
 	/* haven't ever seen this */
 	if (temp & ALI15X3_STS_DEV) {
-		result = -1;
+		result = -EIO;
 		dev_err(&adap->dev, "Error: device error\n");
 	}
 	dev_dbg(&adap->dev, "Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, "
@@ -338,7 +338,7 @@ static int ali15x3_transaction(struct i2
 	return result;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
 		   unsigned short flags, char read_write, u8 command,
 		   int size, union i2c_smbus_data * data)
@@ -364,7 +364,7 @@ static s32 ali15x3_access(struct i2c_ada
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
 		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		return -1;
+		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
@@ -421,8 +421,9 @@ static s32 ali15x3_access(struct i2c_ada
 
 	outb_p(size, SMBHSTCNT);	/* output command */
 
-	if (ali15x3_transaction(adap))	/* Error in transaction */
-		return -1;
+	temp = ali15x3_transaction(adap);
+	if (temp)
+		return temp;
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == ALI15X3_QUICK))
 		return 0;
--- g26.orig/drivers/i2c/busses/i2c-amd756-s4882.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-amd756-s4882.c	2008-05-01 16:02:58.000000000 -0700
@@ -58,7 +58,7 @@ static s32 amd756_access_virt0(struct i2
 	/* We exclude the multiplexed addresses */
 	if (addr == 0x4c || (addr & 0xfc) == 0x50 || (addr & 0xfc) == 0x30
 	 || addr == 0x18)
-		return -1;
+		return -EINVAL;
 
 	mutex_lock(&amd756_lock);
 
@@ -86,7 +86,7 @@ static inline s32 amd756_access_channel(
 
 	/* We exclude the non-multiplexed addresses */
 	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
-		return -1;
+		return -EINVAL;
 
 	mutex_lock(&amd756_lock);
 
--- g26.orig/drivers/i2c/busses/i2c-amd756.c	2008-05-01 16:01:39.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-amd756.c	2008-05-01 16:02:58.000000000 -0700
@@ -151,17 +151,17 @@ static int amd756_transaction(struct i2c
 	}
 
 	if (temp & GS_PRERR_STS) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&adap->dev, "SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
-		result = -1;
+		result = -EIO;
 		dev_warn(&adap->dev, "SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
-		result = -1;
+		result = -ETIMEDOUT;
 		dev_dbg(&adap->dev, "SMBus protocol timeout!\n");
 	}
 
@@ -189,22 +189,23 @@ static int amd756_transaction(struct i2c
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
 	msleep(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
-	return -1;
+	return -EIO;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 amd756_access(struct i2c_adapter * adap, u16 addr,
 		  unsigned short flags, char read_write,
 		  u8 command, int size, union i2c_smbus_data * data)
 {
 	int i, len;
+	int status;
 
 	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
 		dev_dbg(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		/* TODO: Well... It is supported, I'm just not sure what to do here... */
-		return -1;
+		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
 		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMB_HOST_ADDRESS);
@@ -256,8 +257,9 @@ static s32 amd756_access(struct i2c_adap
 	/* How about enabling interrupts... */
 	outw_p(size & GE_CYC_TYPE_MASK, SMB_GLOBAL_ENABLE);
 
-	if (amd756_transaction(adap))	/* Error in transaction */
-		return -1;
+	status = amd756_transaction(adap);
+	if (status)
+		return status;
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == AMD756_QUICK))
 		return 0;
--- g26.orig/drivers/i2c/busses/i2c-amd8111.c	2008-05-01 16:01:39.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-amd8111.c	2008-05-01 16:02:58.000000000 -0700
@@ -77,7 +77,7 @@ static unsigned int amd_ec_wait_write(st
 	if (!timeout) {
 		dev_warn(&smbus->dev->dev,
 			 "Timeout while waiting for IBF to clear\n");
-		return -1;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
@@ -93,7 +93,7 @@ static unsigned int amd_ec_wait_read(str
 	if (!timeout) {
 		dev_warn(&smbus->dev->dev,
 			 "Timeout while waiting for OBF to set\n");
-		return -1;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
@@ -102,16 +102,21 @@ static unsigned int amd_ec_wait_read(str
 static unsigned int amd_ec_read(struct amd_smbus *smbus, unsigned char address,
 		unsigned char *data)
 {
-	if (amd_ec_wait_write(smbus))
-		return -1;
+	int status;
+
+	status = amd_ec_wait_write(smbus);
+	if (status)
+		return status;
 	outb(AMD_EC_CMD_RD, smbus->base + AMD_EC_CMD);
 
-	if (amd_ec_wait_write(smbus))
-		return -1;
+	status = amd_ec_wait_write(smbus);
+	if (status)
+		return status;
 	outb(address, smbus->base + AMD_EC_DATA);
 
-	if (amd_ec_wait_read(smbus))
-		return -1;
+	status = amd_ec_wait_read(smbus);
+	if (status)
+		return status;
 	*data = inb(smbus->base + AMD_EC_DATA);
 
 	return 0;
@@ -120,16 +125,21 @@ static unsigned int amd_ec_read(struct a
 static unsigned int amd_ec_write(struct amd_smbus *smbus, unsigned char address,
 		unsigned char data)
 {
-	if (amd_ec_wait_write(smbus))
-		return -1;
+	int status;
+
+	status = amd_ec_wait_write(smbus);
+	if (status)
+		return status;
 	outb(AMD_EC_CMD_WR, smbus->base + AMD_EC_CMD);
 
-	if (amd_ec_wait_write(smbus))
-		return -1;
+	status = amd_ec_wait_write(smbus);
+	if (status)
+		return status;
 	outb(address, smbus->base + AMD_EC_DATA);
 
-	if (amd_ec_wait_write(smbus))
-		return -1;
+	status = amd_ec_wait_write(smbus);
+	if (status)
+		return status;
 	outb(data, smbus->base + AMD_EC_DATA);
 
 	return 0;
@@ -185,6 +195,7 @@ static s32 amd8111_access(struct i2c_ada
 	struct amd_smbus *smbus = adap->algo_data;
 	unsigned char protocol, len, pec, temp[2];
 	int i;
+	int status;
 
 	protocol = (read_write == I2C_SMBUS_READ) ? AMD_SMB_PRTCL_READ
 						  : AMD_SMB_PRTCL_WRITE;
@@ -267,12 +278,13 @@ static s32 amd8111_access(struct i2c_ada
 
 		default:
 			dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
-			return -1;
+			return -EOPNOTSUPP;
 	}
 
 	amd_ec_write(smbus, AMD_SMB_ADDR, addr << 1);
 	amd_ec_write(smbus, AMD_SMB_PRTCL, protocol);
 
+	/* FIXME this discards status from ec_read() ... */
 	amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
 
 	if (~temp[0] & AMD_SMB_STS_DONE) {
@@ -286,7 +298,7 @@ static s32 amd8111_access(struct i2c_ada
 	}
 
 	if ((~temp[0] & AMD_SMB_STS_DONE) || (temp[0] & AMD_SMB_STS_STATUS))
-		return -1;
+		return -EIO;
 
 	if (read_write == I2C_SMBUS_WRITE)
 		return 0;
--- g26.orig/drivers/i2c/busses/i2c-i801.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-i801.c	2008-05-01 16:02:58.000000000 -0700
@@ -151,7 +151,7 @@ static int i801_transaction(int xact)
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
 			dev_dbg(&I801_dev->dev, "Failed! (%02x)\n", temp);
-			return -1;
+			return -EBUSY;
 		} else {
 			dev_dbg(&I801_dev->dev, "Successful!\n");
 		}
@@ -170,7 +170,7 @@ static int i801_transaction(int xact)
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
-		result = -1;
+		result = -ETIMEDOUT;
 		/* try to stop the current command */
 		dev_dbg(&I801_dev->dev, "Terminating the current operation\n");
 		outb_p(inb_p(SMBHSTCNT) | SMBHSTCNT_KILL, SMBHSTCNT);
@@ -179,19 +179,19 @@ static int i801_transaction(int xact)
 	}
 
 	if (temp & SMBHSTSTS_FAILED) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&I801_dev->dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & SMBHSTSTS_BUS_ERR) {
-		result = -1;
+		result = -EIO;
 		dev_err(&I801_dev->dev, "Bus collision! SMBus may be locked "
 			"until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & SMBHSTSTS_DEV_ERR) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&I801_dev->dev, "Error: no response!\n");
 	}
 
@@ -231,6 +231,7 @@ static int i801_block_transaction_by_blo
 					   char read_write, int hwpec)
 {
 	int i, len;
+	int status;
 
 	inb_p(SMBHSTCNT); /* reset the data buffer index */
 
@@ -242,14 +243,15 @@ static int i801_block_transaction_by_blo
 			outb_p(data->block[i+1], SMBBLKDAT);
 	}
 
-	if (i801_transaction(I801_BLOCK_DATA | ENABLE_INT9 |
-			     I801_PEC_EN * hwpec))
-		return -1;
+	status = i801_transaction(I801_BLOCK_DATA | ENABLE_INT9 |
+			     I801_PEC_EN * hwpec);
+	if (status)
+		return status;
 
 	if (read_write == I2C_SMBUS_READ) {
 		len = inb_p(SMBHSTDAT0);
 		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
-			return -1;
+			return -EILSEQ;
 
 		data->block[0] = len;
 		for (i = 0; i < len; i++)
@@ -314,11 +316,11 @@ static int i801_block_transaction_byte_b
 			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
 				dev_err(&I801_dev->dev,
 					"Reset failed! (%02x)\n", temp);
-				return -1;
+				return -EBUSY;
 			}
 			if (i != 1)
 				/* if die in middle of block transaction, fail */
-				return -1;
+				return -EIO;
 		}
 
 		if (i == 1)
@@ -342,19 +344,19 @@ static int i801_block_transaction_byte_b
 			msleep(1);
 			outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL),
 				SMBHSTCNT);
-			result = -1;
+			result = -ETIMEDOUT;
 			dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
 		}
 
 		if (temp & SMBHSTSTS_FAILED) {
-			result = -1;
+			result = -EIO;
 			dev_dbg(&I801_dev->dev,
 				"Error: Failed bus transaction\n");
 		} else if (temp & SMBHSTSTS_BUS_ERR) {
-			result = -1;
+			result = -EIO;
 			dev_err(&I801_dev->dev, "Bus collision!\n");
 		} else if (temp & SMBHSTSTS_DEV_ERR) {
-			result = -1;
+			result = -EIO;
 			dev_dbg(&I801_dev->dev, "Error: no response!\n");
 		}
 
@@ -362,7 +364,7 @@ static int i801_block_transaction_byte_b
 		 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
 			len = inb_p(SMBHSTDAT0);
 			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
-				return -1;
+				return -EILSEQ;
 			data->block[0] = len;
 		}
 
@@ -383,7 +385,6 @@ static int i801_block_transaction_byte_b
 			"ADD=%02x, DAT0=%02x, DAT1=%02x, BLKDAT=%02x\n", i,
 			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
 			inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1), inb_p(SMBBLKDAT));
-
 		if (result < 0)
 			return result;
 	}
@@ -394,7 +395,7 @@ static int i801_set_block_buffer_mode(vo
 {
 	outb_p(inb_p(SMBAUXCTL) | SMBAUXCTL_E32B, SMBAUXCTL);
 	if ((inb_p(SMBAUXCTL) & SMBAUXCTL_E32B) == 0)
-		return -1;
+		return -EIO;
 	return 0;
 }
 
@@ -414,7 +415,7 @@ static int i801_block_transaction(union 
 		} else if (!(i801_features & FEATURE_I2C_BLOCK_READ)) {
 			dev_err(&I801_dev->dev,
 				"I2C block read is unsupported!\n");
-			return -1;
+			return -EOPNOTSUPP;
 		}
 	}
 
@@ -449,7 +450,7 @@ static int i801_block_transaction(union 
 	return result;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 i801_access(struct i2c_adapter * adap, u16 addr,
 		       unsigned short flags, char read_write, u8 command,
 		       int size, union i2c_smbus_data * data)
@@ -514,7 +515,7 @@ static s32 i801_access(struct i2c_adapte
 	case I2C_SMBUS_PROC_CALL:
 	default:
 		dev_err(&I801_dev->dev, "Unsupported transaction %d\n", size);
-		return -1;
+		return -EOPNOTSUPP;
 	}
 
 	if (hwpec)	/* enable/disable hardware PEC */
@@ -537,7 +538,7 @@ static s32 i801_access(struct i2c_adapte
 	if(block)
 		return ret;
 	if(ret)
-		return -1;
+		return ret;
 	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
 		return 0;
 
--- g26.orig/drivers/i2c/busses/i2c-nforce2.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-nforce2.c	2008-05-01 16:02:58.000000000 -0700
@@ -145,16 +145,16 @@ static int nforce2_check_status(struct i
 		dev_dbg(&adap->dev, "SMBus Timeout!\n");
 		if (smbus->can_abort)
 			nforce2_abort(adap);
-		return -1;
+		return -ETIMEDOUT;
 	}
 	if (!(temp & NVIDIA_SMB_STS_DONE) || (temp & NVIDIA_SMB_STS_STATUS)) {
 		dev_dbg(&adap->dev, "Transaction failed (0x%02x)!\n", temp);
-		return -1;
+		return -EIO;
 	}
 	return 0;
 }
 
-/* Return -1 on error */
+/* Return negative errno on error */
 static s32 nforce2_access(struct i2c_adapter * adap, u16 addr,
 		unsigned short flags, char read_write,
 		u8 command, int size, union i2c_smbus_data * data)
@@ -162,7 +162,7 @@ static s32 nforce2_access(struct i2c_ada
 	struct nforce2_smbus *smbus = adap->algo_data;
 	unsigned char protocol, pec;
 	u8 len;
-	int i;
+	int i, status;
 
 	protocol = (read_write == I2C_SMBUS_READ) ? NVIDIA_SMB_PRTCL_READ :
 		NVIDIA_SMB_PRTCL_WRITE;
@@ -206,7 +206,7 @@ static s32 nforce2_access(struct i2c_ada
 						"Transaction failed "
 						"(requested block size: %d)\n",
 						len);
-					return -1;
+					return -E2BIG;
 				}
 				outb_p(len, NVIDIA_SMB_BCNT);
 				for (i = 0; i < I2C_SMBUS_BLOCK_MAX; i++)
@@ -218,14 +218,15 @@ static s32 nforce2_access(struct i2c_ada
 
 		default:
 			dev_err(&adap->dev, "Unsupported transaction %d\n", size);
-			return -1;
+			return -EOPNOTSUPP;
 	}
 
 	outb_p((addr & 0x7f) << 1, NVIDIA_SMB_ADDR);
 	outb_p(protocol, NVIDIA_SMB_PRTCL);
 
-	if (nforce2_check_status(adap))
-		return -1;
+	status = nforce2_check_status(adap);
+	if (status)
+		return status;
 
 	if (read_write == I2C_SMBUS_WRITE)
 		return 0;
@@ -247,7 +248,7 @@ static s32 nforce2_access(struct i2c_ada
 				dev_err(&adap->dev, "Transaction failed "
 					"(received block size: 0x%02x)\n",
 					len);
-				return -1;
+				return -EILSEQ;
 			}
 			for (i = 0; i < len; i++)
 				data->block[i+1] = inb_p(NVIDIA_SMB_DATA + i);
@@ -308,7 +309,7 @@ static int __devinit nforce2_probe_smb (
 		    != PCIBIOS_SUCCESSFUL) {
 			dev_err(&dev->dev, "Error reading PCI config for %s\n",
 				name);
-			return -1;
+			return -EIO;
 		}
 
 		smbus->base = iobase & PCI_BASE_ADDRESS_IO_MASK;
@@ -318,7 +319,7 @@ static int __devinit nforce2_probe_smb (
 	if (!request_region(smbus->base, smbus->size, nforce2_driver.name)) {
 		dev_err(&smbus->adapter.dev, "Error requesting region %02x .. %02X for %s\n",
 			smbus->base, smbus->base+smbus->size-1, name);
-		return -1;
+		return -EBUSY;
 	}
 	smbus->adapter.owner = THIS_MODULE;
 	smbus->adapter.id = I2C_HW_SMBUS_NFORCE2;
@@ -333,7 +334,7 @@ static int __devinit nforce2_probe_smb (
 	if (error) {
 		dev_err(&smbus->adapter.dev, "Failed to register adapter.\n");
 		release_region(smbus->base, smbus->size);
-		return -1;
+		return error;
 	}
 	dev_info(&smbus->adapter.dev, "nForce2 SMBus adapter at %#x\n", smbus->base);
 	return 0;
--- g26.orig/drivers/i2c/busses/i2c-piix4.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-piix4.c	2008-05-01 16:02:58.000000000 -0700
@@ -220,7 +220,7 @@ static int piix4_transaction(void)
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
 			dev_err(&piix4_adapter.dev, "Failed! (%02x)\n", temp);
-			return -1;
+			return -EBUSY;
 		} else {
 			dev_dbg(&piix4_adapter.dev, "Successful!\n");
 		}
@@ -238,23 +238,23 @@ static int piix4_transaction(void)
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		dev_err(&piix4_adapter.dev, "SMBus Timeout!\n");
-		result = -1;
+		result = -ETIMEDOUT;
 	}
 
 	if (temp & 0x10) {
-		result = -1;
+		result = -EIO;
 		dev_err(&piix4_adapter.dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & 0x08) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&piix4_adapter.dev, "Bus collision! SMBus may be "
 			"locked until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
-		result = -1;
+		result = -EIO;
 		dev_dbg(&piix4_adapter.dev, "Error: no response!\n");
 	}
 
@@ -272,17 +272,18 @@ static int piix4_transaction(void)
 	return result;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 		 unsigned short flags, char read_write,
 		 u8 command, int size, union i2c_smbus_data * data)
 {
 	int i, len;
+	int status;
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
 		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		return -1;
+		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
@@ -334,8 +335,9 @@ static s32 piix4_access(struct i2c_adapt
 
 	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
 
-	if (piix4_transaction())	/* Error in transaction */
-		return -1;
+	status = piix4_transaction();
+	if (status)
+		return status;
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == PIIX4_QUICK))
 		return 0;
--- g26.orig/drivers/i2c/busses/i2c-sis5595.c	2008-05-01 16:01:39.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-sis5595.c	2008-05-01 16:07:18.000000000 -0700
@@ -236,7 +236,7 @@ static int sis5595_transaction(struct i2
 		sis5595_write(SMB_STS_HI, temp >> 8);
 		if ((temp = sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8)) != 0x00) {
 			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
-			return -1;
+			return -EBUSY;
 		} else {
 			dev_dbg(&adap->dev, "Successful!\n");
 		}
@@ -254,19 +254,19 @@ static int sis5595_transaction(struct i2
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		dev_dbg(&adap->dev, "SMBus Timeout!\n");
-		result = -1;
+		result = -ETIMEDOUT;
 	}
 
 	if (temp & 0x10) {
 		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
-		result = -1;
+		result = -EIO;
 	}
 
 	if (temp & 0x20) {
 		dev_err(&adap->dev, "Bus collision! SMBus may be locked until "
 			"next hard reset (or not...)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
-		result = -1;
+		result = -EIO;
 	}
 
 	temp = sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8);
@@ -282,11 +282,13 @@ static int sis5595_transaction(struct i2
 	return result;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 sis5595_access(struct i2c_adapter *adap, u16 addr,
 			  unsigned short flags, char read_write,
 			  u8 command, int size, union i2c_smbus_data *data)
 {
+	int status;
+
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		sis5595_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
@@ -318,13 +320,14 @@ static s32 sis5595_access(struct i2c_ada
 		break;
 	default:
 		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
-		return -1;
+		return -EOPNOTSUPP;
 	}
 
 	sis5595_write(SMB_CTL_LO, ((size & 0x0E)));
 
-	if (sis5595_transaction(adap))
-		return -1;
+	status = sis5595_transaction(adap);
+	if (status)
+		return status;
 
 	if ((size != SIS5595_PROC_CALL) &&
 	    ((read_write == I2C_SMBUS_WRITE) || (size == SIS5595_QUICK)))
--- g26.orig/drivers/i2c/busses/i2c-sis630.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-sis630.c	2008-05-01 16:02:58.000000000 -0700
@@ -134,7 +134,7 @@ static int sis630_transaction_start(stru
 
 		if ((temp = sis630_read(SMB_CNT) & 0x03) != 0x00) {
 			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
-			return -1;
+			return -EBUSY;
                 } else {
 			dev_dbg(&adap->dev, "Successful!\n");
 		}
@@ -177,17 +177,17 @@ static int sis630_transaction_wait(struc
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		dev_dbg(&adap->dev, "SMBus Timeout!\n");
-		result = -1;
+		result = -ETIMEDOUT;
 	}
 
 	if (temp & 0x02) {
 		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
-		result = -1;
+		result = -EIO;
 	}
 
 	if (temp & 0x04) {
 		dev_err(&adap->dev, "Bus collision!\n");
-		result = -1;
+		result = -EIO;
 		/*
 		  TBD: Datasheet say:
 		  the software should clear this bit and restart SMBUS operation.
@@ -250,8 +250,10 @@ static int sis630_block_data(struct i2c_
 			if (i==8 || (len<8 && i==len)) {
 				dev_dbg(&adap->dev, "start trans len=%d i=%d\n",len ,i);
 				/* first transaction */
-				if (sis630_transaction_start(adap, SIS630_BLOCK_DATA, &oldclock))
-					return -1;
+				rc = sis630_transaction_start(adap,
+						SIS630_BLOCK_DATA, &oldclock);
+				if (rc)
+					return rc;
 			}
 			else if ((i-1)%8 == 7 || i==len) {
 				dev_dbg(&adap->dev, "trans_wait len=%d i=%d\n",len,i);
@@ -264,9 +266,10 @@ static int sis630_block_data(struct i2c_
 					*/
 					sis630_write(SMB_STS,0x10);
 				}
-				if (sis630_transaction_wait(adap, SIS630_BLOCK_DATA)) {
+				rc = sis630_transaction_wait(adap,
+						SIS630_BLOCK_DATA);
+				if (rc) {
 					dev_dbg(&adap->dev, "trans_wait failed\n");
-					rc = -1;
 					break;
 				}
 			}
@@ -275,13 +278,14 @@ static int sis630_block_data(struct i2c_
 	else {
 		/* read request */
 		data->block[0] = len = 0;
-		if (sis630_transaction_start(adap, SIS630_BLOCK_DATA, &oldclock)) {
-			return -1;
-		}
+		rc = sis630_transaction_start(adap,
+				SIS630_BLOCK_DATA, &oldclock);
+		if (rc)
+			return rc;
 		do {
-			if (sis630_transaction_wait(adap, SIS630_BLOCK_DATA)) {
+			rc = sis630_transaction_wait(adap, SIS630_BLOCK_DATA);
+			if (rc) {
 				dev_dbg(&adap->dev, "trans_wait failed\n");
-				rc = -1;
 				break;
 			}
 			/* if this first transaction then read byte count */
@@ -311,11 +315,13 @@ static int sis630_block_data(struct i2c_
 	return rc;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 sis630_access(struct i2c_adapter *adap, u16 addr,
 			 unsigned short flags, char read_write,
 			 u8 command, int size, union i2c_smbus_data *data)
 {
+	int status;
+
 	switch (size) {
 		case I2C_SMBUS_QUICK:
 			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
@@ -351,12 +357,13 @@ static s32 sis630_access(struct i2c_adap
 			return sis630_block_data(adap, data, read_write);
 		default:
 			printk("Unsupported I2C size\n");
-			return -1;
+			return -EMSGSIZE;
 			break;
 	}
 
-	if (sis630_transaction(adap, size))
-		return -1;
+	status = sis630_transaction(adap, size);
+	if (status)
+		return status;
 
 	if ((size != SIS630_PCALL) &&
 		((read_write == I2C_SMBUS_WRITE) || (size == SIS630_QUICK))) {
@@ -373,7 +380,7 @@ static s32 sis630_access(struct i2c_adap
 			data->word = sis630_read(SMB_BYTE) + (sis630_read(SMB_BYTE + 1) << 8);
 			break;
 		default:
-			return -1;
+			return -EOPNOTSUPP;
 			break;
 	}
 
--- g26.orig/drivers/i2c/busses/i2c-sis96x.c	2008-05-01 16:01:38.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-sis96x.c	2008-05-01 16:02:58.000000000 -0700
@@ -111,7 +111,7 @@ static int sis96x_transaction(int size)
 		/* check it again */
 		if (((temp = sis96x_read(SMB_CNT)) & 0x03) != 0x00) {
 			dev_dbg(&sis96x_adapter.dev, "Failed (0x%02x)\n", temp);
-			return -1;
+			return -EBUSY;
 		} else {
 			dev_dbg(&sis96x_adapter.dev, "Successful\n");
 		}
@@ -136,19 +136,19 @@ static int sis96x_transaction(int size)
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		dev_dbg(&sis96x_adapter.dev, "SMBus Timeout! (0x%02x)\n", temp);
-		result = -1;
+		result = -ETIMEDOUT;
 	}
 
 	/* device error - probably missing ACK */
 	if (temp & 0x02) {
 		dev_dbg(&sis96x_adapter.dev, "Failed bus transaction!\n");
-		result = -1;
+		result = -EIO;
 	}
 
 	/* bus collision */
 	if (temp & 0x04) {
 		dev_dbg(&sis96x_adapter.dev, "Bus collision!\n");
-		result = -1;
+		result = -EIO;
 	}
 
 	/* Finish up by resetting the bus */
@@ -161,11 +161,12 @@ static int sis96x_transaction(int size)
 	return result;
 }
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 sis96x_access(struct i2c_adapter * adap, u16 addr,
 			 unsigned short flags, char read_write,
 			 u8 command, int size, union i2c_smbus_data * data)
 {
+	int status;
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -203,17 +204,18 @@ static s32 sis96x_access(struct i2c_adap
 	case I2C_SMBUS_BLOCK_DATA:
 		/* TO DO: */
 		dev_info(&adap->dev, "SMBus block not implemented!\n");
-		return -1;
+		return -EOPNOTSUPP;
 		break;
 
 	default:
 		dev_info(&adap->dev, "Unsupported I2C size\n");
-		return -1;
+		return -EMSGSIZE;
 		break;
 	}
 
-	if (sis96x_transaction(size))
-		return -1;
+	status = sis96x_transaction(size);
+	if (status)
+		return status;
 
 	if ((size != SIS96x_PROC_CALL) &&
 		((read_write == I2C_SMBUS_WRITE) || (size == SIS96x_QUICK)))
--- g26.orig/drivers/i2c/busses/i2c-stub.c	2008-05-01 16:10:15.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-stub.c	2008-05-01 16:10:46.000000000 -0700
@@ -43,7 +43,7 @@ struct stub_chip {
 
 static struct stub_chip *stub_chips;
 
-/* Return -1 on error. */
+/* Return negative errno on error. */
 static s32 stub_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
 	char read_write, u8 command, int size, union i2c_smbus_data * data)
 {
@@ -120,7 +120,7 @@ static s32 stub_xfer(struct i2c_adapter 
 
 	default:
 		dev_dbg(&adap->dev, "Unsupported I2C/SMBus command\n");
-		ret = -1;
+		ret = -EOPNOTSUPP;
 		break;
 	} /* switch (size) */
 
--- g26.orig/drivers/i2c/busses/i2c-viapro.c	2008-05-01 17:12:45.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-viapro.c	2008-05-01 17:15:03.000000000 -0700
@@ -152,7 +152,7 @@ static int vt596_transaction(u8 size)
 		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 			dev_err(&vt596_adapter.dev, "SMBus reset failed! "
 				"(0x%02x)\n", temp);
-			return -1;
+			return -EBUSY;
 		}
 	}
 
@@ -167,24 +167,24 @@ static int vt596_transaction(u8 size)
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		result = -1;
+		result = -ETIMEDOUT;
 		dev_err(&vt596_adapter.dev, "SMBus timeout!\n");
 	}
 
 	if (temp & 0x10) {
-		result = -1;
+		result = -EIO;
 		dev_err(&vt596_adapter.dev, "Transaction failed (0x%02x)\n",
 			size);
 	}
 
 	if (temp & 0x08) {
-		result = -1;
+		result = -EIO;
 		dev_err(&vt596_adapter.dev, "SMBus collision!\n");
 	}
 
 	if (temp & 0x04) {
 		int read = inb_p(SMBHSTADD) & 0x01;
-		result = -1;
+		result = -EIO;
 		/* The quick and receive byte commands are used to probe
 		   for chips, so errors are expected, and we don't want
 		   to frighten the user. */
@@ -202,12 +202,13 @@ static int vt596_transaction(u8 size)
 	return result;
 }
 
-/* Return -1 on error, 0 on success */
+/* Return negative errno on error, 0 on success */
 static s32 vt596_access(struct i2c_adapter *adap, u16 addr,
 		unsigned short flags, char read_write, u8 command,
 		int size, union i2c_smbus_data *data)
 {
 	int i;
+	int status;
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -258,8 +259,9 @@ static s32 vt596_access(struct i2c_adapt
 
 	outb_p(((addr & 0x7f) << 1) | read_write, SMBHSTADD);
 
-	if (vt596_transaction(size)) /* Error in transaction */
-		return -1;
+	status = vt596_transaction(size);
+	if (status)
+		return status;
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == VT596_QUICK))
 		return 0;
@@ -287,7 +289,7 @@ static s32 vt596_access(struct i2c_adapt
 exit_unsupported:
 	dev_warn(&vt596_adapter.dev, "Unsupported command invoked! (0x%02x)\n",
 		 size);
-	return -1;
+	return -EOPNOTSUPP;
 }
 
 static u32 vt596_func(struct i2c_adapter *adapter)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
