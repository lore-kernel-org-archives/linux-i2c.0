From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/4] i2c: sh_mobile: use helper to decide if DMA is used
Date: Tue,  6 Jun 2017 11:20:33 +0200
Message-ID: <20170606092034.1516-4-wsa+renesas@sang-engineering.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

This ensures also that we fall back to PIO if the buffer is not DMA
capable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 3d75593487454c..58e2ae3b4c4751 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -666,7 +666,7 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
 	pd->pos = -1;
 	pd->sr = 0;
 
-	if (pd->msg->len > 8)
+	if (i2c_check_msg_for_dma(pd->msg, 8) == 0)
 		sh_mobile_i2c_xfer_dma(pd);
 
 	/* Enable all interrupts to begin with */
-- 
2.11.0
