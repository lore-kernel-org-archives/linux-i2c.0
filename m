From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 01/21] i2c: algo: bit: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:10 +0200
Message-ID: <20180514145330.4857-2-peda@axentia.se>
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
 drivers/i2c/algos/i2c-algo-bit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 3df0efd69ae3..4a34f311e1ff 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -519,9 +519,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 			}
 		}
 	} else {		/* normal 7bit address	*/
-		addr = msg->addr << 1;
-		if (flags & I2C_M_RD)
-			addr |= 1;
+		addr = i2c_8bit_addr_from_msg(msg);
 		if (flags & I2C_M_REV_DIR_ADDR)
 			addr ^= 1;
 		ret = try_address(i2c_adap, addr, retries);
-- 
2.11.0
