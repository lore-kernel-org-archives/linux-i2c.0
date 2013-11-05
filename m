From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] i2c: exynos5: Use reinit_completion instead of INIT_COMPLETION
Date: Tue,  5 Nov 2013 14:57:10 +0530
Message-ID: <1383643630-5036-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

INIT_COMPLETION was replaced by reinit_completion vide commit 2c9627cca471
("tree-wide: use reinit_completion instead of INIT_COMPLETION"). Use it to
avoid the following build error:
drivers/i2c/busses/i2c-exynos5.c:538:9: error:
undefined identifier 'INIT_COMPLETION'

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-exynos5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index aca3991b7636..d4193000643d 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -535,7 +535,7 @@ static int exynos5_i2c_xfer_msg(struct exynos5_i2c *i2c,
 	i2c->msg_ptr = 0;
 	i2c->trans_done = 0;
 
-	INIT_COMPLETION(i2c->msg_complete);
+	reinit_completion(&i2c->msg_complete);
 
 	exynos5_i2c_message_start(i2c, stop);
 
-- 
1.7.9.5
