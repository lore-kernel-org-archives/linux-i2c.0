From: Andreas Werner <wernerandy-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH v2] I2C: busses: i2c-eg20t Do not print error message in syslog if no ACK received
Date: Sun, 17 Nov 2013 09:58:51 +0100
Message-ID: <1384678731-10399-1-git-send-email-wernerandy@gmx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wernerandy-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Revision 2:
	- delete the pch_err completly instead of changing to pch_dbg
	  because there is already a pch_dbg at the function who calls
	  pch_i2c_getack.
	- Fixed message line issue

Using the i2c-eg20t driver and call i2cdetect or probe on the bus,
the driver will print a lot of error messages if there was no ACK
received.

i2cdetect normally print a table with all the available devices. If there
is no device on the address, the table will be empty.
Currently with the i2c-eg20t driver, the table is not visible because
the error messages destroy the table.

Error message: pch_i2c_getack return -71

This patch prevent the driver to print the messages to syslog.
The pch_i2c_wait_for_check_xfer function is the only one who is
calling pch_i2c_getack, and there is already a dbg print if it fails,
so we can delete the pch_err in pch_i2c_getack completly.

Fixed print message to be a one liner so we can grep for the
error message.

Tested on Intel Atom E6xx and Eg20t Chipset.

Signed-off-by: Andreas Werner <wernerandy-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 0f37529..5c39f90 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -321,10 +321,8 @@ static s32 pch_i2c_getack(struct i2c_algo_pch_data *adap)
 	void __iomem *p = adap->pch_base_address;
 	reg_val = ioread32(p + PCH_I2CSR) & PCH_GETACK;
 
-	if (reg_val != 0) {
-		pch_err(adap, "return%d\n", -EPROTO);
+	if (reg_val != 0)
 		return -EPROTO;
-	}
 
 	return 0;
 }
@@ -367,8 +365,7 @@ static int pch_i2c_wait_for_check_xfer(struct i2c_algo_pch_data *adap)
 	adap->pch_event_flag = 0;
 
 	if (pch_i2c_getack(adap)) {
-		pch_dbg(adap, "Receive NACK for slave address"
-			"setting\n");
+		pch_dbg(adap, "Receive NACK for slave address setting\n");
 		return -EIO;
 	}
 
-- 
1.8.4
