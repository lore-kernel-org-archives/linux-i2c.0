From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Thu, 16 Mar 2017 17:24:55 +0100
Message-ID: <20170316162455.22876-1-oneukum@suse.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752921AbdCPQZu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Mar 2017 12:25:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, hdegoede@redhat.com
Cc: Oliver Neukum <oneukum@suse.com>

Our testing shows the semaphore failing to be transferred on CherryTrail
in about 0.5% of all cases. The existing timeout needs to be lengthened
to accomodate the worst cases.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 1590ad0..2d238e3 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -21,7 +21,7 @@
 
 #include "i2c-designware-core.h"
 
-#define SEMAPHORE_TIMEOUT	100
+#define SEMAPHORE_TIMEOUT	500
 #define PUNIT_SEMAPHORE		0x7
 #define PUNIT_SEMAPHORE_BIT	BIT(0)
 #define PUNIT_SEMAPHORE_ACQUIRE	BIT(1)
-- 
2.10.2
