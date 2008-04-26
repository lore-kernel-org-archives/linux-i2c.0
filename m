From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-piix4: Minor cleanups
Date: Sat, 26 Apr 2008 11:05:31 +0200
Message-ID: <20080426110531.1c9b060f@hyperion.delvare>
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

* Remove a needless include.
* Remove a legacy comment in piix4_access.
* Minor optimization in piix4_access.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.26-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2008-04-26 10:44:05.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/busses/i2c-piix4.c	2008-04-26 10:49:16.000000000 +0200
@@ -38,7 +38,6 @@
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/apm_bios.h>
 #include <linux/dmi.h>
 #include <asm/io.h>
 
@@ -343,12 +342,7 @@ static s32 piix4_access(struct i2c_adapt
 
 
 	switch (size) {
-	case PIIX4_BYTE:	/* Where is the result put? I assume here it is in
-				   SMBHSTDAT0 but it might just as well be in the
-				   SMBHSTCMD. No clue in the docs */
-
-		data->byte = inb_p(SMBHSTDAT0);
-		break;
+	case PIIX4_BYTE:
 	case PIIX4_BYTE_DATA:
 		data->byte = inb_p(SMBHSTDAT0);
 		break;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
