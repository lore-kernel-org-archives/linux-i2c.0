From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] i2c: xgene-slimpro: include linux/io.h for memremap
Date: Fri,  9 Jun 2017 12:29:12 +0200
Message-ID: <20170609102937.3054567-1-arnd@arndb.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:55715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdFIKaD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Jun 2017 06:30:03 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Hoan Tran <hotran@apm.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Tin Huynh <tnhuynh@apm.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

The newly added support for the pcc mailbox fails to build
in some configurations:

drivers/i2c/busses/i2c-xgene-slimpro.c: In function 'xgene_slimpro_i2c_probe':
drivers/i2c/busses/i2c-xgene-slimpro.c:516:25: error: implicit declaration of function 'memremap'; did you mean 'memcmp'? [-Werror=implicit-function-declaration]
drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: error: 'MEMREMAP_WB' undeclared (first use in this function)
drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: note: each undeclared identifier is reported only once for each function it appears in

This includes the missing header file.

Fixes: df5da47fe722 ("i2c: xgene-slimpro: Add ACPI support by using PCC mailbox")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index 8e5c8f28bc8b..7e89ba6fcf6f 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -27,6 +27,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.9.0
