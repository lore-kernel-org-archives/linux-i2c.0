From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH 1/2] i2c: rk3x: Fix sparse warning
Date: Thu, 22 Sep 2016 19:29:23 +0800
Message-ID: <1474543764-51135-2-git-send-email-david.wu@rock-chips.com>
References: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474543764-51135-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: dianders@chromium.org, huangtao@rock-chips.com, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

This patch fixes the following sparse warning:
drivers/i2c/busses/i2c-rk3x.c:888:17: warning: cast truncates bits from constant value (ffffffffff00 becomes ffffff00)

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index f2d0148..965477e 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -58,7 +58,7 @@ enum {
 #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
 #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
 
-#define REG_CON_TUNING_MASK GENMASK(15, 8)
+#define REG_CON_TUNING_MASK GENMASK_ULL(15, 8)
 
 #define REG_CON_SDA_CFG(cfg) ((cfg) << 8)
 #define REG_CON_STA_CFG(cfg) ((cfg) << 12)
-- 
1.9.1
