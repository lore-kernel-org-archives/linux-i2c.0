From: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c-s3c2410: Fix pointer type passed to of_match_node()
Date: Wed, 30 May 2012 11:43:05 +0200
Message-ID: <1338370985-6950-1-git-send-email-k.lewandowsk@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This commit fixes warning introduced in 27452498a ("i2c-s3c2410: Rework
device type handling"):

  drivers/i2c/busses/i2c-s3c2410.c: In function 's3c24xx_get_device_quirks':
  drivers/i2c/busses/i2c-s3c2410.c:125: warning: passing argument 1 of 'of_match_node' from incompatible pointer type
  include/linux/of.h:245: note: expected 'const struct of_device_id *' but argument is of type 'const struct of_device_id (*)[4]'

Signed-off-by: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index fa0b134..286e596 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -122,7 +122,7 @@ static inline unsigned int s3c24xx_get_device_quirks(struct platform_device *pde
 {
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
-		match = of_match_node(&s3c24xx_i2c_match, pdev->dev.of_node);
+		match = of_match_node(s3c24xx_i2c_match, pdev->dev.of_node);
 		return (unsigned int)match->data;
 	}
 
-- 
1.7.10
