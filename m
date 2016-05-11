From: Mason <slash.tmp@free.fr>
Subject: [PATCH] i2c: xlr: rename ARCH_TANGOX to ARCH_TANGO
Date: Wed, 11 May 2016 16:27:57 +0200
Message-ID: <5733416D.70409@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:22183 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbcEKO2K (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 10:28:10 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

The ARCH name was changed during the review process.
http://article.gmane.org/gmane.linux.ports.arm.kernel/456331

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2dd40ddf04de..d8d18ed65440 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -965,7 +965,7 @@ config I2C_XILINX
 
 config I2C_XLR
 	tristate "Netlogic XLR and Sigma Designs I2C support"
-	depends on CPU_XLR || ARCH_TANGOX
+	depends on CPU_XLR || ARCH_TANGO
 	help
 	  This driver enables support for the on-chip I2C interface of
 	  the Netlogic XLR/XLS MIPS processors and Sigma Designs SOCs.
-- 
2.8.1
