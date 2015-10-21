From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/9] i2c: brcmstb: make the driver buildable on BMIPS_GENERIC
Date: Wed, 21 Oct 2015 11:36:53 +0900
Message-ID: <1445395021-4204-2-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35220 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJUChy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 22:37:54 -0400
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM and MIPS platforms share a similar hardware block for
I2C.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 08b86178e8fb..fd983c5b36f2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -394,7 +394,7 @@ config I2C_BCM_KONA
 
 config I2C_BRCMSTB
 	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.6.1
