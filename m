From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 05/15] gpio: max732x: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:39 +0200
Message-ID: <20171031142149.32512-5-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56054 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdJaOWy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:54 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-max732x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 7f4d26ce5f23..5fc2efd837fd 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -709,8 +709,7 @@ static int max732x_probe(struct i2c_client *client,
 	return 0;
 
 out_failed:
-	if (chip->client_dummy)
-		i2c_unregister_device(chip->client_dummy);
+	i2c_unregister_device(chip->client_dummy);
 	return ret;
 }
 
@@ -734,8 +733,7 @@ static int max732x_remove(struct i2c_client *client)
 	gpiochip_remove(&chip->gpio_chip);
 
 	/* unregister any dummy i2c_client */
-	if (chip->client_dummy)
-		i2c_unregister_device(chip->client_dummy);
+	i2c_unregister_device(chip->client_dummy);
 
 	return 0;
 }
-- 
2.14.2
