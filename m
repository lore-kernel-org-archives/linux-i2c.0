From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH] i2c-eg20t: Do not print error message if no ACK is received
Date: Tue, 28 Jun 2011 11:43:39 +0200
Message-ID: <1309254219-18875-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Doing so would spam the kernel log for each i2cdetect run and
device probe.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 8abfa4a..97110f7 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -345,7 +345,7 @@ static s32 pch_i2c_getack(struct i2c_algo_pch_data *adap)
 	reg_val = ioread32(p + PCH_I2CSR) & PCH_GETACK;
 
 	if (reg_val != 0) {
-		pch_err(adap, "return%d\n", -EPROTO);
+		pch_dbg(adap, "return%d\n", -EPROTO);
 		return -EPROTO;
 	}
 
-- 
1.7.3.4
