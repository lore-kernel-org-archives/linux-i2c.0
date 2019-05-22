From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] i2c: jz4780: Drop dependency on MACH_JZ4780
Date: Wed, 22 May 2019 19:05:16 +0200
Message-ID: <20190522170516.15086-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: od@zcrc.me, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-i2c@vger.kernel.org

Depending on MACH_JZ4780 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 26186439db6b..bfb1d05248dc 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -691,7 +691,7 @@ config I2C_IOP3XX
 
 config I2C_JZ4780
 	tristate "JZ4780 I2C controller interface support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	help
 	 If you say yes to this option, support will be included for the
 	 Ingenic JZ4780 I2C controller.
-- 
2.21.0.593.g511ec345e18
