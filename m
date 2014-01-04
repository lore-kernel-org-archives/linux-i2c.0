From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: viperboard: remove superfluous assignment
Date: Sat,  4 Jan 2014 22:21:33 +0100
Message-ID: <1388870493-6523-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

cppcheck rightfully says:

drivers/i2c/busses/i2c-viperboard.c:169: style: Variable 'bytes_xfer' is assigned a value that is never used.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-viperboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index 6976e1c..7533fa3 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -118,8 +118,7 @@ static int vprbrd_i2c_addr(struct usb_device *usb_dev,
 static int vprbrd_i2c_read(struct vprbrd *vb, struct i2c_msg *msg)
 {
 	int ret;
-	u16 remain_len, bytes_xfer, len1, len2,
-		start = 0x0000;
+	u16 remain_len, len1, len2, start = 0x0000;
 	struct vprbrd_i2c_read_msg *rmsg =
 		(struct vprbrd_i2c_read_msg *)vb->buf;
 
@@ -166,7 +165,6 @@ static int vprbrd_i2c_read(struct vprbrd *vb, struct i2c_msg *msg)
 			rmsg->header.len3 = remain_len - 512;
 			rmsg->header.len4 = 0x00;
 			rmsg->header.len5 = 0x00;
-			bytes_xfer = remain_len;
 			remain_len = 0;
 		} else if (remain_len <= 1022) {
 			len1 = 512;
-- 
1.8.5.1
