From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/4] gpio: pca953x: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 18:02:45 +0200
Message-ID: <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36921 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964933AbcIPQDG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Sep 2016 12:03:06 -0400
Received: by mail-wm0-f46.google.com with SMTP id k186so49854998wmd.0
        for <linux-i2c@vger.kernel.org>; Fri, 16 Sep 2016 09:03:06 -0700 (PDT)
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
when there's a second expander using the same device driver on one of
the I2C bus segments, lockdep prints a deadlock warning when trying to
set the direction or the value of the GPIOs provided by the second
expander.

The below diagram presents the setup:

                                               - - - - -
 -------             ---------  Bus segment 1 |         |
|       |           |         |---------------  Devices
|       | SCL/SDA   |         |               |         |
| Linux |-----------| I2C MUX |                - - - - -
|       |    |      |         | Bus segment 2
|       |    |      |         |-------------------
 -------     |       ---------                    |
             |           |                    - - - - -
        ------------     | MUX GPIO          |         |
       |            |    |                     Devices
       |    GPIO    |    |                   |         |
       | Expander 1 |----                     - - - - -
       |            |                             |
        ------------                              | SCL/SDA
                                                  |
                                             ------------
                                            |            |
                                            |    GPIO    |
                                            | Expander 2 |
                                            |            |
                                             ------------

The reason for lockdep warning is that we take the chip->i2c_lock in
pca953x_gpio_set_value() or pca953x_gpio_direction_output() and then
come right back to pca953x_gpio_set_value() when the GPIO mux kicks
in. The locks actually protect different expanders, but for lockdep
both are of the same class, so it says:

  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&chip->i2c_lock);
   lock(&chip->i2c_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

In order to get rid of the warning, retrieve the adapter nesting depth
and use it as lockdep subclass for chip->i2c_lock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 02f2a56..892dc04 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -786,6 +786,8 @@ static int pca953x_probe(struct i2c_client *client,
 	chip->chip_type = PCA_CHIP_TYPE(chip->driver_data);
 
 	mutex_init(&chip->i2c_lock);
+	lockdep_set_subclass(&chip->i2c_lock,
+			     i2c_adapter_depth(client->adapter));
 
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
-- 
2.7.4
