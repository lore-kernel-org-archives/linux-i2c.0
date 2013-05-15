From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Document feature bits in modinfo
Date: Wed, 15 May 2013 14:44:10 +0200
Message-ID: <20130515144410.161c9065@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Robert Norris <robn-4vTceeIZeJ0AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Duplicate the feature bits documentation in modinfo, as not every user
will read the driver's source code or documentation file.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-3.10-rc1.orig/drivers/i2c/busses/i2c-i801.c	2013-04-29 02:36:01.000000000 +0200
+++ linux-3.10-rc1/drivers/i2c/busses/i2c-i801.c	2013-05-15 12:42:11.573297161 +0200
@@ -231,7 +231,11 @@ static const char *i801_feature_names[]
 
 static unsigned int disable_features;
 module_param(disable_features, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(disable_features, "Disable selected driver features");
+MODULE_PARM_DESC(disable_features, "Disable selected driver features:\n"
+	"\t\t  0x01  disable SMBus PEC\n"
+	"\t\t  0x02  disable the block buffer\n"
+	"\t\t  0x08  disable the I2C block read functionality\n"
+	"\t\t  0x10  don't use interrupts ");
 
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */


-- 
Jean Delvare
