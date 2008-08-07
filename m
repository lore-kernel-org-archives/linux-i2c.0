From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Fix NULL pointer dereference in
	i2c_new_probed_device
Date: Thu, 7 Aug 2008 15:12:30 +0200
Message-ID: <20080807151230.5506c047@hyperion.delvare>
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

From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>

Fix a NULL pointer dereference that happened when calling
i2c_new_probed_device on one of the addresses for which we use byte
reads instead of quick write for detection purpose (that is: 0x30-0x37
and 0x50-0x5f).

Signed-off-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.27-rc2.orig/drivers/i2c/i2c-core.c	2008-08-05 18:17:05.000000000 +0200
+++ linux-2.6.27-rc2/drivers/i2c/i2c-core.c	2008-08-07 14:42:28.000000000 +0200
@@ -1451,9 +1451,11 @@ i2c_new_probed_device(struct i2c_adapter
 		if ((addr_list[i] & ~0x07) == 0x30
 		 || (addr_list[i] & ~0x0f) == 0x50
 		 || !i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK)) {
+			union i2c_smbus_data data;
+
 			if (i2c_smbus_xfer(adap, addr_list[i], 0,
 					   I2C_SMBUS_READ, 0,
-					   I2C_SMBUS_BYTE, NULL) >= 0)
+					   I2C_SMBUS_BYTE, &data) >= 0)
 				break;
 		} else {
 			if (i2c_smbus_xfer(adap, addr_list[i], 0,


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
