From: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Subject: i2c: xlp9xx: add support for Broadcom Vulcan
Date: Mon, 11 Apr 2016 18:01:26 +0530
Message-ID: <1460377886-22437-1-git-send-email-tanmay.jagdale@broadcom.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:27028 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbcDKMcL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Apr 2016 08:32:11 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: Tanmay Jagdale <tanmay.jagdale@broadcom.com>, linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com

The Broadcom Vulcan ARM64 processor uses the same I2C controller
present on the Broadcom XLP9xx/5xx MIPS processor family.
Updated the Kconfig by adding ARCH_VULCAN option.

Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
---
 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index faa8e68..0967e1a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -975,10 +975,10 @@ config I2C_XLR
 
 config I2C_XLP9XX
 	tristate "XLP9XX I2C support"
-	depends on CPU_XLP || COMPILE_TEST
+	depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
 	help
 	  This driver enables support for the on-chip I2C interface of
-	  the Broadcom XLP9xx/XLP5xx MIPS processors.
+	  the Broadcom XLP9xx/XLP5xx MIPS and Vulcan ARM64 processors.
 
 	  This driver can also be built as a module.  If so, the module will
 	  be called i2c-xlp9xx.
-- 
2.1.0
