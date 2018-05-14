From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 02/21] i2c: algo: pca: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:11 +0200
Message-ID: <20180514145330.4857-3-peda@axentia.se>
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
 drivers/i2c/algos/i2c-algo-pca.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index e370804ec8bc..883a290f6a4d 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -112,11 +112,8 @@ static int pca_address(struct i2c_algo_pca_data *adap,
 		       struct i2c_msg *msg)
 {
 	int sta = pca_get_con(adap);
-	int addr;
+	int addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = ((0x7f & msg->addr) << 1);
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
 	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n",
 	     msg->addr, msg->flags & I2C_M_RD ? 'R' : 'W', addr);
 
-- 
2.11.0
