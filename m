From: Baolin Wang <baolin.wang@spreadtrum.com>
Subject: [PATCH] i2c: sprd: Fix undefined reference errors
Date: Wed, 30 Aug 2017 11:05:47 +0800
Message-ID: <550ed5bf75d653e227d09266670caf2a058b0473.1504061716.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:32734 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdH3DPG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Aug 2017 23:15:06 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org, baolin.wang@spreadtrum.com

Since the i2c driver of Spreadtrum can not be build as one module, thus
it should depend on CONFIG_I2C is build in.

Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 64729ac..71036c1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -902,7 +902,7 @@ config I2C_SIRF
 
 config I2C_SPRD
 	bool "Spreadtrum I2C interface"
-	depends on ARCH_SPRD
+	depends on I2C=y && ARCH_SPRD
 	help
 	  If you say yes to this option, support will be included for the
 	  Spreadtrum I2C interface.
-- 
1.7.9.5
