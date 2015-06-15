From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/9] i2c: xiic: Remove busy loop while waiting for bus busy
Date: Mon, 15 Jun 2015 20:47:57 +0530
Message-ID: <1434381480-3042-6-git-send-email-shubhraj@xilinx.com>
References: <1434381480-3042-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434381480-3042-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Remove the busy loop  while waiting for bus busy.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 7b81aac..8142c2e 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -526,7 +526,7 @@ static int xiic_busy(struct xiic_i2c *i2c)
 	 */
 	err = xiic_bus_busy(i2c);
 	while (err && tries--) {
-		mdelay(1);
+		msleep(1);
 		err = xiic_bus_busy(i2c);
 	}
 
-- 
1.7.1
