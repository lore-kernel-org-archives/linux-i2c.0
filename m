From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] i2c: designware: Let slave adapter support be optional
Date: Wed, 28 Jun 2017 17:23:29 +0300
Message-ID: <20170628142329.14818-3-jarkko.nikula@linux.intel.com>
References: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2993 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdF1OZk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Jun 2017 10:25:40 -0400
In-Reply-To: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Luis Oliveira <lolivei@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Only certain system configurations may use the I2C slave mode so let the
support be optional. This allow reducing module size if needed:

   text    data     bss     dec     hex filename
  10328    1336      16   11680    2da0 drivers/i2c/busses/i2c-designware-core.ko
   7222    1136       8    8366    20ae drivers/i2c/busses/i2c-designware-core.ko

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/Kconfig               | 1 -
 drivers/i2c/busses/i2c-designware-core.h | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index c98c8e51c448..1006b230b236 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -483,7 +483,6 @@ config I2C_DESIGNWARE_CORE
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
 	select I2C_DESIGNWARE_CORE
-	select I2C_DESIGNWARE_SLAVE
 	depends on (ACPI && COMMON_CLK) || !ACPI
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index a403dcdfca4b..9fee4c054d3d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -309,7 +309,11 @@ void i2c_dw_disable_int(struct dw_i2c_dev *dev);
 
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe(struct dw_i2c_dev *dev);
+#if IS_ENABLED(CONFIG_I2C_DESIGNWARE_SLAVE)
 extern int i2c_dw_probe_slave(struct dw_i2c_dev *dev);
+#else
+static inline int i2c_dw_probe_slave(struct dw_i2c_dev *dev) { return -EINVAL; }
+#endif
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 extern int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev);
-- 
2.11.0
