From: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] i2c: sun6i-p2wi: Remove duplicate inclusion of module.h
Date: Tue, 24 Jun 2014 09:25:28 +0530
Message-ID: <1403582128-32562-1-git-send-email-sachin.kamat@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

module.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Changes since v1:
* Retained the alphabetical order of header files
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 09de4fd12d57..4d75d4759709 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -22,7 +22,6 @@
  *
  */
 #include <linux/clk.h>
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
-- 
1.7.9.5
