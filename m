From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Thu, 15 Mar 2012 18:08:35 +0100
Message-ID: <20120315180835.2e669111@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As the bus driver side implementation of I2C_M_RECV_LEN is heavily
tied to SMBus, we can't support received length over 32 bytes, but
let's at least support that.

In practice, the caller will have to setup a buffer large enough to
cover the case where received length byte has value 32, so minimum
32 + 1 = 33 bytes, possibly more if there is a fixed number of bytes
added for the specific slave (for example a checksum.)

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
---
This is an alternative to Doug's implementation. Doug, I sent this to
you one week ago, did you have the time to give it a try, do you have
any comment? Again I can't test this myself so someone else will have
to do it.

 drivers/i2c/i2c-dev.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- linux-3.3-rc7.orig/drivers/i2c/i2c-dev.c	2012-03-15 18:00:02.502988008 +0100
+++ linux-3.3-rc7/drivers/i2c/i2c-dev.c	2012-03-15 18:04:46.394992216 +0100
@@ -265,19 +265,30 @@ static noinline int i2cdev_ioctl_rdrw(st
 
 	res = 0;
 	for (i = 0; i < rdwr_arg.nmsgs; i++) {
-		/* Limit the size of the message to a sane amount;
-		 * and don't let length change either. */
-		if ((rdwr_pa[i].len > 8192) ||
-		    (rdwr_pa[i].flags & I2C_M_RECV_LEN)) {
+		/* Limit the size of the message to a sane amount */
+		if (rdwr_pa[i].len > 8192) {
 			res = -EINVAL;
 			break;
 		}
+
+		/* Use the same RECV_LEN semantics as SMBus */
+		if (rdwr_pa[i].flags & I2C_M_RECV_LEN) {
+			if (rdwr_pa[i].len < I2C_SMBUS_BLOCK_MAX + 1) {
+				res = -EINVAL;
+				break;
+			}
+		}
+
 		data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
 		rdwr_pa[i].buf = memdup_user(data_ptrs[i], rdwr_pa[i].len);
 		if (IS_ERR(rdwr_pa[i].buf)) {
 			res = PTR_ERR(rdwr_pa[i].buf);
 			break;
 		}
+
+		/* Bus driver will add the value of the first byte received */
+		if (rdwr_pa[i].flags & I2C_M_RECV_LEN)
+			rdwr_pa[i].len -= I2C_SMBUS_BLOCK_MAX;
 	}
 	if (res < 0) {
 		int j;


-- 
Jean Delvare
