From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] GPIO_SCH and I2C_SCH: select MFD_SUPPORT to eliminate
 kconfig warnings
Date: Tue, 14 Dec 2010 16:26:56 -0800
Message-ID: <20101214162656.b8550c70.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: akpm <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

I2C_ISCH and GPIO_SCH need to select MFD_SUPPORT so that the
dependency tree hierarchy is satisfied.  This eliminates the
kconfig warning:

warning: (I2C_ISCH && I2C && PCI || GPIO_SCH && GPIOLIB && PCI) selects LPC_SCH which has unmet direct dependencies (MFD_SUPPORT && PCI)

Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/gpio/Kconfig       |    1 +
 drivers/i2c/busses/Kconfig |    1 +
 2 files changed, 2 insertions(+)

--- lnx-2637-rc4.orig/drivers/gpio/Kconfig
+++ lnx-2637-rc4/drivers/gpio/Kconfig
@@ -102,6 +102,7 @@ config GPIO_VR41XX
 config GPIO_SCH
 	tristate "Intel SCH GPIO"
 	depends on GPIOLIB && PCI
+	select MFD_SUPPORT
 	select MFD_CORE
 	select LPC_SCH
 	help
--- lnx-2637-rc4.orig/drivers/i2c/busses/Kconfig
+++ lnx-2637-rc4/drivers/i2c/busses/Kconfig
@@ -107,6 +107,7 @@ config I2C_I801
 config I2C_ISCH
 	tristate "Intel SCH SMBus 1.0"
 	depends on PCI
+	select MFD_SUPPORT
 	select MFD_CORE
 	select LPC_SCH
 	help
