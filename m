From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 1/2] i2c: Update my e-mail address
Date: Fri, 22 Jun 2012 12:11:10 -0700
Message-ID: <1340392270-10443-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

My old e-mail address won't be valid for much longer. Time to update it.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-diolan-u2c.c |    2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index 7eb19a5..aedb94f 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -517,6 +517,6 @@ static struct usb_driver diolan_u2c_driver = {
 
 module_usb_driver(diolan_u2c_driver);
 
-MODULE_AUTHOR("Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>");
+MODULE_AUTHOR("Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>");
 MODULE_DESCRIPTION(DRIVER_NAME " driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 8aacde1..f8f72f3 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -396,6 +396,6 @@ static struct i2c_driver pca9541_driver = {
 
 module_i2c_driver(pca9541_driver);
 
-MODULE_AUTHOR("Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>");
+MODULE_AUTHOR("Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>");
 MODULE_DESCRIPTION("PCA9541 I2C master selector driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.7
