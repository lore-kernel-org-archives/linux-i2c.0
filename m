From: Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH] m68knommu: AMCORE board, add iMX i2c support
Date: Wed, 19 Oct 2016 23:19:39 +0200
Message-ID: <1476911979-4926-1-git-send-email-angelo@sysam.it>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sysam.it ([5.39.81.93]:34168 "EHLO sysam.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752684AbcJSV0Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Oct 2016 17:26:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: gerg@linux-m68k.org, Angelo Dureghello <angelo@sysam.it>

Add iMX i2c support for the Sysam AMCORE board.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
---
 arch/m68k/configs/amcore_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 2bf02e9..dc5adae 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -87,7 +87,7 @@ CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_COLDFIRE=y
+CONFIG_I2C_IMX=y
 CONFIG_PPS=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
-- 
2.8.1
