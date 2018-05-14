From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 13/21] i2c: kempld: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:22 +0200
Message-ID: <20180514145330.4857-14-peda@axentia.se>
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
 drivers/i2c/busses/i2c-kempld.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-kempld.c b/drivers/i2c/busses/i2c-kempld.c
index e879190b5d1d..1c874aaa0447 100644
--- a/drivers/i2c/busses/i2c-kempld.c
+++ b/drivers/i2c/busses/i2c-kempld.c
@@ -124,15 +124,14 @@ static int kempld_i2c_process(struct kempld_i2c_data *i2c)
 		/* 10 bit address? */
 		if (i2c->msg->flags & I2C_M_TEN) {
 			addr = 0xf0 | ((i2c->msg->addr >> 7) & 0x6);
+			/* Set read bit if necessary */
+			addr |= (i2c->msg->flags & I2C_M_RD) ? 1 : 0;
 			i2c->state = STATE_ADDR10;
 		} else {
-			addr = (i2c->msg->addr << 1);
+			addr = i2c_8bit_addr_from_msg(i2c->msg);
 			i2c->state = STATE_START;
 		}
 
-		/* Set read bit if necessary */
-		addr |= (i2c->msg->flags & I2C_M_RD) ? 1 : 0;
-
 		kempld_write8(pld, KEMPLD_I2C_DATA, addr);
 		kempld_write8(pld, KEMPLD_I2C_CMD, I2C_CMD_START);
 
-- 
2.11.0
