From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] I2C: Make I2C core able to be module when I2C_ACPI is selected.
Date: Mon, 11 Aug 2014 15:00:55 +0800
Message-ID: <1407740455-21269-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Commit da3c6647(I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI
config) adds a new kernel config I2C_ACPI and make I2C core built in
when the config is selected. This is wrong because distributions
etc generally compile I2C as a module and the commit broken that.
This patch is to make I2C core able to be a module when I2C_ACPI is
selected. Original issue the commit da3c6647 tried to avoid will
be fixed in ACPICA and it's rarely triggered during unloading module. 

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/Kconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 3e3b680..436ba27 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -2,9 +2,7 @@
 # I2C subsystem configuration
 #
 
-menu "I2C support"
-
-config I2C
+menuconfig I2C
 	tristate "I2C support"
 	select RT_MUTEXES
 	---help---
@@ -25,8 +23,7 @@ config I2C
 
 config I2C_ACPI
 	bool "I2C ACPI support"
-	select I2C
-	depends on ACPI
+	depends on I2C && ACPI
 	default y
 	help
 	  Say Y here if you want to enable ACPI I2C support. This includes support
@@ -139,4 +136,3 @@ config I2C_DEBUG_BUS
 
 endif # I2C
 
-endmenu
-- 
1.8.3.1
