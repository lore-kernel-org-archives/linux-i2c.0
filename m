From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: pca953x: add a comment explaining the need for a lockdep subclass
Date: Mon, 26 Sep 2016 11:54:15 +0200
Message-ID: <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
References: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

This is a follow-up to commit 559b46990e76 ("gpio: pca953x: fix an
incorrect lockdep warning"). The reason for calling
lockdep_set_subclass() in pca953x_probe() is not explained in
the code.

Add a comment describing the problem, partial solution and required
future extensions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-pca953x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 018f39c..f306909 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -786,6 +786,22 @@ static int pca953x_probe(struct i2c_client *client,
 	chip->chip_type = PCA_CHIP_TYPE(chip->driver_data);
 
 	mutex_init(&chip->i2c_lock);
+	/*
+	 * In case we have an i2c-mux controlled by a GPIO provided by an
+	 * expander using the same driver higher on the device tree, read the
+	 * i2c adapter nesting depth and use the retrieved value as lockdep
+	 * subclass for chip->i2c_lock.
+	 *
+	 * REVISIT: This solution is not complete. It protects us from lockdep
+	 * false positives when the expander controlling the i2c-mux is on
+	 * a different level on the device tree, but not when it's on the same
+	 * level on a different branch (in which case the subclass number
+	 * would be the same).
+	 *
+	 * TODO: Once a correct solution is developed, a similar fix should be
+	 * applied to all other i2c-controlled GPIO expanders (and potentially
+	 * regmap-i2c).
+	 */
 	lockdep_set_subclass(&chip->i2c_lock,
 			     i2c_adapter_depth(client->adapter));
 
-- 
2.7.4
