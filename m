From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Consistently reject unsupported transactions
Date: Fri, 16 May 2008 14:11:08 +0200
Message-ID: <20080516141108.1c778c22@hyperion.delvare>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Many PC SMBus host controller drivers don't properly handle the case
where they are requested to achieve a transaction they do not support.
Update them so that the consistently print a warning message and
return a single error value in this case.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This goes on top of David Brownell's patch fixing the error codes
returned by these drivers.

 drivers/i2c/busses/i2c-ali1535.c  |    8 ++++----
 drivers/i2c/busses/i2c-ali1563.c  |    8 ++++----
 drivers/i2c/busses/i2c-ali15x3.c  |    6 +++---
 drivers/i2c/busses/i2c-amd756.c   |    8 +++-----
 drivers/i2c/busses/i2c-i801.c     |    1 -
 drivers/i2c/busses/i2c-piix4.c    |    6 +++---
 drivers/i2c/busses/i2c-sis630.c   |    5 ++---
 drivers/i2c/busses/i2c-sis96x.c   |    8 +-------
 drivers/i2c/busses/i2c-taos-evm.c |    5 ++---
 drivers/i2c/busses/i2c-viapro.c   |    2 +-
 10 files changed, 23 insertions(+), 34 deletions(-)

--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-ali1535.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-ali1535.c	2008-05-16 13:54:50.000000000 +0200
@@ -357,10 +357,6 @@ static s32 ali1535_access(struct i2c_ada
 	outb_p(0xFF, SMBHSTSTS);
 
 	switch (size) {
-	case I2C_SMBUS_PROC_CALL:
-		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		result = -EOPNOTSUPP;
-		goto EXIT;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
@@ -418,6 +414,10 @@ static s32 ali1535_access(struct i2c_ada
 				outb_p(data->block[i], SMBBLKDAT);
 		}
 		break;
+	default:
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		result = -EOPNOTSUPP;
+		goto EXIT;
 	}
 
 	result = ali1535_transaction(adap);
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-ali1563.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-ali1563.c	2008-05-16 14:03:57.000000000 +0200
@@ -243,10 +243,6 @@ static s32 ali1563_access(struct i2c_ada
 
 	/* Map the size to what the chip understands */
 	switch (size) {
-	case I2C_SMBUS_PROC_CALL:
-		dev_err(&a->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		error = -EINVAL;
-		break;
 	case I2C_SMBUS_QUICK:
 		size = HST_CNTL2_QUICK;
 		break;
@@ -262,6 +258,10 @@ static s32 ali1563_access(struct i2c_ada
 	case I2C_SMBUS_BLOCK_DATA:
 		size = HST_CNTL2_BLOCK;
 		break;
+	default:
+		dev_warn(&a->dev, "Unsupported transaction %d\n", size);
+		error = -EOPNOTSUPP;
+		goto Done;
 	}
 
 	outb_p(((addr & 0x7f) << 1) | (rw & 0x01), SMB_HST_ADD);
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-ali15x3.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-ali15x3.c	2008-05-16 13:54:50.000000000 +0200
@@ -362,9 +362,6 @@ static s32 ali15x3_access(struct i2c_ada
 	}
 
 	switch (size) {
-	case I2C_SMBUS_PROC_CALL:
-		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD);
@@ -417,6 +414,9 @@ static s32 ali15x3_access(struct i2c_ada
 		}
 		size = ALI15X3_BLOCK_DATA;
 		break;
+	default:
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		return -EOPNOTSUPP;
 	}
 
 	outb_p(size, SMBHSTCNT);	/* output command */
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-amd756.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-amd756.c	2008-05-16 13:54:50.000000000 +0200
@@ -200,12 +200,7 @@ static s32 amd756_access(struct i2c_adap
 	int i, len;
 	int status;
 
-	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
-	case I2C_SMBUS_PROC_CALL:
-		dev_dbg(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		/* TODO: Well... It is supported, I'm just not sure what to do here... */
-		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
 		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMB_HOST_ADDRESS);
@@ -252,6 +247,9 @@ static s32 amd756_access(struct i2c_adap
 		}
 		size = AMD756_BLOCK_DATA;
 		break;
+	default:
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		return -EOPNOTSUPP;
 	}
 
 	/* How about enabling interrupts... */
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-i801.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-i801.c	2008-05-16 13:54:50.000000000 +0200
@@ -513,7 +513,6 @@ static s32 i801_access(struct i2c_adapte
 			outb_p(command, SMBHSTCMD);
 		block = 1;
 		break;
-	case I2C_SMBUS_PROC_CALL:
 	default:
 		dev_err(&I801_dev->dev, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-piix4.c	2008-05-16 13:54:46.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-piix4.c	2008-05-16 13:54:50.000000000 +0200
@@ -307,9 +307,6 @@ static s32 piix4_access(struct i2c_adapt
 	int status;
 
 	switch (size) {
-	case I2C_SMBUS_PROC_CALL:
-		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
-		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
 		outb_p((addr << 1) | read_write,
 		       SMBHSTADD);
@@ -355,6 +352,9 @@ static s32 piix4_access(struct i2c_adapt
 		}
 		size = PIIX4_BLOCK_DATA;
 		break;
+	default:
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		return -EOPNOTSUPP;
 	}
 
 	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-sis630.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-sis630.c	2008-05-16 13:54:50.000000000 +0200
@@ -356,7 +356,8 @@ static s32 sis630_access(struct i2c_adap
 			size = SIS630_BLOCK_DATA;
 			return sis630_block_data(adap, data, read_write);
 		default:
-			printk("Unsupported SMBus operation\n");
+			dev_warn(&adap->dev, "Unsupported transaction %d\n",
+				 size);
 			return -EOPNOTSUPP;
 	}
 
@@ -378,8 +379,6 @@ static s32 sis630_access(struct i2c_adap
 		case SIS630_WORD_DATA:
 			data->word = sis630_read(SMB_BYTE) + (sis630_read(SMB_BYTE + 1) << 8);
 			break;
-		default:
-			return -EOPNOTSUPP;
 	}
 
 	return 0;
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-sis96x.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-sis96x.c	2008-05-16 13:54:50.000000000 +0200
@@ -201,14 +201,8 @@ static s32 sis96x_access(struct i2c_adap
 			SIS96x_PROC_CALL : SIS96x_WORD_DATA);
 		break;
 
-	case I2C_SMBUS_BLOCK_DATA:
-		/* TO DO: */
-		dev_info(&adap->dev, "SMBus block not implemented!\n");
-		return -EOPNOTSUPP;
-		break;
-
 	default:
-		dev_info(&adap->dev, "Unsupported SMBus operation\n");
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-taos-evm.c	2008-05-16 13:45:09.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-taos-evm.c	2008-05-16 13:54:50.000000000 +0200
@@ -96,9 +96,8 @@ static int taos_smbus_xfer(struct i2c_ad
 			sprintf(p, "$%02X", command);
 		break;
 	default:
-		dev_dbg(&adapter->dev, "Unsupported transaction size %d\n",
-			size);
-		return -EINVAL;
+		dev_warn(&adapter->dev, "Unsupported transaction %d\n", size);
+		return -EOPNOTSUPP;
 	}
 
 	/* Send the transaction to the TAOS EVM */
--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-viapro.c	2008-05-16 13:54:38.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-viapro.c	2008-05-16 13:54:50.000000000 +0200
@@ -289,7 +289,7 @@ static s32 vt596_access(struct i2c_adapt
 	return 0;
 
 exit_unsupported:
-	dev_warn(&vt596_adapter.dev, "Unsupported command invoked! (0x%02x)\n",
+	dev_warn(&vt596_adapter.dev, "Unsupported transaction %d\n",
 		 size);
 	return -EOPNOTSUPP;
 }


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
