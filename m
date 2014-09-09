From: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: [PATCH] i2c-mxs: fixed error message in pio transfer
Date: Tue,  9 Sep 2014 18:19:30 +0200
Message-ID: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marex-ynQEQJNshbs@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If I2C_M_RD flag is set SELECT command is sent
and afterward READ command.
The patch fixes READ command to return READ failure error message
instead of SELECT failure error message.

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 0cde4e6..87ee72d 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -429,7 +429,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		ret = mxs_i2c_pio_wait_xfer_end(i2c);
 		if (ret) {
 			dev_err(i2c->dev,
-				"PIO: Failed to send SELECT command!\n");
+				"PIO: Failed to send READ command!\n");
 			goto cleanup;
 		}
 
-- 
1.7.11.3
