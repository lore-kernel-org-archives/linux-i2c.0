From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 21/21] i2c: xiic: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:30 +0200
Message-ID: <20180514145330.4857-22-peda@axentia.se>
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
 drivers/i2c/busses/i2c-xiic.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c80527816ad0..1818c3b5c8d7 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -143,12 +143,6 @@ struct xiic_i2c {
 
 #define XIIC_TX_RX_INTERRUPTS (XIIC_INTR_RX_FULL_MASK | XIIC_TX_INTERRUPTS)
 
-/* The following constants are used with the following macros to specify the
- * operation, a read or write operation.
- */
-#define XIIC_READ_OPERATION  1
-#define XIIC_WRITE_OPERATION 0
-
 /*
  * Tx Fifo upper bit masks.
  */
@@ -556,8 +550,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
-			(msg->addr << 1) | XIIC_READ_OPERATION |
-			XIIC_TX_DYN_START_MASK);
+			i2c_8bit_addr_from_msg(msg) | XIIC_TX_DYN_START_MASK);
 
 	xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
 
@@ -585,7 +578,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 
 	if (!(msg->flags & I2C_M_NOSTART)) {
 		/* write the address */
-		u16 data = ((msg->addr << 1) & 0xfe) | XIIC_WRITE_OPERATION |
+		u16 data = i2c_8bit_addr_from_msg(msg) |
 			XIIC_TX_DYN_START_MASK;
 		if ((i2c->nmsgs == 1) && msg->len == 0)
 			/* no data and last message -> add STOP */
-- 
2.11.0
