From: Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH 1/2] i2c: versatile: Allow compile test build
Date: Sat, 09 Jul 2016 13:31:23 +0800
Message-ID: <1468042283.21863.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33946 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbcGIFb3 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 9 Jul 2016 01:31:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id 66so9749127pfy.1
        for <linux-i2c@vger.kernel.org>; Fri, 08 Jul 2016 22:31:28 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-i2c@vger.kernel.org

There is no build dependency for this driver, so enable COMPILE_TEST to get
better build coverage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Resend with CC VE maintainers.
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
