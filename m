From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] i2c: zx2967: drop COMPILE_TEST dependency
Date: Sat, 24 Jun 2017 22:25:26 +0800
Message-ID: <1498314326-16121-1-git-send-email-shawnguo@kernel.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbdFXOZm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Jun 2017 10:25:42 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

From: Shawn Guo <shawn.guo@linaro.org>

0-DAY kernel test reports the following build issue on IA64 architecture
with allmodconfig.

   drivers/i2c/busses/i2c-zx2967.c: In function 'zx2967_i2c_writesb':
>> drivers/i2c/busses/i2c-zx2967.c:87:2: error: implicit declaration of function 'writesb' [-Werror=implicit-function-declaration]
     writesb(i2c->reg_base + reg, data, len);
     ^~~~~~~
   drivers/i2c/busses/i2c-zx2967.c: In function 'zx2967_i2c_readsb':
>> drivers/i2c/busses/i2c-zx2967.c:93:2: error: implicit declaration of function 'readsb' [-Werror=implicit-function-declaration]
     readsb(i2c->reg_base + reg, data, len);
     ^~~~~~
   cc1: some warnings being treated as errors

It's caused by that writesb/readsb are unavailable on IA64 architecture.
Let's drop COMPILE_TEST dependency to avoid the build issue.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index ec1f305294a6..a7bc042fe502 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1262,7 +1262,7 @@ config I2C_OPAL
 
 config I2C_ZX2967
 	tristate "ZTE ZX2967 I2C support"
-	depends on ARCH_ZX || COMPILE_TEST
+	depends on ARCH_ZX
 	default y
 	help
 	  Selecting this option will add ZX2967 I2C driver.
-- 
1.9.1
