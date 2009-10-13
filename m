From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 09/16] i2c-designware: i2c_dw_xfer_msg: Fix an i2c_msg
 search bug
Date: Tue, 13 Oct 2009 16:27:25 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D744E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Shinya Kuribayashi
Sent: Monday, October 12, 2009 9:52 PM
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: [PATCH 09/16] i2c-designware: i2c_dw_xfer_msg: Fix an i2c_msg search bug

In case an i2c_msg, which is currently work-in-progress, has more bytes to be written, we need to set STATUS_WRITE_IN_PROGRESS _and_ exit from the msg_write_idx-search loop.  Otherwise, we'll overtake the current index without waiting for transmission completed.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 26efd3a..6bfdc5f 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -386,17 +386,22 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 						dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
+
+		dev->tx_buf_len = buf_len;
+
+		/* more bytes to be written? */
+		if (buf_len > 0) {
+			dev->status |= STATUS_WRITE_IN_PROGRESS;
+			break;
+		} else {
+			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
+		}
 	}
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-	if (buf_len > 0) { /* more bytes to be written */
+	if (buf_len > 0)
 		intr_mask |= DW_IC_INTR_TX_EMPTY;
-		dev->status |= STATUS_WRITE_IN_PROGRESS;
-	} else
-		dev->status &= ~STATUS_WRITE_IN_PROGRESS;
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
-
-	dev->tx_buf_len = buf_len;
 }
 
 static void
--
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
