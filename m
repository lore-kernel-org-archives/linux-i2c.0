From: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Subject: [PATCH] TSL2550: extended mode bugfix
Date: Wed, 05 Aug 2009 17:08:05 +0200
Message-ID: <4A79A055.1010602@valueteam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,
according to the TAOS Application Note 'Controlling a Backlight with the
TSL2550 Ambient Light Sensor' (page 14), the actual lux value in
extended mode should be obtained multiplying the calculated lux value by 5.
The following patch should fix the lux calculation in this case.

Regards,
Michele De Candia
--

Signed-off-by: Michele Jr De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>

drivers/i2c/chips/tsl2550.c |    7 +++++--
1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/tsl2550.c b/drivers/i2c/chips/tsl2550.c
index b96f302..04b87e0 100644
--- a/drivers/i2c/chips/tsl2550.c
+++ b/drivers/i2c/chips/tsl2550.c
@@ -279,7 +279,7 @@ static ssize_t __tsl2550_show_lux(struct i2c_client
*client, char *buf)
{
     u8 ch0, ch1;
     int ret;
-
+    struct tsl2550_data *data = i2c_get_clientdata(client);
     ret = tsl2550_get_adc_value(client, TSL2550_READ_ADC0);
     if (ret < 0)
         return ret;
@@ -293,7 +293,10 @@ static ssize_t __tsl2550_show_lux(struct i2c_client
*client, char *buf)
     ch1 = ret;

     /* Do the job */
-    ret = tsl2550_calculate_lux(ch0, ch1);
+    if (!data->operating_mode)
+        ret = tsl2550_calculate_lux(ch0, ch1);
+    else
+        ret = tsl2550_calculate_lux(ch0, ch1) * 5;
     if (ret < 0)
         return ret;
