From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH 1/2] i2c: i2c-tiny-usb: Remove RobotFuzz USB vendor:product ID
Date: Fri, 15 Nov 2013 11:08:13 +0100
Message-ID: <1384510094-9664-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The RobotFuzz device is not compatible with i2c-tiny-usb. Remove its
entry from the USB table so that the new correct driver can be used.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
CC: Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>
CC: Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

FYI: I'm away from the net for the next two weeks. So please take your time
with reviewing.

 drivers/i2c/busses/i2c-tiny-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index e7d3b755af3b..0ed77eeff31e 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -162,7 +162,6 @@ static const struct i2c_algorithm usb_algorithm = {
 static const struct usb_device_id i2c_tiny_usb_table[] = {
 	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
 	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
-	{ USB_DEVICE(0x1964, 0x0001) },   /* Robofuzz OSIF */
 	{ }                               /* Terminating entry */
 };
 
-- 
1.8.4.rc3
