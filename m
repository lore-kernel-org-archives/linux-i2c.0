From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 2/3] i2c: multiplexer i2c devices.
Date: Wed, 18 Jun 2008 15:06:04 +0200
Message-ID: <1213794365-8089-2-git-send-email-giometti@linux.it>
References: <>
 <1213794365-8089-1-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1213794365-8089-1-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Define a proper configuration structure and new directory to hold
multiplexer i2c device drivers.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/Kconfig        |    2 ++
 drivers/i2c/Makefile       |    2 +-
 drivers/i2c/muxes/Kconfig  |    8 ++++++++
 3 files changed, 11 insertions(+), 1 deletions(-)
 create mode 100644 drivers/i2c/muxes/Kconfig
 create mode 100644 drivers/i2c/muxes/Makefile

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 053fe2f..efc39a1 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -36,6 +36,8 @@ config I2C_VIRT
 	  I2C bus topologies, by presenting each multiplexed segment as a
 	  I2C adapter.
 
+source drivers/i2c/muxes/Kconfig
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index db72ed9..6e59b8e 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_VIRT)		+= i2c-virt.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
-obj-y				+= busses/ chips/ algos/
+obj-y				+= busses/ chips/ muxes/ algos/
 
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
new file mode 100644
index 0000000..f69f326
--- /dev/null
+++ b/drivers/i2c/muxes/Kconfig
@@ -0,0 +1,8 @@
+#
+# Multiplexer I2C chip drivers configuration
+#
+
+menu "Multiplexer I2C Chip support"
+	depends on I2C && I2C_VIRT && EXPERIMENTAL
+
+endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
new file mode 100644
index 0000000..e69de29
-- 
1.5.4.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
