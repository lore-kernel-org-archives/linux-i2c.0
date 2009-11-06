From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 08/22] i2c-designware: i2c_dw_xfer_msg: Fix i2c_msg search
 bug
Date: Fri, 06 Nov 2009 21:47:30 +0900
Message-ID: <4AF41AE2.5010807@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

In case a work-in-progress i2c_msg has more bytes to be written, we
need to set STATUS_WRITE_IN_PROGRESS and exit from the msg_write_idx-
searching loop.  Otherwise, we will overtake the current msg_write_idx
without waiting for its transmission to be processed.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---

v2: The intr_mask handling, which stayed outside for-loop in the
    previous submission, is now folded into the for-loop.

 drivers/i2c/busses/i2c-designware.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index cdfd94e..bfb42f0 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -338,6 +338,8 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 
+	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
+
 	if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 		/* Disable the adapter */
 		writel(0, dev->base + DW_IC_ENABLE);
@@ -387,17 +389,19 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 						dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
+
+		dev->tx_buf_len = buf_len;
+
+		if (buf_len > 0) {
+			/* more bytes to be written */
+			intr_mask |= DW_IC_INTR_TX_EMPTY;
+			dev->status |= STATUS_WRITE_IN_PROGRESS;
+			break;
+		} else
+			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
 	}
 
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-	if (buf_len > 0) { /* more bytes to be written */
-		intr_mask |= DW_IC_INTR_TX_EMPTY;
-		dev->status |= STATUS_WRITE_IN_PROGRESS;
-	} else
-		dev->status &= ~STATUS_WRITE_IN_PROGRESS;
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
-
-	dev->tx_buf_len = buf_len;
 }
 
 static void
-- 
1.6.5.2
