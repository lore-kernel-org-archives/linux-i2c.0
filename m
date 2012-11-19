From: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: s3c2410: Fix code to free gpios
Date: Mon, 19 Nov 2012 15:48:46 +0530
Message-ID: <1353320326-11626-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Store the requested gpios so that they can be freed on error/removal.

Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index dea4cb2..5d5e9cb 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -856,6 +856,7 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
 			dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
 			goto free_gpio;
 		}
+		i2c->gpios[idx] = gpio;
 
 		ret = gpio_request(gpio, "i2c-bus");
 		if (ret) {
-- 
1.6.6.1
