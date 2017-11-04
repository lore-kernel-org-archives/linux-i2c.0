From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: nuc900: remove platform_data, too
Date: Sat,  4 Nov 2017 21:49:26 +0100
Message-ID: <20171104204926.4711-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44934 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbdKDUtc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 4 Nov 2017 16:49:32 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Commit 7da62cb1853025 ("i2c: nuc900: remove driver") removed the driver,
we should remove the platform_data as well.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 include/linux/platform_data/i2c-nuc900.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 include/linux/platform_data/i2c-nuc900.h

diff --git a/include/linux/platform_data/i2c-nuc900.h b/include/linux/platform_data/i2c-nuc900.h
deleted file mode 100644
index 9ffb12d06e9178..00000000000000
--- a/include/linux/platform_data/i2c-nuc900.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __ASM_ARCH_NUC900_I2C_H
-#define __ASM_ARCH_NUC900_I2C_H
-
-struct nuc900_platform_i2c {
-	int		bus_num;
-	unsigned long   bus_freq;
-};
-
-#endif /* __ASM_ARCH_NUC900_I2C_H */
-- 
2.11.0
