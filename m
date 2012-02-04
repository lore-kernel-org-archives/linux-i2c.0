From: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c-dev: relax ban on I2C_M_RECV_LEN
Date: Sat, 04 Feb 2012 16:42:29 -0500
Message-ID: <4F2DA645.3080604@interlog.com>
Reply-To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020501000409030509000807"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------020501000409030509000807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The I2C_M_RECV_LEN flag indicates that the length of
an I2C response is in the first byte read. So the maximum
size of the read buffer using this option is 256 bytes.

Currently the i2c-dev driver returns EINVAL when an
attempt is made to use ioctl(I2C_RDWR) with the
I2C_M_RECV_LEN flag set. That is overly paranoid:

ChangeLog:
   - allow I2C_M_RECV_LEN flag in the i2c-dev driver as
     long as the associated buffer length can cope with
     the worst case size (which is 256 bytes).

Doug Gilbert
[Please cc responses to me]

--------------020501000409030509000807
Content-Type: text/x-patch;
 name="i2c-dev_mrecv_len1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-dev_mrecv_len1.patch"

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 57a45ce8..b8f226a0 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -270,9 +270,10 @@ static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
 	res = 0;
 	for (i = 0; i < rdwr_arg.nmsgs; i++) {
 		/* Limit the size of the message to a sane amount;
-		 * and don't let length change either. */
+		 * with I2C_M_RECV_LEN require worst case len. */
 		if ((rdwr_pa[i].len > 8192) ||
-		    (rdwr_pa[i].flags & I2C_M_RECV_LEN)) {
+		    ((rdwr_pa[i].flags & I2C_M_RECV_LEN) &&
+		     (rdwr_pa[i].len < 256))) {
 			res = -EINVAL;
 			break;
 		}

--------------020501000409030509000807--
