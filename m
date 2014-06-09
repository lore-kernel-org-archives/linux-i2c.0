From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: mux: pca954x: fix dependencies
Date: Mon,  9 Jun 2014 15:11:13 +0200
Message-ID: <1402319473-14993-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver causes the following randconfig build error:

drivers/i2c/muxes/i2c-mux-pca954x.c: In function =E2=80=98pca954x_probe=
=E2=80=99:
drivers/i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaration
of function =E2=80=98devm_gpiod_get=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
  gpio =3D devm_gpiod_get(&client->dev, "reset");
  ^
drivers/i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes
pointer from integer without a cast [enabled by default]
  gpio =3D devm_gpiod_get(&client->dev, "reset");
       ^
drivers/i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaration
of function =E2=80=98gpiod_direction_output=E2=80=99
[-Werror=3Dimplicit-function-declaration]
   gpiod_direction_output(gpio, 0);
   ^
cc1: some warnings being treated as errors
make[3]: *** [drivers/i2c/muxes/i2c-mux-pca954x.o] Error 1

This is because it is getting compiled without gpiolib, so
introduce an explicit dependency.

Reported-by: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/muxes/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index f7f9865b8b89..f6d313e528de 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -40,6 +40,7 @@ config I2C_MUX_PCA9541
=20
 config I2C_MUX_PCA954x
 	tristate "Philips PCA954x I2C Mux/switches"
+	depends on GPIOLIB
 	help
 	  If you say yes here you get support for the Philips PCA954x
 	  I2C mux/switch devices.
--=20
1.9.3
