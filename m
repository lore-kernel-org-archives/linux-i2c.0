From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Resend Patch 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config
Date: Tue, 22 Apr 2014 14:24:15 +0800
Message-ID: <1398147855-9868-10-git-send-email-tianyu.lan@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: wsa@the-dreams.de, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tianyu.lan@intel.com
List-Id: linux-i2c@vger.kernel.org

This patch is to add CONFIG_I2C_ACPI. Current there is a race between
removing I2C ACPI operation region and ACPI AML code accessing.
So make i2c core built-in if CONFIG_I2C_ACPI is set.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/i2c/Kconfig  | 17 ++++++++++++++++-
 drivers/i2c/Makefile |  2 +-
 include/linux/i2c.h  |  2 +-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 7b7ea32..c670d49 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -2,7 +2,9 @@
 # I2C subsystem configuration
 #
 
-menuconfig I2C
+menu "I2C support"
+
+config I2C
 	tristate "I2C support"
 	select RT_MUTEXES
 	---help---
@@ -21,6 +23,17 @@ menuconfig I2C
 	  This I2C support can also be built as a module.  If so, the module
 	  will be called i2c-core.
 
+config I2C_ACPI
+	bool "I2C ACPI support"
+	select I2C
+	depends on ACPI
+	default y
+	help
+	  Say Y here if you want to enable I2C ACPI function. ACPI table
+	  provides I2C slave devices' information to enumerate these devices.
+	  This option also allows ACPI AML code to access I2C slave devices
+	  via I2C ACPI operation region to fulfill ACPI method.
+
 if I2C
 
 config I2C_BOARDINFO
@@ -124,3 +137,5 @@ config I2C_DEBUG_BUS
 	  on.
 
 endif # I2C
+
+endmenu
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 80db307..37464ee 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -3,7 +3,7 @@
 #
 
 i2ccore-y := i2c-core.o
-i2ccore-$(CONFIG_ACPI)		+= i2c-acpi.o
+i2ccore-$(CONFIG_I2C_ACPI)		+= i2c-acpi.o
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2ccore.o
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fc1ef42..d0ece9f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -583,7 +583,7 @@ static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node
 }
 #endif /* CONFIG_OF */
 
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_I2C_ACPI
 int acpi_i2c_install_space_handler(struct i2c_adapter *adapter);
 void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter);
 void acpi_i2c_register_devices(struct i2c_adapter *adap);
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

