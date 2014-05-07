From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/5] i2c: riic: Make of_device_id array const
Date: Wed, 07 May 2014 17:58:05 +0900
Message-ID: <022301cf69d2$75fc4770$61f4d650$%han@samsung.com>
References: <022101cf69d1$f1311200$d3933600$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <022101cf69d1$f1311200$d3933600$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-riic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 9e1f8ba..af3b3d0 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -404,7 +404,7 @@ static int riic_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id riic_i2c_dt_ids[] = {
+static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz" },
 	{ /* Sentinel */ },
 };
-- 
1.7.10.4
