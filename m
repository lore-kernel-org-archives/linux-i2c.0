From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop unused RTC driver IDs
Date: Tue, 29 Apr 2008 09:56:44 +0200
Message-ID: <20080429095644.60bc205b@hyperion.delvare>
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
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The x1208, pcf8563 and isl1208 RTC drivers have been converted to
new-style i2c drivers, so they no longer use I2C driver IDs.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
---
 include/linux/i2c-id.h |    3 ---
 1 file changed, 3 deletions(-)

--- linux-2.6.26-rc0.orig/include/linux/i2c-id.h	2008-04-29 07:41:42.000000000 +0200
+++ linux-2.6.26-rc0/include/linux/i2c-id.h	2008-04-29 09:16:59.000000000 +0200
@@ -79,12 +79,9 @@
 #define I2C_DRIVERID_UPD64031A	79	/* upd64031a video processor	*/
 #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
 #define I2C_DRIVERID_DS1672	81	/* Dallas/Maxim DS1672 RTC	*/
-#define I2C_DRIVERID_X1205	82	/* Xicor/Intersil X1205 RTC	*/
-#define I2C_DRIVERID_PCF8563	83	/* Philips PCF8563 RTC		*/
 #define I2C_DRIVERID_BT866	85	/* Conexant bt866 video encoder */
 #define I2C_DRIVERID_KS0127	86	/* Samsung ks0127 video decoder */
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
-#define I2C_DRIVERID_ISL1208	88	/* Intersil ISL1208 RTC		*/
 #define I2C_DRIVERID_WM8731	89	/* Wolfson WM8731 audio codec */
 #define I2C_DRIVERID_WM8750	90	/* Wolfson WM8750 audio codec */
 #define I2C_DRIVERID_WM8753	91	/* Wolfson WM8753 audio codec */


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
