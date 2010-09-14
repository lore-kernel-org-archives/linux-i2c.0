From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH] I2C-GPIO: Don't include the asm/gpio.h directly
Date: Tue, 14 Sep 2010 16:30:53 +0900
Message-ID: <20100914073053.GA15611__26372.7674413987$1284449483$gmane$org@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang@pengut>
List-Id: linux-i2c@vger.kernel.org

Don't include asm/gpio.h directly. Use the linux/gpio.h.

Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index d9aa9a6..0c1cc37 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 /* Toggle SDA by changing the direction of the pin */
 static void i2c_gpio_setsda_dir(void *data, int state)
