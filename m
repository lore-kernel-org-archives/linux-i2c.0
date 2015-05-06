From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c: xiic: Fix kerneldoc warnings
Date: Wed, 6 May 2015 10:46:23 +0530
Message-ID: <1430889383-18208-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

info(drivers/i2c/busses/i2c-xiic.c:55): Scanning doc for struct xiic_i2c
Warning(drivers/i2c/busses/i2c-xiic.c:79): No description found for parameter 'endianness'

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index e840004..61da433 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -63,6 +63,7 @@ enum xiic_endian {
  * @state:	See STATE_
  * @rx_msg:	Current RX message
  * @rx_pos:	Position within current RX message
+ * @endianness: big/little-endian byte order
  */
 struct xiic_i2c {
 	void __iomem		*base;
-- 
1.7.1
