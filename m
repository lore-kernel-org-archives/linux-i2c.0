From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 2/7] i2c: img-scb: do dummy writes before fifo access
Date: Thu, 10 Sep 2015 15:50:02 +0100
Message-ID: <1441896607-16310-3-git-send-email-sifan.naeem@imgtec.com>
References: <1441896607-16310-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441896607-16310-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move scb_wr_rd_fence to before reading from fifo and writing to
fifo to make sure the the first read/write is done after the required
number of cycles.

Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 5c3c61586d4a..0368d91b6805 100644
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
