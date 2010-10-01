From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 7/9] hwmon: lis3: Adjust fuzziness for 8 bit device
Date: Fri,  1 Oct 2010 14:46:54 +0300
Message-ID: <1285933616-16044-8-git-send-email-samu.p.onkalo@nokia.com>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285933616-16044-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Default fuziness is set smaller for 8 device.
In 12 bit device LSB is quite close to 1 mg.
In 8bit device LSB is about 18 mg. This add
default sensitivity for 8 bit device.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/hwmon/lis3lv02d.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 0a46a0e..b740024 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -70,8 +70,10 @@
 #define LIS3_SENSITIVITY_12B		((LIS3_ACCURACY * 1000) / 1024)
 #define LIS3_SENSITIVITY_8B		(18 * LIS3_ACCURACY)
 
-#define LIS3_DEFAULT_FUZZ		3
-#define LIS3_DEFAULT_FLAT		3
+#define LIS3_DEFAULT_FUZZ_12B		3
+#define LIS3_DEFAULT_FLAT_12B		3
+#define LIS3_DEFAULT_FUZZ_8B		1
+#define LIS3_DEFAULT_FLAT_8B		1
 
 struct lis3lv02d lis3_dev = {
 	.misc_wait   = __WAIT_QUEUE_HEAD_INITIALIZER(lis3_dev.misc_wait),
@@ -529,8 +531,16 @@ int lis3lv02d_joystick_enable(void)
 
 	set_bit(EV_ABS, input_dev->evbit);
 	max_val = (lis3_dev.mdps_max_val * lis3_dev.scale) / LIS3_ACCURACY;
-	fuzz = (LIS3_DEFAULT_FUZZ * lis3_dev.scale) / LIS3_ACCURACY;
-	flat = (LIS3_DEFAULT_FLAT * lis3_dev.scale) / LIS3_ACCURACY;
+	if (lis3_dev.whoami == WAI_12B) {
+		fuzz = LIS3_DEFAULT_FUZZ_12B;
+		flat = LIS3_DEFAULT_FLAT_12B;
+	} else {
+		fuzz = LIS3_DEFAULT_FUZZ_8B;
+		flat = LIS3_DEFAULT_FLAT_8B;
+	}
+	fuzz = (fuzz * lis3_dev.scale) / LIS3_ACCURACY;
+	flat = (flat * lis3_dev.scale) / LIS3_ACCURACY;
+
 	input_set_abs_params(input_dev, ABS_X, -max_val, max_val, fuzz, flat);
 	input_set_abs_params(input_dev, ABS_Y, -max_val, max_val, fuzz, flat);
 	input_set_abs_params(input_dev, ABS_Z, -max_val, max_val, fuzz, flat);
-- 
1.6.0.4
