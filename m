From: Zhiqiang Hou <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv8 1/5] i2c: imx: fix a compiling error
Date: Tue, 17 Nov 2015 17:53:18 +0800
Message-ID: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org, B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Hou Zhiqiang <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Hou Zhiqiang <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

drivers/i2c/busses/i2c-imx.c:978:2: error: implicit declaration of
function =E2=80=98pinctrl_select_state=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
  pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
  ^

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
V8:
 - New patch.

 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index 1e4d99d..9bb0b05 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -50,6 +50,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
--=20
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
