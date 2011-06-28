From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/2] i2c-nomadik: Do not use _interruptible_ variant call
Date: Tue, 28 Jun 2011 10:37:58 +0200
Message-ID: <1309250278-19223-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

If there is a signal pending and wait_for_completion_interruptible_timeout
exited because of the -ERESTARTSYS error we are unable to send any more
i2c messages.

So, deprecate this _interruptible_ variant call.

Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 0c731ca..f9b8854 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -417,12 +417,12 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 	writel(readl(dev->virtbase + I2C_IMSCR) | irq_mask,
 			dev->virtbase + I2C_IMSCR);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	timeout = wait_for_completion_timeout(
 		&dev->xfer_complete, dev->adap.timeout);
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
-			"wait_for_completion_interruptible_timeout"
+			"wait_for_completion_timeout"
 			"returned %d waiting for event\n", timeout);
 		status = timeout;
 	}
@@ -504,12 +504,12 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 	writel(readl(dev->virtbase + I2C_IMSCR) | irq_mask,
 			dev->virtbase + I2C_IMSCR);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	timeout = wait_for_completion_timeout(
 		&dev->xfer_complete, dev->adap.timeout);
 
 	if (timeout < 0) {
 		dev_err(&dev->pdev->dev,
-			"wait_for_completion_interruptible_timeout"
+			"wait_for_completion_timeout"
 			"returned %d waiting for event\n", timeout);
 		status = timeout;
 	}
-- 
1.7.3.2
