From: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c-nomadik: Do not use _interruptible_ variant call
Date: Tue, 24 May 2011 10:49:47 +0530
Message-ID: <1306214387-15997-1-git-send-email-srinidhi.kasagar@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If there is a signal pending and wait_for_completion_interruptible_timeout
exited because of the -ERESTARTSYS error we are unable to send any more
i2c messages.

So, deprecate this _interruptible_ variant call.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index e10e5cf..5b7753e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -423,12 +423,12 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 	writel(readl(dev->virtbase + I2C_IMSCR) | irq_mask,
 			dev->virtbase + I2C_IMSCR);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	timeout = wait_for_completion_timeout(
 		&dev->xfer_complete, msecs_to_jiffies(I2C_TIMEOUT_MS));
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
-			"wait_for_completion_interruptible_timeout"
+			"wait_for_completion_timeout "
 			"returned %d waiting for event\n", timeout);
 		status = timeout;
 	}
@@ -487,12 +487,12 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 	writel(readl(dev->virtbase + I2C_IMSCR) | irq_mask,
 			dev->virtbase + I2C_IMSCR);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	timeout = wait_for_completion_timeout(
 		&dev->xfer_complete, msecs_to_jiffies(I2C_TIMEOUT_MS));
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
-			"wait_for_completion_interruptible_timeout"
+			"wait_for_completion_timeout "
 			"returned %d waiting for event\n", timeout);
 		status = timeout;
 	}
-- 
1.7.4.3
