From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 2/8] i2c: img-scb: do dummy writes before fifo access
Date: Mon, 27 Jul 2015 12:47:15 +0100
Message-ID: <1437997641-32575-3-git-send-email-sifan.naeem@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Move scb_wr_rd_fence to before reading from fifo and writing to
fifo to make sure the the first read/write is done after the required
number of cycles.

Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Acked-by: James Hogan <james.hogan@imgtec.com>
Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 5c3c615..0368d91 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -534,6 +534,7 @@ static void img_i2c_read_fifo(struct img_i2c *i2c)
 		u32 fifo_status;
 		u8 data;
 
+		img_i2c_wr_rd_fence(i2c);
 		fifo_status = img_i2c_readl(i2c, SCB_FIFO_STATUS_REG);
 		if (fifo_status & FIFO_READ_EMPTY)
 			break;
@@ -542,7 +543,6 @@ static void img_i2c_read_fifo(struct img_i2c *i2c)
 		*i2c->msg.buf = data;
 
 		img_i2c_writel(i2c, SCB_READ_FIFO_REG, 0xff);
-		img_i2c_wr_rd_fence(i2c);
 		i2c->msg.len--;
 		i2c->msg.buf++;
 	}
@@ -554,12 +554,12 @@ static void img_i2c_write_fifo(struct img_i2c *i2c)
 	while (i2c->msg.len) {
 		u32 fifo_status;
 
+		img_i2c_wr_rd_fence(i2c);
 		fifo_status = img_i2c_readl(i2c, SCB_FIFO_STATUS_REG);
 		if (fifo_status & FIFO_WRITE_FULL)
 			break;
 
 		img_i2c_writel(i2c, SCB_WRITE_DATA_REG, *i2c->msg.buf);
-		img_i2c_wr_rd_fence(i2c);
 		i2c->msg.len--;
 		i2c->msg.buf++;
 	}
-- 
1.7.9.5
