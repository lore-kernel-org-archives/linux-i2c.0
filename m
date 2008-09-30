From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Only build Tyan SMBus mux drivers on x86
Date: Tue, 30 Sep 2008 11:51:46 +0200
Message-ID: <20080930115146.50ae52d7@hyperion.delvare>
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

The two Tyan SMBus mux drivers (i2c-amd756-s4882 and i2c-nforce2-s4985)
are only useful on specific x86 motherboards, so there is no point in
letting them be built on other architectures.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.27-rc8.orig/drivers/i2c/busses/Kconfig	2008-09-30 10:18:54.000000000 +0200
+++ linux-2.6.27-rc8/drivers/i2c/busses/Kconfig	2008-09-30 11:46:34.000000000 +0200
@@ -55,7 +55,7 @@ config I2C_AMD756
 
 config I2C_AMD756_S4882
 	tristate "SMBus multiplexing on the Tyan S4882"
-	depends on I2C_AMD756 && EXPERIMENTAL
+	depends on I2C_AMD756 && X86 && EXPERIMENTAL
 	help
 	  Enabling this option will add specific SMBus support for the Tyan
 	  S4882 motherboard.  On this 4-CPU board, the SMBus is multiplexed
@@ -149,7 +149,7 @@ config I2C_NFORCE2
 
 config I2C_NFORCE2_S4985
 	tristate "SMBus multiplexing on the Tyan S4985"
-	depends on I2C_NFORCE2 && EXPERIMENTAL
+	depends on I2C_NFORCE2 && X86 && EXPERIMENTAL
 	help
 	  Enabling this option will add specific SMBus support for the Tyan
 	  S4985 motherboard.  On this 4-CPU board, the SMBus is multiplexed


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
