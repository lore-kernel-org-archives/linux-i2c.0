From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: dereference of NULL if request_irq() failsin sh_mobile_i2c_hook_irqs()
Date: Fri, 19 Feb 2010 21:14:52 +0100
Message-ID: <4B7EF13C.80009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In the last iteration k equals 0, so we call platform_get_resource() with
-1 as a third argument. Since platform_get_resource() uses an unsigned it
is converted to 0xffffffff. platform_get_resource() fails for every index
and returns NULL. A test is lacking and we dereference NULL.

Also the variable q was assigned but not used.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index ccc4641..5871335 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -496,7 +496,7 @@ static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, int hook)
 {
 	struct resource *res;
 	int ret = -ENXIO;
-	int q, m;
+	int m;
 	int k = 0;
 	int n = 0;
 
@@ -516,12 +516,16 @@ static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, int hook)
 	ret = 0;
 
  rollback:
-	for (q = k; k >= 0; k--) {
-		for (m = n; m >= res->start; m--)
-			free_irq(m, dev);
+	for (m = n; m >= res->start; m--)
+		free_irq(m, dev);
 
+	while (k--) {
 		res = platform_get_resource(dev, IORESOURCE_IRQ, k - 1);
-		m = res->end;
+		if (res == NULL)
+			break;
+
+		for (m = res->end; m >= res->start; m--)
+			free_irq(m, dev);
 	}
 
 	return ret;
