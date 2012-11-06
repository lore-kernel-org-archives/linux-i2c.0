From: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: s3c2410: Add fix for i2c suspend/resume
Date: Tue, 06 Nov 2012 11:40:59 +0530
Message-ID: <1352182259-28903-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The I2C driver makes a gpio_request during initialization. This request
happens again on resume and fails due to the earlier successful request.
Modify the suspend code to free the earlier requested gpios.

Errors on resume without this:
[   16.020000] s3c-i2c s3c2440-i2c.0: gpio [42] request failed
[   16.020000] s3c-i2c s3c2440-i2c.1: gpio [44] request failed
[   16.020000] s3c-i2c s3c2440-i2c.2: gpio [6] request failed

Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 3e0335f..9bec49e 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -806,6 +806,7 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
 			dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
 			goto free_gpio;
 		}
+		i2c->gpios[idx] = gpio;
 
 		ret = gpio_request(gpio, "i2c-bus");
 		if (ret) {
@@ -1125,6 +1126,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c->suspended = 1;
+	s3c24xx_i2c_dt_gpio_free(i2c);
 
 	return 0;
 }
-- 
1.6.6.1
