From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: i801: Add missing documentation entries for Braswell and Kaby Lake
Date: Fri, 16 Feb 2018 11:24:29 +0200
Message-ID: <20180216092429.24989-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:36450 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757869AbeBPJY0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Feb 2018 04:24:26 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Commits adding PCI IDs for Intel Braswell and Kaby Lake PCH-H lacked the
respective Kconfig and Documentation/i2c/busses/i2c-i801 change. Add
them now.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
There were more commits in the history that forgot to update
documentation part but those were updated later. Like my commit
dd77f423e516 ("i2c: i801: Add support for Intel Broxton") and
2b630df721ee ("i2c: i801: Document Intel DNV and Broxton").
I cross-checked the struct pci_device_id i801_ids[] and these entries
and found only Braswell and Kaby Lake were missing.
---
 Documentation/i2c/busses/i2c-i801 | 2 ++
 drivers/i2c/busses/Kconfig        | 2 ++
 drivers/i2c/busses/i2c-i801.c     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index d47702456926..65514c251318 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -28,8 +28,10 @@ Supported adapters:
   * Intel Wildcat Point (PCH)
   * Intel Wildcat Point-LP (PCH)
   * Intel BayTrail (SOC)
+  * Intel Braswell (SOC)
   * Intel Sunrise Point-H (PCH)
   * Intel Sunrise Point-LP (PCH)
+  * Intel Kaby Lake-H (PCH)
   * Intel DNV (SOC)
   * Intel Broxton (SOC)
   * Intel Lewisburg (PCH)
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a9805c7cb305..e2954fb86d65 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -123,8 +123,10 @@ config I2C_I801
 	    Wildcat Point (PCH)
 	    Wildcat Point-LP (PCH)
 	    BayTrail (SOC)
+	    Braswell (SOC)
 	    Sunrise Point-H (PCH)
 	    Sunrise Point-LP (PCH)
+	    Kaby Lake-H (PCH)
 	    DNV (SOC)
 	    Broxton (SOC)
 	    Lewisburg (PCH)
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 8eac00efadc1..692b34125866 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -58,6 +58,7 @@
  * Wildcat Point (PCH)		0x8ca2	32	hard	yes	yes	yes
  * Wildcat Point-LP (PCH)	0x9ca2	32	hard	yes	yes	yes
  * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
+ * Braswell (SOC)		0x2292	32	hard	yes	yes	yes
  * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
  * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
  * DNV (SOC)			0x19df	32	hard	yes	yes	yes
-- 
2.15.1
