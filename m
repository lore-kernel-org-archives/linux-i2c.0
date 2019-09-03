From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 152/167] i2c: at91: disable TXRDY interrupt after sending data
Date: Tue,  3 Sep 2019 12:25:04 -0400
Message-ID: <20190903162519.7136-152-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Ludovic Desroches <ludovic.desroches@microchip.com>, Raag Jadav <raagjadav@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit d12e3aae160fb26b534c4496b211d6e60a5179ed ]

Driver was not disabling TXRDY interrupt after last TX byte.
This caused interrupt storm until transfer timeouts for slow
or broken device on the bus. The patch fixes the interrupt storm
on my SAMA5D2-based board.

Cc: stable@vger.kernel.org # 5.2.x
[v5.2 introduced file split; the patch should apply to i2c-at91.c before the split]
Fixes: fac368a04048 ("i2c: at91: add new driver")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Tested-by: Raag Jadav <raagjadav@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-at91.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3bf5ff9..0998a388d2ed5 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -270,9 +270,11 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 	writeb_relaxed(*dev->buf, dev->base + AT91_TWI_THR);
 
 	/* send stop when last byte has been written */
-	if (--dev->buf_len == 0)
+	if (--dev->buf_len == 0) {
 		if (!dev->use_alt_cmd)
 			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+		at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_TXRDY);
+	}
 
 	dev_dbg(dev->dev, "wrote 0x%x, to go %zu\n", *dev->buf, dev->buf_len);
 
@@ -690,9 +692,8 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		} else {
 			at91_twi_write_next_byte(dev);
 			at91_twi_write(dev, AT91_TWI_IER,
-				       AT91_TWI_TXCOMP |
-				       AT91_TWI_NACK |
-				       AT91_TWI_TXRDY);
+				       AT91_TWI_TXCOMP | AT91_TWI_NACK |
+				       (dev->buf_len ? AT91_TWI_TXRDY : 0));
 		}
 	}
 
-- 
2.20.1
