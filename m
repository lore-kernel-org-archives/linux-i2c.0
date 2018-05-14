From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 05/21] i2c: axxia: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:14 +0200
Message-ID: <20180514145330.4857-6-peda@axentia.se>
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
 drivers/i2c/busses/i2c-axxia.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 13f07482ec68..f70b097fd567 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -351,13 +351,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 		 *   addr_2: addr[7:0]
 		 */
 		addr_1 = 0xF0 | ((msg->addr >> 7) & 0x06);
+		if (i2c_m_rd(msg))
+			addr_1 |= 1;	/* Set the R/nW bit of the address */
 		addr_2 = msg->addr & 0xFF;
 	} else {
 		/* 7-bit address
 		 *   addr_1: addr[6:0] | (R/nW)
 		 *   addr_2: dont care
 		 */
-		addr_1 = (msg->addr << 1) & 0xFF;
+		addr_1 = i2c_8bit_addr_from_msg(msg);
 		addr_2 = 0;
 	}
 
@@ -365,7 +367,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 		/* I2C read transfer */
 		rx_xfer = i2c_m_recv_len(msg) ? I2C_SMBUS_BLOCK_MAX : msg->len;
 		tx_xfer = 0;
-		addr_1 |= 1;	/* Set the R/nW bit of the address */
 	} else {
 		/* I2C write transfer */
 		rx_xfer = 0;
-- 
2.11.0
