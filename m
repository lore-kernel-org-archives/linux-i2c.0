From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] Schedule removal of the legacy i2c device driver
 binding model
Date: Sat, 18 Oct 2008 14:35:03 +0200
Message-ID: <20081018143503.01af9fce@hyperion.delvare>
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

The legacy i2c device driver binding model is superseded by the
standard model, so it's time to deprecate it and schedule it for
removal.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.28-rc0.orig/Documentation/feature-removal-schedule.txt	2008-10-18 09:53:36.000000000 +0200
+++ linux-2.6.28-rc0/Documentation/feature-removal-schedule.txt	2008-10-18 13:13:38.000000000 +0200
@@ -359,3 +359,11 @@ Why:  The 2.6 kernel supports direct wri
       eliminates the need for ide-scsi. The new method is more
       efficient in every way.
 Who:  FUJITA Tomonori <fujita.tomonori-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
+
+---------------------------
+
+What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
+When:	2.6.29 (ideally) or 2.6.30 (more likely)
+Why:	Deprecated by the new (standard) device driver binding model. Use
+	i2c_driver->probe() and ->remove() instead.
+Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
