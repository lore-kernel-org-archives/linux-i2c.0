From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 1/2] i2c: core: fix compile issue related to incorrect gpio header
Date: Tue, 28 Nov 2017 11:09:10 +0800
Message-ID: <1511838551-4035-2-git-send-email-preid@electromag.com.au>
References: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:52861 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751658AbdK1DJX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 22:09:23 -0500
In-Reply-To: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, preid@electromag.com.au, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au

The correct header to include for the gpiod interface is
<linux/gpio/consumer.h>.

fixes commit 3991c5c80beaf7eb9 ("i2c: Switch to using gpiod interface
for gpio bus recovery")

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 54ffc8d..bf52cca 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -27,7 +27,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
 #include <linux/idr.h>
-- 
1.8.3.1
