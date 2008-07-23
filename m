From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/03] i2c-i801: Fix alignment issues
Date: Wed, 23 Jul 2008 18:57:09 +0200
Message-ID: <488762E5.2030109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040701010902070201080504"
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------040701010902070201080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes alignment issues introduced by previous patch.

Signed-off-by: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
This patch depends on: [PATCH 01/03] i2c-i801: Add basic interrupt support



--------------040701010902070201080504
Content-Type: text/plain;
 name="patch2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2.diff"

--- i2c-i801-nolayout.c	2008-07-07 15:05:21.000000000 +0200
+++ i2c-i801.c	2008-07-07 15:04:25.000000000 +0200
@@ -210,24 +210,24 @@ static int i801_transaction(int xact)
 					((temp = i801_get_status(algo_data))
 					& I801_HST_STS_MASK_NORM), HZ/2);
 	} else {
-	outb_p(xact | I801_START, SMBHSTCNT);
+		outb_p(xact | I801_START, SMBHSTCNT);
 
-	/* We will always wait for a fraction of a second! */
-	do {
-		msleep(1);
-		temp = inb_p(SMBHSTSTS);
-	} while ((temp & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
+		/* We will always wait for a fraction of a second! */
+		do {
+			msleep(1);
+			temp = inb_p(SMBHSTSTS);
+		} while ((temp & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
 
-	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
-		dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
-		result = -1;
-		/* try to stop the current command */
-		dev_dbg(&I801_dev->dev, "Terminating the current operation\n");
-		outb_p(inb_p(SMBHSTCNT) | SMBHSTCNT_KILL, SMBHSTCNT);
-		msleep(1);
-		outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL), SMBHSTCNT);
-	}
+		/* If the SMBus is still busy, we give up */
+		if (timeout >= MAX_TIMEOUT) {
+			dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
+			result = -1;
+			/* try to stop the current command */
+			dev_dbg(&I801_dev->dev, "Terminating the current operation\n");
+			outb_p(inb_p(SMBHSTCNT) | SMBHSTCNT_KILL, SMBHSTCNT);
+			msleep(1);
+			outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL), SMBHSTCNT);
+		}
 	}
 
 	if (temp & SMBHSTSTS_FAILED) {

--------------040701010902070201080504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------040701010902070201080504--
