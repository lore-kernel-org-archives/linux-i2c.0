From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2] i2c-stub: Allow increasing the SMBus block write length
Date: Sun, 13 Jul 2014 09:23:31 +0200
Message-ID: <20140713092331.67d4f5b3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is no good reason to not allow SMBus block writes longer than the
first one was. Lift this limitation, this makes the code more simple.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
Changes since v1:
* Sent in a separate thread
* Added Guenter's Reviewed-by
* Fixed subject

 Documentation/i2c/i2c-stub |    5 ++---
 drivers/i2c/i2c-stub.c     |   12 +++---------
 2 files changed, 5 insertions(+), 12 deletions(-)

--- linux-3.16-rc4.orig/Documentation/i2c/i2c-stub	2014-07-12 09:41:26.508195718 +0200
+++ linux-3.16-rc4/Documentation/i2c/i2c-stub	2014-07-12 10:40:05.064578130 +0200
@@ -20,9 +20,8 @@ operations.  This allows for continuous
 EEPROMs, among others.
 
 SMBus block commands must be written to configure an SMBus command for
-SMBus block operations. The first SMBus block write selects the block length.
-Subsequent writes can be partial. Block read commands always return
-the number of bytes selected with the first write.
+SMBus block operations. Writes can be partial. Block read commands always
+return the number of bytes selected with the largest write so far.
 
 The typical use-case is like this:
 	1. load this module
--- linux-3.16-rc4.orig/drivers/i2c/i2c-stub.c	2014-07-12 09:41:26.508195718 +0200
+++ linux-3.16-rc4/drivers/i2c/i2c-stub.c	2014-07-12 11:19:40.908827183 +0200
@@ -254,13 +254,6 @@ static s32 stub_xfer(struct i2c_adapter
 				ret = -EINVAL;
 				break;
 			}
-			if (b && len > b->len) {
-				dev_dbg(&adap->dev,
-					"Attempt to write more data (%d) than with initial SMBus block write (%d)\n",
-					len, b->len);
-				ret = -EINVAL;
-				break;
-			}
 			if (b == NULL) {
 				b = stub_find_block(&adap->dev, chip, command,
 						    true);
@@ -268,9 +261,10 @@ static s32 stub_xfer(struct i2c_adapter
 					ret = -ENOMEM;
 					break;
 				}
-				/* First write sets block length */
-				b->len = len;
 			}
+			/* Largest write sets read block length */
+			if (len > b->len)
+				b->len = len;
 			for (i = 0; i < len; i++)
 				b->block[i] = data->block[i + 1];
 			/* update for byte and word commands */


-- 
Jean Delvare
SUSE L3 Support
