From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 9/9] i2c: xiic: Do not continue in case of errors in Rx
Date: Wed, 17 Jun 2015 20:48:19 +0530
Message-ID: <1434554299-23443-10-git-send-email-shubhraj@xilinx.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434554299-23443-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In case of error conditions like Arbitration lost or NACK lets signal
the waiting process.

Handle error cases in the Rx path

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 182ea68..c071897 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -399,6 +399,8 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		 */
 		xiic_reinit(i2c);
 
+		if (i2c->rx_msg)
+			xiic_wakeup(i2c, STATE_ERROR);
 		if (i2c->tx_msg)
 			xiic_wakeup(i2c, STATE_ERROR);
 	}
-- 
1.7.1
