From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 08/21] i2c: eg20t: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:17 +0200
Message-ID: <20180514145330.4857-9-peda@axentia.se>
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
pch_i2c_writebytes is always called with a write in msgs->flags,
and pch_i2c_readbytes with a read.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-eg20t.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index bdeab0174fec..835d54ac2971 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -414,7 +414,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		iowrite32(addr_8_lsb, p + PCH_I2CDR);
 	} else {
 		/* set 7 bit slave address and R/W bit as 0 */
-		iowrite32(addr << 1, p + PCH_I2CDR);
+		iowrite32(i2c_8bit_addr_from_msg(msgs), p + PCH_I2CDR);
 		if (first)
 			pch_i2c_start(adap);
 	}
@@ -538,8 +538,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2CDR);
 	} else {
 		/* 7 address bits + R/W bit */
-		addr = (((addr) << 1) | (I2C_RD));
-		iowrite32(addr, p + PCH_I2CDR);
+		iowrite32(i2c_8bit_addr_from_msg(msgs), p + PCH_I2CDR);
 	}
 
 	/* check if it is the first message */
-- 
2.11.0
