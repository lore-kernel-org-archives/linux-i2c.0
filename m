From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 11/15] i2c: octeon: Rename driver to prepare for split
Date: Mon, 25 Apr 2016 16:33:40 +0200
Message-ID: <1461594824-7215-12-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32861 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbcDYOeM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Apr 2016 10:34:12 -0400
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

This is an intermediate commit in preparation of the driver split.
The module rename in this commit will be reverted in the next patch,
this is just done to make the series bisectible.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/Makefile                            | 2 +-
 drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-core.c} (100%)

diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..3405286 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -91,7 +91,7 @@ obj-$(CONFIG_I2C_UNIPHIER)	+= i2c-uniphier.o
 obj-$(CONFIG_I2C_UNIPHIER_F)	+= i2c-uniphier-f.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
-obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
+obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon-core.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon-core.c
similarity index 100%
rename from drivers/i2c/busses/i2c-octeon.c
rename to drivers/i2c/busses/i2c-octeon-core.c
-- 
1.9.1
