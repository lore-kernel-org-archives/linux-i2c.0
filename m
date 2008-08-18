From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-floppy: Mutually exclusive with the PC floppy
	driver
Date: Mon, 18 Aug 2008 21:03:06 +0200
Message-ID: <20080818210306.01acddaf@hyperion.delvare>
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

Make sure that the i2c-floppy and floppy drivers can't both be built
into the kernel.

Also tag i2c-floppy EXPERIMENTAL for now, it's a new driver that did
not see much testing yet.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.27-rc3.orig/drivers/i2c/busses/Kconfig	2008-08-18 19:54:54.000000000 +0200
+++ linux-2.6.27-rc3/drivers/i2c/busses/Kconfig	2008-08-18 20:58:01.000000000 +0200
@@ -508,6 +508,7 @@ config I2C_FLOPPY
 	tristate "Floppy controller adapter"
 	select I2C_ALGOBIT
 	default n
+	depends on !BLK_DEV_FD && EXPERIMENTAL
 	help
 	  This supports a simple do-it-yourself floppy controller to
 	  I2C adapters using the motor control lines for SDA and SCL,


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
