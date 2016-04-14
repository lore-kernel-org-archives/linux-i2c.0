From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] i2c: versatile: Allow compile test build
Date: Thu, 14 Apr 2016 22:30:36 +0800
Message-ID: <1460644236.6039.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35491 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbcDNOal (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 10:30:41 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so7047396pac.2
        for <linux-i2c@vger.kernel.org>; Thu, 14 Apr 2016 07:30:40 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Pawel Moll <pawel.moll@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-i2c@vger.kernel.org

There is no build dependency for this driver, so enable COMPILE_TEST to get
better build coverage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index faa8e68..6e0bba0 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -924,7 +924,7 @@ config I2C_UNIPHIER_F
 
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
-	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
+	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || COMPILE_TEST
 	select I2C_ALGOBIT
 	help
 	  Say yes if you want to support the I2C serial bus on ARMs Versatile
-- 
2.5.0
