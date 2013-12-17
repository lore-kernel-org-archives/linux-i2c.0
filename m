From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 12/13] i2c: viperboard: Use devm_kzalloc() functions
Date: Tue, 17 Dec 2013 16:01:41 +0900
Message-ID: <003001cefaf5$d6618590$832490b0$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Lars Poeschel' <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_kzalloc() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-viperboard.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index c68450c..6976e1c 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -367,7 +367,7 @@ static int vprbrd_i2c_probe(struct platform_device *pdev)
 	int ret;
 	int pipe;
 
-	vb_i2c = kzalloc(sizeof(*vb_i2c), GFP_KERNEL);
+	vb_i2c = devm_kzalloc(&pdev->dev, sizeof(*vb_i2c), GFP_KERNEL);
 	if (vb_i2c == NULL)
 		return -ENOMEM;
 
@@ -394,14 +394,12 @@ static int vprbrd_i2c_probe(struct platform_device *pdev)
 	    if (ret != 1) {
 		dev_err(&pdev->dev,
 			"failure setting i2c_bus_freq to %d\n", i2c_bus_freq);
-		ret = -EIO;
-		goto error;
+		return -EIO;
 	    }
 	} else {
 		dev_err(&pdev->dev,
 			"invalid i2c_bus_freq setting:%d\n", i2c_bus_freq);
-		ret = -EIO;
-		goto error;
+		return -EIO;
 	}
 
 	vb_i2c->i2c.dev.parent = &pdev->dev;
@@ -412,10 +410,6 @@ static int vprbrd_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, vb_i2c);
 
 	return 0;
-
-error:
-	kfree(vb_i2c);
-	return ret;
 }
 
 static int vprbrd_i2c_remove(struct platform_device *pdev)
-- 
1.7.10.4
