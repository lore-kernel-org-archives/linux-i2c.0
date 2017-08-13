From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: drop entry for Blackfin I2C and Sonic's email
Date: Sun, 13 Aug 2017 17:34:31 +0200
Message-ID: <20170813153431.4487-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, Steven Miao <realmz6@gmail.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Sonic's email address bounced, so remove it from MAINTAINERS. Since
there was no I2C/TWI maintenance activity for 3 years now, drop that
whole entry.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Because the Blackfin ML activity is very low, I wonder if the state of the
whole Blackfin arch really matches "Supported"? Yet, I can only speak for
I2C/TWI here. And as always: If you think I am wrong and want to step up, I'd
super-happily drop this patch in favor of an update.

 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f7721d1634c2e..b9f585784e9dee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2546,13 +2546,6 @@ W:	http://blackfin.uclinux.org
 S:	Supported
 F:	drivers/net/ethernet/adi/
 
-BLACKFIN I2C TWI DRIVER
-M:	Sonic Zhang <sonic.zhang@analog.com>
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Supported
-F:	drivers/i2c/busses/i2c-bfin-twi.c
-
 BLACKFIN MEDIA DRIVER
 M:	Scott Jiang <scott.jiang.linux@gmail.com>
 L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
@@ -2569,14 +2562,12 @@ S:	Supported
 F:	drivers/rtc/rtc-bfin.c
 
 BLACKFIN SDH DRIVER
-M:	Sonic Zhang <sonic.zhang@analog.com>
 L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
 W:	http://blackfin.uclinux.org
 S:	Supported
 F:	drivers/mmc/host/bfin_sdh.c
 
 BLACKFIN SERIAL DRIVER
-M:	Sonic Zhang <sonic.zhang@analog.com>
 L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
 W:	http://blackfin.uclinux.org
 S:	Supported
-- 
2.11.0
