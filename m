From: Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c-nomadik: Fixup clock handling
Date: Thu, 20 Sep 2012 17:20:47 +0200
Message-ID: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Make sure to clk_prepare as well as clk_enable.

Signed-off-by: Philippe Begnic <philippe.begnic-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 1b898b6..3eeae52 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -642,7 +642,11 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	pm_runtime_get_sync(&dev->adev->dev);
 
-	clk_enable(dev->clk);
+	status = clk_prepare_enable(dev->clk);
+	if (status) {
+		dev_err(&dev->adev->dev, "can't prepare_enable clock\n");
+		goto out_clk;
+	}
 
 	status = init_hw(dev);
 	if (status)
@@ -669,7 +673,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 
 out:
-	clk_disable(dev->clk);
+	clk_disable_unprepare(dev->clk);
+out_clk:
 	pm_runtime_put_sync(&dev->adev->dev);
 
 	dev->busy = false;
-- 
1.7.10
