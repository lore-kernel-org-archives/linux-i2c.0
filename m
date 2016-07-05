From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCHv2] i2c: meson: allow build with COMPILE_TEST
Date: Tue,  5 Jul 2016 19:24:03 +0100
Message-ID: <1467743043-18703-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1467742788-16431-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:45428 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750962AbcGESYM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 14:24:12 -0400
In-Reply-To: <1467742788-16431-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-amlogic@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>

This driver could be included in COMPILE_TEST so allow it to be
compiled when COMPILE_TEST is selected.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-amlogic@lists.infradead.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
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
