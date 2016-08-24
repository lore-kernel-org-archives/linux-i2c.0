From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 1/8] i2c: octeon: Rename driver to prepare for split
Date: Wed, 24 Aug 2016 23:25:42 +0200
Message-ID: <20160824212549.16140-2-jglauber@cavium.com>
References: <20160824212549.16140-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34322 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756806AbcHXV0I (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Aug 2016 17:26:08 -0400
In-Reply-To: <20160824212549.16140-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

This is an intermediate commit in preparation of the driver split.
The module rename in this commit will be reverted in the next patch,
this is just done to make the series bisectible.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/Makefile                               | 2 +-
 drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-platdrv.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-platdrv.c} (100%)

diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..f2c9c6f 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -91,7 +91,7 @@ obj-$(CONFIG_I2C_UNIPHIER)	+= i2c-uniphier.o
 obj-$(CONFIG_I2C_UNIPHIER_F)	+= i2c-uniphier-f.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
-obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
+obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon-platdrv.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
similarity index 100%
rename from drivers/i2c/busses/i2c-octeon.c
rename to drivers/i2c/busses/i2c-octeon-platdrv.c
-- 
2.9.0.rc0.21.g7777322
