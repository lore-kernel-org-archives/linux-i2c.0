From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH] i2c-au1550: increase timeout waiting for transactions to finish
Date: Sun, 12 Jun 2011 14:31:27 +0200
Message-ID: <1307881887-12676-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wait a bit longer for the I2C master transaction to finish.
With this change the WM8731 codec on the DB1300 board is now
reliably initialized.

Tested on Db1200 and Db1300.

Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/i2c/busses/i2c-au1550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 532828b..e4ece23 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -106,7 +106,7 @@ wait_master_done(struct i2c_au1550_data *adap)
 		au_sync();
 		if ((stat & PSC_SMBEVNT_MD) != 0)
 			return 0;
-		udelay(1);
+		udelay(2);
 	}
 
 	return -ETIMEDOUT;
-- 
1.7.5.3
