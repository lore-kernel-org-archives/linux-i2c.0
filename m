From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] i2c: mux: pca954x needs gpiolib
Date: Thu, 05 Jun 2014 12:44:47 +0200
Message-ID: <17059569.EZXzqhtzTf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

commit 4807e8459bce ("i2c: mux: pca954x: Use the descriptor-based GPIO
API") moved this driver over to the gpio descriptor API, which means
we now have a dependency on GPIOLIB and get this build error when
it is disabled:

i2c/muxes/i2c-mux-pca954x.c: In function 'pca954x_probe':
i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
  gpio = devm_gpiod_get(&client->dev, "reset");
  ^
i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes pointer from integer without a cast [enabled by default]
  gpio = devm_gpiod_get(&client->dev, "reset");
       ^
i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]
   gpiod_direction_output(gpio, 0);
   ^

This adds the dependency in Kconfig as we do for other similar drivers.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index f7f9865b..f6d313e 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -40,6 +40,7 @@ config I2C_MUX_PCA9541
 
 config I2C_MUX_PCA954x
 	tristate "Philips PCA954x I2C Mux/switches"
+	depends on GPIOLIB
 	help
 	  If you say yes here you get support for the Philips PCA954x
 	  I2C mux/switch devices.
