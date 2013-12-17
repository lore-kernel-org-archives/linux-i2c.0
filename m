From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/13] i2c: sirf: Use devm_clk_get()
Date: Tue, 17 Dec 2013 16:00:02 +0900
Message-ID: <002e01cefaf5$9b77e320$d267a960$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Barry Song' <Baohua.Song-kQvG35nSl+M@public.gmane.org>, 'Zhiwu Song' <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_clk_get() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 6784f7f..c8fcddc 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -284,17 +284,16 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	int err;
 	u32 regval;
 
-	clk = clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		err = PTR_ERR(clk);
 		dev_err(&pdev->dev, "Clock get failed\n");
-		goto err_get_clk;
+		return PTR_ERR(clk);
 	}
 
 	err = clk_prepare(clk);
 	if (err) {
 		dev_err(&pdev->dev, "Clock prepare failed\n");
-		goto err_clk_prep;
+		return err;
 	}
 
 	err = clk_enable(clk);
@@ -387,9 +386,6 @@ out:
 	clk_disable(clk);
 err_clk_en:
 	clk_unprepare(clk);
-err_clk_prep:
-	clk_put(clk);
-err_get_clk:
 	return err;
 }
 
@@ -401,7 +397,6 @@ static int i2c_sirfsoc_remove(struct platform_device *pdev)
 	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
 	i2c_del_adapter(adapter);
 	clk_unprepare(siic->clk);
-	clk_put(siic->clk);
 	return 0;
 }
 
-- 
1.7.10.4
