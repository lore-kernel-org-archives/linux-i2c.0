From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] i2c: mux: Remove unneeded platform_set_drvdata to NULL in remove
Date: Fri, 15 Feb 2013 10:41:22 -0800
Message-ID: <1360953682-25066-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Doug Anderson <dianders@chromium.org>, Peter Korsgaard <peter.korsgaard@barco.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Stephen Warren pointed out as part of a code review of another mux
driver that there should be no need to have
"platform_set_drvdata(pdev, NULL)" in the remove function.  Get rid of
it in the i2c-mux-gpio driver.

See Stephen's comment at:
  http://www.gossamer-threads.com/lists/linux/kernel/1678627?do=post_view_threaded#1678627

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 9f50ef0..abc2e55a 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -250,7 +250,6 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
 	for (i = 0; i < mux->data.n_gpios; i++)
 		gpio_free(mux->gpio_base + mux->data.gpios[i]);
 
-	platform_set_drvdata(pdev, NULL);
 	i2c_put_adapter(mux->parent);
 
 	return 0;
-- 
1.8.1
