From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 19/21] i2c: riic: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:28 +0200
Message-ID: <20180514145330.4857-20-peda@axentia.se>
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
 drivers/i2c/busses/i2c-riic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 95c2f1ce3cad..5f1fca7880b1 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -167,15 +167,14 @@ static irqreturn_t riic_tdre_isr(int irq, void *data)
 		return IRQ_NONE;
 
 	if (riic->bytes_left == RIIC_INIT_MSG) {
-		val = !!(riic->msg->flags & I2C_M_RD);
-		if (val)
+		if (riic->msg->flags & I2C_M_RD)
 			/* On read, switch over to receive interrupt */
 			riic_clear_set_bit(riic, ICIER_TIE, ICIER_RIE, RIIC_ICIER);
 		else
 			/* On write, initialize length */
 			riic->bytes_left = riic->msg->len;
 
-		val |= (riic->msg->addr << 1);
+		val = i2c_8bit_addr_from_msg(riic->msg);
 	} else {
 		val = *riic->buf;
 		riic->buf++;
-- 
2.11.0
