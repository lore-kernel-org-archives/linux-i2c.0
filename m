From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/4] i2c: export i2c_adapter_depth()
Date: Fri, 16 Sep 2016 18:02:42 +0200
Message-ID: <1474041765-17818-2-git-send-email-bgolaszewski@baylibre.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36461 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935589AbcIPQDD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Sep 2016 12:03:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id b187so44694526wme.1
        for <linux-i2c@vger.kernel.org>; Fri, 16 Sep 2016 09:03:02 -0700 (PDT)
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

For crazy setups in which an i2c gpio expander is behind an i2c gpio
multiplexer controlled by a gpio provided a second expander using the
same device driver we need to explicitly tell lockdep how to handle
nested locking.

Export i2c_adapter_depth() as public API to be reused outside of i2c
core code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/i2c/i2c-core.c | 9 ++-------
 include/linux/i2c.h    | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index da3a02e..c9b8df8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1335,13 +1335,7 @@ static void i2c_adapter_dev_release(struct device *dev)
 	complete(&adap->dev_released);
 }
 
-/*
- * This function is only needed for mutex_lock_nested, so it is never
- * called unless locking correctness checking is enabled. Thus we
- * make it inline to avoid a compiler warning. That's what gcc ends up
- * doing anyway.
- */
-static inline unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
+unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
 {
 	unsigned int depth = 0;
 
@@ -1350,6 +1344,7 @@ static inline unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
 
 	return depth;
 }
+EXPORT_SYMBOL_GPL(i2c_adapter_depth);
 
 /*
  * Let users instantiate I2C devices through sysfs. This can be used when
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fffdc27..cfacc03 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -673,6 +673,7 @@ extern void i2c_clients_command(struct i2c_adapter *adap,
 
 extern struct i2c_adapter *i2c_get_adapter(int nr);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
+extern unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
 
 void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
 
-- 
2.7.4
