From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Discard warning message on device instantiation from
 user-space
Date: Tue, 5 Oct 2010 16:53:42 +0200
Message-ID: <20101005165342.424ce502@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Discard warning message on device instantiation from user-space

The "new_device" sysfs interface has been there for quite some time
now, nobody complained about it so it must be good enough. Time to
remove the warning and call it stable.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.36-rc6.orig/drivers/i2c/i2c-core.c	2010-10-05 13:32:18.000000000 +0200
+++ linux-2.6.36-rc6/drivers/i2c/i2c-core.c	2010-10-05 13:33:55.000000000 +0200
@@ -683,8 +683,6 @@ i2c_sysfs_new_device(struct device *dev,
 	char *blank, end;
 	int res;
 
-	dev_warn(dev, "The new_device interface is still experimental "
-		 "and may change in a near future\n");
 	memset(&info, 0, sizeof(struct i2c_board_info));
 
 	blank = strchr(buf, ' ');


-- 
Jean Delvare
