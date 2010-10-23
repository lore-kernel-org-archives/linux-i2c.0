From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-viapro: Don't log nacks
Date: Sat, 23 Oct 2010 18:44:48 +0200
Message-ID: <20101023184448.047ab721@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-viapro: Don't log nacks

Transactions not acked can happen every now and then, in particular
during device detection, and various transaction types can be used for
this purpose. So stop logging this event, except when debugging is
enabled. This is what other similar drivers (e.g. i2c-i801 or
i2c-piix4) do.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-viapro.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.37-rc0.orig/drivers/i2c/busses/i2c-viapro.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.37-rc0/drivers/i2c/busses/i2c-viapro.c	2010-10-23 18:31:02.000000000 +0200
@@ -185,14 +185,8 @@ static int vt596_transaction(u8 size)
 	}
 
 	if (temp & 0x04) {
-		int read = inb_p(SMBHSTADD) & 0x01;
 		result = -ENXIO;
-		/* The quick and receive byte commands are used to probe
-		   for chips, so errors are expected, and we don't want
-		   to frighten the user. */
-		if (!((size == VT596_QUICK && !read) ||
-		      (size == VT596_BYTE && read)))
-			dev_err(&vt596_adapter.dev, "Transaction error!\n");
+		dev_dbg(&vt596_adapter.dev, "No response\n");
 	}
 
 	/* Resetting status register */


-- 
Jean Delvare
