From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] [media] altera-stapl should depend on HAS_IOPORT
Date: Sun, 16 Sep 2012 11:21:23 +0200
Message-ID: <1347787283-11994-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: "Igor M. Liplianin" <liplianin@netup.ru>, Peter Huewe <peterhuewe@gmx.de>, Jean Delvare <khali@linux-fr.org>, Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-i2c@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-next@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

On s390:

drivers/misc/altera-stapl/altera-lpt.c: In function 'byteblaster_write':
drivers/misc/altera-stapl/altera-lpt.c:34:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
drivers/misc/altera-stapl/altera-lpt.c: In function 'byteblaster_read':
drivers/misc/altera-stapl/altera-lpt.c:40:2: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[6]: *** [drivers/misc/altera-stapl/altera-lpt.o] Error 1

Before commit 3969d54acd70be70e1b2a72184cba5415bf326c2 ("i2c: Make I2C
available on UML"), this was hidden because I2C depended on HAS_IOMEM, which
is a superset of HAS_IOPORT.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
--
http://kisskb.ellerman.id.au/kisskb/buildresult/7194502/
http://kisskb.ellerman.id.au/kisskb/buildresult/7194476/
---
 drivers/misc/altera-stapl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/altera-stapl/Kconfig b/drivers/misc/altera-stapl/Kconfig
index 7f01d8e..c7e4c77 100644
--- a/drivers/misc/altera-stapl/Kconfig
+++ b/drivers/misc/altera-stapl/Kconfig
@@ -2,7 +2,7 @@ comment "Altera FPGA firmware download module"
 
 config ALTERA_STAPL
 	tristate "Altera FPGA firmware download module"
-	depends on I2C
+	depends on I2C && HAS_IOPORT
 	default n
 	help
 	  An Altera FPGA module. Say Y when you want to support this tool.
-- 
1.7.0.4
