From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Driver IDs are optional
Date: Thu, 3 Jan 2008 17:57:31 +0100
Message-ID: <20080103175731.5c04915f@hyperion.delvare>
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
Cc: Janesh Ramakrishnan <jramakrishnan-WFYV2PrdoUdl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Document the fact that I2C driver IDs are optional.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c-id.h |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.24-rc6.orig/include/linux/i2c-id.h	2007-12-21 18:20:04.000000000 +0100
+++ linux-2.6.24-rc6/include/linux/i2c-id.h	2007-12-21 18:20:40.000000000 +0100
@@ -23,6 +23,10 @@
 #ifndef LINUX_I2C_ID_H
 #define LINUX_I2C_ID_H
 
+/* Please note that I2C driver IDs are optional. They are only needed if a
+   legacy chip driver needs to identify a bus or a bus driver needs to
+   identify a legacy client. If you don't need them, just don't set them. */
+
 /*
  * ---- Driver types -----------------------------------------------------
  */


-- 
Jean Delvare
