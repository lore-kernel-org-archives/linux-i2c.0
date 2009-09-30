From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-powermac: Reject unsupported I2C transactions
Date: Wed, 30 Sep 2009 22:14:35 +0200
Message-ID: <20090930221435.58636363@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-powermac driver doesn't support arbitrary multi-message I2C
transactions, only SMBus ones. Make it clear by returning an error if
a multi-message I2C transaction is attempted. This is better than only
processing the first message, because most callers won't recover from
the short transaction. Anyone wishing to issue multi-message
transactions should use the SMBus API instead of the raw I2C API.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-powermac.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.32-rc1.orig/drivers/i2c/busses/i2c-powermac.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-rc1/drivers/i2c/busses/i2c-powermac.c	2009-09-30 20:29:42.000000000 +0200
@@ -146,6 +146,12 @@ static int i2c_powermac_master_xfer(	str
 	int			read;
 	int			addrdir;
 
+	if (num != 1) {
+		dev_err(&adap->dev,
+			"Multi-message I2C transactions not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (msgs->flags & I2C_M_TEN)
 		return -EINVAL;
 	read = (msgs->flags & I2C_M_RD) != 0;


-- 
Jean Delvare
