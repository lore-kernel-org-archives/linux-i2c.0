From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 6/7] i2c: puv3: add CONFIG_PM_SLEEP to suspend function
Date: Mon, 15 Jul 2013 11:30:36 +0900
Message-ID: <005a01ce8103$4a347580$de9d6080$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend function to fix the following build
warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-puv3.c:249:12: warning: 'puv3_i2c_suspend' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-puv3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index 37a84c8..ac80199 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -245,7 +245,7 @@ static int puv3_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int puv3_i2c_suspend(struct device *dev)
 {
 	int poll_count;
-- 
1.7.10.4
