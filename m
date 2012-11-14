From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] i2c: mxs: Handle i2c DMA failure properly
Date: Wed, 14 Nov 2012 15:31:48 +0100
Message-ID: <1352903508-18113-1-git-send-email-marex@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Properly terminate the DMA transfer in case the DMA PIO transfer
or setup fails for any reason. While at it, enable support for
SMBUS_QUICK. This essentially fixes i2c-detect on this IP.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 286ca19..6ed53da 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -287,12 +287,14 @@ read_init_dma_fail:
 select_init_dma_fail:
 	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
 select_init_pio_fail:
+	dmaengine_terminate_all(i2c->dmach);
 	return -EINVAL;
 
 /* Write failpath. */
 write_init_dma_fail:
 	dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
 write_init_pio_fail:
+	dmaengine_terminate_all(i2c->dmach);
 	return -EINVAL;
 }
 
@@ -357,7 +359,7 @@ static int mxs_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 
 static u32 mxs_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
-- 
1.7.10.4
