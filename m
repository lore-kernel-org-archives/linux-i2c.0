From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: mv64xxx: fix circular Kconfig dependency
Date: Thu,  6 Mar 2014 10:19:13 +0100
Message-ID: <1394097553-5804-1-git-send-email-wsa@the-dreams.de>
References: <20140306135016.2f026cd81b41cd2474c99124@canb.auug.org.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140306135016.2f026cd81b41cd2474c99124@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-i2c@vger.kernel.org

Commit 370136bc67c3 ("i2c: mv64xxx: Add reset deassert call")
introduced:

drivers/video/Kconfig:42:error: recursive dependency detected!

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 70bcad9..ce0de47 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -527,8 +527,7 @@ config I2C_MPC
 
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
-	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
-	select RESET_CONTROLLER
+	depends on MV64X60 || PLAT_ORION || (ARCH_SUNXI && RESET_CONTROLLER)
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
-- 
1.9.0
