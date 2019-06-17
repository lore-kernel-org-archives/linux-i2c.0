From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 3/3] drivers: gpio: pcf857x: use subsys_i2c_driver()
Date: Mon, 17 Jun 2019 20:39:39 +0200
Message-ID: <1560796779-17117-3-git-send-email-info@metux.net>
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
 drivers/gpio/gpio-pcf857x.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 14fb8f6..554663e 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -430,20 +430,10 @@ static void pcf857x_shutdown(struct i2c_client *client)
 	.id_table = pcf857x_id,
 };
 
-static int __init pcf857x_init(void)
-{
-	return i2c_add_driver(&pcf857x_driver);
-}
 /* register after i2c postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(pcf857x_init);
-
-static void __exit pcf857x_exit(void)
-{
-	i2c_del_driver(&pcf857x_driver);
-}
-module_exit(pcf857x_exit);
+subsys_i2c_driver(pcf857x_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
-- 
1.9.1
