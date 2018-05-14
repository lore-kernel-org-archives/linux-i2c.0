From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 11/21] i2c: imx-lpi2c: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:20 +0200
Message-ID: <20180514145330.4857-12-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6da2c7a9a3e..159d23211600 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -180,15 +180,13 @@ static int lpi2c_imx_start(struct lpi2c_imx_struct *lpi2c_imx,
 			   struct i2c_msg *msgs)
 {
 	unsigned int temp;
-	u8 read;
 
 	temp = readl(lpi2c_imx->base + LPI2C_MCR);
 	temp |= MCR_RRF | MCR_RTF;
 	writel(temp, lpi2c_imx->base + LPI2C_MCR);
 	writel(0x7f00, lpi2c_imx->base + LPI2C_MSR);
 
-	read = msgs->flags & I2C_M_RD;
-	temp = (msgs->addr << 1 | read) | (GEN_START << 8);
+	temp = i2c_8bit_addr_from_msg(msgs) | (GEN_START << 8);
 	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
 
 	return lpi2c_imx_bus_busy(lpi2c_imx);
-- 
2.11.0
