From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/4] i2c-i801: Properly report bus arbitration loss
Date: Sat, 14 Jun 2008 21:52:39 +0200
Message-ID: <20080614215239.3bb8ba04@hyperion.delvare>
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

Bit BUS_ERR of the status register means that the ICH host controller
lost the arbitration. Report this event as such.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/i2c/busses/i2c-i801.c	2008-06-14 08:37:17.000000000 +0200
+++ linux-2.6.26-rc5/drivers/i2c/busses/i2c-i801.c	2008-06-14 17:13:08.000000000 +0200
@@ -180,10 +180,8 @@ static int i801_transaction(int xact)
 	}
 
 	if (temp & SMBHSTSTS_BUS_ERR) {
-		result = -EIO;
-		dev_err(&I801_dev->dev, "Bus collision! SMBus may be locked "
-			"until next hard reset. (sorry!)\n");
-		/* Clock stops and slave is stuck in mid-transmission */
+		result = -EAGAIN;
+		dev_dbg(&I801_dev->dev, "Lost arbitration\n");
 	}
 
 	if (temp & SMBHSTSTS_DEV_ERR) {
@@ -340,8 +338,8 @@ static int i801_block_transaction_byte_b
 			dev_dbg(&I801_dev->dev,
 				"Error: Failed bus transaction\n");
 		} else if (temp & SMBHSTSTS_BUS_ERR) {
-			result = -EIO;
-			dev_err(&I801_dev->dev, "Bus collision!\n");
+			result = -EAGAIN;
+			dev_dbg(&I801_dev->dev, "Lost arbitration\n");
 		} else if (temp & SMBHSTSTS_DEV_ERR) {
 			result = -ENXIO;
 			dev_dbg(&I801_dev->dev, "Error: no response!\n");


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
