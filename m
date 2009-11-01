From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Retry on lost arbitration
Date: Sun, 1 Nov 2009 13:25:46 +0100
Message-ID: <20091101132546.21ee43c2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Intel 82801 is sometimes used on systems with a BMC connected. The
BMC can access the SMBus, resulting in lost arbitration for the 82801.
We should let i2c-core retry transactions for us in this case.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.32-rc5.orig/drivers/i2c/busses/i2c-i801.c	2009-10-05 10:45:49.000000000 +0200
+++ linux-2.6.32-rc5/drivers/i2c/busses/i2c-i801.c	2009-11-01 11:33:29.000000000 +0100
@@ -767,6 +767,9 @@ static int __devinit i801_probe(struct p
 	/* set up the sysfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
 
+	/* Retry up to 3 times on arbitration loss */
+	i801_adapter.retries = 3;
+
 	snprintf(i801_adapter.name, sizeof(i801_adapter.name),
 		"SMBus I801 adapter at %04lx", i801_smba);
 	err = i2c_add_adapter(&i801_adapter);


-- 
Jean Delvare
