From: Chris Gorman <chrisjohgorman@gmail.com>
Subject: [PATCH] drivers: i2c: muxes: Kconfig
Date: Wed, 12 Jul 2017 13:31:26 -0400
Message-ID: <1499880686-8257-1-git-send-email-chrisjohgorman@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35424 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbdGLRb5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 12 Jul 2017 13:31:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Gorman <chrisjohgorman@gmail.com>

Kconfig says the resulting module is pinctrl-i2cmux and the module when
built is i2c-mux-pinctrl.

Signed-off-by: Chris Gorman <chrisjohgorman@gmail.com>
---
 drivers/i2c/muxes/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 2c64d0e..1712132 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -83,7 +83,7 @@ config I2C_MUX_PINCTRL
 	  different sets of pins at run-time.
 
 	  This driver can also be built as a module. If so, the module will be
-	  called pinctrl-i2cmux.
+	  called i2c-mux-pinctrl.
 
 config I2C_MUX_REG
 	tristate "Register-based I2C multiplexer"
-- 
2.7.4
