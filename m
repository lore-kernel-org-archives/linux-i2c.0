From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/5] i2c: st: Make of_device_id array const
Date: Wed, 07 May 2014 18:01:29 +0900
Message-ID: <022601cf69d2$ef8ba9f0$cea2fdd0$%han@samsung.com>
References: <022101cf69d1$f1311200$d3933600$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <022101cf69d1$f1311200$d3933600$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Maxime COQUELIN' <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-st.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 8720161..95b94767 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -847,7 +847,7 @@ static int st_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id st_i2c_match[] = {
+static const struct of_device_id st_i2c_match[] = {
 	{ .compatible = "st,comms-ssc-i2c", },
 	{ .compatible = "st,comms-ssc4-i2c", },
 	{},
-- 
1.7.10.4
