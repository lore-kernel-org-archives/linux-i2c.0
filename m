From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c: designware-baytrail: Fix the Kconfig dependency fix
Date: Tue, 2 Feb 2016 14:33:24 +0100
Message-ID: <20160202143324.780986be@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34129 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbcBBNd1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 2 Feb 2016 08:33:27 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, "David E. Box" <david.e.box@linux.intel.com>, "Signed-off-by: Wolfram Sang" <wsa@the-dreams.de>

Commit b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for
proper Kconfig dependencies") claims that the "Baytrail driver" isn't
tristate. But in fact there is no such thing as a "Baytrail driver",
i2c-designware-baytrail is not a stand-alone driver but an optional
addition to the i2c-designware-platform driver, and that driver *is*
tristate. So there is no reason why I2C_DESIGNWARE_BAYTRAIL couldn't
be enabled when IOSF_MBI=m, as long as I2C_DESIGNWARE_PLATFORM=m too.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: b4ad0510f5d9 ("i2c: designware-baytrail: another fixup for proper Kconfig dependencies")
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.5-rc2.orig/drivers/i2c/busses/Kconfig	2016-02-02 13:36:02.621152859 +0100
+++ linux-4.5-rc2/drivers/i2c/busses/Kconfig	2016-02-02 14:06:07.185912775 +0100
@@ -490,7 +490,7 @@ config I2C_DESIGNWARE_PCI
 
 config I2C_DESIGNWARE_BAYTRAIL
 	bool "Intel Baytrail I2C semaphore support"
-	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
+	depends on I2C_DESIGNWARE_PLATFORM && (IOSF_MBI=y || IOSF_MBI=I2C_DESIGNWARE_PLATFORM) && ACPI
 	help
 	  This driver enables managed host access to the PMIC I2C bus on select
 	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows


-- 
Jean Delvare
SUSE L3 Support
