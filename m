From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-sis5595: Minor cleanups in sis5595_access
Date: Sat, 26 Apr 2008 11:08:01 +0200
Message-ID: <20080426110801.67f204c1@hyperion.delvare>
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
List-Id: linux-i2c@vger.kernel.org

* Remove commented-out code.
* Use dev_warn instead of printk.
* Remove a legacy comment.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis5595.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- linux-2.6.26-rc0.orig/drivers/i2c/busses/i2c-sis5595.c	2008-04-26 10:44:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/busses/i2c-sis5595.c	2008-04-26 10:56:05.000000000 +0200
@@ -316,14 +316,8 @@ static s32 sis5595_access(struct i2c_ada
 		}
 		size = (size == I2C_SMBUS_PROC_CALL) ? SIS5595_PROC_CALL : SIS5595_WORD_DATA;
 		break;
-/*
-	case I2C_SMBUS_BLOCK_DATA:
-		printk(KERN_WARNING "sis5595.o: Block data not yet implemented!\n");
-		return -1;
-		break;
-*/
 	default:
-		printk(KERN_WARNING "sis5595.o: Unsupported transaction %d\n", size);
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
 		return -1;
 	}
 
@@ -338,9 +332,7 @@ static s32 sis5595_access(struct i2c_ada
 
 
 	switch (size) {
-	case SIS5595_BYTE:	/* Where is the result put? I assume here it is in
-				   SMB_DATA but it might just as well be in the
-				   SMB_CMD. No clue in the docs */
+	case SIS5595_BYTE:
 	case SIS5595_BYTE_DATA:
 		data->byte = sis5595_read(SMB_BYTE);
 		break;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
