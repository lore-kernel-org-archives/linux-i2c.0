From: Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH] i2c: allow configuration of imx driver for ColdFire architecture
Date: Mon, 17 Oct 2016 11:54:05 +1000
Message-ID: <1476669245-3678-1-git-send-email-gerg@linux-m68k.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:56147
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756893AbcJQCHj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 16 Oct 2016 22:07:39 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, angelo@sysam.it
Cc: Greg Ungerer <gerg@linux-m68k.org>

The i2c controller used by Freescales iMX processors is the same
hardware module used on Freescales ColdFire family of processors.

We can use the existing i2c-imx driver on ColdFire family members.
Modify the configuration to allow it to be selected when compiling
for ColdFire targets.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6d94e2e..cc9adf6 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -589,10 +589,10 @@ config I2C_IMG
 
 config I2C_IMX
 	tristate "IMX I2C interface"
-	depends on ARCH_MXC || ARCH_LAYERSCAPE
+	depends on ARCH_MXC || ARCH_LAYERSCAPE || COLDFIRE
 	help
 	  Say Y here if you want to use the IIC bus controller on
-	  the Freescale i.MX/MXC or Layerscape processors.
+	  the Freescale i.MX/MXC, Layerscape or ColdFire processors.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-imx.
-- 
1.9.1
