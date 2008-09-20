From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Fix mailing lists in two MAINTAINERS entries
Date: Sat, 20 Sep 2008 11:19:50 +0200
Message-ID: <20080920111950.784c0906@hyperion.delvare>
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

Two MAINTAINER entries (I2C/SMBUS STUB DRIVER and SIS 96X I2C/SMBUS
DRIVER) were improperly pointing to the lm-sensors mailing list
instead of the i2c mailing list. Fix them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.27-rc6.orig/MAINTAINERS
+++ linux-2.6.27-rc6/MAINTAINERS
@@ -1984,7 +1984,7 @@ S:	Maintained
 I2C/SMBUS STUB DRIVER
 P:	Mark M. Hoffman
 M:	mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org
-L:	lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
 S:	Maintained
 
 I2C SUBSYSTEM
@@ -3726,7 +3726,7 @@ S:	Maintained
 SIS 96X I2C/SMBUS DRIVER
 P:	Mark M. Hoffman
 M:	mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org
-L:	lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
 S:	Maintained
 
 SIS FRAMEBUFFER DRIVER


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
