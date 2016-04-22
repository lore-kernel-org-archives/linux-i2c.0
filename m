From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/4] i2c: i2c-mv64xxx: enable the driver on ARCH_MVEBU
Date: Fri, 22 Apr 2016 15:19:51 +0200
Message-ID: <1461331194-27637-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39011 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752304AbcDVNUB (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Apr 2016 09:20:01 -0400
In-Reply-To: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The new ARM64 Marvell Armada 7K/8K SoC family is using the same I2C
controller as the 32-bits Marvell EBU SoCs, so this commit allows
mv64xxx to be enabled when ARCH_MVEBU=y.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index faa8e68..2966433 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -663,7 +663,7 @@ config I2C_MT65XX
 
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
-	depends on MV64X60 || PLAT_ORION || ARCH_SUNXI
+	depends on MV64X60 || PLAT_ORION || ARCH_SUNXI || ARCH_MVEBU
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
-- 
2.6.4
