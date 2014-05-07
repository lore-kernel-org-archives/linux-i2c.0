From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/5] i2c: wmt: Make of_device_id array const
Date: Wed, 07 May 2014 18:00:13 +0900
Message-ID: <022501cf69d2$c24d53d0$46e7fb70$%han@samsung.com>
References: <022101cf69d1$f1311200$d3933600$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <022101cf69d1$f1311200$d3933600$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Tony Prisk' <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-wmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 2c8a3e4..924b501 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -454,7 +454,7 @@ static int wmt_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id wmt_i2c_dt_ids[] = {
+static const struct of_device_id wmt_i2c_dt_ids[] = {
 	{ .compatible = "wm,wm8505-i2c" },
 	{ /* Sentinel */ },
 };
-- 
1.7.10.4
