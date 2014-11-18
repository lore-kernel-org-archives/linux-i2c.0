From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 2/4] i2c: dln2: simplify return flow for dln2_i2c_enable
Date: Tue, 18 Nov 2014 14:57:58 +0200
Message-ID: <1416315480-2053-3-git-send-email-octavian.purdila@intel.com>
References: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: wsa@the-dreams.de, julia.lawall@lip6.fr, dan.carpenter@oracle.com, johan@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-i2c@vger.kernel.org

This fixes the following kbuild test robot warning:

>> drivers/i2c/busses/i2c-dln2.c:70:1-4: WARNING: end returns can be simplified if negative or 0 value

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-dln2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index 010a5fa..b3fb86a 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -54,7 +54,6 @@ struct dln2_i2c {
 
 static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
 {
-	int ret;
 	u16 cmd;
 	struct {
 		u8 port;
@@ -67,11 +66,7 @@ static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
 	else
 		cmd = DLN2_I2C_DISABLE;
 
-	ret = dln2_transfer_tx(dln2->pdev, cmd, &tx, sizeof(tx));
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return dln2_transfer_tx(dln2->pdev, cmd, &tx, sizeof(tx));
 }
 
 static int dln2_i2c_write(struct dln2_i2c *dln2, u8 addr,
-- 
1.9.1
