From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: new maintainer for AT24 driver
Date: Thu,  2 Nov 2017 00:18:59 +0100
Message-ID: <20171101231859.16404-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59410 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbdKAXT2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 19:19:28 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Bartosz agreed to take over maintainership from me. Thank you very much
and good luck and have fun! :)

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d85c08956875e5..e021587e8fe46d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2247,7 +2247,7 @@ F:	include/linux/dmaengine.h
 F:	include/linux/async_tx.h
 
 AT24 EEPROM DRIVER
-M:	Wolfram Sang <wsa@the-dreams.de>
+M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/eeprom/at24.c
-- 
2.11.0
