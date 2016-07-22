From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2] i2c: designware-baytrail: Fix the Kconfig dependency fix
Date: Fri, 22 Jul 2016 10:24:03 +0200
Message-ID: <20160722102403.5c2d3c7e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60547 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbcGVIYH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 04:24:07 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, Wolfram Sang <wsa@the-dreams.de>

Commit b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for
proper Kconfig dependencies") claims that the "Baytrail driver" isn't
tristate. But in fact there is no such thing as a "Baytrail driver",
i2c-designware-baytrail is not a stand-alone driver but an optional
addition to the i2c-designware-platform driver, and that driver *is*
tristate. So there is no reason why I2C_DESIGNWARE_BAYTRAIL couldn't
be enabled when IOSF_MBI=m, as long as I2C_DESIGNWARE_PLATFORM=m too.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for proper Kconfig dependencies")
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
Changes since v1:
* Fixed Wolfram's Cc.
* Split the dependency line to avoid too long a line (suggested by
  Jarkko.)
* Added more Ccs.

 drivers/i2c/busses/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-4.5-rc2.orig/drivers/i2c/busses/Kconfig	2016-02-02 14:32:22.762878539 +0100
+++ linux-4.5-rc2/drivers/i2c/busses/Kconfig	2016-02-04 21:01:49.075379053 +0100
@@ -490,7 +490,8 @@ config I2C_DESIGNWARE_PCI
 
 config I2C_DESIGNWARE_BAYTRAIL
 	bool "Intel Baytrail I2C semaphore support"
-	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
+	depends on I2C_DESIGNWARE_PLATFORM && ACPI
+	depends on IOSF_MBI=y || IOSF_MBI=I2C_DESIGNWARE_PLATFORM
 	help
 	  This driver enables managed host access to the PMIC I2C bus on select
 	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows

-- 
Jean Delvare
SUSE L3 Support
