From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/3] i2c: sprd: Make I2C driver can be built as a module
Date: Thu, 25 Jul 2019 15:56:16 +0800
Message-ID: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Now there is no need to keep our I2C driver to be initialized so early,
thus changing to module level and let it can be built as a module,
meanwhile adding some module information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/Kconfig    |    2 +-
 drivers/i2c/busses/i2c-sprd.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 09367fc..69f1931 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -977,7 +977,7 @@ config I2C_SIRF
 	  will be called i2c-sirf.
 
 config I2C_SPRD
-	bool "Spreadtrum I2C interface"
+	tristate "Spreadtrum I2C interface"
 	depends on I2C=y && ARCH_SPRD
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 9611235..8002835 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -644,8 +645,7 @@ static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
 	},
 };
 
-static int sprd_i2c_init(void)
-{
-	return platform_driver_register(&sprd_i2c_driver);
-}
-arch_initcall_sync(sprd_i2c_init);
+module_platform_driver(sprd_i2c_driver);
+
+MODULE_DESCRIPTION("Spreadtrum I2C master controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
