From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 1/6] i2c: make kerneldoc about bus recovery more precise
Date: Tue,  9 Jan 2018 14:58:54 +0100
Message-ID: <20180109135859.20771-2-wsa@the-dreams.de>
References: <20180109135859.20771-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41825 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755932AbeAIN7I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 9 Jan 2018 08:59:08 -0500
In-Reply-To: <20180109135859.20771-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

"Used internally" is vague. What it actually means is that those fields
are populated by the core if valid GPIOs are provided. Change the
comments to reflect that.

Tested-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5d7f3c1853ae4b..f8a9d81e911e52 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -545,12 +545,12 @@ struct i2c_timings {
  * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
  *	i2c_generic_scl_recovery().
  * @get_scl: This gets current value of SCL line. Mandatory for generic SCL
- *      recovery. Used internally for generic GPIO recovery.
- * @set_scl: This sets/clears SCL line. Mandatory for generic SCL recovery. Used
- *      internally for generic GPIO recovery.
+ *      recovery. Populated internally for generic GPIO recovery.
+ * @set_scl: This sets/clears the SCL line. Mandatory for generic SCL recovery.
+ *      Populated internally for generic GPIO recovery.
  * @get_sda: This gets current value of SDA line. Optional for generic SCL
- *      recovery. Used internally, if sda_gpio is a valid GPIO, for generic GPIO
- *      recovery.
+ *      recovery. Populated internally, if sda_gpio is a valid GPIO, for generic
+ *      GPIO recovery.
  * @prepare_recovery: This will be called before starting recovery. Platform may
  *	configure padmux here for SDA/SCL line or something else they want.
  * @unprepare_recovery: This will be called after completing recovery. Platform
-- 
2.11.0
