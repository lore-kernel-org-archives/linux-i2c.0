From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c: designware-platform: Drop duplicate module information
Date: Tue, 2 Feb 2016 14:31:38 +0100
Message-ID: <20160202143138.60adac87@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351AbcBBNbm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 2 Feb 2016 08:31:42 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

The i2c-designware-platform module has duplicate module information
when CONFIG_I2C_DESIGNWARE_BAYTRAIL is set. It gets the information
from both i2c-designware-platdrv and i2c-designware-baytrail. The
latter is optional extra code which ends up in the same module so it
should not export module information.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-designware-baytrail.c |    5 -----
 1 file changed, 5 deletions(-)

--- linux-4.5-rc2.orig/drivers/i2c/busses/i2c-designware-baytrail.c	2016-02-02 09:02:08.098923894 +0100
+++ linux-4.5-rc2/drivers/i2c/busses/i2c-designware-baytrail.c	2016-02-02 13:37:34.418855732 +0100
@@ -11,7 +11,6 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  */
-#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/acpi.h>
@@ -151,7 +150,3 @@ int i2c_dw_eval_lock_support(struct dw_i
 
 	return 0;
 }
-
-MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
-MODULE_DESCRIPTION("Baytrail I2C Semaphore driver");
-MODULE_LICENSE("GPL v2");


-- 
Jean Delvare
SUSE L3 Support
