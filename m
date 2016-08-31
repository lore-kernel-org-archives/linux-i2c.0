From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] i2c: Spelling s/acknowedge/acknowledge/
Date: Wed, 31 Aug 2016 11:38:48 +0200
Message-ID: <1472636328-27229-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jiri Kosina <trivial@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/i2c-cadence.c | 2 +-
 drivers/i2c/busses/i2c-rk3x.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 1cc1e79e958d56ea..686971263bef19a2 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -767,7 +767,7 @@ static int cdns_i2c_setclk(unsigned long clk_in, struct cdns_i2c *id)
  * depending on the scaling direction.
  *
  * Return:	NOTIFY_STOP if the rate change should be aborted, NOTIFY_OK
- *		to acknowedge the change, NOTIFY_DONE if the notification is
+ *		to acknowledge the change, NOTIFY_DONE if the notification is
  *		considered irrelevant.
  */
 static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 3b87afe82f639492..f4562467325a23af 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -918,7 +918,7 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
  * Code adapted from i2c-cadence.c.
  *
  * Return:	NOTIFY_STOP if the rate change should be aborted, NOTIFY_OK
- *		to acknowedge the change, NOTIFY_DONE if the notification is
+ *		to acknowledge the change, NOTIFY_DONE if the notification is
  *		considered irrelevant.
  */
 static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
-- 
1.9.1
