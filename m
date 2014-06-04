From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] i2c: pca954x: Fix compilation without CONFIG_GPIOLIB
Date: Wed,  4 Jun 2014 18:56:32 +0200
Message-ID: <1401900992-16581-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, wsa@the-dreams.de, khali@linux-fr.org, linus.walleij@linaro.org, paul.gortmaker@windriver.com, jg1.han@samsung.com, laurent.pinchart@ideasonboard.com, Stephen Rothwell <sfr@canb.auug.org.au>, Jim Davis <jim.epost@gmail.com>
List-Id: linux-i2c@vger.kernel.org

The pca954x driver recently switched to the GPIO descriptor API without
including the correct <linux/gpio/consumer.h> header. This breaks
compilation without CONFIG_GPIOLIB.

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

=46ix it by including the right header.

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2=
c-mux-pca954x.c
index c2c443f..9bd4212 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -36,12 +36,11 @@
  */
=20
 #include <linux/device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/i2c/pca954x.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
=20
 #define PCA954X_MAX_NCHANS 8
--=20
Regards,

Laurent Pinchart
