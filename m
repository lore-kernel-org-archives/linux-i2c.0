From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH v2] i2c: meson: allow build with COMPILE_TEST
Date: Wed,  6 Jul 2016 21:17:05 +0100
Message-ID: <1467836225-2427-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 34.25.187.81.in-addr.arpa ([81.187.25.34]:52018 "EHLO freya"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751666AbcGFU50 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jul 2016 16:57:26 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben.dooks@codethink.co.uk>

This driver should be buildable with COMPILE_TEST so
add this to the dependency for it.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
V2:
- reduced to just personal signnoff.
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index efa3d9b..1a6f2de 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -637,7 +637,7 @@ config I2C_LPC2K
 
 config I2C_MESON
 	tristate "Amlogic Meson I2C controller"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface on the Amlogic Meson family of SoCs.
-- 
2.8.1
