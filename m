From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: i801: Document Intel DNV and Broxton
Date: Mon, 26 Oct 2015 13:26:56 +0200
Message-ID: <1445858816-19359-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8218 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481AbbJZL1D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 07:27:03 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Add missing entries into i2c-i801 documentation and Kconfig about recently
added Intel DNV and Broxton.

Suggested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/i2c/busses/i2c-i801 | 2 ++
 drivers/i2c/busses/Kconfig        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 82f48f774afb..6a4b1af724f8 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -30,6 +30,8 @@ Supported adapters:
   * Intel BayTrail (SOC)
   * Intel Sunrise Point-H (PCH)
   * Intel Sunrise Point-LP (PCH)
+  * Intel DNV (SOC)
+  * Intel Broxton (SOC)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0774f18f5716..45e1a7ec617d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -124,6 +124,8 @@ config I2C_I801
 	    BayTrail (SOC)
 	    Sunrise Point-H (PCH)
 	    Sunrise Point-LP (PCH)
+	    DNV (SOC)
+	    Broxton (SOC)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
-- 
2.6.1
