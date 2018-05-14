From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 03/21] i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:12 +0200
Message-ID: <20180514145330.4857-4-peda@axentia.se>
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
 drivers/i2c/algos/i2c-algo-pcf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 270d84bfc2c6..bb60c1bd1f2d 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -292,11 +292,8 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
 	unsigned short flags = msg->flags;
-	unsigned char addr;
+	unsigned char addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = msg->addr << 1;
-	if (flags & I2C_M_RD)
-		addr |= 1;
 	if (flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
-- 
2.11.0
