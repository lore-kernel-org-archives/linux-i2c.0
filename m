From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: [PATCH 1/2] i2c-mxs: debug error message: second SELECT -> READ
Date: Mon, 08 Sep 2014 20:04:22 +0200
Message-ID: <540DEFA6.9030600@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
---
  linux-3.14.17/drivers/i2c/busses/i2c-mxs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c 
b/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
index 0cde4e6..87ee72d 100644
--- a/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
+++ b/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
@@ -429,7 +429,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter 
*adap,
                 ret = mxs_i2c_pio_wait_xfer_end(i2c);
                 if (ret) {
                         dev_err(i2c->dev,
-                               "PIO: Failed to send SELECT command!\n");
+                               "PIO: Failed to send READ command!\n");
                         goto cleanup;
                 }

--
1.7.11.3
