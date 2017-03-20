From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Mon, 20 Mar 2017 14:37:30 +0100
Message-ID: <20170320133730.23041-1-oneukum@suse.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754583AbdCTNin (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Mar 2017 09:38:43 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, hdegoede@redhat.com
Cc: Oliver Neukum <oneukum@suse.com>

Our testing shows the semaphore failing to be transferred on CherryTrail
in about 0.5% of all cases. The existing timeout needs to be lengthened
to accomodate the worst cases.

V2: Rebased on https://cgit.freedesktop.org/drm-intel/commit/?h=topic/designware-baytrail

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 1749a0f..c0e7c88 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -22,7 +22,7 @@
 
 #include "i2c-designware-core.h"
 
-#define SEMAPHORE_TIMEOUT	100
+#define SEMAPHORE_TIMEOUT	500
 #define PUNIT_SEMAPHORE		0x7
 #define PUNIT_SEMAPHORE_CHT	0x10e
 #define PUNIT_SEMAPHORE_BIT	BIT(0)
-- 
2.10.2
