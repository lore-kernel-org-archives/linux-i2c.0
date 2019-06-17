From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 2/3] drivers: gpio: pca953x: use subsys_i2c_driver()
Date: Mon, 17 Jun 2019 20:39:38 +0200
Message-ID: <1560796779-17117-2-git-send-email-info@metux.net>
References: <1560796779-17117-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796779-17117-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, wsa@the-dreams.de, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_i2c_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-pca953x.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index cfe827c..532762d 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1202,20 +1202,10 @@ static int pca953x_resume(struct device *dev)
 	.id_table	= pca953x_id,
 };
 
-static int __init pca953x_init(void)
-{
-	return i2c_add_driver(&pca953x_driver);
-}
 /* register after i2c postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(pca953x_init);
-
-static void __exit pca953x_exit(void)
-{
-	i2c_del_driver(&pca953x_driver);
-}
-module_exit(pca953x_exit);
+subsys_i2c_driver(pca953x_driver);
 
 MODULE_AUTHOR("eric miao <eric.miao@marvell.com>");
 MODULE_DESCRIPTION("GPIO expander driver for PCA953x");
-- 
1.9.1
