From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 18/22] i2c-designware: Disable TX_EMPTY when all i2c_msg
 msgs has been processed
Date: Fri, 06 Nov 2009 21:51:00 +0900
Message-ID: <4AF41BB4.1050407@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Currently we disable TX_EMPTY interrupt when buf_len is zero, but this
is wrong.  (buf_len == 0) means that all transmit data in the current
i2c_msg message has been sent out, but that doesn't necessarily mean
all i2c_msg messages have been processed.

TX_EMPTY interrupt is used as the driving force of DW I2C transactions,
so we need to keep it enabled as long as i2c_msg messages are available.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index f184d82..6acbe84 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -415,12 +415,17 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			/* more bytes to be written */
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
 			break;
-		} else {
+		} else
 			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
-			intr_mask &= ~DW_IC_INTR_TX_EMPTY;
-		}
 	}
 
+	/*
+	 * If i2c_msg index search is completed, we don't need TX_EMPTY
+	 * interrupt any more.
+	 */
+	if (dev->msg_write_idx == dev->msgs_num)
+		intr_mask &= ~DW_IC_INTR_TX_EMPTY;
+
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
 }
 
-- 
1.6.5.2
