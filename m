From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/4] i2c-i801: Remove verbose debugging messages
Date: Sat, 14 Jun 2008 21:51:50 +0200
Message-ID: <20080614215150.468d1198@hyperion.delvare>
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

Dumping the register values before and after every transaction was
useful during driver development but now it's only spamming the log.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This patch and the 3 that follow, apply on top of 2.6.26-rc6 + my i2c
tree. If you want to test them, it's probably easier to pick my tar'ed
i2c tree at:
  http://khali.linux-fr.org/devel/linux-2.6/

 drivers/i2c/busses/i2c-i801.c |   18 ------------------
 1 file changed, 18 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/i2c/busses/i2c-i801.c	2008-06-08 20:36:31.000000000 +0200
+++ linux-2.6.26-rc5/drivers/i2c/busses/i2c-i801.c	2008-06-14 17:13:11.000000000 +0200
@@ -139,11 +139,6 @@ static int i801_transaction(int xact)
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
-		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
-		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		inb_p(SMBHSTDAT1));
-
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
@@ -203,10 +198,6 @@ static int i801_transaction(int xact)
 		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
 			"(%02x)\n", temp);
 	}
-	dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
-		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
-		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		inb_p(SMBHSTDAT1));
 	return result;
 }
 
@@ -294,11 +285,6 @@ static int i801_block_transaction_byte_b
 		}
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
 
-		dev_dbg(&I801_dev->dev, "Block (pre %d): CNT=%02x, CMD=%02x, "
-			"ADD=%02x, DAT0=%02x, DAT1=%02x, BLKDAT=%02x\n", i,
-			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
-			inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1), inb_p(SMBBLKDAT));
-
 		/* Make sure the SMBus host is ready to start transmitting */
 		temp = inb_p(SMBHSTSTS);
 		if (i == 1) {
@@ -382,10 +368,6 @@ static int i801_block_transaction_byte_b
 				"Bad status (%02x) at end of transaction\n",
 				temp);
 		}
-		dev_dbg(&I801_dev->dev, "Block (post %d): CNT=%02x, CMD=%02x, "
-			"ADD=%02x, DAT0=%02x, DAT1=%02x, BLKDAT=%02x\n", i,
-			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
-			inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1), inb_p(SMBBLKDAT));
 
 		if (result < 0)
 			return result;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
