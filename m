From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 1/2] i2c: brcmstb: Make the driver buildable on BMIPS_GENERIC
Date: Fri, 15 Jul 2016 12:45:08 +0900
Message-ID: <20160715034509.58148-2-jaedon.shin@gmail.com>
References: <20160715034509.58148-1-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35818 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcGODp4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Jul 2016 23:45:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id t190so5684652pfb.2
        for <linux-i2c@vger.kernel.org>; Thu, 14 Jul 2016 20:45:56 -0700 (PDT)
In-Reply-To: <20160715034509.58148-1-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM and MIPS based SoCs share a similar I2C hardware block.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f167021b8c21..1fdb0c8b0697 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -397,7 +397,7 @@ config I2C_BCM_KONA
 
 config I2C_BRCMSTB
 	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.9.0
