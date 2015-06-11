From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] i2c: at91: fix code checker warnings
Date: Thu, 11 Jun 2015 11:16:32 +0200
Message-ID: <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen@atmel.com>
References: <cover.1434013494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1434013494.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

buf_len is a size_t, so unsigned but was tested with '<= 0'.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 0d2dc7d..967c0cb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -232,7 +232,7 @@ static void at91_twi_dma_cleanup(struct at91_twi_dev *dev)
 
 static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 {
-	if (dev->buf_len <= 0)
+	if (!dev->buf_len)
 		return;
 
 	/* 8bit write works with and without FIFO */
@@ -275,7 +275,7 @@ static void at91_twi_write_data_dma(struct at91_twi_dev *dev)
 	struct dma_chan *chan_tx = dma->chan_tx;
 	unsigned int sg_len = 1;
 
-	if (dev->buf_len <= 0)
+	if (!dev->buf_len)
 		return;
 
 	dma->direction = DMA_TO_DEVICE;
@@ -347,7 +347,7 @@ error:
 
 static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 {
-	if (dev->buf_len <= 0)
+	if (!dev->buf_len)
 		return;
 
 	/* 8bit read works with and without FIFO */
-- 
1.8.2.2
