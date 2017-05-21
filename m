From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5/5] hwmon: pmbus: move header file out of I2C realm
Date: Sun, 21 May 2017 22:34:43 +0200
Message-ID: <20170521203443.6387-6-wsa@the-dreams.de>
References: <20170521203443.6387-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521203443.6387-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

I decided to not move it to 'platform_data' but just one level up because
'pmbus.h' sounds pretty generic to me like 'i2c.h'. And it might contain
different stuff than platform data somewhen? Let me know if you think
different. Thanks!

 Documentation/hwmon/pmbus-core   | 2 +-
 MAINTAINERS                      | 2 +-
 drivers/hwmon/pmbus/pmbus.c      | 2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 drivers/hwmon/pmbus/ucd9000.c    | 2 +-
 drivers/hwmon/pmbus/ucd9200.c    | 2 +-
 include/linux/{i2c => }/pmbus.h  | 0
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename include/linux/{i2c => }/pmbus.h (100%)

diff --git a/Documentation/hwmon/pmbus-core b/Documentation/hwmon/pmbus-core
index 31e4720fed18c7..8ed10e9ddfb589 100644
--- a/Documentation/hwmon/pmbus-core
+++ b/Documentation/hwmon/pmbus-core
@@ -253,7 +253,7 @@ Specifically, it provides the following information.
 PMBus driver platform data
 ==========================
 
-PMBus platform data is defined in include/linux/i2c/pmbus.h. Platform data
+PMBus platform data is defined in include/linux/pmbus.h. Platform data
 currently only provides a flag field with a single bit used.
 
 #define PMBUS_SKIP_STATUS_CHECK (1 << 0)
diff --git a/MAINTAINERS b/MAINTAINERS
index 33541336258e77..259cf67ac17067 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10155,7 +10155,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 S:	Maintained
 F:	Documentation/hwmon/pmbus
 F:	drivers/hwmon/pmbus/
-F:	include/linux/i2c/pmbus.h
+F:	include/linux/pmbus.h
 
 PMC SIERRA MaxRAID DRIVER
 L:	linux-scsi@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 44ca8a94873d62..7718e58dbda543 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pmbus.h>
+#include <linux/pmbus.h>
 #include "pmbus.h"
 
 /*
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index ba59eaef2e075a..f1eff6b6c79826 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -28,7 +28,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
-#include <linux/i2c/pmbus.h>
+#include <linux/pmbus.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include "pmbus.h"
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 3518f0c0893447..b74dbeca2e8d89 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -26,7 +26,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pmbus.h>
+#include <linux/pmbus.h>
 #include "pmbus.h"
 
 enum chips { ucd9000, ucd90120, ucd90124, ucd90160, ucd9090, ucd90910 };
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index a8712c5ded4e93..3ed94585837a9d 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -25,7 +25,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pmbus.h>
+#include <linux/pmbus.h>
 #include "pmbus.h"
 
 #define UCD9200_PHASE_INFO	0xd2
diff --git a/include/linux/i2c/pmbus.h b/include/linux/pmbus.h
similarity index 100%
rename from include/linux/i2c/pmbus.h
rename to include/linux/pmbus.h
-- 
2.11.0
