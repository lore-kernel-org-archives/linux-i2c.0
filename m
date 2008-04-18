From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF
	helpers
Date: Fri, 18 Apr 2008 16:23:03 +0200
Message-ID: <4808AEC7.8040000@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, "Kernel,
	Linux" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix build breakage introduced in commit
"[POWERPC] i2c: OF helpers for the i2c API".
If i2c-core is compiled as module, the helper needs to be
compiled as module, as well. Rename i2c.c to of_i2c.c to
avoid name space conflict.

Signed-off-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
---
 drivers/of/Kconfig             |    2 +-
 drivers/of/Makefile            |    2 +-
 drivers/of/{i2c.c => of_i2c.c} |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/of/{i2c.c => of_i2c.c} (100%)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 7c30531..0e39f00 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -9,7 +9,7 @@ config OF_GPIO
 	  OpenFirmware GPIO accessors
 
 config OF_I2C
-	def_bool y
+	def_tristate I2C
 	depends on OF && I2C
 	help
 	  OpenFirmware I2C accessors
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index a07b953..548772e 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,4 +1,4 @@
 obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
-obj-$(CONFIG_OF_I2C)	+= i2c.o
+obj-$(CONFIG_OF_I2C)	+= of_i2c.o
diff --git a/drivers/of/i2c.c b/drivers/of/of_i2c.c
similarity index 100%
rename from drivers/of/i2c.c
rename to drivers/of/of_i2c.c
-- 
1.5.5


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
