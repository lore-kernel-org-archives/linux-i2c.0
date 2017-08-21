From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] i2c: versatile: Make i2c_algo_bit_data const
Date: Mon, 21 Aug 2017 18:58:37 +0530
Message-ID: <1503322117-25860-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/i2c/busses/i2c-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index c73d2d2..f1ab2a6 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -55,7 +55,7 @@ static int i2c_versatile_getscl(void *data)
 	return !!(readl(i2c->base + I2C_CONTROL) & SCL);
 }
 
-static struct i2c_algo_bit_data i2c_versatile_algo = {
+static const struct i2c_algo_bit_data i2c_versatile_algo = {
 	.setsda	= i2c_versatile_setsda,
 	.setscl = i2c_versatile_setscl,
 	.getsda	= i2c_versatile_getsda,
-- 
1.9.1
