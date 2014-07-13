From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-stub: Avoid an array overrun on I2C block transfers
Date: Sun, 13 Jul 2014 17:17:17 +0200
Message-ID: <20140713171717.25497712@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I2C block transfers can have a size up to 32 bytes. If starting close
to the end of the address space, there may not be enough room to write
that many bytes (on I2C block writes) or not enough bytes to be read
(on I2C block reads.) In that case, we must shorten the transfer so
that it does not exceed the address space.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-stub.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-3.16-rc4.orig/drivers/i2c/i2c-stub.c	2014-07-12 11:56:30.933096483 +0200
+++ linux-3.16-rc4/drivers/i2c/i2c-stub.c	2014-07-13 17:01:02.891235856 +0200
@@ -220,6 +220,8 @@ static s32 stub_xfer(struct i2c_adapter
 		 * We ignore banks here, because banked chips don't use I2C
 		 * block transfers
 		 */
+		if (data->block[0] > 256 - command)	/* Avoid overrun */
+			data->block[0] = 256 - command;
 		len = data->block[0];
 		if (read_write == I2C_SMBUS_WRITE) {
 			for (i = 0; i < len; i++) {


-- 
Jean Delvare
SUSE L3 Support
