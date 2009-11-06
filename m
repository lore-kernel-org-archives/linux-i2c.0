From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 11/22] i2c-designware: Enable RX_FULL interrupt
Date: Fri, 06 Nov 2009 21:48:33 +0900
Message-ID: <4AF41B21.8010900@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Enable RX_FULL interrupt mask by default, and hook it in the interrupt
handler.  If requested amount of rx data (defined by IC_RX_TL) is not
available, we don't have to process i2c_dw_read().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 0eea0dd..940bbf3 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -342,7 +342,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
+	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT | DW_IC_INTR_RX_FULL;
 
 	if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 		/* Disable the adapter */
@@ -593,10 +593,11 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		dev->status = STATUS_IDLE;
 	}
 
-	if (stat & DW_IC_INTR_TX_EMPTY) {
+	if (stat & DW_IC_INTR_RX_FULL)
 		i2c_dw_read(dev);
+
+	if (stat & DW_IC_INTR_TX_EMPTY)
 		i2c_dw_xfer_msg(dev);
-	}
 
 	/*
 	 * No need to modify or disable the interrupt mask here.
-- 
1.6.5.2
