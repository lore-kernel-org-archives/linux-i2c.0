From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] MAINTAINERS: add git URL for at24
Date: Wed, 13 Dec 2017 12:30:31 +0100
Message-ID: <20171213113031.8668-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Add the link to my git tree to the at24 section.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af54fa0837..edaf9802a11f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2262,6 +2262,7 @@ F:	include/linux/async_tx.h
 AT24 EEPROM DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-i2c@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/eeprom/at24.txt
 F:	drivers/misc/eeprom/at24.c
-- 
2.15.1
