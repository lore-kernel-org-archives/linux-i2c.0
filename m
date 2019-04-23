From: Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH] i2c: at91: handle TXRDY interrupt spam
Date: Tue, 23 Apr 2019 13:06:48 +0530
Message-ID: <1556005008-6318-1-git-send-email-raagjadav@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: ludovic.desroches@microchip.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Raag Jadav <raagjadav@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Performing i2c write operation while SDA or SCL line is held
or grounded by slave device, we go into infinite at91_twi_write_next_byte
loop with TXRDY interrupt spam.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/i2c/busses/i2c-at91.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3..b2f5fdb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -72,6 +72,7 @@
 #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
 #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
 #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
 #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
 #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
@@ -571,7 +572,10 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 		at91_disable_twi_interrupts(dev);
 		complete(&dev->cmd_complete);
 	} else if (irqstatus & AT91_TWI_TXRDY) {
-		at91_twi_write_next_byte(dev);
+		if ((status & AT91_TWI_SVREAD) && (dev->buf_len == 0))
+			at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_TXRDY);
+		else
+			at91_twi_write_next_byte(dev);
 	}
 
 	/* catch error flags */
-- 
2.7.4
